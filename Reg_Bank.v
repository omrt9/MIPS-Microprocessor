`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : register bank logic

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:59:30 10/04/2016 
// Design Name: 
// Module Name:    Reg_Bank 
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
module Reg_Bank(A,B,ins,RW_dm,ans_ex,mux_ans_dm,ans_wb,imm,mux_sel_A,mux_sel_B,imm_sel,clk,reset);

//Output Declaration
output [7:0] A,B;

//Input Declaration
input [19:0] ins;
input [4:0] RW_dm;
input [7:0] ans_ex, mux_ans_dm, ans_wb, imm;
input [1:0] mux_sel_A, mux_sel_B;
input imm_sel, clk, reset;

//Temporary Variable Declaration
wire [7:0] reg_A, reg_B;
wire [7:0] temp_B; 
reg  [7:0] temp_ra, temp_rb;
//-----------------------------------
reg  [7:0] memory [31:0];

initial
begin
	memory[0]  = 8'h00;
	memory[1]  = 8'h01; 
	memory[2]  = 8'h02;
	memory[3]  = 8'h03;
	memory[4]  = 8'h04;
	memory[5]  = 8'h00;
	memory[6]  = 8'h06;
	memory[7]  = 8'h07;
	memory[8]  = 8'h08;
	memory[9]  = 8'h09;
	memory[10] = 8'h0a;
	memory[11] = 8'h0b;
	memory[12] = 8'h0c;
	memory[13] = 8'h0d;
	memory[14] = 8'h0e;
	memory[15] = 8'h0f;
	memory[16] = 8'h10;
	memory[17] = 8'h11;
	memory[18] = 8'h12;
	memory[19] = 8'h13;
	memory[20] = 8'h14;
	memory[21] = 8'h15;
	memory[22] = 8'h16;
	memory[23] = 8'h17;
	memory[24] = 8'h18;
	memory[25] = 8'h19;
	memory[26] = 8'h1a;
	memory[27] = 8'h1b;
	memory[28] = 8'h1c;
	memory[29] = 8'h1d;
	memory[30] = 8'h1e;
	memory[31] = 8'h1f;
end

//Assigning 5bit address of Register A and B
assign reg_A = (reset==1'b0) ? 0 : temp_ra;
assign reg_B = (reset==1'b0) ? 0 : temp_rb;

//Register Block
always@(posedge clk)
begin 
	temp_ra <= memory[ins[9:5]];
	temp_rb <= memory[ins[4:0]];
	memory[RW_dm] <= mux_ans_dm;
end

//4to1 mux for A and temp_B
assign A = 	(mux_sel_A == 2'b00) ? reg_A :
				(mux_sel_A == 2'b01) ? ans_ex :
				(mux_sel_A == 2'b10) ? mux_ans_dm :
				(mux_sel_A == 2'b11) ? ans_wb :
				8'bx;
				
assign temp_B = (mux_sel_B == 2'b00) ? reg_B :
					(mux_sel_B == 2'b01) ? ans_ex :
					(mux_sel_B == 2'b10) ? mux_ans_dm :
					(mux_sel_B == 2'b11) ? ans_wb :
					8'bx;

//2to1 mux for B
assign B = (imm_sel == 0) ? temp_B : imm;

endmodule

