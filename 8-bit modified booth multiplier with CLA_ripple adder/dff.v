//17-bit dff with synchronous active-high reset
module dff(q,d,clk,rst);
	output reg [16:0] q;	
	input [16:0] d;
	input clk,rst;
	always @(posedge clk)
	begin
	if(rst)
		q <= 17'd0;
	else
		q <= d;
	end
endmodule