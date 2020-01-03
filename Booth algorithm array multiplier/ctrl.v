//Control unit for booth algorithm array multiplier
module ctrl(md,cin,a,xi);
	output reg [15:0] md;
	output reg cin;
	input [1:0] xi;
	input [15:0] a;
	always @(*)
	begin
		case(xi)
		2'b00:begin md = 16'd0; cin = 1'b0; end
		2'b01:begin md = a; cin = 1'b0; end
		2'b10:begin md = (~a); cin = 1'b1; end
		2'b11:begin md = 16'd0; cin = 1'b0; end
		endcase
	end
endmodule