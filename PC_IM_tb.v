`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : pc_im (program memory) test bench


////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:55:05 10/04/2016
// Design Name:   PC_IM
// Module Name:   C:/Durva/Microprocessor/PC_IM_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PC_IM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PC_IM_tb;

	// Inputs
	reg [7:0] jmp_loc;
	reg pc_mux_sel;
	reg stall;
	reg stall_pm;
	reg reset;
	reg clk;

	// Outputs
	wire [19:0] ins;
	wire [19:0] ins_pm;
	wire [7:0] current_address;

	// Instantiate the Unit Under Test (UUT)
	PC_IM uut (
		.ins(ins), 
		.ins_pm(ins_pm), 
		.current_address(current_address), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.stall(stall), 
		.stall_pm(stall_pm), 
		.reset(reset), 
		.clk(clk)
	);

//waits for 10ns to complete 1 clock cycle
	always #5 clk=~clk;
	initial begin
		// Initialize Inputs
		jmp_loc = 8'h00;
		pc_mux_sel = 1'b1;
		stall = 1'b0;
		stall_pm = 1'b0;
		reset = 1'b1;
		clk = 0;

		//wait for 2ns
		#2;
       
      reset = 1'b0;
		
		//wait for 5ns  
		#5;
		
		reset = 1'b1;
		
		//wait for 3ns		
		#3;

      jmp_loc = 8'h08;
		pc_mux_sel = 1'b0;
		
		#30;
		
		stall = 1'b1;
		
		#20;
		
		stall = 1'b0;
		
		#10;
		
		pc_mux_sel = 1'b1;
		
		#20;
      		
		 
		// Add stimulus here

	end
      
endmodule




