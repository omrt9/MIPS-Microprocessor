`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module Name:    Execution_Block logic



//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:34:56 10/04/2016 
// Design Name: 
// Module Name:    Execution_Block 
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
module Execution_Block(flag_ex,ans_ex,data_out,B_Bypass,mem_en_ex,mem_rw_ex,mem_mux_sel_ex,RW_ex,A,B,data_in,op_dec,clk,mem_en_dec,mem_rw_dec,mem_mux_sel_dec,RW_dec,reset); 

//input declarations
output [3:0] flag_ex;
output reg [7:0] ans_ex,data_out,B_Bypass;
output reg [4:0] RW_ex;
output reg mem_en_ex,mem_rw_ex,mem_mux_sel_ex;

//output declarations
input [7:0] A,B,data_in;
input [4:0] op_dec,RW_dec;
input clk,reset,mem_en_dec,mem_rw_dec,mem_mux_sel_dec;

//temp wires
wire [7:0] data_out_buff,ans_temp,t_add,t_sub,temp_rsa,comp_B,ans_ex_temp,data_out_temp,B_bypass_temp;
wire [3:0] flag_temp,flag;
reg [3:0] flag_ex_reg;
wire [6:0] ct,cs;
wire [4:0] RW_ex_temp;
wire a_carry,s_carry,overflow_a,overflow_s,zero,parity,mem_en_ex_temp,mem_rw_ex_temp,mem_mux_sel_ex_temp;

//2's compliment of B
assign comp_B = (~B) + 8'b00000001;

//8 bit adder
assign {ct[0],t_add[0]} = A[0] + B[0];
assign {ct[1],t_add[1]} = A[1] + B[1] + ct[0];
assign {ct[2],t_add[2]} = A[2] + B[2] + ct[1];
assign {ct[3],t_add[3]} = A[3] + B[3] + ct[2];
assign {ct[4],t_add[4]} = A[4] + B[4] + ct[3];
assign {ct[5],t_add[5]} = A[5] + B[5] + ct[4];
assign {ct[6],t_add[6]} = A[6] + B[6] + ct[5];
assign {a_carry,t_add[7]} = A[7] + B[7] + ct[6];

//overflow for adder
assign overflow_a = a_carry ^ ct[6];

//8 bit subtractor
assign {cs[0],t_sub[0]} = A[0] + comp_B[0];
assign {cs[1],t_sub[1]} = A[1] + comp_B[1] + cs[0];
assign {cs[2],t_sub[2]} = A[2] + comp_B[2] + cs[1];
assign {cs[3],t_sub[3]} = A[3] + comp_B[3] + cs[2];
assign {cs[4],t_sub[4]} = A[4] + comp_B[4] + cs[3];
assign {cs[5],t_sub[5]} = A[5] + comp_B[5] + cs[4];
assign {cs[6],t_sub[6]} = A[6] + comp_B[6] + cs[5];
assign {s_carry,t_sub[7]} = A[7] + comp_B[7] + cs[6];

//overflow for subtractor
assign overflow_s = s_carry ^ cs[6];

//logic for right shift arithmetic
assign temp_rsa = (B[2:0] == 3'b000) ? A :
                  (B[2:0] == 3'b001) ? {A[7],A[7:1]} :
						(B[2:0] == 3'b010) ? {A[7],A[7],A[7:2]} :
						(B[2:0] == 3'b011) ? {A[7],A[7],A[7],A[7:3]} :
						(B[2:0] == 3'b100) ? {A[7],A[7],A[7],A[7],A[7:4]} :
						(B[2:0] == 3'b101) ? {A[7],A[7],A[7],A[7],A[7],A[7:5]} :
               	(B[2:0] == 3'b110) ? {A[7],A[7],A[7],A[7],A[7],A[7],A[7:6]} :
                  (B[2:0] == 3'b110) ? {A[7],A[7],A[7],A[7],A[7],A[7],A[7],A[7]} : 8'bx;
						
//data out buff						
assign data_out_buff = (op_dec == 5'b10111) ? A : data_out;
 
                  
//assign value of answer temp through different opcodes using the given instruction table						
assign ans_temp = (op_dec == 5'b00000) ? t_add :
                  (op_dec == 5'b00001) ? t_sub :
						(op_dec == 5'b00010) ? B :
						(op_dec == 5'b00100) ? A&B :
						(op_dec == 5'b00101) ? A|B :
						(op_dec == 5'b00110) ? A^B :
						(op_dec == 5'b00111) ? (~B) :
						(op_dec == 5'b01000) ? t_add :
						(op_dec == 5'b01001) ? t_sub :
						(op_dec == 5'b01010) ? B :
						(op_dec == 5'b01100) ? A&B :
						(op_dec == 5'b01101) ? A|B :
						(op_dec == 5'b01110) ? A^B :
						(op_dec == 5'b01111) ? (~B) :
						(op_dec == 5'b10000) ? ans_ex:
						(op_dec == 5'b10001) ? ans_ex:
						(op_dec == 5'b10100) ? A :
						(op_dec == 5'b10101) ? A :
						(op_dec == 5'b10110) ? data_in :
						(op_dec == 5'b10111) ? ans_ex :
						(op_dec == 5'b11000) ? ans_ex:
						(op_dec == 5'b11001) ? A<<B :
						(op_dec == 5'b11010) ? A>>B : 
						(op_dec == 5'b11011) ? temp_rsa :
						(op_dec == 5'b11100) ? ans_ex:
						(op_dec == 5'b11101) ? ans_ex :
						(op_dec == 5'b11110) ? ans_ex:
						(op_dec == 5'b11111) ? ans_ex: 8'b0;

//assign ans_temp_1 = ans_temp;				
						
 
//assigning zero and parity flag
assign zero = ~(ans_temp[0] | ans_temp[1] | ans_temp[2] | ans_temp[3] | ans_temp[4] | ans_temp[5] | ans_temp[6] | ans_temp[7]);

assign parity =  (ans_temp[0] ^ ans_temp[1] ^ ans_temp[2] ^ ans_temp[3] ^ans_temp[4] ^ans_temp[5] ^ ans_temp[6] ^ ans_temp[7]);

//assigning value of flag temp for different opcodes
assign flag_temp =(op_dec == 5'b00000) ? {parity,overflow_a,zero,a_carry} :
                  (op_dec == 5'b00001) ? {parity,overflow_s,zero,s_carry} :
						(op_dec == 5'b00010) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b00100) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b00101) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b00110) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b00111) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b01000) ? {parity,overflow_a,zero,a_carry} :
						(op_dec == 5'b01001) ? {parity,overflow_s,zero,s_carry} :
						(op_dec == 5'b01010) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b01100) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b01101) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b01110) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b01111) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b10000) ? 4'b0000 :
						(op_dec == 5'b10001) ? 4'b0000 :
						(op_dec == 5'b10100) ? flag_ex_reg :
						(op_dec == 5'b10101) ? flag_ex_reg :
						(op_dec == 5'b10110) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b10111) ? flag_ex_reg :
						(op_dec == 5'b11000) ? flag_ex_reg :
						(op_dec == 5'b11001) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b11010) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b11011) ? {parity,1'b0,zero,1'b0} :
						(op_dec == 5'b11100) ? flag_ex_reg :
						(op_dec == 5'b11101) ? flag_ex_reg :
						(op_dec == 5'b11110) ? flag_ex_reg :
						(op_dec == 5'b11111) ? flag_ex_reg : 8'b0;


assign flag_ex  = flag_temp;

assign ans_ex_temp = (reset ==1'b0) ? 0 : ans_temp;
assign B_bypass_temp = (reset ==1'b0) ? 0 : B;
assign data_out_temp = (reset ==1'b0) ? 0 : data_out_buff;
assign RW_ex_temp = (reset ==1'b0) ? 0 : RW_dec;
assign mem_en_ex_temp = (reset ==1'b0) ? 0 : mem_en_dec;
assign mem_rw_ex_temp = (reset ==1'b0) ? 0 : mem_rw_dec;
assign mem_mux_sel_ex_temp = (reset ==1'b0) ? 0 : mem_mux_sel_dec;
assign flag = (reset == 1'b0) ? 0 : flag_ex;


//passing the outputs of ALU in register where all outputs will be clock syncronous
always@(posedge clk)
begin
   
	 begin
	    ans_ex <= ans_ex_temp;
		 B_Bypass <= B_bypass_temp;
		 data_out <= data_out_temp;
       mem_en_ex <= mem_en_ex_temp;
		 mem_rw_ex <= mem_rw_ex_temp;
		 mem_mux_sel_ex <= mem_mux_sel_ex_temp;
		 RW_ex <= RW_ex_temp;
		 flag_ex_reg <= flag;
	 end
end

endmodule
