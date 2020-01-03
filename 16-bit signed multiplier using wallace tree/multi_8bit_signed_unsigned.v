//8-bit Radix-4 booth signed-unsigned multiplier. a - Multiplicand. b - Multiplier.
// Multiplicand - signed:2s complement. Multiplier - unsigned
//Partial products produced sequentially.
//Partial products added using carry lookahead adder.
//`include "piso_2bit_us.v"
//`include "reco_unit_us.v"
//`include "mux_4x1_us.v"
//`include "accumulator_us.v"

module multi_8bit_signed_unsigned(prod,a,b,clk,rst,load);
	output [15:0] prod;
	input [7:0] a,b;
	input clk,rst,load;
	wire [2:0] xi;
	wire [1:0] mr_sel;
	wire cla_sub; 
	wire [10:0] md;
	wire [9:0] ad,bd;
	assign ad = {a[7],a[7],a};
	assign bd = {2'd0,b};
	piso_2bit_us p2b1(.sout(xi),.pin(bd),.load(load),.clk(clk),.rst(rst));
	reco_unit_us ru(.op(mr_sel),.sign(cla_sub),.xi(xi));
	mux_4x1_us m41(.dout(md),.d0(11'd0),.d1({ad[9],ad}),.d2({ad,1'b0}),.d3(11'd0),.sel(mr_sel));
	accumulator_us a1(.res(prod),.md(md),.cla_sub(cla_sub),.load(load),.clk(clk),.rst(rst));
endmodule
