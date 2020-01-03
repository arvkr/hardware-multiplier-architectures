//Generates the sum in a 4-bit CLA once the carries are simultaneously generated using the carry module.
module sum(s,p,c);
	output [3:0] s;
	input [3:0]  p,c;
	assign s = p^c;
endmodule