`timescale 1ns/1ps
module qcw_ocd_control #(
	parameter BASE_ADDR = 32'h00000000
)(
	input wire clk, 
	input wire reset,

	input wire mem_valid_i,
	output reg mem_ready_o,
	input wire [31:0] mem_addr_i,
	input wire [31:0] mem_wdata_i,
	input wire [3:0] mem_wstrb_i,
	output reg [31:0] mem_rdata_o,

	input wire [9:0] adc_dout,
	
	input wire qcw_start, 
	output reg qcw_halt
);
	localparam ADDR_RANGE = 4*20;
	localparam OCD_CURR_LIMIT_REG_OFFSET = 0;
	localparam OCD_CURR_MEAS_REG_OFFSET = 4;
	localparam OCD_STATUS_REG_OFFSET = 8;
	localparam OCD_ADC_READING_REG_OFFSET = 12;
	localparam OCD_ADC_RESET_REG_OFFSET = 16;

	wire device_addressed;
	reg transaction_processed; 

	reg [9:0] adc_dout_reg;
	reg [9:0] adc_abs_reg;

	reg [9:0] current_limit;
	reg [9:0] adc_abs_max;

	reg ocd_latched;

	initial begin 
		qcw_halt = 0;
		mem_ready_o = 0;
		mem_rdata_o = 0;

		adc_dout_reg = 0;
		adc_abs_reg = 0;
		current_limit = 0;
		adc_abs_max = 0;

		ocd_latched = 0;
	end

	assign device_addressed = mem_valid_i && (BASE_ADDR<=mem_addr_i) && ((BASE_ADDR + ADDR_RANGE)>mem_addr_i);

	always @(posedge clk) begin

		//re-align ADC data 
		adc_dout_reg <= adc_dout;
		adc_abs_reg <= (adc_dout_reg > 512) ? adc_dout_reg - 512 : 512 - adc_dout_reg;


		//OCD logic 
		if (adc_abs_reg>=current_limit) ocd_latched <= 1'b1;

		if(adc_abs_reg > adc_abs_max) adc_abs_max <= adc_abs_reg;

		qcw_halt = ocd_latched;


		//device addressing logic 
		transaction_processed <= device_addressed;

		if((~transaction_processed) && device_addressed) begin

			mem_ready_o <= 1'b1;

			case (mem_addr_i)

				(BASE_ADDR+OCD_CURR_LIMIT_REG_OFFSET): begin
					mem_rdata_o <= 32'b0;
					if(|mem_wstrb_i) current_limit <= mem_wdata_i[9:0];
				end

				(BASE_ADDR+OCD_CURR_MEAS_REG_OFFSET): begin 
					mem_rdata_o <= {22'b0, adc_abs_max};
				end
				(BASE_ADDR+OCD_STATUS_REG_OFFSET): begin 
					mem_rdata_o <= {31'b0, ocd_latched};
				end
				(BASE_ADDR+OCD_ADC_READING_REG_OFFSET): begin
					mem_rdata_o <= {22'b0, adc_dout_reg};
				end
				(BASE_ADDR+OCD_ADC_RESET_REG_OFFSET): begin
					if(|mem_wstrb_i) begin
						ocd_latched <= 1'b0;
						adc_abs_max <= 0;
					end
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
	end



endmodule 