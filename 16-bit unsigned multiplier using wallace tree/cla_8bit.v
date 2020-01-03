//A 2-level 8-bit CLA built using 2 modules of a 1-level 4bit CLA
//`include "cla_4bit.v"
module cla_8bit(sum,c8,a,b,c0);
	output [7:0] sum;
	output c8;
	input [7:0] a,b;
	wire [1:0] gs,ps;
	input c0;
	wire c4;
	cla_4bit c4b1(.sum(sum[3:0]),.ps(ps[0]),.gs(gs[0]),.a(a[3:0]),.b(b[3:0]),.c0(c0));
	cla_4bit c4b2(.sum(sum[7:4]),.ps(ps[1]),.gs(gs[1]),.a(a[7:4]),.b(b[7:4]),.c0(c4));
	carry_3 c1(.c1(c4),.c2(c8),.p(ps),.g(gs),.c0(c0));
endmodule

module carry_3(c1,c2,p,g,c0);
	output c1,c2;
	input [1:0] p,g;
	input c0;
	assign c1 = g[0] | c0&p[0] ; 
	assign c2 = g[1] | g[0]&p[1] | c0&p[0]&p[1];
	//assign c3 = g[2] | g[1]&p[2] | g[0]&p[1]&p[2] | c0&p[0]&p[1]&p[2];
	//assign c4 = g[3] | g[2]&p[3] | g[1]&p[2]&p[3] | g[0]&p[1]&p[2]&p[3] | c0&p[0]&p[1]&p[2]&p[3];
endmodule

/*
module tb_cla_8bit();
	reg [7:0] a,b;
	reg c0;
	wire [7:0] d;
	wire cout;
	cla_8bit uut(.sum(d),.c8(cout),.a(a),.b(b),.c0(c0));
	
	initial
	begin
	#00 a=8'd10; b=8'd10; c0 = 1'b0; //10-2
	#20 a=8'd30; b=8'd20; c0 = 1'b0;
	#20 a=8'd150; b=8'd30; c0 = 1'b0; //3-5
	#20 a=8'd255; b=8'd0; c0 = 1'b0;
	#20 $stop;
	end
	
	initial
	begin
	$monitor("time=%3d, a=%8d, b=%8d, co=%b, d=%8d, cout=%1b",$time,a,b,c0,d,cout);
	end
		
	initial
	begin
	$dumpfile("cla_8bit.vcd");
	$dumpvars;
	end
	
endmodule
*/