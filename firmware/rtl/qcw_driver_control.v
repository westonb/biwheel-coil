module qcw_driver_control #(
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

	output reg qcw_start,
	output reg [15:0] qcw_cycle_limit,
	output reg qcw_halt, 

	input wire ready
);

	localparam ADDR_RANGE = 4*20;
	localparam DRIVER_RUN_REG_OFFSET = 0;
	localparam DRIVER_CYCLE_LIMIT_REG_OFFSET = 4;
	localparam DRIVER_HALT_REG_OFFSET = 8;

	wire device_addressed;
	reg transaction_processed; 

	assign device_addressed = mem_valid_i && (BASE_ADDR<=mem_addr_i) && ((BASE_ADDR + ADDR_RANGE)>mem_addr_i);

	always@(posedge clk) begin

		//device addressing logic 
		transaction_processed <= device_addressed;

		if((~transaction_processed) && device_addressed) begin

			mem_ready_o <= 1'b1;

			case (mem_addr_i)

				(BASE_ADDR+DRIVER_RUN_REG_OFFSET) begin
					mem_rdata_o <= {31'b0, ready};
					if (|mem_wstrb_i) qcw_start <= 1'b1;
				end

				(BASE_ADDR+DRIVER_CYCLE_LIMIT_REG_OFFSET) begin 
					mem_rdata_o <= 32'b0;
					if(|mem_wstrb_i) begin
						qcw_cycle_limit <= mem_wdata_i[15:0]
					end
				end

				(BASE_ADDR+DRIVER_HALT_REG_OFFSET) begin 
					mem_rdata_o <= 32'b0;
					qcw_halt <= 1'b1;
				end
				
				default: begin 
					mem_rdata_o <= 32'b0;
				end

			endcase 
		end 
		else begin 
			mem_ready_o <= 1'b0;
			mem_ready_o <= 1'b0;
			mem_rdata_i <= 32'b0;
			
			qcw_halt <= 1'b0;
			qcw_start <= 1'b0;
		end


	end




endmodule 