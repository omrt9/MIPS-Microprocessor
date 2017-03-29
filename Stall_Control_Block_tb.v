`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Stall Control Block test bench


////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:25:55 10/04/2016
// Design Name:   Stall_Control_Block
// Module Name:   C:/Durva/Microprocessor/Stall_Control_Block_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Stall_Control_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Stall_Control_Block_tb;

	// Inputs
	reg [19:0] ins_pm;
	reg clk;
	reg reset;

	// Outputs
	wire stall;
	wire stall_pm;

	// Instantiate the Unit Under Test (UUT)
	Stall_Control_Block uut (
		.stall(stall), 
		.stall_pm(stall_pm), 
		.ins_pm(ins_pm), 
		.clk(clk), 
		.reset(reset)
	);

	
	always #500 clk = ~clk;
	initial begin
		// Initialize Inputs
		ins_pm = 20'h00000;
		clk = 0;
		reset = 1'b1;

		// Wait 100 ns for global reset to finish
		#200;
		
		reset = 1'b0;
		
		#550;
		
		reset = 1'b1;
		
		#850;
		
		ins_pm = 20'ha0000;
		
		#2000;
		
		ins_pm = 20'h00000;
		
		#1000;
		
		ins_pm = 20'hf0000;
		
		#3000;
		
		
		ins_pm = 20'h00000;
		
		#1000;
		
		
		ins_pm = 20'h88000;
        
		// Add stimulus here

	end
      
endmodule



