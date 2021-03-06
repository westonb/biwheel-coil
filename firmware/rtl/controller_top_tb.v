`timescale 1ns/1ps
module controller_top_tb;
	reg [9:0] ADC_DATA;
	reg ADC_DCO;
	//reg DEBUG_RX;
	wire DEBUG_RX;
	reg FIBER_RX;
	wire ZCS;
	reg VP_0;
	reg VN_0;
	reg OVER_TEMP;

	wire ADC_SCLK;
	wire ADC_SDIO;
	wire ADC_CS;
	wire ADC_MODE;

	wire LED1;
	wire LED2;
	wire DEBUG_TX, FIBER_TX;

	wire GATE1, GATE2, GATE3, GATE4, GATE_CHARGE, GATE_BOOST;

	wire ADC_MUX, XADC_MUX;

	wire clk;

	reg [1023:0] delay_reg;

	assign clk = ADC_DCO;
	
	assign ZCS = ~delay_reg[300];


	always #10 ADC_DCO = ~ ADC_DCO;

	initial begin
		ADC_DATA = 512 + 100;
		ADC_DCO = 0;
		//DEBUG_RX = 1;
		FIBER_RX = 1;
		VP_0 = 0;
		VN_0 = 0;
		OVER_TEMP = 0;
		#10000;
		ADC_DATA = 512 + 150;
		delay_reg = 0; 
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

	always@(posedge ADC_DCO) begin
		delay_reg <= {delay_reg[1022:0], GATE1};
	end

	reg [7:0] buffer;
	localparam ser_half_period = 53;
	event ser_sample;

	always begin
		@(negedge FIBER_TX);

		repeat (ser_half_period) @(posedge clk);
		-> ser_sample; // start bit

		repeat (8) begin
			repeat (ser_half_period) @(posedge clk);
			repeat (ser_half_period) @(posedge clk);
			buffer = {FIBER_TX, buffer[7:1]};
			-> ser_sample; // data bit
		end

		repeat (ser_half_period) @(posedge clk);
		repeat (ser_half_period) @(posedge clk);
		-> ser_sample; // stop bit

		if (buffer < 32 || buffer >= 127)
			$display("Serial data: %d", buffer);
		else
			$display("Serial data: '%c'", buffer);
	end

endmodule 