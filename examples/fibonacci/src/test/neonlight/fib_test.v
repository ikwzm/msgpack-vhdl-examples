module fib_test;
   reg         clk = 0;
   reg         fib_rst;
   reg  [31:0] fib_data_i;
   wire [31:0] fib_addr;
   wire        fib_wen;
   wire [31:0] fib_data_o;

   always #10
      clk <= !clk;

   task test;
      input [31:0] n;
      input [31:0] expected_result;
      integer      timeout;
      begin
	 fib_rst    <= #1 1;
         @(posedge clk);
         fib_data_i <= #1 n;
         fib_rst    <= #1 0;
         timeout    = 1000;
         begin: loop
            forever begin
               @(posedge clk);
               if (fib_wen) begin
                  if (fib_data_o !== expected_result)
                      $display("fib_return = %d expected but %d found.", expected_result, fib_data_o);
		  else
                      $display("fib_return = %d ok", fib_data_o);
                  disable loop;
               end
               if (timeout == 0) begin
                  $display("fib_wen is timeout.");
                  disable loop;
               end
               timeout = timeout - 1;
            end
         end
      end
   endtask

   initial begin
      fib_rst    <= 1;
      fib_data_i <= 0;
      repeat(10) @(posedge clk);
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
       .clk       (clk       ),
       .rst       (fib_rst   ),
       .addr_o    (fib_addr  ),
       .write_en_o(fib_wen   ),
       .data_o    (fib_data_o),
       .data_i    (fib_data_i)
    );
endmodule // fib_test
