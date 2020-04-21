`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2020 03:29:13 PM
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb();
reg clk, rst, debug_override, debug_instruction_we, debug_data_we;
reg [15:0] debug_instruction_data_in, debug_instruction_address, debug_data_wdata, debug_data_address;
wire [15:0] debug_alu_result_out, debug_pc_out, debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out, debug_regout1, debug_regout2, debug_datamux;
wire  debug_clkdiv_out;
initial clk = 0;

always #5 clk = !clk;

top uut(clk, rst, debug_override, debug_instruction_we, debug_instruction_data_in, debug_instruction_address, debug_data_we, debug_data_wdata, debug_data_address, debug_alu_result_out, debug_pc_out, debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out, debug_clkdiv_out, debug_regout1, debug_regout2, debug_datamux);

initial
begin
 rst = 1;
 debug_override = 0;
 #10;
 debug_instruction_we = 1;
 debug_data_we = 1;
 debug_instruction_address = {{13{1'b0}}, {3'b100}};
 debug_instruction_data_in = 16'b1000000000000000;
 debug_data_address = {16{1'b0}};
 debug_data_wdata = {{15{1'b0}}, {1'b1}};
 #20;
  debug_instruction_we = 1;
  debug_data_we = 1;
  debug_instruction_address = {{12{1'b0}}, {4'b1000}};
  debug_instruction_data_in = 16'b1000000100010000;
  debug_data_address = {{15{1'b0}}, {1'b1}};
  debug_data_wdata = {{14{1'b0}}, {2'b10}};
  #20;
  debug_data_we = 0;
  debug_instruction_address = {{10{1'b0}}, {6'b001100}};
  
  debug_instruction_data_in = 16'b0000000100001111;

  #20;
  debug_instruction_we = 0;
  debug_instruction_address = {16{1'b0}};
  debug_instruction_data_in = {16{1'b0}};
  debug_data_address = {16{1'b0}};
  debug_data_wdata = {16{1'b0}};
  #20;
  rst = 0;
  #100;
end

endmodule
