module Test_FIR();

	reg [15:0] tmp_test=0;
	wire [15:0] data_out;
	reg clk=0,reset =0;
	reg signed [15:0] data_in;
	
	FIR uut(
		.clk(clk), 
		.data_in(data_in),
		.reset(reset),
		.data_out(data_out)
		);
		
	always  #  5 clk = ~clk;
		
	integer in, out;
	initial	begin
		#10
		reset =1;
		
		#30
		reset =0;	
			
		in  = $fopen("Audio_Noisy_Binary.txt", "r");
		out = $fopen("output.txt", "w");
		while ( ! $feof(in)) begin
			  @ (negedge clk);
				$fscanf(in,"%b\n",data_in);
				$fwrite(out,"%b\n",data_out);
				
				if($feof(in))
				$display("finishhhhhhhhed_1\n");
			end
			
		#20
		
		$fclose(in);
		$fclose(out);
	end
		 
endmodule	