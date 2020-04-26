`timescale 1ns/1ps
module qcw_ocd #(
	parameter OCD_LIMIT = 400
	) (
	input wire clk, 
	input wire start, 
	input wire enable,
	input wire [9:0] adc_dout,
	output wire [9:0] current_max,
	output wire qcw_halt
);
	localparam FILTER_K = 128;

	reg [9:0] adc_latched;

	reg [17:0] adc_filtered;

	reg [9:0] current_max_reg;
	reg qcw_halt_reg;

	wire [9:0] adc_abs;

	initial begin 
		//adc_filtered = 10'b10_0000_0000;
		adc_filtered = 512<<8;
		current_max_reg = 0;
		adc_latched = 0;
		qcw_halt_reg = 0;
	end

	assign adc_abs = (adc_filtered[17:8] >= 10'b10_0000_0000) ? adc_filtered[17:8] - 10'b10_0000_0000 : 10'b10_0000_0000 - adc_filtered[17:8];
	assign current_max = current_max_reg;
	assign qcw_halt = qcw_halt_reg;

	always@(posedge clk) begin
		adc_latched <= adc_dout;
		adc_filtered <= ((adc_latched<<8) * (256 - FILTER_K) + adc_filtered * (FILTER_K)) >> 8;

		if (adc_abs > current_max_reg) begin 
			current_max_reg <= adc_abs;
		end

		if (adc_abs > OCD_LIMIT) begin 
			qcw_halt_reg <= 1;
		end else begin 
			qcw_halt_reg <= 0;
		end

		if (start) begin 
			current_max_reg <= 0;
		end
	end

endmodule 