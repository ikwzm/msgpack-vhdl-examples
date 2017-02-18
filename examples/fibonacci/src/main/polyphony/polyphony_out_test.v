module test
  (
    
    
  );

  //localparams
  localparam CLK_PERIOD = 10;
  localparam CLK_HALF_PERIOD = 5;
  localparam INITIAL_RESET_SPAN = 100;
  
  //signals: 
  reg signed [31:0] t181;
  reg signed [31:0] t121;
  reg signed [31:0] t141;
  reg signed [31:0] t201;
  reg signed [31:0] t161;
  reg clk;
  reg rst;
  wire condtest51;
  wire condtest52;
  wire condtest53;
  wire condtest54;
  wire condtest55;
  //signals: fib_0
  wire sub_fib_0_ready;
  reg fib_0_ready;
  wire sub_fib_0_accept;
  reg fib_0_accept;
  wire sub_fib_0_valid;
  wire fib_0_valid;
  wire        [31:0] sub_fib_0_in_n;
  reg signed [31:0] fib_0_in_n;
  wire        [31:0] sub_fib_0_out_0;
  wire signed [31:0] fib_0_out_0;
  //combinations: 
  assign condtest51 = (fib_0_valid == 1);
  assign condtest52 = (fib_0_valid == 1);
  assign condtest53 = (fib_0_valid == 1);
  assign condtest54 = (fib_0_valid == 1);
  assign condtest55 = (fib_0_valid == 1);
  //combinations: fib_0
  assign sub_fib_0_ready = fib_0_ready;
  assign sub_fib_0_accept = fib_0_accept;
  assign fib_0_valid = sub_fib_0_valid;
  assign sub_fib_0_in_n = fib_0_in_n;
  assign fib_0_out_0 = sub_fib_0_out_0;
  //sub modules
  //fib_0 instance
  fib fib_0(
    .clk(clk),
    .rst(rst),
    .fib_ready(sub_fib_0_ready),
    .fib_accept(sub_fib_0_accept),
    .fib_valid(sub_fib_0_valid),
    .fib_in_n(sub_fib_0_in_n),
    .fib_out_0(sub_fib_0_out_0)
  );
  
  
  initial begin
    $monitor("%5t:fib_0_in_n=%4d, fib_0_out_0=%4d", $time, fib_0_in_n, fib_0_out_0);
  end
  initial begin
    clk = 0;
    #CLK_HALF_PERIOD
    forever #CLK_HALF_PERIOD clk = ~clk;
  end
  

  initial begin
    rst <= 1;
    
    #INITIAL_RESET_SPAN
    rst <= 0;
    
    #CLK_PERIOD
    /* test_b1_INIT */
    fib_0_in_n <= 0;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S1 */
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S4 */
    @(posedge condtest51);
    fib_0_accept <= 1;
    t121 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S5 */
    fib_0_accept <= 0;
    if (!(0 === t121)) begin
      $display("ASSERTION FAILED (0 === t121)"); $finish;
    end
    fib_0_in_n <= 1;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S6 */
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S9 */
    @(posedge condtest52);
    fib_0_accept <= 1;
    t141 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S10 */
    fib_0_accept <= 0;
    if (!(1 === t141)) begin
      $display("ASSERTION FAILED (1 === t141)"); $finish;
    end
    fib_0_in_n <= 2;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S11 */
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S14 */
    @(posedge condtest53);
    fib_0_accept <= 1;
    t161 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S15 */
    fib_0_accept <= 0;
    if (!(1 === t161)) begin
      $display("ASSERTION FAILED (1 === t161)"); $finish;
    end
    fib_0_in_n <= 3;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S16 */
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S19 */
    @(posedge condtest54);
    fib_0_accept <= 1;
    t181 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S20 */
    fib_0_accept <= 0;
    if (!(2 === t181)) begin
      $display("ASSERTION FAILED (2 === t181)"); $finish;
    end
    fib_0_in_n <= 8;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S21 */
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S24 */
    @(posedge condtest55);
    fib_0_accept <= 1;
    t201 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_FINISH */
    fib_0_accept <= 0;
    if (!(21 === t201)) begin
      $display("ASSERTION FAILED (21 === t201)"); $finish;
    end
    
    
    $finish;
  end

endmodule

