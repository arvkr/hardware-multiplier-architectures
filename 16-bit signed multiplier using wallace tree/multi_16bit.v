//Implementing large multiplier using small multipliers
//Implementing a 16-bit multiplier using 4 8-bit multiplier modules where the 4 partial products are added using a 1-level Wallace tree (CSA)
`include "multi_8bit_unsigned.v"
`include "multi_8bit.v"
`include "csa_24bit.v"
`include "cla_ripple_24bit.v"
`include "mux_2x1_12bit.v"
`include "mux_2x1_8bit.v"
`include "carry.v"
`include "carry_prop_gen.v"
`include "sum.v"
`include "cla_4bit_2.v"
`include "piso_2bit.v"
`include "reco_unit.v"
`include "mux_4x1.v"
`include "accumulator.v"
`include "cla_ripple_8bit.v"
`include "full_adder.v"
`include "dff.v"
`include "cla_ripple_12bit.v"
`include "dff_us.v"
`include "piso_2bit_us.v"
`include "reco_unit_us.v"
`include "mux_4x1_us.v"
`include "accumulator_us.v"
`include "cla_4bit.v"
`include "cla_8bit.v"
`include "cla_16bit.v"
`include "full_adder_norm.v"
`include "dff_16bit.v"
`include "multi_8bit_signed_unsigned.v"

module multi_16bit(prod,a,b,clk,rst,load);
	output [31:0] prod;
	input [15:0] a,b;
	input clk,rst,load;
	wire [15:0] ahxl,alxl,ahxh,alxh,ahxhm;
	wire [23:0] ahxlex,alxhex,s1,c1;
	multi_8bit_signed_unsigned m8bsu1(.prod(ahxl),.a(a[15:8]),.b(b[7:0]),.clk(clk),.rst(rst),.load(load));
	//dff_16bit d16b1(.q(ahxl),.d(ahxlm),.clk(clk),.rst(rst));
	multi_8bit_unsigned m8bu1(.prod(alxl),.a(a[7:0]),.b(b[7:0]),.clk(clk),.rst(rst),.load(load));
	multi_8bit m8b1(.prod(ahxhm),.a(a[15:8]),.b(b[15:8]),.clk(clk),.rst(rst),.load(load));
	dff_16bit d16b2(.q(ahxh),.d(ahxhm),.clk(clk),.rst(rst));
	multi_8bit_signed_unsigned m8bsu2(.prod(alxh),.a(b[15:8]),.b(a[7:0]),.clk(clk),.rst(rst),.load(load));
	//dff_16bit d16b3(.q(alxh),.d(alxhm),.clk(clk),.rst(rst));
	assign ahxlex = { {8{ahxl[15]}} , ahxl };
	assign alxhex = { {8{alxh[15]}} , alxh };
	csa_24bit c24b1(.s(s1),.c(c1),.x(ahxlex),.y({ahxh,alxl[15:8]}),.z(alxhex));
	cla_ripple_24bit cr24b1(.sum(prod[31:8]),.c24(x),.a(s1),.b({c1[22:0],1'b0}),.c0(1'b0));
	assign prod[7:0]=alxl[7:0];
endmodule

module tb_multi_16bit();
	reg [15:0] a,b;
	reg clk,rst,load;
	wire [31:0] prod;
	multi_16bit uut(.prod(prod),.a(a),.b(b),.clk(clk),.rst(rst),.load(load));
	
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
	#110 load = 1'b1; a = 16'd640; b = 16'd288; //640*288
	# 60 load = 1'b0; 
	
	#570 load = 1'b1; a = 16'b1111111110000000; b = 16'b0000000111000000; //-128*448 at 740 ps
	# 20 load = 1'b0; //at 760 ps. result out at 1050 ps.
	#580 load = 1'b1; a = 16'b0111111111111111; b = 16'b1000000000000000; // 32767*(-32768)
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 16'b0000111011110101; b = 16'b0000101101111001; //3829*2937
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 16'b1010101010101010; b = 16'b1101010101010101; // -21846*-10923
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 16'd55; b = 16'd46;
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 16'd7; b = 16'd211;
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
	$dumpfile("multi_16bit.vcd");
	$dumpvars;
	end
	
endmodule