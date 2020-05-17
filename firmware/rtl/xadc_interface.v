`timescale 1ns/1ps
module xadc_interface(
	input wire clk, 
	input wire vp_in,
	input wire vn_in, 
	output reg mux_ctrl, 
	output reg new_data,
	output reg [11:0] data_a,
	output reg [11:0] data_b,
    output reg valid_data
);

    localparam BLANK_TIME = 1000;
    localparam MAX_SAMPLE_TIME = 24000;

	localparam FSM_START_1 = 0;
	localparam FSM_CONVERSION_1 = 1;
    localparam FSM_WAIT_1 = 2;
    localparam FSM_READ_1 = 3;
    localparam FSM_START_2 = 4;
    localparam FSM_CONVERSION_2 = 5;
    localparam FSM_WAIT_2 = 6;
    localparam FSM_READ_2 = 7;
    localparam FSM_BOOT = 8;
    localparam FSM_BLANK_1 = 9;
    localparam FSM_BLANK_2 = 10;


	reg [3:0] fsm_state = FSM_BOOT;
    reg [23:0] timer = 0;
    reg [23:0] valid_data_timer;

	reg conversion_start = 0;
	reg den_in = 0;

	wire busy_out;
	wire [15:0] do_out;
	wire drdy_out;
	wire eoc_out;

    reg busy_out_reg;
    reg [15:0] do_out_reg;
    reg drdy_out_reg;
    reg eoc_out_reg;


    initial begin 
        mux_ctrl = 1'b0;
        new_data = 1'b0;
        data_a = 12'b0;
        data_b = 12'b0;
        fsm_state = FSM_BOOT;

        busy_out_reg = 0;
        do_out_reg = 0;
        drdy_out_reg = 0;
        eoc_out_reg = 0;
        valid_data_timer = 0;
        valid_data = 0;
    end 

	always @(posedge clk) begin

        busy_out_reg <= busy_out;
        do_out_reg <= do_out;
        drdy_out_reg <= drdy_out;
        eoc_out_reg <= eoc_out;

        if (valid_data_timer < MAX_SAMPLE_TIME) begin 
            valid_data_timer <= valid_data_timer + 1;
        end else begin 
            valid_data <= 1'b0;
        end

        if (new_data) begin
            valid_data = 1'b1;
            valid_data_timer <= 0;
        end

        if (data_b<275) begin //sanity check to not blow up boost converter
            valid_data <= 0;
        end


		case (fsm_state)

            FSM_BOOT: begin
                if (!busy_out_reg) begin
                    timer <= timer+1;
                    if (timer == 600000) fsm_state <= FSM_START_1;
                end
                else begin 
                    timer <= 0;
                end
            end



			FSM_START_1: begin
                new_data <= 1'b0;
                if(!busy_out_reg) begin
    				mux_ctrl <= 1'b0;
    				fsm_state <= FSM_BLANK_1;
                    timer <= 0;
                end
			end 

            FSM_BLANK_1: begin 
                timer <= timer + 1;
                if (timer >= BLANK_TIME) begin
                    timer <= 0;
                    fsm_state <= FSM_CONVERSION_1;
                end
            end 


			FSM_CONVERSION_1: begin
				conversion_start <= 1'b1;
				fsm_state <= FSM_WAIT_1;
			end

			FSM_WAIT_1: begin 
				conversion_start <= 1'b0;
                if (eoc_out_reg) begin
				    fsm_state <= FSM_READ_1;
                    den_in <= 1'b1;
                end
            end

            FSM_READ_1: begin
                den_in <= 1'b0;
                if(drdy_out_reg) begin
                    data_a <= do_out_reg[15:4];
                    fsm_state <= FSM_START_2;
                    mux_ctrl <= 1'b1;
                end
            end


            FSM_START_2: begin
                if(!busy_out_reg) begin
                    fsm_state <= FSM_BLANK_2;
                     timer <= 0;
                end
            end 

             FSM_BLANK_2: begin
                timer <= timer + 1;
                if (timer >= BLANK_TIME) begin
                    timer <= 0;
                    fsm_state <= FSM_CONVERSION_2;
                end

            end 

            FSM_CONVERSION_2: begin
                conversion_start <= 1'b1;
                fsm_state <= FSM_WAIT_2;
            end

            FSM_WAIT_2: begin 
                conversion_start <= 1'b0;
                if (eoc_out_reg) begin
                    fsm_state <= FSM_READ_2;
                    den_in <= 1'b1;
                end
            end

            FSM_READ_2: begin
                den_in <= 1'b0;
                if(drdy_out_reg) begin
                    data_b <= do_out_reg[15:4];
                    fsm_state <= FSM_START_1;
                    mux_ctrl <= 1'b0;
                    new_data <= 1'b1;
                end
            end

		endcase 
	end




XADC #(
        .INIT_40(16'h8203), // config reg 0
        .INIT_41(16'h313F), // config reg 1
        .INIT_42(16'h0A00), // config reg 2
        .INIT_48(16'h0100), // Sequencer channel selection
        .INIT_49(16'h0000), // Sequencer channel selection
        .INIT_4A(16'h0000), // Sequencer Average selection
        .INIT_4B(16'h0000), // Sequencer Average selection
        .INIT_4C(16'h0000), // Sequencer Bipolar selection
        .INIT_4D(16'h0000), // Sequencer Bipolar selection
        .INIT_4E(16'h0000), // Sequencer Acq time selection
        .INIT_4F(16'h0000), // Sequencer Acq time selection
        .INIT_50(16'hB5ED), // Temp alarm trigger
        .INIT_51(16'h57E4), // Vccint upper alarm limit
        .INIT_52(16'hA147), // Vccaux upper alarm limit
        .INIT_53(16'hCA33),  // Temp alarm OT upper
        .INIT_54(16'hA93A), // Temp alarm reset
        .INIT_55(16'h52C6), // Vccint lower alarm limit
        .INIT_56(16'h9555), // Vccaux lower alarm limit
        .INIT_57(16'hAE4E),  // Temp alarm OT reset
        .INIT_58(16'h5999), // VCCBRAM upper alarm limit
        .INIT_5C(16'h5111),  //  VCCBRAM lower alarm limit
        .SIM_DEVICE("7SERIES"),
        .SIM_MONITOR_FILE("design1.txt")
)

inst (
        .CONVST(conversion_start),
        .CONVSTCLK(1'b0),
        .DADDR(7'h03), // hard wired to read vp/vn 
        .DCLK(clk),
        .DEN(den_in),
        .DI(16'b0),
        .DWE(1'b0),
        .RESET(1'b0),
        .VAUXN(16'b0),
        .VAUXP(16'b0),
        .ALM(),
        .BUSY(busy_out),
        .CHANNEL(),
        .DO(do_out),
        .DRDY(drdy_out),
        .EOC(eoc_out),
        .EOS(),
        .JTAGBUSY(),
        .JTAGLOCKED(),
        .JTAGMODIFIED(),
        .OT(),
        .MUXADDR(),
        .VP(vp_in),
        .VN(vn_in)
          );
endmodule 
