module mux_2x1_1bit(dout,d0,d1,sel);
	output dout;
	input d0,d1;
	input sel;
	assign dout = sel ? d1 : d0;
endmodule