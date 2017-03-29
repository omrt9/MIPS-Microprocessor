`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Data_memory logic

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:18:45 10/04/2016 
// Design Name: 
// Module Name:    Data_Mem 
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
module Data_Mem(mux_ans_dm,RW_dm,ans_ex,B_Bypass,RW_ex,mem_en_ex,mem_rw_ex,mem_mux_sel_ex,clk,reset);

//Output Declaration
output [7:0] mux_ans_dm;
output reg [4:0] RW_dm;

//Input Declaration
input [7:0] ans_ex, B_Bypass;
input [4:0] RW_ex;
input mem_en_ex, mem_rw_ex, mem_mux_sel_ex, clk, reset;

//Tenporary Variable Declaration
wire [7:0] ans_dm, ans_ex_temp;
reg [7:0] ans_reg;
reg mem_mux_sel_dm;
wire [4:0] RW_ex_temp;
wire mem_mul_sel_ex_temp;

//MUX used for reset in Register Block
assign RW_ex_temp = (reset == 1'b1) ? RW_ex : 0;
assign mem_mul_sel_ex_temp = (reset == 1'b1) ? mem_mux_sel_ex : 0;
assign ans_ex_temp = (reset == 1'b1) ? ans_ex : 0;

//Register Block, Clock Synchronous
always @(posedge clk)
begin
		RW_dm <= RW_ex_temp;
		mem_mux_sel_dm <= mem_mul_sel_ex_temp;
		ans_reg <= ans_ex_temp;
end

//IP Core instance
Data_Memory Data_Mem (
  .clka(clk), // input clka
  .ena(mem_en_ex), // input ena
  .wea(mem_rw_ex), // input [0 : 0] wea
  .addra(ans_ex), // input [7 : 0] addra
  .dina(B_Bypass), // input [7 : 0] dina
  .douta(ans_dm) // output [7 : 0] douta
);

//MUX 
assign mux_ans_dm = (mem_mux_sel_dm == 0) ? ans_reg : ans_dm;

endmodule
