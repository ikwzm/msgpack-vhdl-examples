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

	// global signal
	input [31:0] __args_n,
	output [31:0] __func_result
);
// wire
wire fib__func_start;
wire fib__func_done;
wire fib__func_ready;
wire [31:0] fib__args_n;
wire [31:0] fib__func_result;
// connection

// system signal
assign fib__func_start = __func_start;
assign __func_done = fib__func_done;
assign __func_ready = fib__func_ready;
assign fib__args_n = __args_n;
assign __func_result = fib__func_result;
// modules
fib u_fib(
	// system signals
	.__func_clock(system_clock),
	.__func_reset(system_reset),
	.__func_start(fib__func_start),
	.__func_done(fib__func_done),
	.__func_ready(fib__func_ready),

	// memory bus

	// base address

	// arguments
	.__args_n(fib__args_n),

	// call instruction

	// return value
	.__func_result(fib__func_result)
);
endmodule
