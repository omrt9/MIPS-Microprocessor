`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Data Memory test bench


////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:24:48 10/04/2016
// Design Name:   Data_Mem
// Module Name:   C:/Durva/Microprocessor/Data_Mem_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Data_Mem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Data_Mem_tb;

	// Inputs
	reg [7:0] ans_ex;
	reg [7:0] B_Bypass;
	reg [4:0] RW_ex;
	reg mem_en_ex;
	reg mem_rw_ex;
	reg mem_mux_sel_ex;
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] mux_ans_dm;
	wire [4:0] RW_dm;

	// Instantiate the Unit Under Test (UUT)
	Data_Mem uut (
		.mux_ans_dm(mux_ans_dm), 
		.RW_dm(RW_dm), 
		.ans_ex(ans_ex), 
		.B_Bypass(B_Bypass), 
		.RW_ex(RW_ex), 
		.mem_en_ex(mem_en_ex), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_mux_sel_ex(mem_mux_sel_ex), 
		.clk(clk), 
		.reset(reset)
	);

always #500 clk = ~clk;
	initial begin
		// Initialize Inputs
		ans_ex = 8'h05;
		B_Bypass =  8'h50;
		RW_ex = 5'h1f;
		mem_en_ex = 0;
		mem_rw_ex = 0;
		mem_mux_sel_ex = 1'b1;
		clk = 0;
		reset = 1'b1;

		// Wait 100 ns for global reset to finish
		#200;
        
		 reset = 1'b0;

     #500;

      reset = 1'b1;

     #1400;

		mem_en_ex = 1'b1;
		
		#1000;
		
		mem_rw_ex = 1'b1;
		
		#1000;
		
		mem_rw_ex = 1'b0;
		
		#1000;
		
		mem_mux_sel_ex = 1'b0;
		
		#2000;
		// Add stimulus here

	end
      
endmodule


