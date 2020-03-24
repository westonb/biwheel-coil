module qcw_driver_tb;

	reg clk; 
	wire zcs;
	reg halt;
	reg start;
	reg [7:0] phase_shift;
	reg [15:0] cycle_limit;
	wire cycle_finished;
	wire fault;
	wire sw1_drive, sw2_drive, sw3_drive, sw4_drive;

	reg [1023:0] delay_reg;

	qcw_driver #(
		.STARTING_PERIOD(300),
		.PHASE_LEAD     (5)
		) dut (
		.clk           (clk),
		.zcs           (zcs),
		.halt          (halt),
		.start         (start),
		.phase_shift   (phase_shift),
		.cycle_limit   (cycle_limit),
		.ready         (ready),
		.cycle_finished(cycle_finished),
		.fault         (fault),
		.sw1_drive     (sw1_drive),
		.sw2_drive     (sw2_drive),
		.sw3_drive     (sw3_drive),
		.sw4_drive     (sw4_drive)
	);
	

	assign zcs = delay_reg[900];

	initial begin
		phase_shift = 230;
		clk = 0;
		delay_reg = 0;
		halt = 0;
		start = 0;
		phase_shift = 100;
		cycle_limit = 100;

		#100;
		start = 1;
		#10;
		start = 0;
		#20000;
		phase_shift = 200;
		#4000;
		phase_shift = 50;
		#4000;
		phase_shift = 10;
		#4000;
		phase_shift = 0;
		#4000;
		phase_shift = 255;

	end

	always@(posedge clk) begin
		delay_reg <= {delay_reg[1022:0], sw1_drive};
	end

	always #5 clk = ~clk;



endmodule 