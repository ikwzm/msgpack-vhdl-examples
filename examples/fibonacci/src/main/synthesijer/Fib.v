module Fib
(
  input  clk,
  input  reset,
  input signed [32-1 : 0] fib_n,
  output signed [64-1 : 0] fib_return,
  output  fib_busy,
  input  fib_req
);

  wire  clk_sig;
  wire  reset_sig;
  wire signed [32-1 : 0] fib_n_sig;
  reg signed [64-1 : 0] fib_return_sig = 0;
  reg  fib_busy_sig = 1'b1;
  wire  fib_req_sig;

  reg signed [32-1 : 0] fib_n_0000 = 0;
  reg signed [32-1 : 0] fib_n_local = 0;
  reg signed [64-1 : 0] fib_cur_0001 = 64'sh0000000000000000;
  reg signed [64-1 : 0] fib_next_0005 = 64'sh0000000000000001;
  reg signed [32-1 : 0] fib_i_0009 = 32'sh00000000;
  reg  binary_expr_00012 = 1'b0;
  reg signed [32-1 : 0] unary_expr_00015 = 0;
  reg signed [64-1 : 0] fib_tmp_0016 = 0;
  reg signed [64-1 : 0] binary_expr_00017 = 0;
  wire  fib_req_flag;
  reg  fib_req_local = 1'b0;
  wire  tmp_0001;
  localparam fib_method_IDLE = 32'd0;
  localparam fib_method_S_0000 = 32'd1;
  localparam fib_method_S_0001 = 32'd2;
  localparam fib_method_S_0002 = 32'd3;
  localparam fib_method_S_0005 = 32'd4;
  localparam fib_method_S_0006 = 32'd5;
  localparam fib_method_S_0007 = 32'd6;
  localparam fib_method_S_0008 = 32'd7;
  localparam fib_method_S_0009 = 32'd8;
  localparam fib_method_S_0010 = 32'd9;
  localparam fib_method_S_0011 = 32'd10;
  localparam fib_method_S_0012 = 32'd11;
  localparam fib_method_S_0014 = 32'd12;
  localparam fib_method_S_0015 = 32'd13;
  localparam fib_method_S_0016 = 32'd14;
  localparam fib_method_S_0017 = 32'd15;
  reg [31:0] fib_method = fib_method_IDLE;
  reg signed [32-1 : 0] fib_method_delay = 0;
  reg  fib_req_flag_d = 1'b0;
  wire  fib_req_flag_edge;
  wire  tmp_0002;
  wire  tmp_0003;
  wire  tmp_0004;
  wire  tmp_0005;
  wire  tmp_0006;
  wire  tmp_0007;
  wire  tmp_0008;
  wire  tmp_0009;
  wire  tmp_0010;
  wire  tmp_0011;
  wire signed [32-1 : 0] tmp_0012;
  wire  tmp_0013;
  wire signed [32-1 : 0] tmp_0014;
  wire signed [64-1 : 0] tmp_0015;


  assign clk_sig = clk;
  assign reset_sig = reset;
  assign fib_n_sig = fib_n;
  assign fib_return = fib_return_sig;
  always @(posedge clk) begin
    if(reset == 1'b1) begin
      fib_return_sig <= 0;
    end else begin
      if (fib_method == fib_method_S_0016) begin
        fib_return_sig <= fib_cur_0001;
      end
    end
  end

  assign fib_busy = fib_busy_sig;
  always @(posedge clk) begin
    if(reset == 1'b1) begin
      fib_busy_sig <= 1'b1;
    end else begin
      if (fib_method == fib_method_S_0000) begin
        fib_busy_sig <= 1'b0;
      end else if (fib_method == fib_method_S_0001) begin
        fib_busy_sig <= tmp_0005;
      end
    end
  end

  assign fib_req_sig = fib_req;

  assign tmp_0001 = fib_req_local | fib_req_sig;
  assign tmp_0002 = ~fib_req_flag_d;
  assign tmp_0003 = fib_req_flag & tmp_0002;
  assign tmp_0004 = fib_req_flag | fib_req_flag_d;
  assign tmp_0005 = fib_req_flag | fib_req_flag_d;
  assign tmp_0006 = binary_expr_00012 == 1'b1 ? 1'b1 : 1'b0;
  assign tmp_0007 = binary_expr_00012 == 1'b0 ? 1'b1 : 1'b0;
  assign tmp_0008 = fib_method != fib_method_S_0000 ? 1'b1 : 1'b0;
  assign tmp_0009 = fib_method != fib_method_S_0001 ? 1'b1 : 1'b0;
  assign tmp_0010 = tmp_0009 & fib_req_flag_edge;
  assign tmp_0011 = tmp_0008 & tmp_0010;
  assign tmp_0012 = fib_req_sig == 1'b1 ? fib_n_sig : fib_n_local;
  assign tmp_0013 = fib_i_0009 < fib_n_0000 ? 1'b1 : 1'b0;
  assign tmp_0014 = fib_i_0009 + 32'sh00000001;
  assign tmp_0015 = fib_next_0005 + fib_tmp_0016;

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      fib_method <= fib_method_IDLE;
      fib_method_delay <= 32'h0;
    end else begin
      case (fib_method)
        fib_method_IDLE : begin
          fib_method <= fib_method_S_0000;
        end
        fib_method_S_0000 : begin
          fib_method <= fib_method_S_0001;
        end
        fib_method_S_0001 : begin
          if (tmp_0004 == 1'b1) begin
            fib_method <= fib_method_S_0002;
          end
        end
        fib_method_S_0002 : begin
          fib_method <= fib_method_S_0005;
        end
        fib_method_S_0005 : begin
          fib_method <= fib_method_S_0006;
        end
        fib_method_S_0006 : begin
          if (tmp_0006 == 1'b1) begin
            fib_method <= fib_method_S_0011;
          end else if (tmp_0007 == 1'b1) begin
            fib_method <= fib_method_S_0007;
          end
        end
        fib_method_S_0007 : begin
          fib_method <= fib_method_S_0016;
        end
        fib_method_S_0008 : begin
          fib_method <= fib_method_S_0009;
        end
        fib_method_S_0009 : begin
          fib_method <= fib_method_S_0010;
        end
        fib_method_S_0010 : begin
          fib_method <= fib_method_S_0005;
        end
        fib_method_S_0011 : begin
          fib_method <= fib_method_S_0012;
        end
        fib_method_S_0012 : begin
          fib_method <= fib_method_S_0014;
        end
        fib_method_S_0014 : begin
          fib_method <= fib_method_S_0015;
        end
        fib_method_S_0015 : begin
          fib_method <= fib_method_S_0008;
        end
        fib_method_S_0016 : begin
          fib_method <= fib_method_S_0000;
        end
        fib_method_S_0017 : begin
          fib_method <= fib_method_S_0000;
        end
      endcase
      fib_req_flag_d <= fib_req_flag;
      if(tmp_0008 & tmp_0010 == 1'b1) begin
        fib_method <= fib_method_S_0001;
      end
    end
  end


  always @(posedge clk) begin
    if(reset == 1'b1) begin
      fib_n_0000 <= 0;
    end else begin
      if (fib_method == fib_method_S_0001) begin
        fib_n_0000 <= tmp_0012;
      end
    end
  end

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      fib_cur_0001 <= 64'sh0000000000000000;
    end else begin
      if (fib_method == fib_method_S_0002) begin
        fib_cur_0001 <= 64'sh0000000000000000;
      end else if (fib_method == fib_method_S_0012) begin
        fib_cur_0001 <= fib_next_0005;
      end
    end
  end

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      fib_next_0005 <= 64'sh0000000000000001;
    end else begin
      if (fib_method == fib_method_S_0002) begin
        fib_next_0005 <= 64'sh0000000000000001;
      end else if (fib_method == fib_method_S_0014) begin
        fib_next_0005 <= binary_expr_00017;
      end
    end
  end

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      fib_i_0009 <= 32'sh00000000;
    end else begin
      if (fib_method == fib_method_S_0002) begin
        fib_i_0009 <= 32'sh00000000;
      end else if (fib_method == fib_method_S_0009) begin
        fib_i_0009 <= unary_expr_00015;
      end
    end
  end

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      binary_expr_00012 <= 1'b0;
    end else begin
      if (fib_method == fib_method_S_0005) begin
        binary_expr_00012 <= tmp_0013;
      end
    end
  end

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      unary_expr_00015 <= 0;
    end else begin
      if (fib_method == fib_method_S_0008) begin
        unary_expr_00015 <= tmp_0014;
      end
    end
  end

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      fib_tmp_0016 <= 0;
    end else begin
      if (fib_method == fib_method_S_0011) begin
        fib_tmp_0016 <= fib_cur_0001;
      end
    end
  end

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      binary_expr_00017 <= 0;
    end else begin
      if (fib_method == fib_method_S_0012) begin
        binary_expr_00017 <= tmp_0015;
      end
    end
  end

  assign fib_req_flag = tmp_0001;

  assign fib_req_flag_edge = tmp_0003;



endmodule
