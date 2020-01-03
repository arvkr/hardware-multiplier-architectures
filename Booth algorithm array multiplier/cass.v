module cass(pout,cout,a,pin,cin);
	output pout,cout;
	input a,pin,cin;
	assign pout = a^pin^cin;
	assign cout = (a&pin)|(a&cin)|(pin&cin);
endmodule