module Accumulator
(
  input  clk,
  input  reset,
  input signed [32-1 : 0] reg_in,
  input  reg_we,
  output signed [32-1 : 0] reg_out,
  input signed [32-1 : 0] add_x,
  output signed [32-1 : 0] add_return,
  output  add_busy,
  input  add_req
);

  wire  clk_sig;
  wire  reset_sig;
  wire signed [32-1 : 0] reg_in_sig;
  wire  reg_we_sig;
  wire signed [32-1 : 0] reg_out_sig;
  wire signed [32-1 : 0] add_x_sig;
  reg signed [32-1 : 0] add_return_sig = 0;
  reg  add_busy_sig = 1'b1;
  wire  add_req_sig;

  reg signed [32-1 : 0] class_reg_0000 = 0;
  wire signed [32-1 : 0] class_reg_0000_mux;
  wire signed [32-1 : 0] tmp_0001;
  reg signed [32-1 : 0] add_x_0001 = 0;
  reg signed [32-1 : 0] add_x_local = 0;
  reg signed [32-1 : 0] binary_expr_00002 = 0;
  wire  add_req_flag;
  reg  add_req_local = 1'b0;
  wire  tmp_0002;
  localparam add_method_IDLE = 32'd0;
  localparam add_method_S_0000 = 32'd1;
  localparam add_method_S_0001 = 32'd2;
  localparam add_method_S_0002 = 32'd3;
  localparam add_method_S_0003 = 32'd4;
  localparam add_method_S_0004 = 32'd5;
  localparam add_method_S_0005 = 32'd6;
  reg [31:0] add_method = add_method_IDLE;
  reg signed [32-1 : 0] add_method_delay = 0;
  reg  add_req_flag_d = 1'b0;
  wire  add_req_flag_edge;
  wire  tmp_0003;
  wire  tmp_0004;
  wire  tmp_0005;
  wire  tmp_0006;
  wire  tmp_0007;
  wire  tmp_0008;
  wire  tmp_0009;
  wire  tmp_0010;
  wire signed [32-1 : 0] tmp_0011;
  wire signed [32-1 : 0] tmp_0012;


  assign clk_sig = clk;
  assign reset_sig = reset;
  assign reg_in_sig = reg_in;
  assign reg_we_sig = reg_we;
  assign reg_out = reg_out_sig;
  assign reg_out_sig = class_reg_0000;

  assign add_x_sig = add_x;
  assign add_return = add_return_sig;
  always @(posedge clk) begin
    if(reset == 1'b1) begin
      add_return_sig <= 0;
    end else begin
      if (add_method == add_method_S_0004) begin
        add_return_sig <= class_reg_0000;
      end
    end
  end

  assign add_busy = add_busy_sig;
  always @(posedge clk) begin
    if(reset == 1'b1) begin
      add_busy_sig <= 1'b1;
    end else begin
      if (add_method == add_method_S_0000) begin
        add_busy_sig <= 1'b0;
      end else if (add_method == add_method_S_0001) begin
        add_busy_sig <= tmp_0006;
      end
    end
  end

  assign add_req_sig = add_req;

  assign tmp_0001 = reg_we_sig == 1'b1 ? reg_in_sig : class_reg_0000;
  assign tmp_0002 = add_req_local | add_req_sig;
  assign tmp_0003 = ~add_req_flag_d;
  assign tmp_0004 = add_req_flag & tmp_0003;
  assign tmp_0005 = add_req_flag | add_req_flag_d;
  assign tmp_0006 = add_req_flag | add_req_flag_d;
  assign tmp_0007 = add_method != add_method_S_0000 ? 1'b1 : 1'b0;
  assign tmp_0008 = add_method != add_method_S_0001 ? 1'b1 : 1'b0;
  assign tmp_0009 = tmp_0008 & add_req_flag_edge;
  assign tmp_0010 = tmp_0007 & tmp_0009;
  assign tmp_0011 = add_req_sig == 1'b1 ? add_x_sig : add_x_local;
  assign tmp_0012 = class_reg_0000 + add_x_0001;

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      add_method <= add_method_IDLE;
      add_method_delay <= 32'h0;
    end else begin
      case (add_method)
        add_method_IDLE : begin
          add_method <= add_method_S_0000;
        end
        add_method_S_0000 : begin
          add_method <= add_method_S_0001;
        end
        add_method_S_0001 : begin
          if (tmp_0005 == 1'b1) begin
            add_method <= add_method_S_0002;
          end
        end
        add_method_S_0002 : begin
          add_method <= add_method_S_0003;
        end
        add_method_S_0003 : begin
          add_method <= add_method_S_0004;
        end
        add_method_S_0004 : begin
          add_method <= add_method_S_0000;
        end
        add_method_S_0005 : begin
          add_method <= add_method_S_0000;
        end
      endcase
      add_req_flag_d <= add_req_flag;
      if(tmp_0007 & tmp_0009 == 1'b1) begin
        add_method <= add_method_S_0001;
      end
    end
  end


  always @(posedge clk) begin
    if(reset == 1'b1) begin
      class_reg_0000 <= 0;
    end else begin
      if (add_method == add_method_S_0003) begin
        class_reg_0000 <= binary_expr_00002;
      end else begin
        class_reg_0000 <= class_reg_0000_mux;
      end
    end
  end

  assign class_reg_0000_mux = tmp_0001;

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      add_x_0001 <= 0;
    end else begin
      if (add_method == add_method_S_0001) begin
        add_x_0001 <= tmp_0011;
      end
    end
  end

  always @(posedge clk) begin
    if(reset == 1'b1) begin
      binary_expr_00002 <= 0;
    end else begin
      if (add_method == add_method_S_0002) begin
        binary_expr_00002 <= tmp_0012;
      end
    end
  end

  assign add_req_flag = tmp_0002;

  assign add_req_flag_edge = tmp_0004;



endmodule
