module sum(s,p,c);
	output [3:0] s;
	input [3:0]  p,c;
	assign s = p^c;
endmodule