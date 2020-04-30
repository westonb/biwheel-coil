`timescale 1ns/1ps
module boost_converter_control#(
	parameter BASE_ADDR = 32'h00000000,
	parameter I_LIMIT = 40,
	parameter VOUT_HYSTERESIS = 10,
	parameter OFF_TIME = 2000,
	parameter ON_TIME_MAX = 20000,
	parameter BLANK_TIME = 100
)(
	input clk, 
	input reset,

	input wire mem_valid_i,
	output reg mem_ready_o,
	input wire [31:0] mem_addr_i,
	input wire [31:0] mem_wdata_i,
	input wire [3:0] mem_wstrb_i,
	output reg [31:0] mem_rdata_o,

	input [9:0] il_adc,
	input [11:0] vin_adc,
	input [11:0] vout_adc,

	output reg sw_out,
	output reg boost_running
);

	localparam FSM_IDLE = 0;
	localparam FSM_RUN_SW_ON = 1;
	localparam FSM_RUN_SW_RAMPUP = 2;
	localparam FSM_RUN_SW_OFF = 3; 
	localparam FSM_RUN_SW_RAMPDOWN = 4;
	localparam FSM_RUN_SW_ON_BLANK = 6;
	localparam FSM_INIT_WAIT = 7;
	localparam FSM_INIT_AVERAGE = 8;

	localparam ADDR_RANGE = 4*20;
	localparam BOOST_ENABLE_REG_OFFSET = 0;
	localparam BOOST_INIT_REG_OFFSET = 4;
	localparam BOOST_STATUS_REG_OFFSET = 8;
	localparam BOOST_VIN_REG_OFFSET = 12;
	localparam BOOST_VOUT_REG_OFFSET = 16;
	localparam BOOST_VOUT_SET_REG_OFFSET= 20;


	wire device_addressed;
	reg transaction_processed; 

	reg [19:0] current_null; 
	reg [9:0] il_adc_reg; 
	reg [11:0] vin_adc_reg;
	reg [11:0] vout_adc_reg;

	reg boost_enable;
	reg boost_init;
	reg boost_init_finished; 

	reg vout_good; 

	reg [11:0] vout_target;

	wire [9:0] current_compare;

	reg [3:0] fsm_state;
	reg [23:0] counter;

	reg sw_ctrl;

	initial begin 
		mem_ready_o = 0;
		mem_rdata_o = 0;
		transaction_processed = 0;

		sw_out = 0;
		boost_running = 0;

		current_null = 0;
		il_adc_reg = 0;
		vin_adc_reg = 0;
		vout_adc_reg = 0;

		boost_enable = 0;
		boost_init = 0;
		boost_init_finished = 0;

		vout_good = 0;
		vout_target = 0;

		fsm_state = FSM_INIT_WAIT;
		counter = 0;
		sw_ctrl = 0;
	end

	assign current_compare = (current_null>>10) + I_LIMIT; 

	assign device_addressed = mem_valid_i && (BASE_ADDR<=mem_addr_i) && ((BASE_ADDR + ADDR_RANGE)>mem_addr_i);

	always@(posedge clk) begin

		sw_out <= sw_ctrl;

		il_adc_reg <= il_adc;
		vin_adc_reg <= vin_adc;
		vout_adc_reg <= vout_adc;

		boost_running <= (!vout_good) && boost_enable;



		//control logic 
		transaction_processed <= device_addressed;
		if((~transaction_processed) && device_addressed) begin

			mem_ready_o <= 1'b1;

			case (mem_addr_i)

				(BASE_ADDR+BOOST_ENABLE_REG_OFFSET): begin
					if(|mem_wstrb_i) boost_enable <= mem_wdata_i[0];
					mem_rdata_o <= {31'b0, boost_enable};
				end
				(BASE_ADDR+BOOST_INIT_REG_OFFSET): begin
					if(|mem_wstrb_i) boost_init <= mem_wdata_i[0];
					mem_rdata_o <= {31'b0, boost_init};
				end
				(BASE_ADDR+BOOST_STATUS_REG_OFFSET): begin
					mem_rdata_o <= {30'b0, boost_running, boost_init_finished};
				end
				(BASE_ADDR+BOOST_VIN_REG_OFFSET): begin
					mem_rdata_o <= {20'b0, vin_adc_reg};
				end
				(BASE_ADDR+BOOST_VOUT_REG_OFFSET): begin
					mem_rdata_o <= {20'b0, vout_adc_reg};
				end
				(BASE_ADDR+BOOST_VOUT_SET_REG_OFFSET): begin
					if(|mem_wstrb_i) vout_target <= mem_wdata_i[11:0];
					mem_rdata_o <= {20'b0, vout_target};
				end

				default: begin 
					mem_rdata_o <= 32'b0;
				end

			endcase 
		end 
		else begin 
			mem_ready_o <= 1'b0;
			mem_rdata_o <= 32'b0;
		end

		//boost converter 

		if (vout_good) begin 
			if (vout_adc_reg + VOUT_HYSTERESIS < (vout_target)) vout_good <= 1'b0;
		end else begin 
			if (vout_adc_reg >= vout_target) vout_good <= 1'b1;
		end

		case (fsm_state)

			//initalize states
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
					boost_init_finished <= 1'b1;
				end 
			end

			//power states 
			FSM_IDLE: begin 
				if (boost_enable) begin
					if (!vout_good) begin
						fsm_state <= FSM_RUN_SW_ON;
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
				if (il_adc_reg > current_compare) begin 
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
					fsm_state <= FSM_IDLE;
				end
			end
		endcase 
	end

endmodule 
