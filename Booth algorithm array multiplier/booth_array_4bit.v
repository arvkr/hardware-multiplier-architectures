`timescale 1ns/10ps
// A 4-bit implementation which was done on a trial basis before the 16-bit implementation to check the correctness.
module tb_booth_array_4bit();
	reg signed [3:0] a,b;
	wire signed [7:0] prod;
	booth_array_4bit uut(.prod(prod),.a(a),.b(b));

	initial
	begin
	#20 a = 4'd3; b = 4'd5;
	#20 a = -4'd3; b = 4'd3;
	#20 a = -4'd3; b = -4'd7;
	#20 a = 4'd6; b = -4'd7;
	#20 a = 4'd0; b = 4'd2;
	#20 a = 4'd0; b = 4'd0;
	#20 a = -4'd4; b = 4'd1;
	#20 $stop;
	end
	
	initial
	begin
		$monitor("time=%3d, a=%4d, b=%4d, prod=%8d",$time,a,b,prod);
	end
	
	initial
	begin
	$dumpfile("booth_array_4bit.vcd");
	$dumpvars;
	end
	
endmodule

module booth_array_4bit(prod,a,b);
	output [7:0] prod;
	input [3:0] a,b;
	wire cr1,cr2,cr3,cr4;
	wire [3:0] mdr1,mdr2,mdr3,mdr4;
	wire [3:0] poutr1;
	wire [4:0] poutr2;
	wire [5:0] poutr3;
	wire [6:0] poutr4;
	ctrl c1(.md(mdr1),.cin(cr1),.a(a),.xi({b[3],b[2]}));
	cass_4bit c4b1(.pout(poutr1),.a(mdr1),.pin(3'd0),.cin(cr1));
	
	ctrl c2(.md(mdr2),.cin(cr2),.a(a),.xi({b[2],b[1]}));
	cass_5bit c5b1(.pout(poutr2),.a(mdr2),.pin(poutr1),.cin(cr2));
	
	ctrl c3(.md(mdr3),.cin(cr3),.a(a),.xi({b[1],b[0]}));
	cass_6bit c6b1(.pout(poutr3),.a(mdr3),.pin(poutr2),.cin(cr3));
	
	ctrl c4(.md(mdr4),.cin(cr4),.a(a),.xi({b[0],1'b0}));
	cass_7bit c7b1(.pout(poutr4),.a(mdr4),.pin(poutr3),.cin(cr4));
	assign prod = {poutr4[6],poutr4};
endmodule

module cass(pout,cout,a,pin,cin);
	output pout,cout;
	input a,pin,cin;
	assign pout = a^pin^cin;
	assign cout = (a&pin)|(a&cin)|(pin&cin);
endmodule

module ctrl(md,cin,a,xi);
	output reg [3:0] md;
	output reg cin;
	input [1:0] xi;
	input [3:0] a;
	always @(*)
	begin
		case(xi)
		2'b00:begin md = 4'd0; cin = 1'b0; end
		2'b01:begin md = a; cin = 1'b0; end
		2'b10:begin md = (~a); cin = 1'b1; end
		2'b11:begin md = 4'd0; cin = 1'b0; end
		endcase
	end
endmodule



module cass_4bit(pout,a,pin,cin);
	output [3:0] pout;
	input [3:0] a;
	input [2:0] pin;
	input cin;
	wire c1,c2,c3;
	cass ca1(.pout(pout[0]),.cout(c1),.a(a[0]),.pin(1'b0),.cin(cin));
	cass ca2(.pout(pout[1]),.cout(c2),.a(a[1]),.pin(pin[0]),.cin(c1));
	cass ca3(.pout(pout[2]),.cout(c3),.a(a[2]),.pin(pin[1]),.cin(c2));
	cass ca4(.pout(pout[3]),.cout(x),.a(a[3]),.pin(pin[2]),.cin(c3));
	//cass ca5(.pout(pout[4]),.cout(x),.a(a[3]),.pin(pin[3]),.cin(c4));
	//cass ca6(.pout(pout[5]),.cout(x),.a(a[3]),.pin(pin[4]),.cin(c5));
	//cass ca7(.pout(pout[6]),.cout(x),.a(a[3]),.pin(pin[5]),.cin(c6));
endmodule


module cass_5bit(pout,a,pin,cin);
	output [4:0] pout;
	input [3:0] a;
	input [3:0] pin;
	input cin;
	wire c1,c2,c3,c4;
	cass ca1(.pout(pout[0]),.cout(c1),.a(a[0]),.pin(1'b0),.cin(cin));
	cass ca2(.pout(pout[1]),.cout(c2),.a(a[1]),.pin(pin[0]),.cin(c1));
	cass ca3(.pout(pout[2]),.cout(c3),.a(a[2]),.pin(pin[1]),.cin(c2));
	cass ca4(.pout(pout[3]),.cout(c4),.a(a[3]),.pin(pin[2]),.cin(c3));
	cass ca5(.pout(pout[4]),.cout(x),.a(a[3]),.pin(pin[3]),.cin(c4));
	//cass ca6(.pout(pout[5]),.cout(x),.a(a[3]),.pin(pin[4]),.cin(c5));
	//cass ca7(.pout(pout[6]),.cout(x),.a(a[3]),.pin(pin[5]),.cin(c6));
endmodule

module cass_6bit(pout,a,pin,cin);
	output [5:0] pout;
	input [3:0] a;
	input [4:0] pin;
	input cin;
	wire c1,c2,c3,c4,c5;
	cass ca1(.pout(pout[0]),.cout(c1),.a(a[0]),.pin(1'b0),.cin(cin));
	cass ca2(.pout(pout[1]),.cout(c2),.a(a[1]),.pin(pin[0]),.cin(c1));
	cass ca3(.pout(pout[2]),.cout(c3),.a(a[2]),.pin(pin[1]),.cin(c2));
	cass ca4(.pout(pout[3]),.cout(c4),.a(a[3]),.pin(pin[2]),.cin(c3));
	cass ca5(.pout(pout[4]),.cout(c5),.a(a[3]),.pin(pin[3]),.cin(c4));
	cass ca6(.pout(pout[5]),.cout(x),.a(a[3]),.pin(pin[4]),.cin(c5));
	//cass ca7(.pout(pout[6]),.cout(x),.a(a[3]),.pin(pin[5]),.cin(c6));
endmodule

module cass_7bit(pout,a,pin,cin);
	output [6:0] pout;
	input [3:0] a;
	input [5:0] pin;
	input cin;
	wire c1,c2,c3,c4,c5,c6;
	cass ca1(.pout(pout[0]),.cout(c1),.a(a[0]),.pin(1'b0),.cin(cin));
	cass ca2(.pout(pout[1]),.cout(c2),.a(a[1]),.pin(pin[0]),.cin(c1));
	cass ca3(.pout(pout[2]),.cout(c3),.a(a[2]),.pin(pin[1]),.cin(c2));
	cass ca4(.pout(pout[3]),.cout(c4),.a(a[3]),.pin(pin[2]),.cin(c3));
	cass ca5(.pout(pout[4]),.cout(c5),.a(a[3]),.pin(pin[3]),.cin(c4));
	cass ca6(.pout(pout[5]),.cout(c6),.a(a[3]),.pin(pin[4]),.cin(c5));
	cass ca7(.pout(pout[6]),.cout(x),.a(a[3]),.pin(pin[5]),.cin(c6));
endmodule



/*
module cass_16bit(pout,a,pin,cin);
	output [15:0] pout;
	input [15:0] a,pin;
	input cin;
	cass c1(.pout(pout[0]),.cout(c1),.a(a[0]),.pin(1'b0),.cin(cin));
	cass c2(.pout(pout[1]),.cout(c2),.a(a[1]),.pin(pin[0]),.cin(c1));
	cass c3(.pout(pout[2]),.cout(c3),.a(a[2]),.pin(pin[1]),.cin(c2));
	cass c4(.pout(pout[3]),.cout(c4),.a(a[3]),.pin(pin[2]),.cin(c3));
	cass c5(.pout(pout[4]),.cout(c5),.a(a[4]),.pin(pin[3]),.cin(c4));
	cass c6(.pout(pout[5]),.cout(c6),.a(a[5]),.pin(pin[4]),.cin(c5));
	cass c7(.pout(pout[6]),.cout(c7),.a(a[6]),.pin(pin[5]),.cin(c6));
	cass c8(.pout(pout[7]),.cout(c8),.a(a[7]),.pin(pin[6]),.cin(c7));

	cass c9(.pout(pout[8]),.cout(c9),.a(a[8]),.pin(pin[7]),.cin(c8));
	cass c10(.pout(pout[9]),.cout(c10),.a(a[9]),.pin(pin[8]),.cin(c9));
	cass c11(.pout(pout[10]),.cout(c11),.a(a[10]),.pin(pin[9]),.cin(c10));
	cass c12(.pout(pout[11]),.cout(c12),.a(a[11]),.pin(pin[10]),.cin(c11));
	cass c13(.pout(pout[12]),.cout(c13),.a(a[12]),.pin(pin[11]),.cin(c12));
	cass c14(.pout(pout[13]),.cout(c14),.a(a[13]),.pin(pin[12]),.cin(c13));
	cass c15(.pout(pout[14]),.cout(c15),.a(a[14]),.pin(pin[13]),.cin(c14));
	cass c16(.pout(pout[15]),.cout(c16),.a(a[15]),.pin(pin[14]),.cin(c15));

	cass c17(.pout(pout[16]),.cout(c17),.a(a[15]),.pin(pin[15]),.cin(c16));
endmodule
*/