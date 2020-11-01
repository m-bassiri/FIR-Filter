module FIR #(parameter SIZE = 19)
	(
		input clk,[15:0] data_in,reset, 
		
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
	always @(posedge clk) begin
	if(reset)
		for(i = 0; i < SIZE-1; i = i + 1)
			reg_data[i ] <=  0;
	else
		begin	
			reg_data[0] <=  data_in;
			for(i = 0; i < SIZE-1; i = i + 1)
				reg_data[i + 1] <=  reg_data[i];
		end
	end
	always @(*) begin
		sum = 0;
		for(i = 0; i < SIZE; i = i + 1)
			 sum = sum + reg_data[i] * coef[i];
		data_out = sum[35:19];//ghesmate por arzesh ra bayad be data_out bedim :)
	end
	

endmodule