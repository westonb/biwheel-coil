`timescale 1ns/1ps
//`default_nettype none

module controller_top(
	//ADC data bus
	input wire [9:0] ADC_DATA,
	input wire ADC_DCO,
	//XADC Input pins
	input wire VP_0, 
	input wire VN_0,
	//XADC mux, 
	output wire XADC_MUX,
	//ADC configuration interface
	output wire ADC_SCLK, 
	output wire ADC_SDIO,
	output wire ADC_CS,
	output wire ADC_MODE,
	//ADC mux
	output wire ADC_MUX,
	//debug / status
	output wire LED1,
	output wire LED2,
	output wire DEBUG_TX,
	output wire DEBUG_RX,
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
	wire clk_80MHz, clk_240MHz;
 	
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
	wire reset = 0;
	
	//unused signal assign 


	//assign DEBUG_TX = 1;

	assign ADC_SCLK = 0;
	assign ADC_SDIO = 0;
	assign ADC_CS = 1;
	assign ADC_MODE = 0; 


	assign GATE_CHARGE = 1;

	assign ADC_MUX = 1;

	//assign XADC_MUX = 1;



	//register ADC_DATA
	reg [9:0] ADC_data_captured;

	//connecting wires 
	wire [11:0] vin_adc, vout_adc;
	wire xadc_update;
	wire boost_init;

	reg [31:0] counter = 0;

	wire qcw_driver_start;
	wire qcw_cycle_done;
	wire [7:0] qcw_phase;
	wire qcw_halt;

	assign qcw_driver_start = (counter[26:0]==1) ? 1 : 0;

	assign LED1 = counter[25];
	assign LED2 = 0;
	assign boost_init = counter[15];

	always@(posedge clk_240MHz) begin 
		ADC_data_captured <= ADC_DATA;
		counter <= counter + 1;
	end

	assign GATE_BOOST = 0;


	/*
	xadc_interface xadc (
		.clk     (clk_240MHz),
		.vp_in   (VP_0),
		.vn_in   (VN_0),
		.mux_ctrl(XADC_MUX),
		.new_data(xadc_update),
		.data_a  (vin_adc),
		.data_b  (vout_adc)
	);

	basic_boost_converter boost (
		.clk     (clk_240MHz),
		.il_adc  (ADC_data_captured),
		.vin_adc (vin_adc),
		.vout_adc(vout_adc),
		.boost_en(1'b0),
		.boost_init(boost_init),
		.sw_out  (GATE_BOOST)
	);
	*/

	simple_rampgen #(
		.START_PHASE(100),
		.END_PHASE(255),
		.PHASE_STEP(76)
	) rampgen (
		.clk(clk_240MHz),
		.start(qcw_driver_start), 
		.cycle_done(qcw_cycle_done),
		.phase_value(qcw_phase)
	);

	qcw_driver #(
		.STARTING_PERIOD(600),
		.PHASE_LEAD     (80)
		) driver (
		.clk           (clk_240MHz),
		.zcs           (~ZCS),
		.halt          (qcw_halt),
		.start         (qcw_driver_start),
		.phase_shift   (qcw_phase),
		.cycle_limit   (500),
		.ready         (),
		.cycle_finished(qcw_cycle_done),
		.fault         (),
		.sw1_drive     (GATE1),
		.sw2_drive     (GATE2),
		.sw3_drive     (GATE3),
		.sw4_drive     (GATE4),
		.zcs_state_debug   (DEBUG_TX),
		.output_state_debug(DEBUG_RX)
	);

	qcw_ocd #(
		.OCD_LIMIT(60) //3A
	) ocd (
		.clk        (clk_240MHz),
		.start      (qcw_driver_start),
		.enable     (1),
		.adc_dout   (ADC_DATA),
		.current_max(),
		.qcw_halt   (qcw_halt)
	);

	system_clocking system_clocks (
		.clk_80MHz_i(ADC_DCO),
		.clk_80MHz_o(clk_80MHz),
		.clk_240MHz_o(clk_240MHz)
	);


	/*
	
	base_soc soc (
		.clk_i(clk_240MHz),
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
	
	*/
endmodule
