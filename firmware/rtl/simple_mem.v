`timescale 1ns/1ps
module simple_mem #(
	parameter BASE_ADDR = 32'h1000000,
	parameter LOG_SIZE = 14, // in words
	parameter MEMFILE = ""
) (
	input wire clk,
	input wire mem_valid_i,
	output reg mem_ready_o,
	input wire [31:0] mem_addr_i,
	input wire [31:0] mem_wdata_i,
	input wire [3:0] mem_wstrb_i,
	output reg [31:0] mem_rdata_o
);
	wire addr_valid;
	wire [LOG_SIZE-1:0] addr_translated; 

	reg [31:0] mem[(2**LOG_SIZE-1):0];
	reg transacton_done = 0;
	initial begin
	  if (MEMFILE != "") begin
	    $readmemh(MEMFILE, mem);
	  end
	end

	assign addr_valid = (mem_addr_i >= BASE_ADDR) && (mem_addr_i < (BASE_ADDR+ (2**(LOG_SIZE+2))));
	assign addr_translated = mem_addr_i[(LOG_SIZE+1):2];

	always @(posedge clk) begin
		if(addr_valid && mem_valid_i) begin 
			transacton_done <= 1'b1;

			if (transacton_done == 1'b0) begin
				mem_ready_o <= 1'b1;
				mem_rdata_o <= mem[addr_translated];

				if(mem_wstrb_i[0]) mem[addr_translated][7:0] <= mem_wdata_i[7:0];
				if(mem_wstrb_i[1]) mem[addr_translated][15:8] <= mem_wdata_i[15:8];
				if(mem_wstrb_i[2]) mem[addr_translated][23:16] <= mem_wdata_i[23:16];
				if(mem_wstrb_i[3]) mem[addr_translated][31:24] <= mem_wdata_i[31:24];
			end
			else begin
				mem_ready_o <= 1'b0;
				mem_rdata_o <= 32'b0;
			end

		end

		else begin 
			transacton_done <= 1'b0;
			mem_ready_o <= 1'b0;
			mem_rdata_o <= 32'b0;
		end
	end  
endmodule