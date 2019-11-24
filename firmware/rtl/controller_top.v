`timescale 1ns/1ps
//`default_nettype none

module controller_top(
	//ADC data bus
	input wire [9:0] ADC_DATA,
	input wire ADC_DCO,
	//ADC configuration interface
	output wire ADC_SCLK, 
	output wire ADC_SDIO,
	output wire ADC_CS,
	output wire ADC_MODE,
	//debug / status
	output wire LED1,
	output wire LED2,
	output wire DEBUG_TX,
	input wire DEBUG_RX,
	//interface
	output wire FIBER_TX,
	input wire FIBER_RX,
	
	//comparator inputs
	input wire OVER_TEMP, 
	input wire ZCS,
	//bridge gate drive
	output wire GATE1,
	output wire GATE2,
	output wire GATE3,
	output wire GATE4,
	//aux gate drive
	output wire GATE_CHARGE,
	output wire GATE_BOOST
	);

	//clock signals
	wire clk_80MHz, clk_160MHz;
 
	//wishbone signals, soc clock domain 
	wire [31:0] wb_adr;
	wire [31:0] wb_dat_i;
	wire [31:0] wb_dat_o;
	wire [3:0] wb_sel; 
	wire wb_stb;
	wire wb_ack;
	wire wb_cyc;
	wire wb_we;

	wire [31:0] gpio_i, gpio_o;

	//reset generation
	reg [31:0] reset_counter = 0;
	wire reset = ~reset_counter[31];

	//unused signal assign 
	assign GATE_BOOST = test_counter[12];
	assign DEBUG_TX = 1'b0;

	//gpio assign 

	assign {ADC_CS, LED1, LED2, GATE_CHARGE} = gpio_o[3:0];
	assign gpio_i = 32'b0;

	//test drive
	reg [15:0] test_counter = 0;

	assign GATE1 = test_counter[9];
	assign GATE3 = test_counter[9];

	assign GATE2 = ~test_counter[9];
	assign GATE4 = ~test_counter[9];

	always@(posedge clk_160MHz) begin
		test_counter <= test_counter + 1;
		reset_counter <= {reset_counter[30:0], 1'b1};
	end




	system_clocking system_clocks (
		.clk_80MHz_i(ADC_DCO),
		.clk_80MHz_o(clk_80MHz),
		.clk_160MHz_o(clk_160MHz)
	);


	base_soc soc (
		.clk_i(clk_160MHz),
		.reset_i   (reset),
		.wb_adr_o  (wb_adr),
		.wb_dat_o  (wb_dat_o),
		.wb_dat_i  (wb_dat_i),
		.wb_we_o   (wb_we),
		.wb_sel_o  (wb_sel),
		.wb_stb_o  (wb_stb),
		.wb_ack_i  (wb_ack),
		.wb_cyc_o  (wb_cyc),
		.gpio_o    (gpio_o),
		.gpio_i    (gpio_i),
		.spi_mosi_o(ADC_SDIO),
		.spi_sclk_o(ADC_SCLK),
		.spi_miso_i(1'b0),
		.tx_o      (FIBER_TX),
		.rx_i      (FIBER_RX)
	);

	
	
endmodule
