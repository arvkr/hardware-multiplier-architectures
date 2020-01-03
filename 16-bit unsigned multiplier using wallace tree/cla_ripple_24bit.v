//A 24-bit adder built using one 16-bit CLA module and one 8-bit CLA module with the carries rippling from one to the other
`include "cla_8bit.v"
`include "cla_16bit.v"
module cla_ripple_24bit(sum,c24,a,b,c0);
	output [23:0] sum;
	output c24;
	input [23:0] a,b;
	input c0;
	wire c16;
	cla_16bit c16b1(.sum(sum[15:0]),.c16(c16),.a(a[15:0]),.b(b[15:0]),.c0(c0));
	cla_8bit c8b1(.sum(sum[23:16]),.c8(c24),.a(a[23:16]),.b(b[23:16]),.c0(c16));
endmodule

/*
module tb_cla_ripple_24bit();
	reg [23:0] a,b;
	reg c0;
	wire [23:0] d;
	wire cout;
	cla_ripple_24bit uut(.sum(d),.c24(cout),.a(a),.b(b),.c0(c0));
	
	initial
	begin
	#00 a=16'd10; b=16'd10; c0 = 1'b0; //10-2
	#20 a=16'd300; b=16'd20; c0 = 1'b0;
	#20 a=16'd65500; b=16'd20000; c0 = 1'b0; //3-5
	#20 a=16'd1000; b=16'd255; c0 = 1'b0;
	#20 $stop;
	end
	
	initial
	begin
	$monitor("time=%3d, a=%24d, b=%24d, co=%b, d=%24d, cout=%1b",$time,a,b,c0,d,cout);
	end
		
	initial
	begin
	$dumpfile("cla_ripple_24bit.vcd");
	$dumpvars;
	end
	
endmodule
*/