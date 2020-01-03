//11-bit 4x1 mux
module mux_4x1_us(dout,d0,d1,d2,d3,sel);
	output reg [10:0] dout;
	input [10:0] d0,d1,d2,d3;
	input [1:0] sel;
	always @(*)
	begin
		case(sel)
		2'b00: dout <= d0;
		2'b01: dout <= d1;
		2'b10: dout <= d2;
		2'b11: dout <= d3;
		default: dout <= 11'dz;
		endcase
	end
endmodule