//Can perform addition or subtraction depending on add_sub bit
module  full_adder(sum,cout,a,b,cin);
	output sum,cout;
	input a,b,cin;
	assign sum = a^b^cin;
	assign cout = (a&b)|(a&cin)|(b&cin);
	//assign {cout,sum}=a+b+cin;
endmodule