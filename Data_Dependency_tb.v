`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Data dependency block test bench


////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:35:03 10/04/2016
// Design Name:   Data_Dependency
// Module Name:   C:/Durva/Microprocessor/Data_Dependency_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Data_Dependency
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Data_Dependency_tb;

	// Inputs
	reg [19:0] ins;
	reg clk;
	reg reset;

	// Outputs
	wire [1:0] mux_sel_a;
	wire [1:0] mux_sel_b;
	wire imm_sel;
	wire [7:0] Imm;
	wire mem_en_dec;
	wire mem_rw_dec;
	wire mem_mux_sel_dec;
	wire [4:0] RW_dec;
	wire [4:0] op_dec;

	// Instantiate the Unit Under Test (UUT)
	Data_Dependency uut (
		.mux_sel_a(mux_sel_a), 
		.mux_sel_b(mux_sel_b), 
		.imm_sel(imm_sel), 
		.Imm(Imm), 
		.mem_en_dec(mem_en_dec), 
		.mem_rw_dec(mem_rw_dec), 
		.mem_mux_sel_dec(mem_mux_sel_dec), 
		.RW_dec(RW_dec), 
		.op_dec(op_dec), 
		.ins(ins), 
		.clk(clk), 
		.reset(reset)
	);

	always #500 clk = ~clk;

	initial begin
		// Initialize Inputs
		ins = 20'b00000_00000_00000_00000;
		clk = 0;
		reset = 1;
		
		#200;
		
		reset = 0;
		
		#500;
		
		reset = 1;
		
		#300;
		
		ins = 20'b00000_00001_00010_00011;
		#1000;
		
		ins = 20'b10100_00100_00001_00000;
		
		#2000;
		
		ins = 20'b00100_00101_00001_00100;

		// Wait 100 ns for global reset to finish
		ins = 20'b00100_00101_00001_00100;
		
		#1000;
		
		ins = 20'b01101_00110_00001_00101 ;
		
		#4000;
		$finish;
        
		// Add stimulus here

	end
      
endmodule 