//Can perform only addition. No control bit for performing subtraction
module  full_adder_norm(sum,cout,a,b,cin);
	output sum,cout;
	input a,b,cin;
	assign sum = a^b^cin;
	assign cout = (a&b)|(a&cin)|(b&cin);
	//assign {cout,sum}=a+b+cin;
endmodule