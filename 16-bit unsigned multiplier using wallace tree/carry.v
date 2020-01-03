module carry(c1,c2,c3,c4,p,g,c0);
	output c1,c2,c3,c4;
	input [3:0] p,g;
	input c0;
	assign c1 = g[0] | c0&p[0] ; 
	assign c2 = g[1] | g[0]&p[1] | c0&p[0]&p[1];
	assign c3 = g[2] | g[1]&p[2] | g[0]&p[1]&p[2] | c0&p[0]&p[1]&p[2];
	assign c4 = g[3] | g[2]&p[3] | g[1]&p[2]&p[3] | g[0]&p[1]&p[2]&p[3] | c0&p[0]&p[1]&p[2]&p[3];
endmodule