module simple_rampgen #(
	parameter START_PHASE = 100,
	parameter END_PHASE = 254,
	parameter PHASE_STEP = 76
	)(
	input wire clk,
	input wire start, 
	input wire cycle_done,
	output reg [7:0] phase_value
	);

	reg [15:0] cycle_counter = 0; 

	reg [23:0] phase_value_reg; 


	always@(posedge clk) begin 

		phase_value_reg <= (START_PHASE<<8) + (PHASE_STEP*cycle_counter);

		if ((phase_value_reg>>8) > END_PHASE) begin 
			phase_value <= END_PHASE;
		end 
		else begin 
			phase_value <= (phase_value_reg>>8);
		end

		if(start) begin 
			cycle_counter <= 0;
		end 
		else begin 
			if (cycle_done) begin
				cycle_counter <= cycle_counter + 1;
			end 
		end
	end

endmodule 