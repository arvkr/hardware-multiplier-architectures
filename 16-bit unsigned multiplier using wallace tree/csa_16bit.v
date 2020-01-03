`include "full_adder_norm.v"
module csa_16bit(s,c,x,y,z);
	output [15:0] s,c;
	input [15:0] x,y,z;
	full_adder_norm fan0(.sum(s[0]),.cout(c[0]),.a(x[0]),.b(y[0]),.cin(z[0]));
	full_adder_norm fan1(.sum(s[1]),.cout(c[1]),.a(x[1]),.b(y[1]),.cin(z[1]));
	full_adder_norm fan2(.sum(s[2]),.cout(c[2]),.a(x[2]),.b(y[2]),.cin(z[2]));
	full_adder_norm fan3(.sum(s[3]),.cout(c[3]),.a(x[3]),.b(y[3]),.cin(z[3]));
	full_adder_norm fan4(.sum(s[4]),.cout(c[4]),.a(x[4]),.b(y[4]),.cin(z[4]));
	full_adder_norm fan5(.sum(s[5]),.cout(c[5]),.a(x[5]),.b(y[5]),.cin(z[5]));
	full_adder_norm fan6(.sum(s[6]),.cout(c[6]),.a(x[6]),.b(y[6]),.cin(z[6]));
	full_adder_norm fan7(.sum(s[7]),.cout(c[7]),.a(x[7]),.b(y[7]),.cin(z[7]));
	full_adder_norm fan8(.sum(s[8]),.cout(c[8]),.a(x[8]),.b(y[8]),.cin(z[8]));
	full_adder_norm fan9(.sum(s[9]),.cout(c[9]),.a(x[9]),.b(y[9]),.cin(z[9]));
	full_adder_norm fan10(.sum(s[10]),.cout(c[10]),.a(x[10]),.b(y[10]),.cin(z[10]));
	full_adder_norm fan11(.sum(s[11]),.cout(c[11]),.a(x[11]),.b(y[11]),.cin(z[11]));
	full_adder_norm fan12(.sum(s[12]),.cout(c[12]),.a(x[12]),.b(y[12]),.cin(z[12]));
	full_adder_norm fan13(.sum(s[13]),.cout(c[13]),.a(x[13]),.b(y[13]),.cin(z[13]));
	full_adder_norm fan14(.sum(s[14]),.cout(c[14]),.a(x[14]),.b(y[14]),.cin(z[14]));
	full_adder_norm fan15(.sum(s[15]),.cout(c[15]),.a(x[15]),.b(y[15]),.cin(z[15]));
endmodule

/*
module tb_csa_16bit();
	reg [15:0] x,y,z;
	wire [15:0] s,c;
	csa_16bit uut(.s(s),.c(c),.x(x),.y(y),.z(z));
	
	initial
	begin
	#00 x=16'd10; y=16'd10; z = 16'd12345; //10-2
	#20 x=16'd30; y=16'd20; z = 16'd20123;
	#20 x=16'd150; y=16'd130; z = 16'd55555; //3-5
	#20 x=16'd20000; y=16'd25555; z = 16'd212;
	#20 $stop;
	end
	
	initial
	begin
	$monitor("time=%3d, x=%16b, y=%16b, z=%16b, s=%16b, c=%16b",$time,x,y,z,s,c);
	end
		
	initial
	begin
	$dumpfile("csa_16bit.vcd");
	$dumpvars;
	end
endmodule
*/