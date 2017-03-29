`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Writeback block Logic

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:38 10/04/2016 
// Design Name: 
// Module Name:    Writeback_Block 
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
module Writeback_Block(ans_wb,mux_ans_dm,clk,reset);
   
//output declaration
output reg [7:0] ans_wb;

//input declaration
input [7:0] mux_ans_dm;
input reset,clk;

//temp variable
wire [7:0] ans_wb_temp;

//mux before register
assign ans_wb_temp = (reset == 1'b0) ? 1'b0 : mux_ans_dm;

//register
always@(posedge clk)
begin 
   ans_wb <= ans_wb_temp;
end


endmodule
