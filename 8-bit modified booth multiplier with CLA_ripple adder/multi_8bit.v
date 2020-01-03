//8-bit Radix-4 booth multiplier. a - Multiplicand. b - Multiplier
// Partial products generated using a radix-4 modified booth algorithm
//Partial products produced sequentially using two 4-bit CLA modules with carries rippling across them.
`include "piso_2bit.v"
`include "reco_unit.v"
`include "mux_4x1.v"
`include "accumulator.v"


module multi_8bit(prod,a,b,clk,rst,load);
	output [15:0] prod;
	input [7:0] a,b;
	input clk,rst,load;
	wire [2:0] xi;
	wire [1:0] mr_sel;
	wire cla_sub; 
	wire [8:0] md;
	piso_2bit p2b1(.sout(xi),.pin(b),.load(load),.clk(clk),.rst(rst));
	reco_unit ru(.op(mr_sel),.sign(cla_sub),.xi(xi));
	mux_4x1 m41(.dout(md),.d0(9'd0),.d1({a[7],a}),.d2({a,1'b0}),.d3(9'd0),.sel(mr_sel));
	accumulator a1(.res(prod),.md(md),.cla_sub(cla_sub),.load(load),.clk(clk),.rst(rst));
endmodule


module tb_multi_8bit();
	reg [7:0] a,b;
	reg clk,rst,load;
	wire [15:0] prod;
	multi_8bit uut(.prod(prod),.a(a),.b(b),.clk(clk),.rst(rst),.load(load));
	
	initial
	begin
	#00 clk = 1'b0;
	forever #50 clk = ~clk;
	end
	
	initial
	begin
	#00 rst = 1'b1;
	#60 rst = 1'b0;
	end
	
	initial
	begin
	#110 load = 1'b1; a = -8'd38; b = 8'd55;
	# 60 load = 1'b0; 
	#470 load = 1'b1; a = 8'd22; b = 8'd107; //at 640 ps
	# 20 load = 1'b0; //at 660 ps. result out at 1050 ps.
	#480 load = 1'b1; a = -8'd99; b = 8'd91;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd78; b = -8'd82;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd0; b = 8'd0;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = -8'd55; b = -8'd46;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd111; b = 8'd0;
	# 20 load = 1'b0;
	#480 $stop;
	end
	
	initial
	begin
	$dumpfile("multi_8bit.vcd");
	$dumpvars;
	end
	
endmodule

