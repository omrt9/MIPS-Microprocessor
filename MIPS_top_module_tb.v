`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:22:17 10/07/2016
// Design Name:   MIPS_top_module
// Module Name:   C:/Durva/Microprocessor/MIPS_top_module_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MIPS_top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MIPS_top_module_tb;

	// Inputs
	reg [7:0] data_in;
	reg clk;
	reg interrupt; 
	reg reset;

	// Outputs
	//wire [19:0] ins;
	//wire [7:0] A;
	//wire [7:0] B;
	//wire [7:0] current_address;
	//wire [7:0] ans_ex;
	//wire [7:0] mux_ans_dm;
	//wire [7:0] ans_wb;
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	MIPS_top_module uut (
		//.ins(ins), 
		//.A(A), 
		//.B(B), 
		//.current_address(current_address), 
		//.ans_ex(ans_ex), 
		//.mux_ans_dm(mux_ans_dm), 
		//.ans_wb(ans_wb), 
		.data_out(data_out), 
		.data_in(data_in), 
		.clk(clk), 
		.interrupt(interrupt), 
		.reset(reset)
	);

	initial  begin   	
			data_in = 0;  
			interrupt = 0;   
			clk = 0;   
			reset = 1; 
			#2; 
			reset = 0;
			#5; 
			reset = 1;
			#500; $finish;
			end  
			
			always    #5 clk = ~clk; 
      
endmodule

