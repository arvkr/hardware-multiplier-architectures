//8-bit Radix-4 booth unsigned multiplier. a - Multiplicand. b - Multiplier
//Partial products produced sequentially.
//Partial products added using carry lookahead adder.
`timescale 1ns/10ps
`include "carry_prop_gen.v"
`include "sum.v"
`include "carry.v"
/*
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
	#580 load = 1'b1; a = 8'd7; b = 8'd211;
	# 20 load = 1'b0;
	*/
	
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
	/*
	end
	
	initial #4400 $stop;
	
	initial
	begin
	$dumpfile("multi_8bit_unsigned.vcd");
	$dumpvars;
	end
	
endmodule
*/

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
	piso_2bit p2b1(.sout(xi),.pin(bd),.load(load),.clk(clk),.rst(rst));
	reco_unit ru(.op(mr_sel),.sign(cla_sub),.xi(xi));
	mux_4x1 m41(.dout(md),.d0(11'd0),.d1({ad[9],ad}),.d2({ad,1'b0}),.d3(11'd0),.sel(mr_sel));
	accumulator a1(.res(prod),.md(md),.cla_sub(cla_sub),.load(load),.clk(clk),.rst(rst));
endmodule

module piso_2bit(sout,pin,load,clk,rst);
    output reg [2:0] sout;
    input [9:0] pin;
    input load,clk,rst;
    reg [10:0] dout;
    always @(posedge clk)
        begin
            if(rst)
				begin
                dout = 11'd0;
				sout = 3'b0;
				end
            else if(load)
				begin
                dout = {pin,1'b0};
				sout = dout[2:0];
				end
            else
                begin
                    dout = {2'b0,dout[10:2]};
					sout = dout[2:0];
                end
        end
endmodule

module reco_unit(op,sign,xi);
	output reg [1:0] op;
	output reg sign;
	input [2:0] xi;
	always @(*)
	begin
		case(xi)
		3'b000: begin op <= 2'd0; sign <= 1'd0; end //0
		3'b010: begin op <= 2'd1; sign <= 1'd0; end //+A
		3'b100: begin op <= 2'd2; sign <= 1'd1; end //-2A
		3'b110: begin op <= 2'd1; sign <= 1'd1; end //-A
		3'b001: begin op <= 2'd1; sign <= 1'd0; end //+A
		3'b011: begin op <= 2'd2; sign <= 1'd0; end //+2A
		3'b101: begin op <= 2'd1; sign <= 1'd1; end //-A
		3'b111: begin op <= 2'd0; sign <= 1'd0; end //0
		default: begin op <= 2'dz; sign <= 1'dz; end 
		endcase
	end

endmodule

module mux_4x1(dout,d0,d1,d2,d3,sel);
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

module accumulator(res,md,cla_sub,load,clk,rst);
	output [15:0] res;
	input [10:0] md;
	input clk,rst,load,cla_sub;
	
	wire [20:0] par_res, shift_par_res, reg_res;
	wire [11:0] cla_res;
	wire rst_new;
	cla_ripple_12bit cr12b1(.sum(cla_res),.c12(x),.a({1'b0,reg_res[20:10]}),.b({1'd0,md}),.c0(cla_sub));
	assign par_res[20:10] =  cla_res[10:0];
	assign par_res[9:0] = reg_res[9:0];
	assign shift_par_res = {par_res[20],par_res[20],par_res[20:2]};
	assign rst_new = rst | load;
	dff d1(.q(reg_res),.d(shift_par_res),.clk(clk),.rst(rst_new));
	assign res = reg_res[15:0];
endmodule

module cla_ripple_12bit(sum,c12,a,b,c0);
	output [11:0] sum;
	output c12;
	input [11:0] a,b;
	input c0;
	wire c4;
	wire c8;
	wire [11:0] b2;
	mux_2x1 m2x1(.dout(b2),.d0(b),.d1((~b)),.sel(c0));
	cla_4bit_2 c4b1(.sum(sum[3:0]),.c4(c4),.a(a[3:0]),.b(b2[3:0]),.c0(c0));
	cla_4bit_2 c4b2(.sum(sum[7:4]),.c4(c8),.a(a[7:4]),.b(b2[7:4]),.c0(c4));
	cla_4bit_2 c4b3(.sum(sum[11:8]),.c4(c12),.a(a[11:8]),.b(b2[11:8]),.c0(c8));
endmodule

module cla_4bit_2(sum,c4,a,b,c0);
	output [3:0] sum;
	output c4;
	input [3:0] a,b;
	input c0;
	wire [3:0] p,g;
	wire c1,c2,c3;
	carry_prop_gen cpg1(.p(p),.g(g),.a(a),.b(b));
	carry ca1(.c1(c1),.c2(c2),.c3(c3),.c4(c4),.p(p),.g(g),.c0(c0));
	sum s1(.s(sum),.p(p),.c({c3,c2,c1,c0}));
endmodule

/*
module carry(c1,c2,c3,c4,p,g,c0);
	output c1,c2,c3,c4;
	input [3:0] p,g;
	input c0;
	assign c1 = g[0] | c0&p[0] ; 
	assign c2 = g[1] | g[0]&p[1] | c0&p[0]&p[1];
	assign c3 = g[2] | g[1]&p[2] | g[0]&p[1]&p[2] | c0&p[0]&p[1]&p[2];
	assign c4 = g[3] | g[2]&p[3] | g[1]&p[2]&p[3] | g[0]&p[1]&p[2]&p[3] | c0&p[0]&p[1]&p[2]&p[3];
endmodule

module carry_prop_gen(p,g,a,b);
	output [3:0] p,g;
	input [3:0] a,b;
	assign p = a^b;
	assign g = a&b;
endmodule

module sum(s,p,c);
	output [3:0] s;
	input [3:0]  p,c;
	assign s = p^c;
endmodule
*/
module dff(q,d,clk,rst);
	output reg [20:0] q;	
	input [20:0] d;
	input clk,rst;
	always @(posedge clk)
	begin
	if(rst)
		q <= 21'd0;
	else
		q <= d;
	end
endmodule

module mux_2x1(dout,d0,d1,sel);
	output [11:0] dout;
	input [11:0] d0,d1;
	input sel;
	assign dout = sel ? d1 : d0;
endmodule

