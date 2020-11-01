`timescale 1ns / 1ps
module Test_FIR;
	reg [15:0] din;
	reg clk,reset;
	wire [15:0] dout_normal,dout_pipeline;
	
	FIR_NORMAL n_myfir (.reset(reset),.clk(clk), .data_in(din), .data_out(dout_normal));
	FIR_PIPELINE myfir (.reset(reset),.clk(clk), .data_in(din), .data_out(dout_pipeline));
	
	always #10 clk = ~clk;
	integer j, i, out;
	reg [15:0] mem [1:441000];
	initial begin
		j = 0;
		clk = 0;
		reset = 1;
		out = $fopen("C:/Users/ALI-PC/Desktop/lessons/verilog HDL/final project/project/02/pipeline/out/out.bin", "wb");
		$readmemb("C:/Users/ALI-PC/Desktop/lessons/verilog HDL/final project/project/02/pipeline/Audio_Noisy_Binary.txt", mem);
		#25
		reset = 0;
		#20
		for (i = 1; i <= 441000; i = i + 1) begin #20
			din = mem[i];
		end
	end
	always @(posedge clk) begin
		if (1) begin
			j = j + 1;
			if (dout_pipeline !== 16'bx)
				$fwrite(out, "%b\n", dout_pipeline);
			else
				$fwrite(out, "0000000000000000\n");
		end
		if (j == 441001)
			$finish;
	end

endmodule
