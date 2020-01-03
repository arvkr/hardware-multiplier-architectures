//21-bit dff with synchronous active-high reset
module dff_us(q,d,clk,rst);
	output reg [20:0] q;	
	input [20:0] d;
	input clk,rst;
	always @(posedge clk)
	begin
	if(rst)
		q <= 21'd0;
	else
		q <= d;
	end
endmodule