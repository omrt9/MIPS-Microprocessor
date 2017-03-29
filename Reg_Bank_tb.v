`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Register block test bench



////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:01:05 10/04/2016
// Design Name:   Reg_Bank
// Module Name:   C:/Durva/Microprocessor/Reg_Bank_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Reg_Bank
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Reg_Bank_tb;

	// Inputs
	reg [19:0] ins;
	reg [4:0] RW_dm;
	reg [7:0] ans_ex;
	reg [7:0] mux_ans_dm;
	reg [7:0] ans_wb;
	reg [7:0] imm;
	reg [1:0] mux_sel_A;
	reg [1:0] mux_sel_B;
	reg imm_sel;
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] A;
	wire [7:0] B;

	// Instantiate the Unit Under Test (UUT)
	Reg_Bank uut (
		.A(A), 
		.B(B), 
		.ins(ins), 
		.RW_dm(RW_dm), 
		.ans_ex(ans_ex), 
		.mux_ans_dm(mux_ans_dm), 
		.ans_wb(ans_wb), 
		.imm(imm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.clk(clk), 
		.reset(reset)
	);

	always #500 clk = ~clk;
	initial begin
		// Initialize Inputs
		ins = 20'b00000001010011000101;
		RW_dm = 8'h05;	
		ans_ex = 8'h01;
		mux_ans_dm = 8'h02;
		ans_wb = 8'h03;
		imm = 8'h04;
		mux_sel_A = 2'b00;
		mux_sel_B = 2'b00;
		imm_sel = 0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#200;
		
		reset = 0;
		
		#500;
		
		reset = 1;
		
		#1000;
		
		RW_dm = 8'h06;
		mux_ans_dm = 8'h05;
        
		#1000;
		
		RW_dm = 8'h07;
		mux_sel_A = 2'b01;
		
		#1000;
		
		mux_sel_A = 2'b10;
		mux_sel_B = 2'b11;
		
		#1000;
		
		imm_sel = 1;
		// Add stimulus here
		
		#1000;
		$finish;

	end
      
endmodule


