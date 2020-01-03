//8-bit Radix-4 booth unsigned multiplier. a - Multiplicand. b - Multiplier
// Partial products generated using a radix-4 modified booth algorithm
//Partial products produced sequentially using three 4-bit CLA modules with carries rippling across them.
`include "piso_2bit_us.v"
`include "reco_unit_us.v"
`include "mux_4x1_us.v"
`include "accumulator_us.v"

module multi_8bit_unsigned(prod,a,b,clk,rst,load);
	output [15:0] prod;
	input [7:0] a,b;
	input clk,rst,load;
	wire [2:0] xi;
	wire [1:0] mr_sel;
	wire cla_sub; 
	wire [10:0] md;
	wire [9:0] ad,bd;
	assign ad = {2'd0,a};
	assign bd = {2'd0,b};
	piso_2bit_us p2b1(.sout(xi),.pin(bd),.load(load),.clk(clk),.rst(rst));
	reco_unit_us ru(.op(mr_sel),.sign(cla_sub),.xi(xi));
	mux_4x1_us m41(.dout(md),.d0(11'd0),.d1({ad[9],ad}),.d2({ad,1'b0}),.d3(11'd0),.sel(mr_sel));
	accumulator_us a1(.res(prod),.md(md),.cla_sub(cla_sub),.load(load),.clk(clk),.rst(rst));
endmodule


module tb_multi_8bit_unsigned();
	reg [7:0] a,b;
	reg clk,rst,load;
	wire [15:0] prod;
	multi_8bit_unsigned uut(.prod(prod),.a(a),.b(b),.clk(clk),.rst(rst),.load(load));
	
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
	#110 load = 1'b1; a = 8'd255; b = 8'd230;
	# 60 load = 1'b0; 
	
	#570 load = 1'b1; a = 8'd5; b = 8'd9; //at 740 ps
	# 20 load = 1'b0; //at 760 ps. result out at 1050 ps.
	#580 load = 1'b1; a = 8'd150; b = 8'd100;
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 8'd200; b = 8'd250;
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 8'd233; b = 8'd111;
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 8'd55; b = 8'd46;
	# 20 load = 1'b0;
	#580 load = 1'b1; a = 8'd255; b = 8'd255;
	# 20 load = 1'b0;
	#580 $stop;

	/*
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	#480 load = 1'b1; a = 8'd13; b = 8'd15;
	# 20 load = 1'b0;
	*/
	
	end
	
	
	initial
	begin
	$dumpfile("multi_8bit_unsigned.vcd");
	$dumpvars;
	end
	
endmodule

