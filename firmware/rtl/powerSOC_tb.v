`timescale 1ns/1ps
module powerSOC_tb;

	reg clk;
	reg resetn;
	reg clk_b;

	wire core_valid, core_ready;
	wire [31:0] core_addr, core_wdata, core_rdata;
	wire [3:0] core_wstrb;

	wire [31:0] ram_rdata, rom_rdata;
	wire ram_ready, rom_ready;

	wire [31:0] crossing_rdata, crossed_rdata;
	wire crossing_ready, crossed_ready;
	wire [31:0] crossed_addr, crossed_wdata;
	wire [3:0] crossed_wstrb;
	wire crossed_valid;

	assign core_ready = ram_ready | rom_ready | crossing_ready;
	assign core_rdata = ram_rdata | rom_rdata | crossing_rdata;



	picorv32 #(
		.ENABLE_MUL(0),
		.ENABLE_IRQ(0),
		.PROGADDR_RESET(32'h100000), //start of ROM
		.STACKADDR(32'h001000) //end of RAM
	) picorv32_core (
		.clk      (clk   ),
		.resetn   (resetn),

		.mem_valid(core_valid),
		.mem_addr (core_addr),
		.mem_wdata(core_wdata),
		.mem_wstrb(core_wstrb),
		.mem_ready(core_ready),
		.mem_rdata(core_rdata),

		.irq(32'b0)
	);


	simple_mem #(
		.BASE_ADDR(32'h00100000),
		.LOG_SIZE (12),
		.MEMFILE  ("src/firmware.hex")
	) rom (
		.clk        (clk),
		.mem_valid_i(core_valid),
		.mem_ready_o(rom_ready),
		.mem_addr_i (core_addr),
		.mem_wdata_i(core_wdata),
		.mem_wstrb_i(core_wstrb),
		.mem_rdata_o(rom_rdata)
	);

	simple_mem #(
		.BASE_ADDR(32'h00000000),
		.LOG_SIZE (10),
		.MEMFILE  ("")
	) ram (
		.clk        (clk),
		.mem_valid_i(core_valid),
		.mem_ready_o(ram_ready),
		.mem_addr_i (core_addr),
		.mem_wdata_i(core_wdata),
		.mem_wstrb_i(core_wstrb),
		.mem_rdata_o(ram_rdata)
	);

	simple_clock_crossing #(
		.BASE_ADDR (32'h2000000),
		.UPPER_ADDR(32'h3000000)
	) clock_crossing (
		.clk_a      (clk),
		.clk_b      (clk_b),
		.mem_valid_a(core_valid),
		.mem_ready_a(crossing_ready),
		.mem_addr_a (core_addr),
		.mem_wdata_a(core_wdata),
		.mem_wstrb_a(core_wstrb),
		.mem_rdata_a(crossing_rdata),

		.mem_valid_b(crossed_valid),
		.mem_ready_b(crossed_ready),
		.mem_addr_b (crossed_addr),
		.mem_wdata_b(crossed_wdata),
		.mem_wstrb_b(crossed_wstrb),
		.mem_rdata_b(crossed_rdata)
	);


	simple_mem #(
		.BASE_ADDR(32'h2000000),
		.LOG_SIZE (10),
		.MEMFILE  ("")
	) test_mem (
		.clk        (clk_b),
		.mem_valid_i(crossed_valid),
		.mem_ready_o(crossed_ready),
		.mem_addr_i (crossed_addr),
		.mem_wdata_i(crossed_wdata),
		.mem_wstrb_i(crossed_wstrb),
		.mem_rdata_o(crossed_rdata)
	);


	initial begin 
		clk = 0;
		clk_b = 0;
		resetn = 1;
		#100;
		resetn = 0;
		#100;
		resetn = 1;

	end 

	always #5 clk = ~clk;
	always #3 clk_b = ~clk_b;



endmodule 