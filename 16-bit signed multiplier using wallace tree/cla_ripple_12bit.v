//12-bit CLA built using three 4-bit CLAs with a ripple carry between individual CLAs. Adder can function as a subtractor depending on the control signal. (a + b) or (a-b)


module cla_ripple_12bit(sum,c12,a,b,c0);
	output [11:0] sum;
	output c12;
	input [11:0] a,b;
	input c0;
	wire c4;
	wire c8;
	wire [11:0] b2;
	mux_2x1_12bit m2x112b1(.dout(b2),.d0(b),.d1((~b)),.sel(c0));
	cla_4bit_2 c4b1(.sum(sum[3:0]),.c4(c4),.a(a[3:0]),.b(b2[3:0]),.c0(c0));
	cla_4bit_2 c4b2(.sum(sum[7:4]),.c4(c8),.a(a[7:4]),.b(b2[7:4]),.c0(c4));
	cla_4bit_2 c4b3(.sum(sum[11:8]),.c4(c12),.a(a[11:8]),.b(b2[11:8]),.c0(c8));
endmodule


/*
module cla_ripple_8bit(sum,c8,a,b,c0);
	output [7:0] sum;
	output c8;
	input [7:0] a,b;
	input c0;
	wire c4;
	wire [7:0] b2;
	mux_2x1 m2x1(.dout(b2),.d0(b),.d1((~b)),.sel(c0));
	cla_4bit_2 c4b1(.sum(sum[3:0]),.c4(c4),.a(a[3:0]),.b(b2[3:0]),.c0(c0));
	cla_4bit_2 c4b2(.sum(sum[7:4]),.c4(c8),.a(a[7:4]),.b(b2[7:4]),.c0(c4));
endmodule
*/



/*
module tb_cla_ripple_8bit();
	reg [7:0] a,b;
	reg c0;
	wire [7:0] d;
	wire cout;
	cla_ripple_8bit uut(.sum(d),.c8(cout),.a(a),.b(b),.c0(c0));
	
	initial
	begin
	#00 a=8'd10; b=8'd10; c0 = 1'b0; //10-2
	#20 a=8'd30; b=8'd20; c0 = 1'b1;
	#20 a=8'd150; b=8'd130; c0 = 1'b1; //3-5
	#20 a=8'd255; b=8'd255; c0 = 1'b1;
	#20 $stop;
	end
	
	initial
	begin
	$monitor("time=%3d, a=%8d, b=%8d, co=%b, d=%8d, cout=%1b",$time,a,b,c0,d,cout);
	end
		
	initial
	begin
	$dumpfile("cla.vcd");
	$dumpvars;
	end
	
endmodule
*/

/*
module tb_cla_4bit();
	reg [3:0] a,b;
	reg c0;
	wire [3:0] d;
	wire cout;
	cla_4bit uut(.sum(d),.c4(cout),.a(a),.b(b),.c0(c0));
	
	initial
	begin
	#00 a=4'd10; b=4'b1101; c0 = 1'b1; //10-2
	#20 a=4'd10; b=4'b0101; c0 = 1'b1;
	#20 a=4'd3; b=4'b1010; c0 = 1'b1; //3-5
	#20 a=4'd15; b=4'd0; c0 = 1'b1;
	#20 $stop;
	end
	
	initial
	begin
	$monitor("time=%3d, a=%4d, b=%4d, co=%b, d=%4d, cout=%1b",$time,a,b,c0,d,cout);
	end
		
	initial
	begin
	$dumpfile("cla.vcd");
	$dumpvars;
	end
	
endmodule
*/