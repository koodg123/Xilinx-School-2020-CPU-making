`include "nettype.h"
`include "global_config.h"
`include "stddef.h"


`include "isa.h"
`include "cpu.h"


module id_stage (
	
	input  wire					 clk,			 
	input  wire					 reset,			 
	
	input  wire [`WordDataBus]	 gpr_rd_data_0,	 
	input  wire [`WordDataBus]	 gpr_rd_data_1,	 
	output wire [`RegAddrBus]	 gpr_rd_addr_0,	 
	output wire [`RegAddrBus]	 gpr_rd_addr_1,	 
	

	input  wire					 ex_en,			
	input  wire [`WordDataBus]	 ex_fwd_data,	 
	input  wire [`RegAddrBus]	 ex_dst_addr,	 
	input  wire					 ex_gpr_we_,	 
	
	input  wire [`WordDataBus]	 mem_fwd_data,	 
	
	input  wire [`CpuExeModeBus] exe_mode,		 
	input  wire [`WordDataBus]	 creg_rd_data,	 
	output wire [`RegAddrBus]	 creg_rd_addr,	 
	
	input  wire					 stall,			
	input  wire					 flush,			
	output wire [`WordAddrBus]	 br_addr,		
	output wire					 br_taken,		
	output wire					 ld_hazard,		
	
	input  wire [`WordAddrBus]	 if_pc,			
	input  wire [`WordDataBus]	 if_insn,		
	input  wire					 if_en,			
	
	output wire [`WordAddrBus]	 id_pc,			
	output wire					 id_en,			
	output wire [`AluOpBus]		 id_alu_op,		
	output wire [`WordDataBus]	 id_alu_in_0,	
	output wire [`WordDataBus]	 id_alu_in_1,	
	output wire					 id_br_flag,	
	output wire [`MemOpBus]		 id_mem_op,		
	output wire [`WordDataBus]	 id_mem_wr_data,
	output wire [`CtrlOpBus]	 id_ctrl_op,	
	output wire [`RegAddrBus]	 id_dst_addr,	
	output wire					 id_gpr_we_,	
	output wire [`IsaExpBus]	 id_exp_code	
)

	
	wire  [`AluOpBus]			 alu_op;		
	wire  [`WordDataBus]		 alu_in_0;		
	wire  [`WordDataBus]		 alu_in_1;		
	wire						 br_flag;		
	wire  [`MemOpBus]			 mem_op;		
	wire  [`WordDataBus]		 mem_wr_data;	
	wire  [`CtrlOpBus]			 ctrl_op;		
	wire  [`RegAddrBus]			 dst_addr;		
	wire						 gpr_we_;		
	wire  [`IsaExpBus]			 exp_code;		

	
	decoder decoder (
		
		.if_pc			(if_pc),		 
		.if_insn		(if_insn),		 
		.if_en			(if_en),		 
		
		.gpr_rd_data_0	(gpr_rd_data_0), 
		.gpr_rd_data_1	(gpr_rd_data_1), 
		.gpr_rd_addr_0	(gpr_rd_addr_0), 
		.gpr_rd_addr_1	(gpr_rd_addr_1), 

	
		.id_en			(id_en),		  
		.id_dst_addr	(id_dst_addr),	  
		.id_gpr_we_		(id_gpr_we_),	  
		.id_mem_op		(id_mem_op),	  
		
		.ex_en			(ex_en),		  
		.ex_fwd_data	(ex_fwd_data),	  
		.ex_dst_addr	(ex_dst_addr),	  
		.ex_gpr_we_		(ex_gpr_we_),	  
		
		.mem_fwd_data	(mem_fwd_data),	  
		
		.exe_mode		(exe_mode),		  
		.creg_rd_data	(creg_rd_data),	  
		.creg_rd_addr	(creg_rd_addr),	  
		
		.alu_op			(alu_op),		  
		.alu_in_0		(alu_in_0),		  
		.alu_in_1		(alu_in_1),		  
		.br_addr		(br_addr),		  
		.br_taken		(br_taken),		  
		.br_flag		(br_flag),		  
		.mem_op			(mem_op),		  
		.mem_wr_data	(mem_wr_data),	  
		.ctrl_op		(ctrl_op),		  
		.dst_addr		(dst_addr),		
		.gpr_we_		(gpr_we_),		  
		.exp_code		(exp_code),		  
		.ld_hazard		(ld_hazard)		  
	);

	
	id_reg id_reg (
		
		.clk			(clk),			 
		.reset			(reset),		 
	
		.alu_op			(alu_op),		 
		.alu_in_0		(alu_in_0),		 
		.alu_in_1		(alu_in_1),		 
		.br_flag		(br_flag),		 
		.mem_op			(mem_op),		 
		.mem_wr_data	(mem_wr_data),	 
		.ctrl_op		(ctrl_op),		 
		.dst_addr		(dst_addr),		 
		.gpr_we_		(gpr_we_),		 
		.exp_code		(exp_code),		 
		
		.stall			(stall),		 
		.flush			(flush),		 
		
		.if_pc			(if_pc),		 
		.if_en			(if_en),		 
		
		.id_pc			(id_pc),		 
		.id_en			(id_en),		 
		.id_alu_op		(id_alu_op),	 
		.id_alu_in_0	(id_alu_in_0),	 
		.id_alu_in_1	(id_alu_in_1),	 
		.id_br_flag		(id_br_flag),	 
		.id_mem_op		(id_mem_op),	 
		.id_mem_wr_data (id_mem_wr_data),
		.id_ctrl_op		(id_ctrl_op),	 
		.id_dst_addr	(id_dst_addr),	 
		.id_gpr_we_		(id_gpr_we_),	 
		.id_exp_code	(id_exp_code)	 
	);

endmodule