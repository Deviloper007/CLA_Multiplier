`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:39:40 07/28/2023 
// Design Name: 
// Module Name:    cpu_wb_cla_multiplier 
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
module cla_multiplier (multicand, multiplier, product);
parameter MULTICAND_WID = 32;
parameter MULTIPLIER_WID = 32;

input [MULTICAND_WID-1:0] multicand;
input [MULTIPLIER_WID-1:0] multiplier;
output [(MULTICAND_WID + MULTIPLIER_WID - 1):0] product;

wire [MULTICAND_WID - 1:0] multicand_tmp [MULTIPLIER_WID-1:0];
wire [MULTICAND_WID - 1:0] product_tmp [MULTIPLIER_WID-1:0];
wire [MULTIPLIER_WID -1:0] carry_tmp;
 genvar i, j;
generate 
 for(j = 0; j < MULTIPLIER_WID; j = j + 1) begin: for_loop_j
 assign multicand_tmp[j] =  multicand & {MULTICAND_WID{multiplier[j]}};
 end
 
 assign product_tmp[0] = multicand_tmp[0];
 assign carry_tmp[0] = 1'b0;
 assign product[0] = product_tmp[0][0];
 for(i = 1; i < MULTIPLIER_WID; i = i + 1) begin: for_loop_i
 cpu_wb_cla_adder #(.DATA_WID(MULTIPLIER_WID)) add1 (
     // Outputs
     .sum(product_tmp[i]),
     .carry_out(carry_tmp[i]),
     // Inputs
   .carry_in(1'b0),
     .in1(multicand_tmp[i]),
     .in2({carry_tmp[i-1],product_tmp[i-1][31-:31]}));
 assign product[i] = product_tmp[i][0];
 end //end for loop
 assign product[(MULTIPLIER_WID+MULTIPLIER_WID-1):MULTIPLIER_WID] = {carry_tmp[MULTIPLIER_WID-1],product_tmp[MULTIPLIER_WID-1][31-:31]};
endgenerate
endmodule
