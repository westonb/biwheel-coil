/*
module wb_cm_boost #(
	parameter BASE_ADR = 32'h1000000
)(
	input wb_clk_i,
	input wb_rst_i,

	input [31:0] wb_adr_i,
	input [31:0] wb_dat_i,
	input [3:0] wb_sel_i, // byte write enable
	input wb_we_i, //write enable from bus
	input wb_cyc_i, //wishbone transaction is taking place
	input wb_stb_i, //wishbone transction request

	output reg wb_ack_o, //bus request ack'ed
	output reg [31:0] wb_dat_o, //data output

	input enable,
	input [11:0] vin,
	input [11:0] vout,
	input [9:0] current_L,
	output switch
	);
	*/