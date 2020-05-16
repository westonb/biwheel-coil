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
 	

	wire [31:0] gpio_i, gpio_o;

	//reset generation
	wire reset;

	//connecting wires 
	wire [11:0] vin_adc, vout_adc;

	reg [31:0] counter = 0;

	wire qcw_start;
	wire qcw_halt;
	wire qcw_halt_driver;
	wire qcw_halt_ocd;
	wire qcw_halt_ramp;
	wire [7:0] qcw_phase_value;
	wire qcw_ready;
	wire qcw_cycle_done;
	wire [15:0] qcw_cycle_limit;


	//wires for bus connections 
	wire core_valid, core_ready;
	wire [31:0] core_addr, core_wdata, core_rdata;
	wire [3:0] core_wstrb;

	//ram and rom 
	wire [31:0] ram_rdata, rom_rdata;
	wire ram_ready, rom_ready;

	//uart
	wire [31:0] uart_rdata;
	wire uart_ready;

	//clock crossing 
	wire [31:0] crossing_rdata, crossed_rdata;
	wire crossing_ready, crossed_ready;
	wire [31:0] crossed_addr, crossed_wdata;
	wire [3:0] crossed_wstrb;
	wire crossed_valid;

	//GPIO peripheral
	wire [31:0] gpio_rdata;
	wire gpio_ready;

	//QCW peripherals 
	wire [31:0] qcw_control_rdata, qcw_ramp_rdata, qcw_ocd_rdata, boost_rdata;
	wire qcw_control_ready, qcw_ramp_ready, qcw_ocd_ready, boost_ready;

	assign crossed_ready = gpio_ready | qcw_control_ready | qcw_ramp_ready | qcw_ocd_ready | boost_ready;
	assign crossed_rdata = gpio_rdata | qcw_control_rdata | qcw_ramp_rdata | qcw_ocd_rdata | boost_rdata;

	assign core_ready = ram_ready | rom_ready | crossing_ready | uart_ready;
	assign core_rdata = ram_rdata | rom_rdata | crossing_rdata | uart_rdata;

	assign qcw_halt = qcw_halt_ramp | qcw_halt_driver | qcw_halt_ocd;

	assign reset = (counter < 10) ? 1 : 0;

	assign ADC_SCLK = 0;
	assign ADC_SDIO = 0;
	assign ADC_CS = 1;
	assign ADC_MODE = 0; 

	assign gpio_i = {31'b0, OVER_TEMP};
	assign ADC_MUX = gpio_o[0]; //mux==1: OCD connected, mux==0 boost converter current sense
	assign GATE_CHARGE = gpio_o[1];
	assign {LED2,LED1} = gpio_o[3:2];


	/* 
	Softcore Memory Map: 
	32'h00000000 RAM
	32'h00100000 ROM
	32'h01000000 UART
	//cross clock domain crossing 
	32'h10000000 GPIO
	32'h11000000 QCW Ramp Control 
	32'h12000000 QCW Driver Control 
	32'h13000000 QCW OCD Control 
	32'h14000000 Boost Control 
	*/




	always@(posedge clk_80MHz) begin 
		if (counter < 10000) counter <= counter + 1;
	end




	picorv32 #(

		.ENABLE_COUNTERS     (1),
		.ENABLE_COUNTERS64   (1),
		.ENABLE_REGS_16_31   (1),
		.ENABLE_REGS_DUALPORT(1),
		.TWO_STAGE_SHIFT     (1),
		.BARREL_SHIFTER      (0),
		.TWO_CYCLE_COMPARE   (0),
		.TWO_CYCLE_ALU       (0),
		.COMPRESSED_ISA      (0),
		.CATCH_MISALIGN      (1),
		.CATCH_ILLINSN       (1),
		.ENABLE_PCPI         (0),
		.ENABLE_MUL          (0),
		.ENABLE_FAST_MUL     (1),
		.ENABLE_DIV          (1),
		.ENABLE_IRQ          (0),
		.ENABLE_IRQ_QREGS    (0),
		.ENABLE_IRQ_TIMER    (0),
		.ENABLE_TRACE        (0),
		.REGS_INIT_ZERO      (0),
		.MASKED_IRQ          (32'b0),
		.LATCHED_IRQ         (32'hffff_ffff),
		.PROGADDR_RESET      (32'h0010_0000),
		.PROGADDR_IRQ        (32'h0000_0010),
		.STACKADDR           (32'h0000_4000)

	) picorv32_core (
		.clk      (clk_80MHz   ),
		.resetn   (~reset),

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
		.LOG_SIZE (13),
		.MEMFILE  ("src/firmware.hex")
	) rom (
		.clk        (clk_80MHz),
		.mem_valid_i(core_valid),
		.mem_ready_o(rom_ready),
		.mem_addr_i (core_addr),
		.mem_wdata_i(core_wdata),
		.mem_wstrb_i(core_wstrb),
		.mem_rdata_o(rom_rdata)
	);

	simple_mem #(
		.BASE_ADDR(32'h00000000),
		.LOG_SIZE (12),
		.MEMFILE  ("")
	) ram (
		.clk        (clk_80MHz),
		.mem_valid_i(core_valid),
		.mem_ready_o(ram_ready),
		.mem_addr_i (core_addr),
		.mem_wdata_i(core_wdata),
		.mem_wstrb_i(core_wstrb),
		.mem_rdata_o(ram_rdata)
	);

	interface_simpleuart #(
		.BASE_ADDR(32'h01000000)
	) uart ( 
		.clk(clk_80MHz),
		.reset(reset),

		.mem_valid_i(core_valid),
		.mem_ready_o(uart_ready),
		.mem_addr_i (core_addr),
		.mem_wdata_i(core_wdata),
		.mem_wstrb_i(core_wstrb),
		.mem_rdata_o(uart_rdata),

		.rx(FIBER_RX),
		.tx(FIBER_TX)
	);


	simple_clock_crossing #(
		.BASE_ADDR (32'h10000000),
		.UPPER_ADDR(32'h20000000)
	) clock_crossing (
		.clk_a      (clk_80MHz),
		.clk_b      (clk_240MHz),
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

	gpio_control #(
		.BASE_ADDR(32'h10000000)
	) simple_gpio (
		.clk(clk_240MHz),
		.reset(1'b0),
		.mem_valid_i(crossed_valid),
		.mem_ready_o(gpio_ready), 
		.mem_addr_i(crossed_addr), 
		.mem_wdata_i(crossed_wdata), 
		.mem_wstrb_i(crossed_wstrb), 
		.mem_rdata_o(gpio_rdata), 
		.gpio_i(gpio_i), 
		.gpio_o(gpio_o)
	);

	
	qcw_ramp_control #(
		.BASE_ADDR(32'h11000000)
	) simple_ramp (
		.clk(clk_240MHz),
		.reset(1'b0),
		.mem_valid_i(crossed_valid),
		.mem_ready_o(qcw_ramp_ready), 
		.mem_addr_i(crossed_addr), 
		.mem_wdata_i(crossed_wdata), 
		.mem_wstrb_i(crossed_wstrb), 
		.mem_rdata_o(qcw_ramp_rdata), 

		.qcw_start(qcw_start),
		.qcw_cycle_done(qcw_cycle_done), 
		.qcw_halt(qcw_halt_ramp), 
		.qcw_phase_value(qcw_phase_value)
	);


	qcw_driver_control #(
		.BASE_ADDR(32'h12000000)
	) simple_control (
		.clk(clk_240MHz),
		.reset(1'b0),

		.mem_valid_i(crossed_valid),
		.mem_ready_o(qcw_control_ready), 
		.mem_addr_i(crossed_addr), 
		.mem_wdata_i(crossed_wdata), 
		.mem_wstrb_i(crossed_wstrb), 
		.mem_rdata_o(qcw_control_rdata), 

		.qcw_start(qcw_start), 
		.qcw_cycle_limit(qcw_cycle_limit), 
		.qcw_halt(qcw_halt_driver), 
		.qcw_ready(qcw_ready)
	);


	qcw_ocd_control #(
		.BASE_ADDR(32'h13000000)
	) simple_ocd (
		.clk(clk_240MHz),
		.reset(1'b0),

		.mem_valid_i(crossed_valid),
		.mem_ready_o(qcw_ocd_ready), 
		.mem_addr_i(crossed_addr), 
		.mem_wdata_i(crossed_wdata), 
		.mem_wstrb_i(crossed_wstrb), 
		.mem_rdata_o(qcw_ocd_rdata), 


		.adc_dout(ADC_DATA),
		.qcw_start(qcw_start), 
		.qcw_halt(qcw_halt_ocd)
	);


	boost_converter_control #(
		.BASE_ADDR(32'h14000000), 
		.I_LIMIT(), 
		.VOUT_HYSTERESIS(), 
		.OFF_TIME(), 
		.ON_TIME_MAX(), 
		.BLANK_TIME()
	) simple_boost (
		.clk(clk_240MHz),
		.reset(1'b0),

		.mem_valid_i(crossed_valid),
		.mem_ready_o(boost_ready), 
		.mem_addr_i(crossed_addr), 
		.mem_wdata_i(crossed_wdata), 
		.mem_wstrb_i(crossed_wstrb), 
		.mem_rdata_o(boost_rdata), 

		.il_adc(ADC_DATA), 
		.vin_adc(vin_adc), 
		.vout_adc(vout_adc), //vout_adc
		.sw_out(GATE_BOOST), 
		.boost_running()
	);

	qcw_driver #(
		.STARTING_PERIOD(600),
		.PHASE_LEAD     (60),
		.DEADTIME		(18)
		) driver (
		.clk           (clk_240MHz),
		.zcs           (~ZCS),
		.halt          (qcw_halt),
		.start         (qcw_start),
		.phase_shift   (qcw_phase_value),
		.cycle_limit   (qcw_cycle_limit),
		.ready         (qcw_ready),
		.cycle_finished(qcw_cycle_done),
		.fault         (),
		.sw1_drive     (GATE1),
		.sw2_drive     (GATE2),
		.sw3_drive     (GATE3),
		.sw4_drive     (GATE4),
		.zcs_state_debug   (DEBUG_TX),
		.output_state_debug(DEBUG_RX)
	);

	xadc_interface xadc (
		.clk     (clk_240MHz),
		.vp_in   (VP_0),
		.vn_in   (VN_0),
		.mux_ctrl(XADC_MUX),
		.new_data(),
		.data_a  (vin_adc),
		.data_b  (vout_adc)
	);

	system_clocking system_clocks (
		.clk_80MHz_i(ADC_DCO),
		.clk_80MHz_o(clk_80MHz),
		.clk_240MHz_o(clk_240MHz)
	);

	
endmodule
