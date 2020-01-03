`include "mux_2x1_1bit.v"
//Can perform addition or subtraction depending on add_sub bit
module  full_adder(sum,cout,a,b,cin,add_sub);
	output sum,cout;
	input a,b,cin,add_sub;
	wire b2,b3;
	mux_2x1_1bit m2x1b1(.dout(b2),.d0(b),.d1((~b)),.sel(add_sub));
	assign b3 = b2;
	assign sum = a^b3^cin;
	assign cout = (a&b3)|(a&cin)|(b3&cin);
	//assign {cout,sum}=a+b+cin;

endmodule