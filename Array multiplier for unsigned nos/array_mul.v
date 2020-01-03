//Array multipler for 16-bit unsigned nos. Purely combinational circuit.
//module pp_bits is used to generate indvidual partial product bits when each bit of the multiplier is multiplier is and'ed with each bit of the multiplicand. 
//Refer to the refernce book for exact architecture.
`timescale 1ns/10ps
`include "full_adder.v"
`include "cla_16bit.v"
module tb_array_mul();
	reg [15:0] a,b;
	wire [31:0] prod;
	array_mul uut(.prod(prod),.a(a),.b(b));

	initial
	begin
	#20 a = 16'd30; b = 16'd500;
	#20 a = 16'd65535; b = 16'd65535;
	#20 a = 16'd3131; b = 16'd720;
	#20 a = 16'd0; b = 16'd774;
	#20 a = 16'd32767; b = 16'd32767;
	#20 a = 16'd1; b = 16'd32767;
	#20 $stop;
	end
	
	initial
	begin
		$monitor("time=%3d, a=%5d, b=%5d, prod=%10d",$time,a,b,prod);
	end
	
	initial
	begin
	$dumpfile("array_mul.vcd");
	$dumpvars;
	end
endmodule

module array_mul(prod,a,b);
	output [31:0] prod;
	input [15:0] a,b;
	wire [15:0] pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,pp9,pp10,pp11,pp12,pp13,pp14,pp15,pp16;
	wire [14:0] ra_sum1,ra_sum2,ra_sum3,ra_sum4,ra_sum5,ra_sum6,ra_sum7,ra_sum8,ra_sum9,ra_sum10,ra_sum11,ra_sum12,ra_sum13,ra_sum14,ra_sum15,ra_sum16;
	wire [14:0] ra_cout1,ra_cout2,ra_cout3,ra_cout4,ra_cout5,ra_cout6,ra_cout7,ra_cout8,ra_cout9,ra_cout10,ra_cout11,ra_cout12,ra_cout13,ra_cout14,ra_cout15,ra_cout16;
	
	/*
	pp_bits pb1(.pp(pp1),.a(a),.x(x[0]));
	pp_bits pb2(.pp(pp2),.a(a),.x(x[1]));
	pp_bits pb3(.pp(pp3),.a(a),.x(x[2]));
	pp_bits pb4(.pp(pp4),.a(a),.x(x[3]));
	pp_bits pb5(.pp(pp5),.a(a),.x(x[4]));
	pp_bits pb6(.pp(pp6),.a(a),.x(x[5]));
	pp_bits pb7(.pp(pp7),.a(a),.x(x[6]));
	pp_bits pb8(.pp(pp8),.a(a),.x(x[7]));
	pp_bits pb9(.pp(pp9),.a(a),.x(x[8]));
	pp_bits pb10(.pp(pp10),.a(a),.x(x[9]));
	pp_bits pb11(.pp(pp11),.a(a),.x(x[10]));
	pp_bits pb12(.pp(pp12),.a(a),.x(x[11]));
	pp_bits pb13(.pp(pp13),.a(a),.x(x[12]));
	pp_bits pb14(.pp(pp14),.a(a),.x(x[13]));
	pp_bits pb15(.pp(pp15),.a(a),.x(x[14]));
	pp_bits pb16(.pp(pp16),.a(a),.x(x[15]));
	*/
	pp_bits pb1(.pp(pp1),.a(a),.x(b[0]));
	pp_bits pb2(.pp(pp2),.a(a),.x(b[1]));
	pp_bits pb3(.pp(pp3),.a(a),.x(b[2]));
	pp_bits pb4(.pp(pp4),.a(a),.x(b[3]));
	pp_bits pb5(.pp(pp5),.a(a),.x(b[4]));
	pp_bits pb6(.pp(pp6),.a(a),.x(b[5]));
	pp_bits pb7(.pp(pp7),.a(a),.x(b[6]));
	pp_bits pb8(.pp(pp8),.a(a),.x(b[7]));
	pp_bits pb9(.pp(pp9),.a(a),.x(b[8]));
	pp_bits pb10(.pp(pp10),.a(a),.x(b[9]));
	pp_bits pb11(.pp(pp11),.a(a),.x(b[10]));
	pp_bits pb12(.pp(pp12),.a(a),.x(b[11]));
	pp_bits pb13(.pp(pp13),.a(a),.x(b[12]));
	pp_bits pb14(.pp(pp14),.a(a),.x(b[13]));
	pp_bits pb15(.pp(pp15),.a(a),.x(b[14]));
	pp_bits pb16(.pp(pp16),.a(a),.x(b[15]));

	
	assign prod[0] = pp1[0];
	
	row_array ra1(.sum(ra_sum1),.cout(ra_cout1),.a(pp1[15:1]),.b(pp2[14:0]),.cin(15'd0));
	assign prod[1] = ra_sum1[0];
	
	//row_array ra2(.sum(ra_sum2),.cout(ra_cout2),.a({pp2[15],ra_sum1[14:1]}),.b(pp3[14:0]),.cin(ra_cout1));
	//assign prod[2]=ra_sum2[0];
	
	row_array ra2(.sum(ra_sum2),.cout(ra_cout2),.a({pp2[15],ra_sum1[14:1]}),.b(pp3[14:0]),.cin(ra_cout1));
	assign prod[2]=ra_sum2[0];

	row_array ra3(.sum(ra_sum3),.cout(ra_cout3),.a({pp3[15],ra_sum2[14:1]}),.b(pp4[14:0]),.cin(ra_cout2));
	assign prod[3]=ra_sum3[0];

	row_array ra4(.sum(ra_sum4),.cout(ra_cout4),.a({pp4[15],ra_sum3[14:1]}),.b(pp5[14:0]),.cin(ra_cout3));
	assign prod[4]=ra_sum4[0];

	row_array ra5(.sum(ra_sum5),.cout(ra_cout5),.a({pp5[15],ra_sum4[14:1]}),.b(pp6[14:0]),.cin(ra_cout4));
	assign prod[5]=ra_sum5[0];

	row_array ra6(.sum(ra_sum6),.cout(ra_cout6),.a({pp6[15],ra_sum5[14:1]}),.b(pp7[14:0]),.cin(ra_cout5));
	assign prod[6]=ra_sum6[0];

	row_array ra7(.sum(ra_sum7),.cout(ra_cout7),.a({pp7[15],ra_sum6[14:1]}),.b(pp8[14:0]),.cin(ra_cout6));
	assign prod[7]=ra_sum7[0];

	row_array ra8(.sum(ra_sum8),.cout(ra_cout8),.a({pp8[15],ra_sum7[14:1]}),.b(pp9[14:0]),.cin(ra_cout7));
	assign prod[8]=ra_sum8[0];

	row_array ra9(.sum(ra_sum9),.cout(ra_cout9),.a({pp9[15],ra_sum8[14:1]}),.b(pp10[14:0]),.cin(ra_cout8));
	assign prod[9]=ra_sum9[0];

	row_array ra10(.sum(ra_sum10),.cout(ra_cout10),.a({pp10[15],ra_sum9[14:1]}),.b(pp11[14:0]),.cin(ra_cout9));
	assign prod[10]=ra_sum10[0];

	row_array ra11(.sum(ra_sum11),.cout(ra_cout11),.a({pp11[15],ra_sum10[14:1]}),.b(pp12[14:0]),.cin(ra_cout10));
	assign prod[11]=ra_sum11[0];

	row_array ra12(.sum(ra_sum12),.cout(ra_cout12),.a({pp12[15],ra_sum11[14:1]}),.b(pp13[14:0]),.cin(ra_cout11));
	assign prod[12]=ra_sum12[0];

	row_array ra13(.sum(ra_sum13),.cout(ra_cout13),.a({pp13[15],ra_sum12[14:1]}),.b(pp14[14:0]),.cin(ra_cout12));
	assign prod[13]=ra_sum13[0];

	row_array ra14(.sum(ra_sum14),.cout(ra_cout14),.a({pp14[15],ra_sum13[14:1]}),.b(pp15[14:0]),.cin(ra_cout13));
	assign prod[14]=ra_sum14[0];

	row_array ra15(.sum(ra_sum15),.cout(ra_cout15),.a({pp15[15],ra_sum14[14:1]}),.b(pp16[14:0]),.cin(ra_cout14));
	assign prod[15]=ra_sum15[0];
	
	cla_16bit c16b1(.sum(prod[31:16]),.c16(x),.a({1'd0,pp16[15],ra_sum15[14:1]}),.b({1'd0,ra_cout15}),.c0(1'd0));
	

endmodule

module pp_bits(pp,a,x);
	output [15:0] pp;
	input [15:0] a;
	input x;
	wire [15:0] xd;
	assign xd = {16{x}};
	assign pp = a&xd;
endmodule

module row_array(sum,cout,a,b,cin);
	output [14:0] sum,cout;
	input [14:0] a,b,cin;
	full_adder fa1(.sum(sum[0]),.cout(cout[0]),.a(a[0]),.b(b[0]),.cin(cin[0]));
	full_adder fa2(.sum(sum[1]),.cout(cout[1]),.a(a[1]),.b(b[1]),.cin(cin[1]));
	full_adder fa3(.sum(sum[2]),.cout(cout[2]),.a(a[2]),.b(b[2]),.cin(cin[2]));
	full_adder fa4(.sum(sum[3]),.cout(cout[3]),.a(a[3]),.b(b[3]),.cin(cin[3]));
	full_adder fa5(.sum(sum[4]),.cout(cout[4]),.a(a[4]),.b(b[4]),.cin(cin[4]));
	full_adder fa6(.sum(sum[5]),.cout(cout[5]),.a(a[5]),.b(b[5]),.cin(cin[5]));
	full_adder fa7(.sum(sum[6]),.cout(cout[6]),.a(a[6]),.b(b[6]),.cin(cin[6]));
	full_adder fa8(.sum(sum[7]),.cout(cout[7]),.a(a[7]),.b(b[7]),.cin(cin[7]));
	full_adder fa9(.sum(sum[8]),.cout(cout[8]),.a(a[8]),.b(b[8]),.cin(cin[8]));
	full_adder fa10(.sum(sum[9]),.cout(cout[9]),.a(a[9]),.b(b[9]),.cin(cin[9]));
	full_adder fa11(.sum(sum[10]),.cout(cout[10]),.a(a[10]),.b(b[10]),.cin(cin[10]));
	full_adder fa12(.sum(sum[11]),.cout(cout[11]),.a(a[11]),.b(b[11]),.cin(cin[11]));
	full_adder fa13(.sum(sum[12]),.cout(cout[12]),.a(a[12]),.b(b[12]),.cin(cin[12]));
	full_adder fa14(.sum(sum[13]),.cout(cout[13]),.a(a[13]),.b(b[13]),.cin(cin[13]));
	full_adder fa15(.sum(sum[14]),.cout(cout[14]),.a(a[14]),.b(b[14]),.cin(cin[14]));
	//full_adder fa16(.sum(sum[15]),.cout(cout[15]),.a(a[15]),.b(b[15]),.cin(cin[15]));
endmodule