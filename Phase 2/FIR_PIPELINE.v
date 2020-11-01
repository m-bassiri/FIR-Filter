`timescale 1ns / 100ps

module FIR_PIPELINE (
	input reg signed [15:0] data_in,
	input reg clk,reset,
	output [15:0] data_out
);
	wire signed [15:0] coef[18:0];
	reg signed [35:0] sum[18:0];
	
	assign data_out = sum[18][35:19];
	
	integer i,out;
	
//	initial
//		out = $fopen("C:/Users/ALI-PC/Desktop/lessons/verilog HDL/final project/project/02/pipeline/out/out_pipeline.txt", "wb");
	
	always @(posedge clk) begin
		if(reset)
			for(i=0;i<19;i = i + 1)
				sum[i] <= 0;
		else begin
			sum[0] <= coef[18]*data_in;
			for(i=1;i<19;i = i + 1) begin
				sum[i] <= sum[i-1] + coef[18-i]*data_in;
			end
		end		
		//$display("out = %b     time = %d",sum[18],$realtime);
	end
	
	// always @(posedge clk) begin
		// #2
		// $fwrite(out,"data_in = %d      data_out = %d   ,time = %d \n",data_in,data_out,$realtime-2);
	// end
	
	assign coef[0] = 26;
	assign coef[1] = 270;
	assign coef[2] = 963;
	assign coef[3] = 2424;
	assign coef[4] = 4869;
	assign coef[5] = 8259;
	assign coef[6] = 12194;
	assign coef[7] = 15948;
	assign coef[8] = 18666;
	assign coef[9] = 19660;
	assign coef[10] = 18666;
	assign coef[11] = 15948;
	assign coef[12] = 12194;
	assign coef[13] = 8259;
	assign coef[14] = 4869;
	assign coef[15] = 2424;
	assign coef[16] = 963;
	assign coef[17] = 270;
	assign coef[18] = 26;

endmodule