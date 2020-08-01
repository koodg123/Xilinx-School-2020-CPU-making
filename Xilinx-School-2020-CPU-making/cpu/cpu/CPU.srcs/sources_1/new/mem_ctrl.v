`include "nettype.h"
`include "global_config.h"
`include "stddef.h"

`include "isa.h"
`include "cpu.h"
`include "bus.h"


module mem_ctrl (
	
	input  wire				   ex_en,		   
	input  wire [`MemOpBus]	   ex_mem_op,	   
	input  wire [`WordDataBus] ex_mem_wr_data, 
	input  wire [`WordDataBus] ex_out,		   
	
	input  wire [`WordDataBus] rd_data,		   
	output wire [`WordAddrBus] addr,		   
	output reg				   as_,			   
	output reg				   rw,			   
	output wire [`WordDataBus] wr_data,		   
	
	output reg [`WordDataBus]  out	 ,		   
	output reg				   miss_align	   
)

	
	wire [`ByteOffsetBus]	 offset;		   

	
	assign wr_data = ex_mem_wr_data;		   
	assign addr	   = ex_out[`WordAddrLoc];	   
	assign offset  = ex_out[`ByteOffsetLoc];   

	
	always @(*) begin
		
		miss_align = `DISABLE;
		out		   = `WORD_DATA_W'h0;
		as_		   = `DISABLE_;
		rw		   = `READ;
		
		if (ex_en == `ENABLE) begin
			case (ex_mem_op)
				`MEM_OP_LDW : begin 
					
					if (offset == `BYTE_OFFSET_WORD) begin 
						out			= rd_data;
						as_		   = `ENABLE_;
					end else begin						  
						miss_align	= `ENABLE;
					end
				end
				`MEM_OP_STW : begin 
				
					if (offset == `BYTE_OFFSET_WORD) begin 
						rw			= `WRITE;
						as_		   = `ENABLE_;
					end else begin						   
						miss_align	= `ENABLE;
					end
				end
				default		: begin 
					out			= ex_out;
				end
			endcase
		end
	end

endmodule