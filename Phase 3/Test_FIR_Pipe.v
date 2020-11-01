`timescale 1ns / 1ps
module Test_FIR_Pipe;
	reg [15:0] din;
	reg clk;
	wire [15:0] dout;
	wire rfd, rdy;
	
	FIR_Pipe myfir (.clk(clk), .rfd(rfd), .rdy(rdy), .din(din), .dout(dout));
	
	always #10 clk = ~clk;
	integer j, i, out;
	reg [15:0] mem [1:441000];
	initial begin
		j = 0;
		clk = 0;
		out = $fopen("C:/Users/user/Downloads/Compressed/out.bin", "wb");
		$readmemb("C:/Users/user/Downloads/Compressed/Audio_Noisy_Binary.txt", mem);
		for (i = 1; i <= 441000; i = i + 1) begin #22675
			din = mem[i];
		end
	end
	always @(posedge clk) begin
		if (rdy) begin
			j = j + 1;
			if (dout !== 16'bx)
				$fwrite(out, "%b\n", dout);
			else
				$fwrite(out, "0000000000000000\n");
		end
		if (j == 441001)
			$finish;
	end


endmodule
