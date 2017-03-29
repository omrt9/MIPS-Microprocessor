`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Stall Control Block Logic

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:23:34 10/04/2016 
// Design Name: 
// Module Name:    Stall_Control_Block 
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
module Stall_Control_Block(stall, stall_pm, ins_pm, clk, reset);


//output declaration
output stall;
output reg stall_pm;

//input declaration
input [19:0] ins_pm;
input clk, reset;


//temp variables
wire hlt_out, ld_out, jump_out;
wire temp_ld, temp_j1,temp_j2,temp;
reg t1,t2,t3;


//logic for all and and or gates
assign hlt_out = (ins_pm[15] & (~ins_pm[16]) & (~ins_pm[17]) & (~ins_pm[18]) & ins_pm[19]);
assign ld_out = ((~ins_pm[15]) & (~ins_pm[16]) & ins_pm[17] & (~ins_pm[18]) & ins_pm[19] & (~t1));
assign jump_out = (ins_pm[17] & ins_pm[18] & ins_pm[19] & (~t3));
assign stall = ( hlt_out | ld_out | jump_out);


//muxes for register block for reset
assign temp_ld = (reset == 1'b0) ? 1'b0 : ld_out;
assign temp_j1 = (reset == 1'b0) ? 1'b0 : jump_out;
assign temp_j2 = (reset == 1'b0) ? 1'b0 : t2;
assign temp = (reset == 1'b0) ? 1'b0 : stall;


//logic for register blocks
always@(posedge clk)
begin

   t1 <= temp_ld;
	t2 <= temp_j1;
	t3 <= temp_j2;
	stall_pm <= temp;

end

endmodule

