`include "nettype.h"
`include "global_config.h"
`include "stddef.h"


`include "isa.h"
`include "cpu.h"


module mem_stage (
	
	input  wire				   clk,			   
	input  wire				   reset,		   

	input  wire				   stall,		   
	input  wire				   flush,		   
	output wire				   busy,		   
	
	output wire [`WordDataBus] fwd_data,	   
	
	input  wire [`WordDataBus] spm_rd_data,	   
	output wire [`WordAddrBus] spm_addr,	   
	output wire				   spm_as_,		   
	output wire				   spm_rw,		   
	output wire [`WordDataBus] spm_wr_data,	   
	
	input  wire [`WordDataBus] bus_rd_data,	   
	input  wire				   bus_rdy_,	   
	input  wire				   bus_grnt_,	   
	output wire				   bus_req_,	   
	output wire [`WordAddrBus] bus_addr,	   
	output wire				   bus_as_,		   
	output wire				   bus_rw,		   
	output wire [`WordDataBus] bus_wr_data,	   
	
	input  wire [`WordAddrBus] ex_pc,		   
	input  wire				   ex_en,		   
	input  wire				   ex_br_flag,	   
	input  wire [`MemOpBus]	   ex_mem_op,	   
	input  wire [`WordDataBus] ex_mem_wr_data, 
	input  wire [`CtrlOpBus]   ex_ctrl_op,	   
	input  wire [`RegAddrBus]  ex_dst_addr,	   
	input  wire				   ex_gpr_we_,	   
	input  wire [`IsaExpBus]   ex_exp_code,	   
	input  wire [`WordDataBus] ex_out,		   
	
	output wire [`WordAddrBus] mem_pc,		   
	output wire				   mem_en,		   
	output wire				   mem_br_flag,	   
	output wire [`CtrlOpBus]   mem_ctrl_op,	   
	output wire [`RegAddrBus]  mem_dst_addr,   
	output wire				   mem_gpr_we_,	   
	output wire [`IsaExpBus]   mem_exp_code,   
	output wire [`WordDataBus] mem_out		   
)


	wire [`WordDataBus]		   rd_data;		   
	wire [`WordAddrBus]		   addr;		   
	wire					   as_;			   
	wire					   rw;			   
	wire [`WordDataBus]		   wr_data;		   
	wire [`WordDataBus]		   out;			   
	wire					   miss_align;	   

	
	assign fwd_data	 = out

	
	mem_ctrl mem_ctrl 
		
		.ex_en			(ex_en),			   
		.ex_mem_op		(ex_mem_op),		   
		.ex_mem_wr_data (ex_mem_wr_data),	   
		.ex_out			(ex_out),			   
	
		.rd_data		(rd_data),			   
		.addr			(addr),				   
		.as_			(as_),				   
		.rw				(rw),				   
		.wr_data		(wr_data),			   
		
		.out			(out),				   
		.miss_align		(miss_align)		   
	)

	
	bus_if bus_if 
		
		.clk		 (clk),					   
		.reset		 (reset),				   
		
		.stall		 (stall),				   
		.flush		 (flush),				   
		.busy		 (busy),				   
		
		.addr		 (addr),				   
		.as_		 (as_),					   
		.rw			 (rw),					   
		.wr_data	 (wr_data),				   
		.rd_data	 (rd_data),				   
		
		.spm_rd_data (spm_rd_data),			   
		.spm_addr	 (spm_addr),			   
		.spm_as_	 (spm_as_),				   
		.spm_rw		 (spm_rw),				   
		.spm_wr_data (spm_wr_data),			   
		
		.bus_rd_data (bus_rd_data),			   
		.bus_rdy_	 (bus_rdy_),			   
		.bus_grnt_	 (bus_grnt_),			   
		.bus_req_	 (bus_req_),			   
		.bus_addr	 (bus_addr),			   
		.bus_as_	 (bus_as_),				   
		.bus_rw		 (bus_rw),				   
		.bus_wr_data (bus_wr_data)			   
	)


	mem_reg mem_reg 
		
		.clk		  (clk),				   
		.reset		  (reset),				   
		
		.out		  (out),				   
		.miss_align	  (miss_align),			   
		
		.stall		  (stall),				   
		.flush		  (flush),				   
		
		.ex_pc		  (ex_pc),				   
		.ex_en		  (ex_en),				   
		.ex_br_flag	  (ex_br_flag),			   
		.ex_ctrl_op	  (ex_ctrl_op),			   
		.ex_dst_addr  (ex_dst_addr),		   
		.ex_gpr_we_	  (ex_gpr_we_),			   
		.ex_exp_code  (ex_exp_code),		   
		
		.mem_pc		  (mem_pc),				   
		.mem_en		  (mem_en),				   
		.mem_br_flag  (mem_br_flag),		   
		.mem_ctrl_op  (mem_ctrl_op),		   
		.mem_dst_addr (mem_dst_addr),		   
		.mem_gpr_we_  (mem_gpr_we_),		   
		.mem_exp_code (mem_exp_code),		   
		.mem_out	  (mem_out)				   
	)

endmodule