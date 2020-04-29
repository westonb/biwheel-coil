`timescale 1ns/1ps
module gpio_control #(
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

	input wire [31:0] gpio_i,
	output reg [31:0] gpio_o
);
	localparam ADDR_RANGE = 4*4;
	localparam GPIO_OUT_REG_OFFSET = 0;
	localparam GPIO_IN_REG_OFFSET = 4;

	wire device_addressed;
	reg transaction_processed;

	reg [31:0] gpio_i_reg;

	initial begin 
		mem_ready_o = 0;
		mem_rdata_o = 0;
		transaction_processed = 0;

		gpio_o = 0;
		gpio_i_reg = 0;
	end 


	assign device_addressed = mem_valid_i && (BASE_ADDR<=mem_addr_i) && ((BASE_ADDR + ADDR_RANGE)>mem_addr_i);

	always@(posedge clk) begin

		transaction_processed <= device_addressed;

		if((~transaction_processed) && device_addressed) begin

			mem_ready_o <= 1'b1;

			case (mem_addr_i)

				(BASE_ADDR+GPIO_OUT_REG_OFFSET): begin
					if(|mem_wstrb_i) gpio_o <= mem_wdata_i;
					mem_rdata_o <= gpio_o;
				end
				(BASE_ADDR+GPIO_IN_REG_OFFSET): begin
					mem_rdata_o <= gpio_i_reg;
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
