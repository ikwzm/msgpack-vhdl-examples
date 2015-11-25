module fib_test;
   reg         clk = 0;
   reg         fib_rst;
   reg [63:0]  fib_param_data;
   reg         fib_param_en;
   wire        fib_param_ack;
   wire [63:0] fib_result_data;
   wire        fib_result_en;
   reg         fib_result_ack;

   always #10
      clk <= !clk;

   task test;
      input [31:0] n;
      input [63:0] expected_result;
      integer      timeout;
      begin
         @(posedge clk);
	 fib_param_data <= #1 n;
	 fib_param_en   <= #1 1;
         fib_result_ack <= #1 0;
         timeout        = 1000;
         begin: param_loop
            forever begin
               @(posedge clk);
               if (fib_param_ack) begin
                  fib_param_en   <= #1 0;
                  disable param_loop;
               end
               if (timeout == 0) begin
                  $display("fib_param_ack is timeout.");
                  fib_param_en   <= #1 0;
                  disable param_loop;
	       end
               timeout = timeout - 1;
            end 
	 end
         timeout        = 1000;
         begin: result_loop
            forever begin
               @(posedge clk);
               if (fib_result_en) begin
                  if (fib_result_data !== expected_result)
                      $display("fib_result = %d expected but %d found.", expected_result, fib_result_data);
                  else
                      $display("fib_result = %d ok", fib_result_data);
                  fib_result_ack <= #1 1;
                  @(posedge clk);
                  fib_result_ack <= #1 0;
                  disable result_loop;
               end
               if (timeout == 0) begin
                  $display("fib_result_en is timeout.");
                  disable result_loop;
               end
               timeout = timeout - 1;
            end
         end // block: result_loop
      end
   endtask

   initial begin
      fib_rst        <= 1;
      fib_param_en   <= 0;
      fib_param_data <= 0;
      fib_result_ack <= 0;
      repeat(10) @(posedge clk);
      fib_rst        <= 0;
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
       .clk                 (clk             ),
       .rst                 (fib_rst         ),
       .channel_param_data  (fib_param_data  ),
       .channel_param_en    (fib_param_en    ),
       .channel_param_ack   (fib_param_ack   ),
       .channel_result_data (fib_result_data ),
       .channel_result_en   (fib_result_en   ),
       .channel_result_ack  (fib_result_ack  )
    );
endmodule // fib_test
