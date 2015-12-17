`default_nettype none

module fib
  (
  input wire i_w_clk,  
  input wire i_w_res_p,  
  input wire i_w_req_p,  
  input wire i_w_ce_p,  
  output reg o_r_fin_p,  
  input wire signed [31:0] i_w_n,  
  output reg signed [31:0] o_r_o  
  );
  reg signed [31:0] r_add0_a;
  reg signed [31:0] r_add0_b;
  reg signed [31:0] r_mul0_a;
  reg signed [31:0] r_mul0_b;
  reg signed [31:0] r_div0_dividend;
  reg signed [31:0] r_div0_divisor;
  reg signed [31:0] r_divrem0_dividend;
  reg signed [31:0] r_divrem0_divisor;
  reg signed [31:0] r_n;
  reg [2:0] r_sys_current_state;
  reg [2:0] r_sys_prev_state;
  reg signed [31:0] r_tmp;
  reg signed r_tmp1;
  reg signed [31:0] r_tmp2;
  reg signed [31:0] r_tmp3;
  reg signed [31:0] r_tmp6;
  reg signed [31:0] r_tmp4;
  reg signed [31:0] r_tmp7;
  reg signed [31:0] r_tmp5;
  reg signed r_tmp8;
  reg signed [31:0] r__lcssa;
  reg [2:0] r_sys_step;

  wire signed [31:0] w_add0_s;
  wire signed [31:0] w_mul0_p;
  wire signed [31:0] w_div0_quotient;
  wire signed [31:0] w_div0_fractional;
  wire signed w_div0_rfd;
  wire signed [31:0] w_divrem0_quotient;
  wire signed [31:0] w_divrem0_fractional;
  wire signed w_divrem0_rfd;

  parameter signed pb_TRUE = 1'h1;
  parameter signed pb_FALSE = 1'h0;
  parameter signed pb_ZERO = 1'h0;
  parameter [2:0] l_entry = 3'h1;
  parameter [2:0] l_4_lr_ph = 3'h2;
  parameter [2:0] l_4 = 3'h3;
  parameter [2:0] l_5 = 3'h4;
  parameter [2:0] l_finish_state = 3'h5;
  parameter signed [31:0] p_0 = 32'h0;
  parameter signed [31:0] p_1 = 32'h1;

  wire [31:0] w_phi_r_tmp3;
  assign w_phi_r_tmp3 = phi_r_tmp3(r_sys_prev_state, p_1, r_tmp6);

  wire [31:0] w_phi_r_tmp4;
  assign w_phi_r_tmp4 = phi_r_tmp4(r_sys_prev_state, p_0, r_tmp7);

  wire [31:0] w_phi_r_tmp5;
  assign w_phi_r_tmp5 = phi_r_tmp5(r_sys_prev_state, p_0, r_tmp3);

  wire [31:0] w_phi_r__lcssa;
  assign w_phi_r__lcssa = phi_r__lcssa(r_sys_prev_state, p_0, r_tmp3);

  function [31:0] phi_r_tmp3;
    input [2:0] r_sys_prev_state;
    input [31:0] p_1;
    input [31:0] r_tmp6;
    case (r_sys_prev_state)
      l_4_lr_ph: phi_r_tmp3 = p_1;
      l_4: phi_r_tmp3 = r_tmp6;
      default: phi_r_tmp3 = pb_ZERO;
    endcase
  endfunction

  function [31:0] phi_r_tmp4;
    input [2:0] r_sys_prev_state;
    input [31:0] p_0;
    input [31:0] r_tmp7;
    case (r_sys_prev_state)
      l_4_lr_ph: phi_r_tmp4 = p_0;
      l_4: phi_r_tmp4 = r_tmp7;
      default: phi_r_tmp4 = pb_ZERO;
    endcase
  endfunction

  function [31:0] phi_r_tmp5;
    input [2:0] r_sys_prev_state;
    input [31:0] p_0;
    input [31:0] r_tmp3;
    case (r_sys_prev_state)
      l_4_lr_ph: phi_r_tmp5 = p_0;
      l_4: phi_r_tmp5 = r_tmp3;
      default: phi_r_tmp5 = pb_ZERO;
    endcase
  endfunction

  function [31:0] phi_r__lcssa;
    input [2:0] r_sys_prev_state;
    input [31:0] p_0;
    input [31:0] r_tmp3;
    case (r_sys_prev_state)
      l_entry: phi_r__lcssa = p_0;
      l_4: phi_r__lcssa = r_tmp3;
      default: phi_r__lcssa = pb_ZERO;
    endcase
  endfunction

  Add add0(
    .a(r_add0_a),
    .b(r_add0_b),
    .clk(i_w_clk),
    .ce(i_w_ce_p),
    .s(w_add0_s)
  );

  multiplier mul0(
    .a(r_mul0_a),
    .b(r_mul0_b),
    .clk(i_w_clk),
    .ce(i_w_ce_p),
    .p(w_mul0_p)
  );

  Divider div0(
    .dividend(r_div0_dividend),
    .divisor(r_div0_divisor),
    .clk(i_w_clk),
    .quotient(w_div0_quotient),
    .fractional(w_div0_fractional),
    .rfd(w_div0_rfd)
  );

  Divider divrem0(
    .dividend(r_divrem0_dividend),
    .divisor(r_divrem0_divisor),
    .clk(i_w_clk),
    .quotient(w_divrem0_quotient),
    .fractional(w_divrem0_fractional),
    .rfd(w_divrem0_rfd)
  );

  always @(posedge i_w_clk)
    begin
      if (i_w_res_p ==  pb_TRUE)
        begin
          o_r_fin_p <= pb_FALSE;
          r_sys_current_state <= pb_ZERO;
          r_sys_step <= pb_ZERO;
        end
      else if (i_w_ce_p == pb_TRUE)
        begin
          case (r_sys_current_state)
            3'h0:
              begin
                o_r_fin_p <= pb_FALSE;
                r_sys_step <= pb_ZERO;
                o_r_o <= pb_ZERO;
                if (i_w_req_p)
                  begin
                    r_sys_current_state <= 3'h1;
                    r_sys_prev_state <= pb_ZERO;
                    r_n <= i_w_n;
                  end
              end
            3'h1: //l_entry
              begin
                r_sys_step <= r_sys_step + 1'h1;
                case (r_sys_step)
                  3'h0:
                    begin
                      r_tmp <= r_n;
                    end
                  3'h1:
                    begin
                      r_tmp1 = (r_tmp  >  p_0);
                      r_sys_current_state <= (r_tmp1 ) ? l_4_lr_ph : l_5;
                      r_sys_prev_state <= r_sys_current_state;
                      r_sys_step <= 0;
                    end
                endcase
              end
            3'h2: //l_4_lr_ph
              begin
                r_sys_step <= r_sys_step + 1'h1;
                case (r_sys_step)
                  3'h0:
                    begin
                      r_tmp2 <= r_n;
                      r_sys_current_state <= l_4;
                      r_sys_prev_state <= r_sys_current_state;
                      r_sys_step <= 0;
                    end
                endcase
              end
            3'h3: //l_4
              begin
                r_sys_step <= r_sys_step + 1'h1;
                case (r_sys_step)
                  3'h0:
                    begin
                      r_tmp3 <= w_phi_r_tmp3;
                      r_tmp4 <= w_phi_r_tmp4;
                      r_tmp5 <= w_phi_r_tmp5;
                    end
                  3'h1:
                    begin
                      r_add0_a <= r_tmp4;
                      r_add0_b <= p_1;
                    end
                  3'h2:
                    begin
                      r_add0_a <= r_tmp3;
                      r_add0_b <= r_tmp5;
                    end
                  3'h3:
                    begin
                      r_tmp7 <= w_add0_s;
                    end
                  3'h4:
                    begin
                      r_tmp6 <= w_add0_s;
                      r_tmp8  = (r_tmp2  >  r_tmp7);
                      r_sys_current_state <= (r_tmp8 ) ? l_4 : l_5;
                      r_sys_prev_state <= r_sys_current_state;
                      r_sys_step <= 0;
                    end
                endcase
              end
            3'h4: //l_5
              begin
                r_sys_step <= r_sys_step + 1'h1;
                case (r_sys_step)
                  3'h0:
                    begin
                      r__lcssa <= w_phi_r__lcssa;
                    end
                  3'h1:
                    begin
                      o_r_o <= r__lcssa;
                    end
                  3'h2:
                    begin
                      r_sys_current_state <= l_finish_state;
                      r_sys_step <= 0;
                    end
                endcase
              end
            3'h5: //l_finish_state
              begin
                r_sys_step <= r_sys_step + 1'h1;
                case (r_sys_step)
                  3'h0:
                    begin
                      o_r_fin_p <= pb_TRUE;
                      r_sys_current_state <= 0;
                    end
                endcase
              end
          endcase
        end
    end
endmodule

`default_nettype wire
