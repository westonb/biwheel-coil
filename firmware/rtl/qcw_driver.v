`timescale 1ns/1ps
module qcw_driver #(
	parameter STARTING_PERIOD = 600,
	parameter PHASE_LEAD = 20,
	parameter DEADTIME = 24
	)(
	input wire clk, 
	input wire zcs,

	input wire halt, 
	input wire start,
	input wire [7:0] phase_shift,
	input wire [15:0] cycle_limit,

	output wire ready,
	output wire cycle_finished,
	output wire fault,

	output wire sw1_drive,
	output wire sw2_drive, 
	output wire sw3_drive,
	output wire sw4_drive,
	
	output wire zcs_state_debug,
	output wire output_state_debug
	);	


	localparam K_GAIN = 1;
	localparam STARTING_PHASE_SHIFT = 100;

	localparam PHASE_MIN = 50;
	localparam PHASE_MAX = 254; 


	localparam FSM_IDLE = 0;
	localparam FSM_START1 = 1;
	localparam FSM_START2 = 2;
	localparam FSM_RUN1 = 3; 
	localparam FSM_RINGDOWN1 = 4;
	localparam FSM_HALT = 5;
	localparam FSM_FINISH = 6;

	localparam ZCS_FILTER_LEN = 10;
	localparam PERIOD_MAX = 730; //325KHz Fmin 
	localparam PERIOD_MIN = 480; //500KHz Fmax
	localparam PERIOD_VALUE_MAX = ((1<<24) - 1 - K_GAIN);
	localparam PERIOD_VALUE_MIN = K_GAIN; 
	localparam FORCE_CYCLES = 10; 


	reg ready_reg;


	reg [PHASE_LEAD:0] phase_lead_shiftreg;

	reg [5:0] fsm_state; 
	reg [15:0] cycle_counter;
	reg [25:0] period_value; 
	reg [(ZCS_FILTER_LEN-1):0] zcs_filter;
	reg zcs_state;
	reg phase_detector_en; 
	
	//oscillator input registers
	reg osc_load;
	reg osc_en;
	reg [7:0] latched_phase_shift;
	reg [15:0] latched_period_value;

	//phase detector regs 
	reg latch_rise_zcs;
	reg latch_rise_ref;
	reg zcs_last;
	reg phase_signal_ref_last; 

	//oscillator output wires 
	wire osc_period_done;
	wire osc_ref_out;
	wire osc_sw1;
	wire osc_sw2;
	wire osc_sw3;
	wire osc_sw4;

	//phase comparator wires
	wire phase_signal_ref;


	wire osc_fault;

	initial begin 

		phase_lead_shiftreg = 0;
		fsm_state = FSM_IDLE;
		zcs_filter = 0;
		zcs_state = 0;
		osc_load = 0;
		osc_en = 0;

	end

	assign phase_signal_ref = phase_lead_shiftreg[PHASE_LEAD];

	assign osc_fault = (osc_sw1 && osc_sw2) | (osc_sw3 && osc_sw4);
	assign sw1_drive = osc_fault ? 0 : osc_sw1;
	assign sw2_drive = osc_fault ? 0 : osc_sw2;
	assign sw3_drive = osc_fault ? 0 : osc_sw3;
	assign sw4_drive = osc_fault ? 0 : osc_sw4;

	assign cycle_finished = osc_period_done;

	assign fault = 0;
	assign ready = ready_reg; 

	assign output_state_debug = phase_signal_ref;
	assign zcs_state_debug = zcs_state;


	always@(posedge clk) begin
		//filter zcs input signal
		zcs_filter <= {zcs_filter[(ZCS_FILTER_LEN-2):0], zcs};
		zcs_state <= (&zcs_filter) ? 1'b1 : (~|zcs_filter) ? 1'b0 : zcs_state;

		//phase lead shiftreg
		phase_lead_shiftreg <= {phase_lead_shiftreg, osc_ref_out};
		phase_signal_ref_last <= phase_signal_ref;

		zcs_last <= zcs_state; 

		//phase detector 
		//if current lags voltage, load is inductive, decrease frequency (increase period)
		// if current leads voltage, load is capacitive, increase frequency (decrease period)
		if(phase_detector_en) begin 

			latch_rise_zcs <= (zcs_state) && (~zcs_last) ? 1 : latch_rise_zcs;
			latch_rise_ref <= (phase_signal_ref) && (~phase_signal_ref_last) ? 1 : latch_rise_ref;

			if ((latch_rise_zcs) && (latch_rise_ref)) begin  
				latch_rise_zcs <= 0;
				latch_rise_ref <= 0;
			end 

			if ((zcs_state) && (phase_signal_ref)) begin
				latch_rise_zcs <= 0;
				latch_rise_ref <= 0;
			end
			//current lagging voltage 
			if ( (latch_rise_ref) && (~latch_rise_zcs) ) begin 
				period_value <= (period_value < (PERIOD_VALUE_MAX-K_GAIN) ) ? period_value + K_GAIN : period_value; 
			end 
			//current leading voltage 
			if ( (~latch_rise_ref) && (latch_rise_zcs) ) begin
				period_value <= ( period_value > (PERIOD_VALUE_MIN+K_GAIN) ) ? period_value - K_GAIN : period_value;
			end 
		end 
		else begin
			latch_rise_zcs <= 0;
			latch_rise_ref <= 0;
		end



		case (fsm_state) 

			FSM_IDLE: begin 
				ready_reg <= 1;

				if (start) begin
					ready_reg <= 0;
					fsm_state <= FSM_START1;
				end
			end

			FSM_START1: begin  //start osc for FORCE_CYCLES at STARTING_PERIOD
				cycle_counter <= 0;
				phase_detector_en <= 0; 
				period_value <= (STARTING_PERIOD<<8);
				latched_period_value <= ((STARTING_PERIOD>>1)<<1);
				latched_phase_shift <= STARTING_PHASE_SHIFT;
				osc_en <= 1;
				osc_load <= 1; 
				fsm_state <= FSM_START2;
			end

			FSM_START2: begin // wait for FORCE_CYCLES to elapse 
				osc_load <= 0;
				if (osc_period_done) begin
					cycle_counter <= cycle_counter + 1;
					if (cycle_counter == (FORCE_CYCLES-1)) begin
						cycle_counter <= 0;
						fsm_state <= FSM_RUN1;
						phase_detector_en <= 1;
					end
				end
			end

			FSM_RUN1: begin  // increment period counter and update latched_period_value
				if (osc_period_done) begin 
					cycle_counter <= cycle_counter + 1;
					latched_period_value <= (((period_value>>9)<<1) > PERIOD_MAX) ? PERIOD_MAX :  (((period_value>>9)<<1) < PERIOD_MIN) ? PERIOD_MIN : ((period_value>>9)<<1);
					latched_phase_shift <= phase_shift; 
					osc_load <= 1;

					if (cycle_counter >= cycle_limit) begin 
						fsm_state <= FSM_RINGDOWN1;
						osc_en <= 0; 
					end
				end
				else begin 
					osc_load <= 0;
				end

				if (halt) begin 
					osc_en <= 0;
					osc_load <= 0;
					fsm_state <= FSM_HALT;
				end 
			end 

			FSM_RINGDOWN1: begin 
				//not implimented
				osc_load <= 0;
				phase_detector_en <= 0;
				fsm_state <= FSM_FINISH;
			end 

			FSM_HALT: begin 
				//not implimented
				fsm_state <= FSM_FINISH;
			end

			FSM_FINISH: begin 
				fsm_state <= FSM_IDLE;
			end 
		endcase 
	end


	qcw_oscillator #(
		.DEADTIME(DEADTIME)
		) oscillator (
		.clk         (clk),
		.enable      (osc_en),
		.load        (osc_load),
		.period_value(latched_period_value),
		.phase_shift (latched_phase_shift),
		.period_done (osc_period_done),
		.signal_ref  (osc_ref_out),
		.sw1         (osc_sw1),
		.sw2         (osc_sw2),
		.sw3         (osc_sw3),
		.sw4         (osc_sw4)
	);
endmodule 