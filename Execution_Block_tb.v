`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Execution block test bench


////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:37:22 10/04/2016
// Design Name:   Execution_Block
// Module Name:   C:/Durva/Microprocessor/Execution_Block_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Execution_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Execution_Block_tb;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] data_in;
	reg [4:0] op_dec;
	reg clk;
	reg mem_en_dec;
	reg mem_rw_dec;
	reg mem_mux_sel_dec;
	reg [4:0] RW_dec;
	reg reset;

	// Outputs
	wire [3:0] flag_ex;
	wire [7:0] ans_ex;
	wire [7:0] data_out;
	wire [7:0] B_Bypass;
	wire mem_en_ex;
	wire mem_rw_ex;
	wire mem_mux_sel_ex;
	wire [4:0] RW_ex;

	// Instantiate the Unit Under Test (UUT)
	Execution_Block uut (
		.flag_ex(flag_ex), 
		.ans_ex(ans_ex), 
		.data_out(data_out), 
		.B_Bypass(B_Bypass), 
		.mem_en_ex(mem_en_ex), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_mux_sel_ex(mem_mux_sel_ex), 
		.RW_ex(RW_ex), 
		.A(A), 
		.B(B), 
		.data_in(data_in), 
		.op_dec(op_dec), 
		.clk(clk), 
		.mem_en_dec(mem_en_dec), 
		.mem_rw_dec(mem_rw_dec), 
		.mem_mux_sel_dec(mem_mux_sel_dec), 
		.RW_dec(RW_dec), 
		.reset(reset)
	);

	always #500 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk 					= 1'b0;
		reset 				= 1'b1;
		op_dec 				= 5'b00000;
		data_in 				= 8'h00;
		A 						= 8'h00;
		B 						= 8'h00;
		mem_en_dec 			= 1'b0;
		mem_rw_dec 			= 1'b0;
		mem_mux_sel_dec 	= 1'b0;
		RW_dec 				= 5'b00000;

		#200;//0.2us
		reset 				= 1'b0;
		
		#600;//0.8us
		reset 				= 1'b1;
		
		#200;//1us
		op_dec 				= 5'b00000;
		data_in 				= 8'h08;
		A 						= 8'h40;
		B 						= 8'hc0;
		RW_dec 				= 5'b00101;
		
		#1000;//2us
		op_dec 				= 5'b00001;
		
		#1000;//3us
		op_dec 				= 5'b00010;
		
		#1000;//4us
		op_dec 				= 5'b00100;
		
		#1000;//5us
		op_dec 				= 5'b00101;
		
		#1000;//6us
		op_dec 				= 5'b00110;
		
		#1000;//7us
		op_dec 				= 5'b00111;
		
		#1000;//8us
		op_dec 				= 5'b01000;
		
		#1000;//9us
		op_dec 				= 5'b01001;
		
		#1000;//10us
		op_dec 				= 5'b01010;
		
		#1000;//11us
		op_dec 				= 5'b01100;
		
		#1000;//12us
		op_dec 				= 5'b01101;
		
		#1000;//13us
		op_dec 				= 5'b01110;
		
		#1000;//14us
		op_dec 				= 5'b01111;
		
		#1000;//15us
		op_dec 				= 5'b10000;
		
		#1000;//16us
		op_dec 				= 5'b10001;
		
		#1000;//17us
		op_dec 				= 5'b10100;
		
		#1000;//18us
		op_dec 				= 5'b10101;
		
		#1000;//19us
		op_dec 				= 5'b10110;
		
		#1000;//20us
		op_dec 				= 5'b10111;
		
		#1000;//21us
		op_dec 				= 5'b11000;
		
		#1000;//22us
		op_dec 				= 5'b11001;
		data_in 				= 8'h08;
		A 						= 8'hc0;
		B 						= 8'h01;
		mem_en_dec 			= 1'b1;
		mem_rw_dec 			= 1'b1;
		mem_mux_sel_dec 	= 1'b1;
		RW_dec 				= 5'b01010;
		
		#1000;//23us
		op_dec 				= 5'b11010;
		
		#1000;//24us
		op_dec 				= 5'b11011;
		
		#1000;//25us
		op_dec 				= 5'b11100;
		
		#1000;//26us
		op_dec 				= 5'b11101;
		
		#1000;//27us
		op_dec 				= 5'b11110;
		
		#1000;//28us
		op_dec 				= 5'b11111;
				
		#2000;//30us
		$finish;

	end
      
endmodule

