/*
 * Copyright (C)2005-2015 AQUAXIS TECHNOLOGY.
 *  Don't remove this header.
 * When you use this source, there is a need to inherit this header.
 *
 * This software is released under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 *
 * For further information please contact.
 *  URI:    http://www.aquaxis.com/
 *  E-Mail: info(at)aquaxis.com
 */
module fib_top(
	input system_clock,
	input system_reset,
	input __func_start,
	output __func_done,
	output __func_ready,

	output __gm_req,
	output __gm_rnw,
	input __gm_done,
	output [31:0] __gm_adrs,
	output [1:0] __gm_leng,
	input [31:0] __gm_di,
	output [31:0] __gm_do,

	// global signal
	input [31:0] __args_n,

	output dummy
);
// wire
wire fib__func_start;
wire fib__func_done;
wire fib__func_ready;
wire fib__gm_req;
wire fib__gm_rnw;
wire fib__gm_done;
wire [31:0] fib__gm_adrs;
wire [1:0] fib__gm_leng;
wire [31:0] fib__gm_di;
wire [31:0] fib__gm_do;
wire [31:0] fib__args_n;
// connection
assign fib__gm_done = __gm_done;
assign fib__gm_di = __gm_di;

// Global Memory
assign __gm_req =  fib__gm_req ;
assign __gm_adrs =  fib__gm_adrs ;
assign __gm_rnw =  fib__gm_rnw ;
assign __gm_do =  fib__gm_do ;
assign __gm_leng =  fib__gm_leng ;

// system signal
assign fib__func_start = __func_start;
assign __func_done = fib__func_done;
assign __func_ready = fib__func_ready;
assign fib__args_n = __args_n;
// modules
fib u_fib(
	// system signals
	.__func_clock(system_clock),
	.__func_reset(system_reset),
	.__func_start(fib__func_start),
	.__func_done(fib__func_done),
	.__func_ready(fib__func_ready),

	// memory bus
	.__gm_req(fib__gm_req),
	.__gm_rnw(fib__gm_rnw),
	.__gm_done(fib__gm_done),
	.__gm_adrs(fib__gm_adrs),
	.__gm_leng(fib__gm_leng),
	.__gm_di(fib__gm_di),
	.__gm_do(fib__gm_do),

	// base address

	// arguments
	.__args_n(fib__args_n),

	// call instruction

	.__dummy()
);
endmodule
