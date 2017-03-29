`timescale 1ns / 1ps


//Group number : 16
//Group name : The Intellites
//Module name : Top module for processor

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:32:52 10/07/2016 
// Design Name: 
// Module Name:    MIPS_top_module 
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
module MIPS_top_module(data_out,data_in, clk, interrupt, reset);

//output declaration 
output [7:0] data_out;
wire [7:0] A, B, current_address, mux_ans_dm, ans_wb;
wire [19:0] ins;

//input declaration
input [7:0] data_in;
input clk, interrupt, reset;

//temp variables declaration
wire [3:0] flag_ex;
wire [7:0] ans_ex,B_Bypass,jmp_loc,Imm;
wire [4:0] RW_ex,op_dec,RW_dec,RW_dm;
wire mem_en_ex,mem_rw_ex,mem_mux_sel_ex,mem_en_dec,mem_rw_dec,mem_mux_sel_dec,pc_mux_sel,stall,stall_pm,imm_sel;
wire [1:0] mux_sel_A, mux_sel_B;
wire [19:0] ins_pm;

	
 

//calling of all modules for generating the final answer
Execution_Block e(flag_ex,ans_ex,data_out,B_Bypass,mem_en_ex,mem_rw_ex,mem_mux_sel_ex,RW_ex,A,B,data_in,op_dec,clk,mem_en_dec,mem_rw_dec,mem_mux_sel_dec,RW_dec,reset); 

PC_IM pc(ins,ins_pm,current_address,jmp_loc,pc_mux_sel,stall,stall_pm,reset,clk);

Reg_Bank r(A,B,ins,RW_dm,ans_ex,mux_ans_dm,ans_wb,Imm,mux_sel_A,mux_sel_B,imm_sel,clk,reset);

Data_Mem dm(mux_ans_dm,RW_dm,ans_ex,B_Bypass,RW_ex,mem_en_ex,mem_rw_ex,mem_mux_sel_ex,clk,reset);

Stall_Control_Block scb(stall, stall_pm, ins_pm, clk, reset);

Jump_Control_Block jcb(pc_mux_sel,jmp_loc,ins,clk,interrupt,current_address,flag_ex,reset);

Data_Dependency dd(mux_sel_A,mux_sel_B,imm_sel,Imm,mem_en_dec,mem_rw_dec,mem_mux_sel_dec,RW_dec,op_dec,ins,clk,reset);

Writeback_Block wb(ans_wb,mux_ans_dm,clk,reset);





endmodule
