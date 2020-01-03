
module accumulator_us(res,md,cla_sub,load,clk,rst);
	output [15:0] res;
	input [10:0] md;
	input clk,rst,load,cla_sub;
	
	wire [20:0] par_res, shift_par_res, reg_res;
	wire [11:0] cla_res;
	wire rst_new;
	cla_ripple_12bit cr12b1(.sum(cla_res),.c12(x),.a({1'b0,reg_res[20:10]}),.b({1'd0,md}),.c0(cla_sub));
	assign par_res[20:10] =  cla_res[10:0];
	assign par_res[9:0] = reg_res[9:0];
	assign shift_par_res = {par_res[20],par_res[20],par_res[20:2]};
	assign rst_new = rst | load;
	dff_us d1(.q(reg_res),.d(shift_par_res),.clk(clk),.rst(rst_new));
	assign res = reg_res[15:0];
endmodule