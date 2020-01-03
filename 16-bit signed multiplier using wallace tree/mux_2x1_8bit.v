//do if sel is 0 else d1.
module mux_2x1_8bit(dout,d0,d1,sel);
	output [7:0] dout;
	input [7:0] d0,d1;
	input sel;
	assign dout = sel ? d1 : d0;
endmodule