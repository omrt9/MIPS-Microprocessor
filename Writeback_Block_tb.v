`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Writeback block test bench


////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:10:30 10/04/2016
// Design Name:   Writeback_Block
// Module Name:   C:/Durva/Microprocessor/Writeback_Block_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Writeback_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Writeback_Block_tb;

	// Inputs
	reg [7:0] mux_ans_dm;
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] ans_wb;

	// Instantiate the Unit Under Test (UUT)
	Writeback_Block uut (
		.ans_wb(ans_wb), 
		.mux_ans_dm(mux_ans_dm), 
		.clk(clk), 
		.reset(reset)
	);
	
	always #500 clk = ~clk;

	initial begin
		// Initialize Inputs
		mux_ans_dm = 8'hff;
		clk = 0;
		reset = 1;
		
		

		// Wait 100 ns for global reset to finish
		#200;
		
		reset = 0;
		
		#500;
		
		reset = 1;
		
		#1300;
		
		mux_ans_dm = 8'h0f;
		
		#2000;
		$finish;
        
		// Add stimulus here

	end
      
endmodule

