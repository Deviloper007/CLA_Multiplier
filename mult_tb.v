`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:40:05 07/28/2023
// Design Name:   cpu_wb_cla_multiplier
// Module Name:   E:/xilinx/location_workingDirectory/cla_multiplier/mult_tb.v
// Project Name:  cla_multiplier
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu_wb_cla_multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mult_tb;

	// Inputs
	reg [31:0] multicand;
	reg [31:0] multiplier;

	// Outputs
	wire [63:0] product;

	// Instantiate the Unit Under Test (UUT)
	cla_multiplier uut (
		.multicand(multicand), 
		.multiplier(multiplier), 
		.product(product)
	);

	initial begin
		// Initialize Inputs
		multicand = 0;
		multiplier = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		  multicand = 32'h00007FFF;
        multiplier = 32'h0000007F;
	end
      
endmodule

