module basic_boost_converter(
	input clk, 
	input [9:0] il_adc,
	input [11:0] vin_adc,
	input [11:0] vout_adc,
	input boost_en,
	input boost_init,
	output wire sw_out
);
	localparam VOUT_TARGET = 440; //50V 
	localparam VOUT_DELTA = 10;

	//localparam I_LIMIT = 15; // 1.1A peak 
	//localparam I_LIMIT = 25; //1.8A peak
	localparam I_LIMIT = 40; //3A peak  
	//localparam I_LIMIT = 50; //3.75A peak 
	localparam OFF_TIME = 2000;
	localparam ON_TIME_MAX = 20000;
	localparam BLANK_TIME = 100;

	localparam FSM_IDLE = 0;
	localparam FSM_RUN_SW_ON = 1;
	localparam FSM_RUN_SW_RAMPUP = 2;
	localparam FSM_RUN_SW_OFF = 3; 
	localparam FSM_RUN_SW_RAMPDOWN = 4;
	localparam FSM_RUN_CHECK = 5;
	localparam FSM_RUN_SW_ON_BLANK = 6;
	localparam FSM_INIT_WAIT = 7;
	localparam FSM_INIT_AVERAGE = 8;

	reg [19:0] current_null = 0; 

	wire [9:0] current_compare;

	/*
	Vin/Vout ADC are sampled through XADC
	12 bits, 1V full scale 
	Vin is 0.070V/bit
	Vout is 0.112V/bit

	Il is derived from bi-directional hall effect current sensor, 100mv/A. Goes through 1.8/5 voltage divider before being sampled by main high-speed ADC
	Il is sampled through main ADC, 10 bits for 0.073A / bit, 2^9 bit offset (for +- current )
	*/
	reg output_en = 0;
	reg sw_ctrl = 0;
	reg [3:0] fsm_state = FSM_INIT_WAIT;
	reg [23:0] counter = 0; 

	initial begin 
		fsm_state = FSM_INIT_WAIT;
	end

	assign current_compare = (current_null>>10) + I_LIMIT; 
	assign sw_out =sw_ctrl & output_en;

	always@(posedge clk) begin
		case (fsm_state)

			FSM_INIT_WAIT: begin 
				fsm_state <= boost_init ? FSM_INIT_AVERAGE : FSM_INIT_WAIT;
				counter <= 0;
			end

			FSM_INIT_AVERAGE: begin 
				counter <= counter + 1;
				if (counter[1:0] == 0) begin 
					current_null <= current_null + il_adc;
				end
				if (counter[23:2] >= (1<<10)) begin
					counter <= 0;
					fsm_state <= FSM_IDLE;
				end 
			end

			FSM_IDLE: begin 
				output_en <= 0;
				if (boost_en) begin
					if (vout_adc < (VOUT_TARGET - VOUT_DELTA)) begin
					fsm_state <= FSM_RUN_SW_ON;
					output_en <= 1;
					end
				end
				else begin 
					fsm_state <= FSM_IDLE;
				end 
			end

			FSM_RUN_SW_ON: begin 
				counter <= 0;
				sw_ctrl <= 1;
				fsm_state <= FSM_RUN_SW_ON_BLANK;	
			end

			FSM_RUN_SW_ON_BLANK: begin 
				counter <= counter + 1;
				if (counter >= BLANK_TIME) begin
					counter <= 0;
					fsm_state <= FSM_RUN_SW_RAMPUP;
				end
			end

			FSM_RUN_SW_RAMPUP: begin 
				counter <= counter + 1;
				if (il_adc > current_compare) begin 
					fsm_state <= FSM_RUN_SW_OFF;
				end
				if (counter > ON_TIME_MAX) begin 
					fsm_state <= FSM_RUN_SW_OFF;
				end
			end

			FSM_RUN_SW_OFF: begin 
				counter <= 0; 
				sw_ctrl <= 0;
				fsm_state <= FSM_RUN_SW_RAMPDOWN;
			end

			FSM_RUN_SW_RAMPDOWN: begin 
				counter <= counter + 1;
				if (counter >= OFF_TIME) begin 
					fsm_state <= FSM_RUN_CHECK;
				end
			end

			FSM_RUN_CHECK: begin 
				if (vout_adc > VOUT_TARGET) begin 
					fsm_state <= FSM_IDLE;
				end 
				else if (~boost_en) begin
					fsm_state <= FSM_IDLE;
				end 
				else begin 
					fsm_state <= FSM_RUN_SW_ON;
				end
			end
		endcase 

	end

endmodule 