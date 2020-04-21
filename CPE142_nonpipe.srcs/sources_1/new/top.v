`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sacramento State University
// Engineer: Travis Anderson
// 
// Create Date: 04/19/2020 02:50:37 PM
// Design Name: MIPs limited instruction set CPU for CPE142
// Module Name: top
// Project Name: CPE142 term project
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


module top(clk, rst, debug_override, debug_instruction_we, debug_instruction_data_in, debug_instruction_address, debug_data_we, 
debug_data_wdata, debug_data_address, debug_alu_result_out, debug_pc_out, debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out, debug_clkdiv_out,
debug_regout1, debug_regout2, debug_datamux);
input clk, rst;

input debug_override, debug_instruction_we, debug_data_we;
input [15:0] debug_instruction_data_in, debug_instruction_address, debug_data_wdata, debug_data_address;
output [15:0] debug_alu_result_out, debug_pc_out, debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out, debug_regout1, debug_regout2, debug_datamux;
output debug_clkdiv_out;

wire [15:0] instruction, signex;//instruction mem out
wire instruction_re;
wire Branch, MemRead, MemToReg, Memwrite, ALUsrc, RegWrite, zero;//control
wire [3:0] ALUop;
wire [15:0] rdata1, rdata2, aluop2;//registers out
wire [15:0] ALUResult;//ALU OUT
wire [15:0] readdata;//data mem out;
wire [15:0] pccurrent, pcnext;//pc
wire [15:0] pcadderout;//pcadderout
wire [15:0] datamemmuxout;//reg write data in
wire[15:0] aluop2muxout;
wire[3:0] alucontrolout;
wire aluoverflow;
wire [15:0] signshiftout;
wire[15:0] branchadderout;
wire branchand;
wire[15:0] dmRdata;
wire clk_div;
//debug stuff
assign instruction_re = !debug_instruction_we;
assign debug_alu_result_out = ALUResult;
assign debug_pc_out = pccurrent;
assign debug_instruction_out = instruction;
assign debug_alu_op2_out = rdata1;
assign debug_alu_op1_out = aluop2muxout;
assign debug_clkdiv_out = clk_div; 
assign debug_regout1 = rdata1;
assign debug_regout2 = rdata2;
assign debug_datamux = datamemmuxout;
always @(posedge clk)
begin
    if(debug_override)
    begin 
            
        
    end
end
//end debug stuff
clkdiv feqdiv(clk, rst, clk_div);
ProgramCounter pc(pcnext, pccurrent, clk_div, rst);
PCAdder pcadder(pccurrent, 16'b0000000000000100, pcadderout);
InstructionMemory im(debug_instruction_data_in, pccurrent, instruction, debug_instruction_we, instruction_re, clk, debug_instruction_we, debug_instruction_data_in, debug_instruction_address);
Control c(clk, rst, instruction[15:12], Branch, MemRead, MemToReg, ALUop, Memwrite, ALUsrc, RegWrite);
Registers r(instruction[11:8], instruction[7:4], rdata1, rdata2, instruction[11:8], datamemmuxout, RegWrite, clk, rst);
SignExtender se(clk, instruction[7:4], signex);
ALU alu(rdata1, aluop2muxout, alucontrolout, ALUResult, aluoverflow, zero, clk, rst);
mux16 alumux(rdata2, signex, ALUsrc, aluop2muxout);
ALUControl aluc(clk, instruction[3:0], ALUop, alucontrolout);
SignShift ss(signex, signshiftout);
BranchAdder ba(pcadderout, signshiftout, branchadderout);
assign branchand = !(Branch & zero);
mux16 bmux(pcadderout, branchadderout, branchand, pcnext);
DataMemory dm(rdata2, ALUResult, dmRdata, Memwrite, MemRead, clk,  debug_data_we, debug_data_wdata, debug_data_address);
mux16 datamux(ALUResult, dmRdata, MemToReg, datamemmuxout);


endmodule
