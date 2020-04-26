module qcw_ocd_control #(
	parameter BASE_ADDR = 32'h00000000
)(
	input wire clk, 

	input wire mem_valid_i,
	output reg mem_ready_o,
	input wire [31:0] mem_addr_i,
	input wire [31:0] mem_wdata_i,
	input wire [3:0] mem_wstrb_i,
	output reg [31:0] mem_rdata_o

	input wire [9:0] adc_dout,
	
	input wire qcw_start, 
	input wire qcw_cycle_done, 
	input wire qcw_phase_value, 
	input wire qcw_halt
);



endmodule 