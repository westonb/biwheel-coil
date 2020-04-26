
module qcw_ramp_control #(
	parameter BASE_ADDR = 32'h00000000,
	parameter DUTY_MIN = 100
)(
	input wire clk, 
	input wire reset,

	input wire mem_valid_i,
	output reg mem_ready_o,
	input wire [31:0] mem_addr_i,
	input wire [31:0] mem_wdata_i,
	input wire [3:0] mem_wstrb_i,
	output reg [31:0] mem_rdata_o

	input wire qcw_start, 
	input wire qcw_cycle_done, 
	input wire qcw_done, 
	output reg qcw_halt,
	output reg [7:0] qcw_phase_value
);
	localparam ADDR_RANGE = 4*20;
	localparam FIFO_STATUS_REG_OFFSET = 0;
	localparam FIFO_WRITE_REG_OFFSET = 4;
	localparam FIFO_READ_REG_OFFSET = 8;

	wire device_addressed;
	reg transaction_processed; 

	reg fifo_wr_en;
	reg fifo_rd_en;
	reg [8:0] fifo_din;

	wire fifo_empty, fifo_full;
	wire [9:0] fifo_dout;

	reg qcw_running;

	reg [2:0] fsm_state;

	localparam FSM_IDLE = 0;



	assign device_addressed = mem_valid_i && (BASE_ADDR<=mem_addr_i) && ((BASE_ADDR + ADDR_RANGE)>mem_addr_i);


	always @(posedge clk) begin

		//device addressing logic 
		transaction_processed <= device_addressed;

		if((~transaction_processed) && device_addressed) begin

			mem_ready_o <= 1'b1;

			case (mem_addr_i)

				(BASE_ADDR+FIFO_STATUS_REG_OFFSET) begin
					mem_rdata_o <= {30'b0, fifo_full, fifo_empty};
				end

				(BASE_ADDR+FIFO_WRITE_REG_OFFSET) begin 
					mem_rdata_o <= 32'b0;
					fifo_wr_en <= 1'b1;
					fifo_din <= mem_wdata_i[8:0]
				end
				(BASE_ADDR+FIFO_READ_REG_OFFSET) begin 
					fifo_rd_en <= 1'b1;
					mem_wdata_i <= {23'b0, fifo_dout};

				end

				default: begin 
					mem_rdata_o <= 32'b0;
				end

			endcase 
		end 
		else begin 
			mem_ready_o <= 1'b0;
			mem_rdata_i <= 32'b0;
			fifo_wr_en <= 1'b0;
			fifo_re_en <= 1'b0;

		end

		//ramp gen logic 
		





	end



// xpm_fifo_sync: Synchronous FIFO
// Xilinx Parameterized Macro, version 2018.3
xpm_fifo_sync #(

 .DOUT_RESET_VALUE("0"), // String
 .ECC_MODE("no_ecc"), // String
 .FIFO_MEMORY_TYPE("auto"), // String
 .FIFO_READ_LATENCY(0), // DECIMAL
 .FIFO_WRITE_DEPTH(8192), // DECIMAL
 .FULL_RESET_VALUE(0), // DECIMAL
 .RD_DATA_COUNT_WIDTH(1), // DECIMAL
 .READ_DATA_WIDTH(9), // DECIMAL
 .READ_MODE("fwft"), // String
 .USE_ADV_FEATURES("0707"), // String
 .WAKEUP_TIME(0), // DECIMAL
 .WRITE_DATA_WIDTH(9), // DECIMAL
 .WR_DATA_COUNT_WIDTH(1) // DECIMAL
	)
xpm_fifo_sync_inst (
 .data_valid(), 
 .dout(fifo_dout),
 .empty(fifo_empty), 
 .full(fifo_full), 
 .wr_rst_busy(), 
 .din(fifo_din), 
 .rd_en(fifo_rd_en),
 .rst(rest),
 .wr_clk(clk),
 .wr_en(fifo_wr_en) 
);

endmodule 