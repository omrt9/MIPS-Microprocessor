`timescale 1ns / 1ps

//Group number : 16
//Group name : The Intellites
//Module name : Jump Control Block logic

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:29:15 10/04/2016 
// Design Name: 
// Module Name:    Jump_Control_Block 
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
module Jump_Control_Block(pc_mux_sel,jmp_loc,ins,clk,interrupt,current_address,flag_ex,reset);

//output declaration
output  pc_mux_sel;
output  [7:0] jmp_loc;

//input declaration
input [19:0] ins;
input clk,interrupt,reset;
input [7:0] current_address;
input [3:0] flag_ex;

//temp variables
wire [7:0] t1,t2,t9;
wire t8;
reg [7:0] t3;
reg [3:0] t6;
reg r1;
wire [3:0] t4,t5,t7;
wire ret,jc,jnc,jz,jnz,jmp,m1,m2,m3,m4;

//2:1 mux to decide between current address and the feedbacked value of the register
assign t1 = (interrupt == 1'b1) ? current_address : t3;
assign t2 = (reset == 1'b0) ? 0 : t1;

//register for the current address
always@(posedge clk)
begin
   t3 <= t2;
end
	
//2:1 mux to decide between flag ex and the feedbacked value	
assign t4 = (interrupt == 1'b1) ? flag_ex : t6;
assign t5 = (reset == 1'b0) ? 0 : t4;

//register for value of flag_ex
always@(posedge clk)
begin
   t6 <= t5;
end

//RET gate
assign ret = (ins[19] & (~ins[18]) & (~ins[17]) & (~ins[16]) & (~ins[15]));

//2:1 mux to decide between flag_ex and the feedbacked value with ret value as select line
assign t7 = (ret == 1'b1) ? t6 : flag_ex;

//register for interrupt as it is clock synchronous
assign t8 = (reset == 1'b0) ? 0 : interrupt;
always@(posedge clk)
begin
   r1 <= t8;
end

//mux to decide the one of the input for mux of the selection of jum_loc
assign t9 = (r1 == 1'b1) ? 8'hf0 : ins[7:0];

//mux to decide the jump location
assign jmp_loc = (ret == 1'b1) ? t3 : t9;

//logic for the gates
assign jc = (ins[19] & ins[18] & ins[17] & (~ins[16]) & (~ins[15]));
	
assign jnc = (ins[19] & ins[18] & ins[17] & (~ins[16]) & ins[15]);

assign jz = (ins[19] & ins[18] & ins[17] & ins[16] & (~ins[15]));

assign jnz = (ins[19] & ins[18] & ins[17] & ins[16] & ins[15]);

assign jmp = (ins[19] & ins[18] & (~ins[17]) & (~ins[16]) & (~ins[15]));


assign m1 = (jc & t7[0]);

assign m2 = ((~t7[0]) & jnc);

assign m3 = (jz & t7[1]);

assign m4 = ((~t7[1]) & jnz);


//output pc_mux_sel
assign pc_mux_sel = (m1 | m2 | m3 | ret | m4 | jmp | r1 );


endmodule


