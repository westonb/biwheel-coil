`timescale 1ns/1ps
module qcw_oscillator #(
	parameter DEADTIME = 40
	) (
	input wire clk, 
	input wire enable, 
	input wire load,
	input wire [11:0] period_value,
	input wire [7:0] phase_shift,
	output wire period_done,
	output wire signal_ref,
	output wire sw1, 
	output wire sw2, 
	output wire sw3, 
	output wire sw4 
);
	
	localparam FSM_STATE_IDLE = 0;
	localparam FSM_STATE_STARTING1 = 1;
	localparam FSM_STATE_STARTING2 = 2;
	localparam FSM_STATE_RUNNING = 3;
	localparam FSM_STATE_ENDING = 4; 

	reg [11:0] period1_value_latched;
	reg [11:0] period2_value_latched;
	reg [7:0] phase_shift_latched;

	reg [20:0] period2_reset_compare_p1; 
	reg [20:0] period2_reset_compare_p2;
	reg [20:0] period2_reset_compare_p3;

	reg [11:0] period1_value_active;
	reg [11:0] period1_value_active_m1;
	reg [11:0] period2_value_active;
	reg [11:0] period2_reset_compare_active; 
	reg [7:0] phase_shift_active; 

	reg [7:0] phase_shift_active_p;
	reg [11:0] period1_value_active_p;


	reg [11:0] counter1;
	reg [11:0] counter2;

	reg [2:0] fsm_state;
	reg sw1_reg, sw2_reg, sw3_reg, sw4_reg, signal_ref_reg;
	reg period_done_reg;

	wire [11:0] sw1_compare_on, sw1_compare_off;
	wire [11:0] sw2_compare_on, sw2_compare_off;
	wire [11:0] sw3_compare_on, sw3_compare_off;
	wire [11:0] sw4_compare_on, sw4_compare_off;

	reg enable_delay;


	assign period_done = period_done_reg;

	assign sw1_compare_on = DEADTIME;
	assign sw1_compare_off = (period1_value_active>>1);

	assign sw2_compare_on = (DEADTIME + (period1_value_active>>1));
	assign sw2_compare_off = period1_value_active;

	assign sw3_compare_on = DEADTIME;
	assign sw3_compare_off = (period2_value_active>>1);

	assign sw4_compare_on = (DEADTIME + (period2_value_active>>1));
	assign sw4_compare_off = period2_value_active; 

	assign sw1 = sw1_reg;
	assign sw2 = sw2_reg;
	assign sw3 = sw3_reg;
	assign sw4 = sw4_reg;
	assign signal_ref = signal_ref_reg;

	initial begin 
		fsm_state = FSM_STATE_IDLE;
		sw1_reg = 0;
		sw2_reg = 0;
		sw3_reg = 0;
		sw4_reg = 0;
		signal_ref_reg = 0;
		enable_delay = 0;
		period_done_reg = 0;
	end


	always@(posedge clk) begin 
		enable_delay <= enable;

		//load data
		if (load) begin
			period1_value_latched <= period_value;
			period2_value_latched <= period_value;
			phase_shift_latched <= phase_shift;

		end

		phase_shift_active_p <= phase_shift_active;
		period1_value_active_p <= period1_value_active_m1;

		period2_reset_compare_p1 <= (phase_shift_active_p * period1_value_active_p)>>9;
		period2_reset_compare_p2 <= period2_reset_compare_p1;
		period2_reset_compare_active <= (period2_reset_compare_p2 > 5) ? period2_reset_compare_p2 : 6;

		case (fsm_state) 

			FSM_STATE_IDLE: begin

				sw1_reg <= 0;
				sw2_reg <= 0;
				sw3_reg <= 0;
				sw4_reg <= 0;
				signal_ref_reg <= 0;

				if (enable_delay) begin 
					fsm_state <= FSM_STATE_STARTING1;
				end
			end

			//start phase 1 and wait to start phase 2 
			FSM_STATE_STARTING1: begin 
				counter1 <= 0;
				counter2 <= 0;
				period1_value_active <= period1_value_latched;
				period1_value_active_m1 <= period1_value_latched - 1;
				period2_value_active <= period2_value_latched;
				phase_shift_active <= phase_shift_latched;
				

				fsm_state <= FSM_STATE_STARTING2;
			end

			FSM_STATE_STARTING2: begin 
				counter1 <= counter1+1; 

				sw1_reg <= (counter1 > sw1_compare_on) && (counter1 < sw1_compare_off) ? 1 : 0;
				sw2_reg <= (counter1 > sw2_compare_on) ? 1 : 0;

				signal_ref_reg <= (counter1<(period1_value_active>>1)) ? 1 : 0; 

				sw3_reg <= 0;
				sw4_reg <= 0;

				if (counter1 == period2_reset_compare_active) begin
					fsm_state <= FSM_STATE_RUNNING;
				end
			end 

			FSM_STATE_RUNNING: begin 

				if (counter1 >= (period1_value_active_m1)) begin
					counter1 <= 0; 
					period_done_reg <= 1;
					//load new timer values 
					period1_value_active <= period1_value_latched;
					period1_value_active_m1 <= period1_value_latched - 1;
					phase_shift_active <= phase_shift_latched;
				end 
				else begin
					counter1 <= counter1 + 1;
					period_done_reg <= 0;
				end

				if (counter1 == period2_reset_compare_active) begin 
					counter2 <= 0;
					//load new timer values 
					period2_value_active <= period2_value_latched;
				end 
				else begin 
					counter2 <= counter2+1; 
				end

				signal_ref_reg <= (counter1 < (period1_value_active>>1)) ? 1 : 0;

				sw1_reg <= (counter1 > sw1_compare_on) && (counter1 < sw1_compare_off) ? 1 : 0;
				sw2_reg <= (counter1 > sw2_compare_on) && (counter1 < sw2_compare_off) ? 1 : 0;

				sw3_reg <= (counter2 > sw3_compare_on) && (counter2 < sw3_compare_off) ? 1 : 0;
				sw4_reg <= (counter2 > sw4_compare_on) && (counter2 < sw4_compare_off) ? 1 : 0;

				signal_ref_reg <= (counter1<(period1_value_active>>1)) ? 1 : 0;

				if (~enable_delay) begin
					fsm_state <= FSM_STATE_ENDING;
				end
			end

			FSM_STATE_ENDING: begin
				//finish one last cycle 
				period_done_reg <= 0;

				sw1_reg <= (counter1 > sw1_compare_on) && (counter1 < sw1_compare_off) ? 1 : 0;
				sw2_reg <= (counter1 > sw2_compare_on) && (counter1 < sw2_compare_off) ? 1 : 0;

				sw3_reg <= (counter2 > sw3_compare_on) && (counter2 < sw3_compare_off) ? 1 : 0;
				sw4_reg <= (counter2 > sw4_compare_on) && (counter2 < sw4_compare_off) ? 1 : 0;

				signal_ref_reg <= (counter1<(period1_value_active>>1)) ? 1 : 0;

				if (counter1 < period1_value_active) begin 
					counter1 <= counter1 + 1;
				end 
				else begin 
					counter1 <= counter1;
				end

				if (counter2 < period2_value_active) begin 
					counter2 <= counter2 + 1;
				end
				else begin 
					counter2 <= counter2;
				end

				if ( (counter2>=period2_value_active) && (counter1 >= period1_value_active)) begin
					sw1_reg <= 0;
					sw2_reg <= 0; 
					sw3_reg <= 0;
					sw4_reg <= 0;

					fsm_state <= FSM_STATE_IDLE;
				end
			end 
		endcase 
	end 
endmodule 

