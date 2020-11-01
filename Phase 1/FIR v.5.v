module FIR #(parameter SIZE = 19)
	(
		input clk,[15:0] data_in,reset, 
		
		output reg signed [15:0] data_out
	);
		
	reg [35:0]hasel_zarb[SIZE-1:0];	
		
	reg [1:0]level =0;	
		
		
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
	begin
		level <=0;
		for(i = 0; i < SIZE-1; i = i + 1)
			reg_data[i ] <=  0;
	end		
	else
		begin	
		level <= level +1;
		if(level ==0)
		begin
			reg_data[0] <=  data_in;
			for(i = 0; i < SIZE-1; i = i + 1)
				reg_data[i + 1] <=  reg_data[i];
			
		end
		if(level ==1)
			for(i = 0; i < SIZE; i = i + 1)
			begin
				hasel_zarb[i]<= reg_data[i] * coef[i];
				
					
			end		
		if(level ==2)
			sum <= 	hasel_zarb[0]+hasel_zarb[1]+hasel_zarb[2]+hasel_zarb[3]+hasel_zarb[4]+hasel_zarb[5]+hasel_zarb[6]+hasel_zarb[7]+hasel_zarb[8]+hasel_zarb[9]+hasel_zarb[10]+hasel_zarb[11]+hasel_zarb[12]+hasel_zarb[13]+hasel_zarb[14]+hasel_zarb[15]+hasel_zarb[16]+hasel_zarb[17]+hasel_zarb[18];
		if(level == 3)
		begin	
			data_out <= sum[35:19];
			level <= 0;
			
		end		
	end
	/*always @(reg_data) begin
		sum = 0;
		for(i = 0; i < SIZE; i = i + 1)
		begin	 
			sum = sum + reg_data[i] * coef[i];
		
		end	
		data_out = sum[35:19];//ghesmate por arzesh ra bayad be data_out bedim :)
		
	end
	*/
	end
endmodule