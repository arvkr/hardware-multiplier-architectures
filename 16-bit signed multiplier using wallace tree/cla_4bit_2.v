module cla_4bit_2(sum,c4,a,b,c0);
	output [3:0] sum;
	output c4;
	input [3:0] a,b;
	input c0;
	wire [3:0] p,g;
	wire c1,c2,c3;
	carry_prop_gen cpg1(.p(p),.g(g),.a(a),.b(b));
	carry ca1(.c1(c1),.c2(c2),.c3(c3),.c4(c4),.p(p),.g(g),.c0(c0));
	sum s1(.s(sum),.p(p),.c({c3,c2,c1,c0}));
endmodule