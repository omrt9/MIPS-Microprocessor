`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Jump Control Block test bench


////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:30:24 10/04/2016
// Design Name:   Jump_Control_Block
// Module Name:   C:/Durva/Microprocessor/Jump_Control_Block_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Jump_Control_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Jump_Control_Block_tb;

	// Inputs
	reg [19:0] ins;
	reg clk;
	reg interrupt;
	reg [7:0] current_address;
	reg [3:0] flag_ex;
	reg reset;

	// Outputs
	wire pc_mux_sel;
	wire [7:0] jmp_loc;

	// Instantiate the Unit Under Test (UUT)
	Jump_Control_Block uut (
		.pc_mux_sel(pc_mux_sel), 
		.jmp_loc(jmp_loc), 
		.ins(ins), 
		.clk(clk), 
		.interrupt(interrupt), 
		.current_address(current_address), 
		.flag_ex(flag_ex), 
		.reset(reset)
	);

always #500 clk = ~clk;
	initial begin
		// Initialize Inputs
		ins = 20'h00000;
		clk = 1'b0;
		interrupt = 1'b0;
		current_address = 8'h01;
		flag_ex = 4'h8;
		reset = 1'b1;

		// Wait 100 ns for global reset to finish
		#200;
        
		reset  = 1'b0;
		
		#500;
		
		reset = 1'b1;
		
		#1000;
		
		interrupt = 1'b1;
		
		#1000;
		
		ins = 20'h00008;
		interrupt = 1'b0;
		
		#1000;
		
		ins = 20'hc0008;
		current_address = 8'h04;
		
		#1000;
		
		ins = 20'h80008;
		
		#1000;
		
		ins = 20'hf8008;
		
		#1000;
		
		flag_ex = 4'ha;
		
		
		// Add stimulus here

	end
      
endmodule




