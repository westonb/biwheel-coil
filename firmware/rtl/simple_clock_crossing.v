module simple_clock_crossing #(
	parameter BASE_ADDR = 32'h1000000,
	parameter UPPER_ADDR = 32'h2000000
) (
	input wire clk_a,
	input wire clk_b,

	input wire mem_valid_a,
	output reg mem_ready_a,
	input wire [31:0] mem_addr_a,
	input wire [31:0] mem_wdata_a,
	input wire [3:0] mem_wstrb_a,
	output reg [31:0] mem_rdata_a,

	output reg mem_valid_b,
	input wire mem_ready_b,
	output reg [31:0] mem_addr_b,
	output reg [31:0] mem_wdata_b,
	output reg [3:0] mem_wstrb_b,
	input wire [31:0] mem_rdata_b

);
	
	//clock domain A
	wire addr_valid_a;
	reg [31:0] latched_addr_a;
	reg [31:0] latched_wdata_a;
	reg [3:0] latched_wstrb_a;

	reg req_a; 
	reg busy_a;
	reg [2:0] req_b_sync_a;


	//clock domain B

	reg [31:0] latched_rdata_b;
	reg req_b;
	reg [2:0] req_a_sync_b;

	initial begin 
		mem_ready_a = 1'b0;
		mem_rdata_a = 32'b0;

		mem_valid_b = 1'b0;
		mem_addr_b = 32'b0;
		mem_wdata_b = 32'b0;
		mem_wstrb_b = 4'b0;

		latched_addr_a = 32'b0;
		latched_wdata_a = 32'b0;
		latched_wstrb_a = 4'b0;

		req_a = 1'b0;
		busy_a = 1'b0;
		req_b_sync_a = 3'b0;

		latched_rdata_b = 32'b0;
		req_b = 1'b0;
		req_a_sync_b = 3'b0;
	end

	assign addr_valid_a = (mem_addr_a >= BASE_ADDR) && (mem_addr_a < (UPPER_ADDR));

	always @(posedge clk_a) begin 

		req_b_sync_a <= {req_b_sync_a[1:0], req_b};

		//start transaction
		if (addr_valid_a && mem_valid_a && ~busy_a) begin 
			latched_addr_a <= mem_addr_a;
			latched_wdata_a <= mem_wdata_a; 
			latched_wstrb_a <= mem_wstrb_a;
			req_a <= ~req_a;
			busy_a <= 1'b1;
		end

		//process reply 
		if (req_b_sync_a[2] ^ req_b_sync_a[1]) begin 
			mem_ready_a <= 1'b1;
			mem_rdata_a <= latched_rdata_b;
		end 
		else begin //clear bus 
			mem_ready_a <= 1'b0;
			mem_rdata_a <= 32'b0;
		end

		//clear busy
		if (mem_ready_a) busy_a <= 1'b0; 

	end 

	always @(posedge clk_b) begin 

		req_a_sync_b <= {req_a_sync_b[1:0], req_a};

		if (req_a_sync_b[2] ^ req_a_sync_b[1]) begin //new transaction 
			mem_addr_b <= latched_addr_a;
			mem_wdata_b <= latched_wdata_a;
			mem_valid_b <= 1'b1;
			mem_wstrb_b <= latched_wstrb_a;
		end

		if(mem_ready_b) begin //transaction completed 
			latched_rdata_b <= mem_rdata_b;
			req_b <= ~req_b;
			mem_addr_b <= 32'b0;
			mem_wdata_b <= 32'b0;
			mem_valid_b <= 32'b0;
			mem_wstrb_b <= 4'b0;
		end
	end
endmodule 
