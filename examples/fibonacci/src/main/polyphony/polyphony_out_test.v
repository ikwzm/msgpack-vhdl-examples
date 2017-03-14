module test
  (
    
    
  );

  //localparams
  localparam CLK_PERIOD = 10;
  localparam CLK_HALF_PERIOD = 5;
  localparam INITIAL_RESET_SPAN = 100;
  
  //signals: 
  reg signed [31:0] result4;
  reg signed [31:0] result9;
  reg signed [31:0] t2041;
  reg signed [31:0] result14;
  reg signed [31:0] result12;
  reg signed [31:0] t2031;
  reg signed [31:0] result2;
  reg signed [31:0] result10;
  reg signed [31:0] result5;
  reg signed [31:0] result13;
  reg signed [31:0] result11;
  reg signed [31:0] t2001;
  reg signed [31:0] t2081;
  reg signed [31:0] result16;
  reg signed [31:0] t2071;
  reg signed [31:0] t20131;
  reg signed [31:0] t20101;
  reg signed [31:0] t2061;
  reg signed [31:0] t20151;
  reg signed [31:0] result7;
  reg signed [31:0] t2091;
  reg signed [31:0] t20121;
  reg signed [31:0] result6;
  reg signed [31:0] result3;
  reg signed [31:0] t20141;
  reg signed [31:0] t20111;
  reg signed [31:0] t2021;
  reg signed [31:0] result1;
  reg signed [31:0] result15;
  reg signed [31:0] t2011;
  reg signed [31:0] result8;
  reg signed [31:0] t2051;
  reg clk;
  reg rst;
  wire condtest119;
  wire condtest120;
  wire condtest121;
  wire condtest122;
  wire condtest123;
  wire condtest124;
  wire condtest125;
  wire condtest126;
  wire condtest127;
  wire condtest128;
  wire condtest129;
  wire condtest130;
  wire condtest131;
  wire condtest132;
  wire condtest133;
  wire condtest134;
  //signals: array56
  wire        [4:0] sub_array56_addr;
  wire        [4:0] array56_addr;
  wire        [31:0] sub_array56_d;
  wire        [31:0] array56_d;
  wire sub_array56_we;
  wire array56_we;
  wire        [31:0] sub_array56_q;
  wire        [31:0] array56_q;
  wire        [4:0] sub_array56_len;
  wire        [4:0] array56_len;
  //signals: expect1
  reg        [4:0] expect1_addr;
  reg        [31:0] expect1_d;
  reg expect1_we;
  wire        [31:0] expect1_q;
  wire        [4:0] expect1_len;
  reg expect1_req;
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
  assign condtest119 = (fib_0_valid == 1);
  assign condtest120 = (fib_0_valid == 1);
  assign condtest121 = (fib_0_valid == 1);
  assign condtest122 = (fib_0_valid == 1);
  assign condtest123 = (fib_0_valid == 1);
  assign condtest124 = (fib_0_valid == 1);
  assign condtest125 = (fib_0_valid == 1);
  assign condtest126 = (fib_0_valid == 1);
  assign condtest127 = (fib_0_valid == 1);
  assign condtest128 = (fib_0_valid == 1);
  assign condtest129 = (fib_0_valid == 1);
  assign condtest130 = (fib_0_valid == 1);
  assign condtest131 = (fib_0_valid == 1);
  assign condtest132 = (fib_0_valid == 1);
  assign condtest133 = (fib_0_valid == 1);
  assign condtest134 = (fib_0_valid == 1);
  //combinations: array56
  assign sub_array56_addr = array56_addr;
  assign sub_array56_d = array56_d;
  assign sub_array56_we = array56_we;
  assign array56_q = sub_array56_q;
  assign array56_len = sub_array56_len;
  assign array56_addr = expect1_addr;
  assign array56_d = expect1_d;
  assign array56_we = expect1_we;
  assign expect1_q = array56_q;
  assign expect1_len = array56_len;
  //combinations: fib_0
  assign sub_fib_0_ready = fib_0_ready;
  assign sub_fib_0_accept = fib_0_accept;
  assign fib_0_valid = sub_fib_0_valid;
  assign sub_fib_0_in_n = fib_0_in_n;
  assign fib_0_out_0 = sub_fib_0_out_0;
  //sub modules
  //array56 instance
  BidirectionalSinglePortRam#(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(5),
    .RAM_LENGTH(16)
    )
    array56(
      .clk(clk),
      .rst(rst),
      .ram_addr(sub_array56_addr),
      .ram_d(sub_array56_d),
      .ram_we(sub_array56_we),
      .ram_q(sub_array56_q),
      .ram_len(sub_array56_len)
    );
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
    expect1_addr <= 0;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 0;
    fib_0_in_n <= 0;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S1 */
    expect1_addr <= 1;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 1;
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S2 */
    expect1_addr <= 2;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 1;
    
    #CLK_PERIOD
    /* test_b1_S3 */
    expect1_addr <= 3;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 2;
    
    #CLK_PERIOD
    /* test_b1_S4 */
    expect1_addr <= 4;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 3;
    @(posedge condtest119);
    fib_0_accept <= 1;
    result1 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S5 */
    expect1_addr <= 5;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 5;
    fib_0_accept <= 0;
    $display("%1d", 0, "=>", result1);
    fib_0_in_n <= 1;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S6 */
    expect1_addr <= 6;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 8;
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S7 */
    expect1_addr <= 7;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 13;
    
    #CLK_PERIOD
    /* test_b1_S8 */
    expect1_addr <= 8;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 21;
    
    #CLK_PERIOD
    /* test_b1_S9 */
    expect1_addr <= 9;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 34;
    @(posedge condtest120);
    fib_0_accept <= 1;
    result2 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S10 */
    expect1_addr <= 10;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 55;
    fib_0_accept <= 0;
    $display("%1d", 1, "=>", result2);
    fib_0_in_n <= 2;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S11 */
    expect1_addr <= 11;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 89;
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S12 */
    expect1_addr <= 12;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 144;
    
    #CLK_PERIOD
    /* test_b1_S13 */
    expect1_addr <= 13;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 233;
    
    #CLK_PERIOD
    /* test_b1_S14 */
    expect1_addr <= 14;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 377;
    @(posedge condtest121);
    fib_0_accept <= 1;
    result3 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S15 */
    expect1_addr <= 15;
    expect1_we <= 1;
    expect1_req <= 1;
    expect1_d <= 610;
    fib_0_accept <= 0;
    $display("%1d", 2, "=>", result3);
    fib_0_in_n <= 3;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S16 */
    fib_0_ready <= 0;
    expect1_addr <= 0;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S17 */
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S18 */
    t2001 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S19 */
    @(posedge condtest122);
    fib_0_accept <= 1;
    result4 <= fib_0_out_0;
    if (!(t2001 === result1)) begin
      $display("ASSERTION FAILED (t2001 === result1)"); $finish;
    end
    expect1_addr <= 1;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S20 */
    fib_0_accept <= 0;
    /*wait for output of expect1*/
    $display("%1d", 3, "=>", result4);
    fib_0_in_n <= 4;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S21 */
    t2011 <= expect1_q;
    expect1_req <= 0;
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S22 */
    if (!(t2011 === result2)) begin
      $display("ASSERTION FAILED (t2011 === result2)"); $finish;
    end
    expect1_addr <= 2;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S23 */
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S24 */
    @(posedge condtest123);
    fib_0_accept <= 1;
    result5 <= fib_0_out_0;
    t2021 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S25 */
    fib_0_accept <= 0;
    if (!(t2021 === result3)) begin
      $display("ASSERTION FAILED (t2021 === result3)"); $finish;
    end
    expect1_addr <= 3;
    expect1_we <= 0;
    expect1_req <= 1;
    $display("%1d", 4, "=>", result5);
    fib_0_in_n <= 5;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S26 */
    /*wait for output of expect1*/
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S27 */
    t2031 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S28 */
    if (!(t2031 === result4)) begin
      $display("ASSERTION FAILED (t2031 === result4)"); $finish;
    end
    expect1_addr <= 4;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S29 */
    @(posedge condtest124);
    fib_0_accept <= 1;
    result6 <= fib_0_out_0;
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S30 */
    fib_0_accept <= 0;
    t2041 <= expect1_q;
    expect1_req <= 0;
    $display("%1d", 5, "=>", result6);
    fib_0_in_n <= 6;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S31 */
    fib_0_ready <= 0;
    if (!(t2041 === result5)) begin
      $display("ASSERTION FAILED (t2041 === result5)"); $finish;
    end
    expect1_addr <= 5;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S32 */
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S33 */
    t2051 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S34 */
    @(posedge condtest125);
    fib_0_accept <= 1;
    result7 <= fib_0_out_0;
    if (!(t2051 === result6)) begin
      $display("ASSERTION FAILED (t2051 === result6)"); $finish;
    end
    expect1_addr <= 6;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S35 */
    fib_0_accept <= 0;
    /*wait for output of expect1*/
    $display("%1d", 6, "=>", result7);
    fib_0_in_n <= 7;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S36 */
    t2061 <= expect1_q;
    expect1_req <= 0;
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S37 */
    if (!(t2061 === result7)) begin
      $display("ASSERTION FAILED (t2061 === result7)"); $finish;
    end
    expect1_addr <= 7;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S38 */
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S39 */
    @(posedge condtest126);
    fib_0_accept <= 1;
    result8 <= fib_0_out_0;
    t2071 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S40 */
    fib_0_accept <= 0;
    if (!(t2071 === result8)) begin
      $display("ASSERTION FAILED (t2071 === result8)"); $finish;
    end
    $display("%1d", 7, "=>", result8);
    fib_0_in_n <= 8;
    fib_0_ready <= 1;
    expect1_addr <= 8;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S41 */
    fib_0_ready <= 0;
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S42 */
    t2081 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S43 */
    expect1_addr <= 9;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S44 */
    @(posedge condtest127);
    fib_0_accept <= 1;
    result9 <= fib_0_out_0;
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S45 */
    fib_0_accept <= 0;
    t2091 <= expect1_q;
    expect1_req <= 0;
    if (!(t2081 === result9)) begin
      $display("ASSERTION FAILED (t2081 === result9)"); $finish;
    end
    $display("%1d", 8, "=>", result9);
    fib_0_in_n <= 9;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S46 */
    fib_0_ready <= 0;
    expect1_addr <= 10;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S47 */
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S48 */
    t20101 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S49 */
    @(posedge condtest128);
    fib_0_accept <= 1;
    result10 <= fib_0_out_0;
    expect1_addr <= 11;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S50 */
    fib_0_accept <= 0;
    /*wait for output of expect1*/
    if (!(t2091 === result10)) begin
      $display("ASSERTION FAILED (t2091 === result10)"); $finish;
    end
    $display("%1d", 9, "=>", result10);
    fib_0_in_n <= 10;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S51 */
    t20111 <= expect1_q;
    expect1_req <= 0;
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S52 */
    expect1_addr <= 12;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S53 */
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S54 */
    @(posedge condtest129);
    fib_0_accept <= 1;
    result11 <= fib_0_out_0;
    t20121 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S55 */
    fib_0_accept <= 0;
    if (!(t20101 === result11)) begin
      $display("ASSERTION FAILED (t20101 === result11)"); $finish;
    end
    $display("%1d", 10, "=>", result11);
    fib_0_in_n <= 11;
    fib_0_ready <= 1;
    expect1_addr <= 13;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S56 */
    fib_0_ready <= 0;
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S57 */
    t20131 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S58 */
    expect1_addr <= 14;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S59 */
    @(posedge condtest130);
    fib_0_accept <= 1;
    result12 <= fib_0_out_0;
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S60 */
    fib_0_accept <= 0;
    t20141 <= expect1_q;
    expect1_req <= 0;
    if (!(t20111 === result12)) begin
      $display("ASSERTION FAILED (t20111 === result12)"); $finish;
    end
    $display("%1d", 11, "=>", result12);
    fib_0_in_n <= 12;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S61 */
    fib_0_ready <= 0;
    expect1_addr <= 15;
    expect1_we <= 0;
    expect1_req <= 1;
    
    #CLK_PERIOD
    /* test_b1_S62 */
    /*wait for output of expect1*/
    
    #CLK_PERIOD
    /* test_b1_S63 */
    t20151 <= expect1_q;
    expect1_req <= 0;
    
    #CLK_PERIOD
    /* test_b1_S64 */
    @(posedge condtest131);
    fib_0_accept <= 1;
    result13 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S65 */
    fib_0_accept <= 0;
    if (!(t20121 === result13)) begin
      $display("ASSERTION FAILED (t20121 === result13)"); $finish;
    end
    $display("%1d", 12, "=>", result13);
    fib_0_in_n <= 13;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S66 */
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S69 */
    @(posedge condtest132);
    fib_0_accept <= 1;
    result14 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S70 */
    fib_0_accept <= 0;
    if (!(t20131 === result14)) begin
      $display("ASSERTION FAILED (t20131 === result14)"); $finish;
    end
    $display("%1d", 13, "=>", result14);
    fib_0_in_n <= 14;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S71 */
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S74 */
    @(posedge condtest133);
    fib_0_accept <= 1;
    result15 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_S75 */
    fib_0_accept <= 0;
    if (!(t20141 === result15)) begin
      $display("ASSERTION FAILED (t20141 === result15)"); $finish;
    end
    $display("%1d", 14, "=>", result15);
    fib_0_in_n <= 15;
    fib_0_ready <= 1;
    
    #CLK_PERIOD
    /* test_b1_S76 */
    fib_0_ready <= 0;
    
    #CLK_PERIOD
    /* test_b1_S79 */
    @(posedge condtest134);
    fib_0_accept <= 1;
    result16 <= fib_0_out_0;
    
    #CLK_PERIOD
    /* test_b1_FINISH */
    fib_0_accept <= 0;
    if (!(t20151 === result16)) begin
      $display("ASSERTION FAILED (t20151 === result16)"); $finish;
    end
    $display("%1d", 15, "=>", result16);
    
    
    $finish;
  end

endmodule

