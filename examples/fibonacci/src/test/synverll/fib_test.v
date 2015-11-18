module fib_test;
   reg         clk = 0;
   reg         rst = 1;
   reg         fib_start;
   reg  [31:0] fib_n;
   wire        fib_done;
   wire        fib_ready;
   wire [31:0] fib_result;
   
   always #10
      clk <= !clk;

   task test;
      input [31:0] n;
      input [31:0] expected_result;
      integer      timeout;
      begin
         repeat(10) @(posedge clk);
         fib_n     <= #1 n;
         fib_start <= #1 1;
         @(posedge clk);
         fib_start <= #1 0;
	 timeout   = 1000;
	 begin: loop
	    forever begin
               @(posedge clk);
               if (fib_done) begin
                  if (fib_result !== expected_result)
                      $display("fib_return = %d expected but %d found.", expected_result, fib_result);
                  disable loop;
               end
               if (timeout == 0) begin
                  $display("fib_done is timeout.");
                  rst <= #1 0;
                  repeat(10) @(posedge clk);
                  rst <= #1 1;
                  disable loop;
               end
               timeout = timeout - 1;
            end
	 end
      end
   endtask

   initial begin
      rst       <= 0;
      fib_n     <= 0;
      fib_start <= 0;
      repeat(10) @(posedge clk);
      rst <= #1 1;
      test(0, 0);
      test(1, 1);
      test(2, 1);
      test(3, 2);
      test(4, 3);
      test(5, 5);
      test(6, 8);
      $stop;
   end

   fib dut(
       .__func_clock (clk),
       .__func_reset (rst),
       .__func_start (fib_start ),
       .__func_done  (fib_done  ),
       .__func_ready (fib_ready ),
       .__args_n     (fib_n     ),
       .__func_result(fib_result)
    );
endmodule
