module fib_wrap(
	input  system_clock,
	input  system_reset,
	input  func_start,
	output func_done,
	output func_ready,

	// global signal
	input [31:0]  args_n,
	output [31:0] func_result
);
fib u_fib(
	// system signals
	.__func_clock(system_clock),
	.__func_reset(system_reset),
	.__func_start(func_start),
	.__func_done(func_done),
	.__func_ready(func_ready),

	// memory bus

	// base address

	// arguments
	.__args_n(args_n),

	// call instruction

	// return value
	.__func_result(func_result)
);
endmodule
