//Implementing large multiplier using small multipliers
//Implementing a 16-bit multiplier using 4 8-bit multiplier modules where the 4 partial products are added using a 1-level Wallace tree (CSA)
`include "multi_8bit_unsigned.v"
`include "csa_16bit.v"
`include "cla_ripple_24bit.v"

module multi_16bit_unsigned(prod,a,b,clk,rst,load);
	output [31:0] prod;
	input [15:0] a,b;
	input clk,rst,load;
	wire [15:0] ahxl,alxl,ahxh,alxh,s1,c1;
	multi_8bit_unsigned m8b1(.prod(ahxl),.a(a[15:8]),.b(b[7:0]),.clk(clk),.rst(rst),.load(load));
	multi_8bit_unsigned m8b2(.prod(alxl),.a(a[7:0]),.b(b[7:0]),.clk(clk),.rst(rst),.load(load));
	multi_8bit_unsigned m8b3(.prod(ahxh),.a(a[15:8]),.b(b[15:8]),.clk(clk),.rst(rst),.load(load));
	multi_8bit_unsigned m8b4(.prod(alxh),.a(a[7:0]),.b(b[15:8]),.clk(clk),.rst(rst),.load(load));
	csa_16bit c16b1(.s(s1),.c(c1),.x(ahxl),.y({ahxh[7:0],alxl[15:8]}),.z(alxh));
	cla_ripple_24bit cr24b1(.sum(prod[31:8]),.c24(x),.a({ahxh[15:8],s1}),.b({7'd0,c1,1'b0}),.c0(1'b0));
	assign prod[7:0]=alxl[7:0];
endmodule

module tb_multi_16bit_unsigned();
	reg [15:0] a,b;
	reg clk,rst,load;
	wire [31:0] prod;
	multi_16bit_unsigned uut(.prod(prod),.a(a),.b(b),.clk(clk),.rst(rst),.load(load));
	
	initial
	begin
	#00 clk = 1'b0;
	forever #50 clk = ~clk;
	end
	
	initial
	begin
	#00 rst = 1'b1;
	#60 rst = 1'b0;
	end
	
	initial
	begin
	#110 load = 1'b1; a = 16'b0000111011110101; b = 16'b0000101101111001; //3829*2937
	# 60 load = 1'b0; 
	
	#570 load = 1'b1; a = 16'b1111111110000000; b = 16'b0000000111000000; //65408*448 at 740 ps
	# 20 load = 1'b0; //at 760 ps. result out at 1050 ps.
	#580 load = 1'b1; a = 16'b1111111111111111; b = 16'b1111111111111111; // 65535*65535
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 16'd250; b = 16'd250;
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 16'b1010101010101010; b = 16'b0101010101010101; // 43690*21845
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 16'd5500; b = 16'd0;
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 16'd7123; b = 16'd1;
	# 20 load = 1'b0;
	#580 $stop;
	
	/*
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	*/
	end

	
	initial
	begin
	$dumpfile("multi_16bit_unsigned.vcd");
	$dumpvars;
	end
	
endmodule