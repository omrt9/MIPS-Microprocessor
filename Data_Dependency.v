`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Data dependency Block logic 


//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:23 10/04/2016 
// Design Name: 
// Module Name:    Data_Dependency 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Data_Dependency(mux_sel_a,mux_sel_b,imm_sel,Imm,mem_en_dec,mem_rw_dec,mem_mux_sel_dec,RW_dec,op_dec,ins,clk,reset);

//Outputs
output  [7:0] Imm;
output reg [4:0] RW_dec, op_dec;
output [1:0] mux_sel_a, mux_sel_b;
output reg imm_sel, mem_en_dec, mem_rw_dec;
output mem_mux_sel_dec;

//Inputs
input [19:0] ins;
input clk, reset;


//Temp Variables
wire [4:0] op_dec_temp, t1_a, t1_b, t2, t3, t4, t;
wire  c_t2_t1_a, c_t3_t1_a, c_t4_t1_a, c_t2_t1_b, c_t3_t1_b, c_t4_t1_b, and2_a, and3_a, and2_b, and3_b;
wire c_and, unc_and, ld_and, imm_and, ld_st_and, a1,a2, ld_and_temp, a1_temp, a2_temp, imm_sel_temp, nor_temp;
wire [4:0] imm_temp;
wire [14:0] ext,ins_temp;
reg ld_and_r;
reg [4:0] t1_a_out, t1_b_out, t2_out, t3_out, t4_out,imm_reg;


//logic for all other outputs according to the circuit
assign op_dec_temp = (reset == 1'b0) ? 0 : ins[19:15];

assign imm_and = ((~ins[19]) & ins[18]);
assign ld_st_and = (ins[19] & (~ins[18]) & ins[17] & (~ins[16]));

assign a1_temp = (reset == 1'b0) ? 0 : a1;

assign a1 = (~mem_rw_dec) & ins[15];

assign a2_temp = (reset == 1'b0) ? 0 : a2;

assign a2 = (~mem_en_dec) & ld_st_and;
assign mem_mux_sel_dec = (~mem_rw_dec) & mem_en_dec;

assign imm_sel_temp = (reset == 1'b0) ? 0 : imm_and;

assign imm_temp = (reset == 1'b0) ? 0: ins[4:0];







//logic to find mux_sel_a ,mux_sel_b and RW_dec
assign c_and = (ins[19] & ins[18] & (~ins[17]) & (~ins[16]) & (~ins[15]));
assign unc_and = (ins[19] & ins[18] & ins[17]);

assign ld_and_temp = (reset == 1'b0) ? 0 : ld_and;

assign ld_and = (ins[19] & (~ins[18]) & ins[17] & (~ins[16]) & (~ins[15]) & (~ld_and_r));

assign nor_temp = ~(c_and | unc_and | ld_and_r);

assign ext = {15{nor_temp}};

assign ins_temp = ext & ins[14:0];

assign t1_a = (reset == 1'b0) ? 0 : ins_temp[9:5];

assign t1_b = (reset == 1'b0) ? 0 : ins_temp[4:0];

assign t = (reset == 1'b0) ? 0 : ins_temp[14:10];

assign t2 = (reset == 1'b0) ? 0 : RW_dec;

assign t3 = (reset == 1'b0) ? 0 : t2_out;

assign t4 = (reset == 1'b0) ? 0 : t3_out;

always @(posedge clk)
begin
	op_dec <= op_dec_temp;
	mem_rw_dec <= a1_temp;
	mem_en_dec <= a2_temp;
	imm_sel <= imm_sel_temp;
	imm_reg <= imm_temp;
	ld_and_r <= ld_and_temp;
	t1_a_out <= t1_a;
	t1_b_out <= t1_b;
	RW_dec <= t;
	t2_out <= t2;
	t3_out <= t3;
	t4_out <= t4;
end

assign Imm = {3'b000,imm_reg};

//logic for comparators
assign c_t2_t1_a = (t2_out == t1_a_out) ? 1 : 0;
assign c_t3_t1_a = (t3_out == t1_a_out) ? 1 : 0;
assign c_t4_t1_a = (t4_out == t1_a_out) ? 1 : 0;

assign c_t2_t1_b = (t2_out == t1_b_out) ? 1 : 0;
assign c_t3_t1_b = (t3_out == t1_b_out) ? 1 : 0;
assign c_t4_t1_b = (t4_out == t1_b_out) ? 1 : 0;

//logic for and gates
assign and2_a = (~c_t2_t1_a) & (c_t3_t1_a);
assign and3_a = (~c_t2_t1_a) & (~c_t3_t1_a) & c_t4_t1_a;

assign and2_b = (~c_t2_t1_b) & (c_t3_t1_b);
assign and3_b = (~c_t2_t1_b) & (~c_t3_t1_b) & c_t4_t1_b;

//logic for priority encoder

assign mux_sel_a[1] = and3_a | and2_a;
assign mux_sel_a[0] = and3_a | (c_t2_t1_a & (~and2_a));

assign mux_sel_b[1] = and3_b | and2_b;
assign mux_sel_b[0] = and3_b | (c_t2_t1_b & (~and2_b));

endmodule

