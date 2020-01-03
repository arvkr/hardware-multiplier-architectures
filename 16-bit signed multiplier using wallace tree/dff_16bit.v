//16-bit dff with synchronous active-high reset
module dff_16bit(q,d,clk,rst);
	output reg [15:0] q;	
	input [15:0] d;
	input clk,rst;
	always @(posedge clk)
	begin
	if(rst)
		q <= 16'd0;
	else
		q <= d;
	end
endmodule