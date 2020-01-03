
module accumulator(res,md,cla_sub,load,clk,rst);
	output [15:0] res;
	input [8:0] md;
	input clk,rst,load,cla_sub;
	wire [16:0] par_res, shift_par_res;
	wire msb_carry, rst_new;
	wire fin_carry;
	wire [16:0] reg_res;
	cla_ripple_8bit cr8b1(.sum(par_res[15:8]),.c8(fin_carry),.a(reg_res[15:8]),.b(md[7:0]),.c0(cla_sub));
	assign msb_carry = fin_carry;
	//full_adder fa1(.sum(par_res[16]),.cout(x),.a(reg_res[16]),.b(md[8]),.cin(msb_carry));
	full_adder fa1(.sum(par_res[16]),.cout(x),.a(reg_res[16]),.b(md[8]),.cin(msb_carry),.add_sub(cla_sub));
	assign par_res[7:0] = reg_res[7:0];
	assign shift_par_res = {par_res[16],par_res[16],par_res[16:2]};
	assign rst_new = rst | load;
	dff d1(.q(reg_res),.d(shift_par_res),.clk(clk),.rst(rst_new));
	assign res = reg_res[15:0];
endmodule