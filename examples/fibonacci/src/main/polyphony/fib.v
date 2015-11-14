module fib
  (
    input signed [31:0] fib_IN0,
    input CLK,
    input RST,
    input fib_READY,
    input fib_ACCEPT,
    output reg signed [31:0] fib_OUT0,
    output reg fib_VALID
  );

  //localparams
  localparam fib_grp_top0_INIT = 0;
  localparam fib_grp_top0_S0 = 1;
  localparam fib_grp_top0_S1 = 2;
  localparam fib_grp_top0_S2 = 3;
  localparam fib_grp_top0_S8 = 4;
  localparam fib_grp_top0_FINISH = 5;
  localparam fib_grp_ifthen1_S1 = 6;
  localparam fib_grp_ifthen3_S2 = 7;
  localparam L1_grp_top0_S0 = 8;
  localparam L1_grp_top0_S1 = 9;
  localparam L1_grp_forbody5_S2 = 10;
  localparam L1_grp_bridge6_S0 = 11;
  localparam L1_grp_bridge6_S3 = 12;
  
  //internal regs
  reg /*unsigned*/ [3:0] fib_state;
  reg signed [31:0] i;
  reg signed [31:0] prev_r1;
  reg signed [31:0] r0;
  reg signed [31:0] r1;
  reg signed [31:0] t10;
  
  
  //internal wires
  wire cond11;
  wire cond8;
  wire cond9;
  
  //functions
  
  //sub module instances
  
  //assigns
  assign cond8 = (fib_IN0 <= 0);
  assign cond9 = (fib_IN0 == 1);
  assign cond11 = (i < t10);
  
  always @(posedge CLK) begin
    if (RST) begin
      fib_OUT0 <= 0;
      fib_VALID <= 0;
      fib_state <= fib_grp_top0_INIT;
    end else begin //if (RST)
      case(fib_state)
      fib_grp_top0_INIT: begin
        if (fib_READY == 1) begin
          fib_VALID <= 0;
          fib_state <= fib_grp_top0_S0;
        end
      end
      fib_grp_top0_S0: begin
        if (cond8) begin
          fib_state <= fib_grp_ifthen1_S1;
        end else begin
          fib_state <= fib_grp_top0_S1;
        end
      end
      fib_grp_top0_S1: begin
        if (cond9) begin
          fib_state <= fib_grp_ifthen3_S2;
        end else begin
          fib_state <= fib_grp_top0_S2;
        end
      end
      fib_grp_top0_S2: begin
        r1 <= 1;
        r0 <= 0;
        i <= 0;
        fib_state <= L1_grp_top0_S0;
      end
      fib_grp_top0_S8: begin
        fib_OUT0 <= r1;
        fib_state <= fib_grp_top0_FINISH;
      end
      fib_grp_top0_FINISH: begin
        fib_VALID <= 1;
        if (fib_ACCEPT == 1) begin
          fib_state <= fib_grp_top0_INIT;
        end
      end
      fib_grp_ifthen1_S1: begin
        fib_OUT0 <= 0;
        fib_state <= fib_grp_top0_S1;
      end
      fib_grp_ifthen3_S2: begin
        fib_OUT0 <= 1;
        fib_state <= fib_grp_top0_S2;
      end
      L1_grp_top0_S0: begin
        t10 <= (fib_IN0 - 1);
        fib_state <= L1_grp_top0_S1;
      end
      L1_grp_top0_S1: begin
        if (cond11) begin
          fib_state <= L1_grp_forbody5_S2;
        end else begin
          fib_state <= fib_grp_top0_S8;
        end
      end
      L1_grp_forbody5_S2: begin
        r1 <= (r0 + r1);
        prev_r1 <= r1;
        fib_state <= L1_grp_bridge6_S0;
      end
      L1_grp_bridge6_S0: begin
        i <= (i + 1);
        fib_state <= L1_grp_bridge6_S3;
      end
      L1_grp_bridge6_S3: begin
        r0 <= prev_r1;
        fib_state <= L1_grp_top0_S0;
      end
      endcase
    end
  end
  
endmodule

