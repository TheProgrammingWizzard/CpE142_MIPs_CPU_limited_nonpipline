`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2020 06:04:51 PM
// Design Name: 
// Module Name: Control
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


module Control(clk, rst, instruction,  Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite);
input [3:0] instruction;
input clk, rst;
output Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
output[3:0] ALUop;
reg[3:0] aluoptemp;
reg  BranchTemp, MemReadTemp, MemtoRegTemp, MemWriteTemp, ALUSrcTemp, RegWriteTemp;

assign ALUop = aluoptemp;
assign Branch = BranchTemp;
assign MemRead = MemReadTemp;
assign MemtoReg = MemtoRegTemp;
assign MemWrite = MemWriteTemp;
assign ALUSrc = ALUSrcTemp;
assign RegWrite = RegWriteTemp;

always @(posedge clk)
begin
    if(!rst) begin
    case(instruction)
        4'b0000:
                begin
                   BranchTemp = 0;
                   MemReadTemp = 0;
                   MemtoRegTemp = 1;
                   aluoptemp = instruction;
                   MemWriteTemp = 0;
                   ALUSrcTemp = 1;
                   RegWriteTemp = 0;                                            
                end
        4'b1000:
                begin
                   BranchTemp = 0;
                   MemReadTemp = 1;
                   MemtoRegTemp = 0;
                   aluoptemp = instruction;
                   MemWriteTemp = 0;
                   ALUSrcTemp = 0;
                   RegWriteTemp = 1;
                end
        4'b1011:
                begin
                  BranchTemp = 0;
                  MemReadTemp = 0;
                  MemtoRegTemp = 0;
                  aluoptemp = instruction;
                  MemWriteTemp = 1;
                  ALUSrcTemp = 0;
                  RegWriteTemp = 0;
                end
        4'b0100:
                begin
                
                end
        4'b0101:
                begin
                end
        4'b0110:
                begin
                end
        4'b1100:
                begin
                end
        4'b1111:
                begin
                end
        default:
                begin
                                BranchTemp = 0;
                                 MemReadTemp = 0;
                                 MemtoRegTemp = 0;
                                 aluoptemp = instruction;
                                 MemWriteTemp = 0;
                                 ALUSrcTemp = 0;
                                 RegWriteTemp = 0;                
                end
                    
     endcase;            
     end 
     else 
     begin
        BranchTemp = 0;
        MemReadTemp = 0;
        MemtoRegTemp = 0;
        aluoptemp = 4'b0000;
        MemWriteTemp = 0;
        ALUSrcTemp = 0;
        RegWriteTemp = 0;
     end           
                
                        
                

end
endmodule
