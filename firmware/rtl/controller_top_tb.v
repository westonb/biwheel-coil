`timescale 1ns/1ps
module controller_top_tb;
	reg [9:0] ADC_DATA;
	reg ADC_DCO;
	reg DEBUG_RX;
	reg FIBER_RX;
	reg ZCS;
	reg VP_0;
	reg VN_0;

	wire ADC_SCLK;
	wire ADC_SDIO;
	wire ADC_CS;
	wire ADC_MODE;
	wire LED1;
	wire LED2;
	wire DEBUG_TX;
	


	always #10 ADC_DCO = ~ ADC_DCO;

	initial begin
		ADC_DATA = 12'b10_0010_0000;
		ADC_DCO = 0;
		DEBUG_RX = 1;
		FIBER_RX = 1;
		ZCS = 0;
		VP_0 = 0;
		VN_0 = 0;
	end

	controller_top uut (
		.VP_0       (VP_0),
		.VN_0       (VN_0),
		.XADC_MUX   (XADC_MUX),
		.ADC_MUX    (ADC_MUX),
		.OVER_TEMP  (OVER_TEMP),
		.GATE1      (GATE1),
		.GATE2      (GATE2),
		.GATE3      (GATE3),
		.GATE4      (GATE4),
		.GATE_CHARGE(GATE_CHARGE),
		.GATE_BOOST (GATE_BOOST),
		.ADC_DATA(ADC_DATA),
		.ADC_DCO (ADC_DCO),
		.ADC_SCLK(ADC_SCLK),
		.ADC_SDIO(ADC_SDIO),
		.ADC_CS  (ADC_CS),
		.ADC_MODE(ADC_MODE),
		.LED1    (LED1),
		.LED2    (LED2),
		.DEBUG_TX(DEBUG_TX),
		.DEBUG_RX(DEBUG_RX),
		.FIBER_TX(FIBER_TX),
		.FIBER_RX(FIBER_RX),
		.ZCS     (ZCS)
		);

endmodule 