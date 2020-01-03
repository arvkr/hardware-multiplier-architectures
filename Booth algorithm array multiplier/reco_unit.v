//Recoding unit for radix-4 booth's algorithm
// op = 0 => 0
// op = 1 => A
// op = 2 => 2A
// sign = 0 => Add
// sign = 1 => Subtract
module reco_unit(op,sign,xi);
	output reg [1:0] op;
	output reg sign;
	input [2:0] xi;
	always @(*)
	begin
		case(xi)
		3'b000: begin op <= 2'd0; sign <= 1'd0; end //0
		3'b010: begin op <= 2'd1; sign <= 1'd0; end //+A
		3'b100: begin op <= 2'd2; sign <= 1'd1; end //-2A
		3'b110: begin op <= 2'd1; sign <= 1'd1; end //-A
		3'b001: begin op <= 2'd1; sign <= 1'd0; end //+A
		3'b011: begin op <= 2'd2; sign <= 1'd0; end //+2A
		3'b101: begin op <= 2'd1; sign <= 1'd1; end //-A
		3'b111: begin op <= 2'd0; sign <= 1'd0; end //0
		default: begin op <= 2'dz; sign <= 1'dz; end 
		endcase
	end

endmodule