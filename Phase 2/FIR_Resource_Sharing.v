module FIR_Resource_Sharing #(parameter SIZE = 19)
	(
		input clk, reset, 
		input [15:0] data_in, 
		output reg signed [15:0] data_out
	);
		
	reg signed [15:0] reg_data [SIZE - 1:0];
	wire signed [15:0] coef [SIZE-1:0];
	reg signed [35:0] sum;
	
	assign coef [0] = 26;
	assign coef [1] = 270;
	assign coef [2] = 963;
	assign coef [3] = 2424;
	assign coef [4] = 4869;
	assign coef [5] = 8259;
	assign coef [6] = 12194;
	assign coef [7] = 15948;
	assign coef [8] = 18666;
	assign coef [9] = 19660;
	assign coef [10] = 18666;
	assign coef [11] = 15948;
	assign coef [12] = 12194;
	assign coef [13] = 8259;
	assign coef [14] = 4869;
	assign coef [15] = 2424;
	assign coef [16] = 963;
	assign coef [17] = 270;
	assign coef [18] = 26;
	
	integer i;
	reg [4:0]counter =0;
	always @(posedge clk) begin
	if(reset)
		for(i = 0; i < SIZE-1; i = i + 1)
			reg_data[i ] <=  0;
	else
		begin	
			 sum <= sum + reg_data[counter] * coef[counter];
			 counter <= (counter+1)%20;
			 if(counter == 19)//data out is completed
			begin	
				data_out = sum[35:19];
				reg_data[0] <=  data_in;
				sum <= 0;
				for(i = 0; i < SIZE-1; i = i + 1)
					reg_data[i + 1] <=  reg_data[i];
			end		
		end	
	end

endmodule