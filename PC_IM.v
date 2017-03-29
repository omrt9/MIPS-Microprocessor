`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Program Memory logic

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:15 10/04/2016 
// Design Name: 
// Module Name:    PC_IM 
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

module PC_IM(ins,ins_pm,current_address,jmp_loc,pc_mux_sel,stall,stall_pm,reset,clk);
    
	//output declaration
	output [19:0] ins,ins_pm;
	output [7:0] current_address;
	
	//input declaration
	input [7:0] jmp_loc;
	input pc_mux_sel,stall,stall_pm,reset,clk;
	
	//temp variable
	reg [7:0] address_hold,next_address;
	reg [19:0] ins_out;
	wire [7:0] current_address_temp,i_address,curr_addr, addr_temp, next_addr_temp;
	wire [19:0] ins_pm_temp,ins_temp;
	

   //logic of all multiplexers                                     
   
   //mux which chooses the output from the register block by stall as selection
    assign current_address_temp = (stall == 1'b1) ? address_hold : next_address;
   
   //mux which chooses the output and passes it to program memory block via pc_mux_sel as selection
    assign current_address = (pc_mux_sel == 1'b1) ? jmp_loc : current_address_temp;  

    assign curr_addr = (reset == 1'b0) ? 8'b0 : current_address;	 
	 
	 assign ins_pm = (reset == 1'b0) ? 20'b0 : ins; 
    
   //mux which gives the final output of ins with stall_pm as selection
	assign ins = (stall_pm == 1'b1) ? ins_out : ins_pm_temp;
	
	assign  ins_temp = (reset == 1'b0) ? 20'b0 : ins;

   //program counter logic

   //increment block
   assign i_address = current_address + 8'b00000001;   //increments the value of current address by 1
	
	assign addr_temp = (reset == 1'b0) ? 8'b0 : current_address;
	assign next_addr_temp = (reset == 1'b0) ? 8'b0 : i_address;
	
	//register block
   always@(posedge clk)
	  begin
	       address_hold <= addr_temp;
			 next_address <= next_addr_temp;
			 ins_out <= ins_temp;
	  end

//ip_core instance    (enable not present in the block diagram so default value 1'b1) 
//The code for the block program memory in the given instance
PM PC_IM (
  .clka(clk), // input clka
  .ena(1'b1), // input ena
  .addra(curr_addr), // input [7 : 0] addra
  .douta(ins_pm_temp) // output [19 : 0] douta
);

endmodule

