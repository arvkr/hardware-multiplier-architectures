//Generates carry propogate and carry generate given two input nos. refer CLA theory.
module carry_prop_gen(p,g,a,b);
	output [3:0] p,g;
	input [3:0] a,b;
	assign p = a^b;
	assign g = a&b;
endmodule