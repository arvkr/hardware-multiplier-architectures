//`include "carry_prop_gen.v"
//`include "sum.v"
module cla_4bit(sum,ps,gs,a,b,c0);
	output [3:0] sum;
	output gs,ps;
	//wire c4;
	input [3:0] a,b;
	input c0;
	wire [3:0] p,g;
	wire c1,c2,c3;
	carry_prop_gen cpg1(.p(p),.g(g),.a(a),.b(b));
	assign gs = g[3] | g[2]&p[3] | g[1]&p[2]&p[3] | g[0]&p[1]&p[2]&p[3]; 
	assign ps = p[3]&p[2]&p[1]&p[0];
	carry_2 ca1(.c1(c1),.c2(c2),.c3(c3),.p(p),.g(g),.c0(c0));
	sum s1(.s(sum),.p(p),.c({c3,c2,c1,c0}));
endmodule



module carry_2(c1,c2,c3,p,g,c0);
	output c1,c2,c3;
	input [3:0] p,g;
	input c0;
	assign c1 = g[0] | c0&p[0] ; 
	assign c2 = g[1] | g[0]&p[1] | c0&p[0]&p[1];
	assign c3 = g[2] | g[1]&p[2] | g[0]&p[1]&p[2] | c0&p[0]&p[1]&p[2];
	//assign c4 = g[3] | g[2]&p[3] | g[1]&p[2]&p[3] | g[0]&p[1]&p[2]&p[3] | c0&p[0]&p[1]&p[2]&p[3];
endmodule

