//do if sel is 0 else d1.
module mux_2x1_12bit(dout,d0,d1,sel);
	output [11:0] dout;
	input [11:0] d0,d1;
	input sel;
	assign dout = sel ? d1 : d0;
endmodule