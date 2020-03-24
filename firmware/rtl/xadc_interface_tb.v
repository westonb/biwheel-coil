`timescale 1ns/1ps
module xadc_interface_tb;
	reg clk;
	reg vp_in;
	reg vn_in;
	wire mux_ctrl;
	wire new_data;
	wire [11:0] data_a;
	wire [11:0] data_b;

	initial begin 
		clk = 0;
		vp_in = 0;
		vn_in = 0;
	end

	always begin
		#5 clk = ~clk;
	end

	xadc_interface uut (
		.clk(clk),
		.vp_in(vp_in),
		.vn_in(vn_in),
		.mux_ctrl(mux_ctrl),
		.new_data(new_data),
		.data_a(data_a),
		.data_b(data_b)
	);

endmodule