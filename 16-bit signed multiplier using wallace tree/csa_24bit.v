//`include "full_adder_norm.v"
module csa_24bit(s,c,x,y,z);
	output [23:0] s,c;
	input [23:0] x,y,z;
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
	
	full_adder_norm fan16(.sum(s[16]),.cout(c[16]),.a(x[16]),.b(y[16]),.cin(z[16]));
	full_adder_norm fan17(.sum(s[17]),.cout(c[17]),.a(x[17]),.b(y[17]),.cin(z[17]));
	full_adder_norm fan18(.sum(s[18]),.cout(c[18]),.a(x[18]),.b(y[18]),.cin(z[18]));
	full_adder_norm fan19(.sum(s[19]),.cout(c[19]),.a(x[19]),.b(y[19]),.cin(z[19]));
	full_adder_norm fan20(.sum(s[20]),.cout(c[20]),.a(x[20]),.b(y[20]),.cin(z[20]));
	full_adder_norm fan21(.sum(s[21]),.cout(c[21]),.a(x[21]),.b(y[21]),.cin(z[21]));
	full_adder_norm fan22(.sum(s[22]),.cout(c[22]),.a(x[22]),.b(y[22]),.cin(z[22]));
	full_adder_norm fan23(.sum(s[23]),.cout(c[23]),.a(x[23]),.b(y[23]),.cin(z[23]));
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