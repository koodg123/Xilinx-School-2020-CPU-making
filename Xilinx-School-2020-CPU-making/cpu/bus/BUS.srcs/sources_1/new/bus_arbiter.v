`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 

// Design Name: 
// Module Name: bus_arbiter
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

`include "nettype.h"
`include "stddef.h"
`include "global_config.h"


`include "bus.h"


module bus_arbiter (
	
	input  wire		   clk,		 
	input  wire		   reset,	 
	
	
	input  wire		   m0_req_,	 
	output reg		   m0_grnt_, 

	input  wire		   m1_req_,	 
	output reg		   m1_grnt_, 

	input  wire		   m2_req_,	 
	output reg		   m2_grnt_, 

	input  wire		   m3_req_,	 
	output reg		   m3_grnt_	 
)


	reg [`BusOwnerBus] owner;	 
  

	always @(*) begi
		
		m0_grnt_ = `DISABLE_
		m1_grnt_ = `DISABLE_
		m2_grnt_ = `DISABLE_;
		m3_grnt_ = `DISABLE_;
	
		case (owner)
			`BUS_OWNER_MASTER_0 : begin
				m0_grnt_ = `ENABLE_
			en
			`BUS_OWNER_MASTER_1 : begin
				m1_grnt_ = `ENABLE_
			en
			`BUS_OWNER_MASTER_2 : begin
				m2_grnt_ = `ENABLE_
			en
			`BUS_OWNER_MASTER_3 : begin
				m3_grnt_ = `ENABLE_
			end
		endcase
	end
   

	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
		
			owner <= #1 `BUS_OWNER_MASTER_0;
		end else begin
			
			case (owner)
				`BUS_OWNER_MASTER_0 : begin 
					
					if (m0_req_ == `ENABLE_) begin			
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_3;
					end
				end
				`BUS_OWNER_MASTER_1 : begin 
					
					if (m1_req_ == `ENABLE_) begin			
						owner <= #1 `BUS_OWNER_MASTER_1
					end else if (m2_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_2
					end else if (m3_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_3
					end else if (m0_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_0;
					end
				end
				`BUS_OWNER_MASTER_2 : begin 
					
					if (m2_req_ == `ENABLE_) begin			
						owner <= #1 `BUS_OWNER_MASTER_2
					end else if (m3_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_3
					end else if (m0_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_0
					end else if (m1_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_1
					end
				end
				`BUS_OWNER_MASTER_3 : begin
					
					if (m3_req_ == `ENABLE_) begin			
						owner <= #1 `BUS_OWNER_MASTER_3
					end else if (m0_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_0
					end else if (m1_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_1
					end else if (m2_req_ == `ENABLE_) begin 
						owner <= #1 `BUS_OWNER_MASTER_2
					en
				end
			endcase
		end
	end

endmodule
