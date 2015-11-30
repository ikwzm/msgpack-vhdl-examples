// 0.1.9

module fib_main(clk, rst, channel_result_data, channel_result_en, channel_result_ack, channel_param_data, channel_param_en, channel_param_ack);
  input clk;
  input rst;
  // Channel result
  output [63:0] channel_result_data;
  output channel_result_en;
  input channel_result_ack;
  // Channel param
  input [31:0] channel_param_data;
  input channel_param_en;
  output channel_param_ack;

  reg [63:0] channel_result_data;
  reg channel_result_en;
  reg channel_param_ack;

  reg [31:0]  r4_main;
  reg [63:0]  reg_t1;
  reg  reg_t4;
  reg [63:0]  reg_t6;
  reg [63:0]  reg_t1_v1;
  reg [63:0]  reg_t2_v2;
  reg [31:0]  reg_t3_v3;
  reg [63:0]  reg_t2_v6;
  reg [63:0]  reg_t2_v7;
  reg [31:0]  reg_t3_v9;
  reg [31:0]  r4_main_v13;
  reg  reg_t8;
  reg  reg_t9;
  wire [63:0]  wire_t10;
  wire [63:0]  wire_t11;
  wire [31:0]  wire_t12;
  wire  wire_t13;
  wire [31:0]  wire_t14;
  wire [63:0]  wire_t15;

  // declare state begin
 `define S_3 3
 `define S_8 8
 `define S_12 12
 `define S_40 40
 `define S_43 43

  reg [6:0] cur_st;
  // declare state end

  // resources begin
  // branch_1

  // read_channel_3

  // write_channel_5


  // gt_7
  wire gt_7_d0;
  wire [31:0] gt_7_s0;
  wire [31:0] gt_7_s1;
  assign gt_7_s0 = (cur_st == `S_40) ? r4_main_v13 : (0);
  assign gt_7_s1 = (cur_st == `S_40) ? wire_t12 : (0);
  assign gt_7_d0 = (gt_7_s0 > gt_7_s1);

  // add_8
  wire [63:0] add_8_d0;
  wire [63:0] add_8_s0;
  wire [63:0] add_8_s1;
  assign add_8_s0 = (cur_st == `S_43) ? reg_t2_v2 : (0);
  assign add_8_s1 = (cur_st == `S_43) ? reg_t1_v1 : (0);
  assign add_8_d0 = (add_8_s0 + add_8_s1);

  // add_9
  wire [31:0] add_9_d0;
  wire [31:0] add_9_s0;
  wire [31:0] add_9_s1;
  assign add_9_s0 = (cur_st == `S_43) ? reg_t3_v3 : (0);
  assign add_9_s1 = (cur_st == `S_43) ? 2'd1 : (0);
  assign add_9_d0 = (add_9_s0 + add_9_s1);

  // selector_12

  // resources end

  // insn wires begin
  wire [31:0] o_insn_2_0; // id:2
  assign o_insn_2_0 = channel_param_data;
  wire [63:0] o_insn_86_0; // id:86
  assign o_insn_86_0 = reg_t4 ? reg_t1 : reg_t6;
  wire [63:0] o_insn_89_0; // id:89
  assign o_insn_89_0 = reg_t8 ? reg_t2_v7 : reg_t2_v6;
  wire [31:0] o_insn_92_0; // id:92
  assign o_insn_92_0 = reg_t9 ? reg_t3_v9 : r4_main;
  wire o_insn_56_0; // id:56
  assign o_insn_56_0 = gt_7_d0;
  wire [31:0] o_insn_67_0; // id:67
  assign o_insn_67_0 = add_9_d0;
  wire [63:0] o_insn_63_0; // id:63
  assign o_insn_63_0 = add_8_d0;
  // insn wires end

  // insn result wires begin
   assign wire_t10 = o_insn_86_0;
   assign wire_t11 = o_insn_89_0;
   assign wire_t12 = o_insn_92_0;
   assign wire_t13 = o_insn_56_0;
   assign wire_t14 = o_insn_67_0;
   assign wire_t15 = o_insn_63_0;
  // insn result wires end

  // sub state regs begin
  reg [1:0] st_2;
  reg [1:0] st_4;
  // sub state regs end
  always @(posedge clk) begin
    if (rst) begin
      cur_st <= `S_3;
      st_2 <= 0;
      st_4 <= 0;
      channel_result_data <= 0;
      channel_result_en <= 0;
      channel_param_ack <= 0;
    end else begin
`ifdef NLI_DEBUG
      $display("NLI:st fib_main_main=%d", cur_st);
      $display("NLI: r4_main =%d reg_t1 =%d reg_t4 =%d reg_t6 =%d reg_t1_v1 =%d reg_t2_v2 =%d reg_t3_v3 =%d reg_t2_v6 =%d reg_t2_v7 =%d reg_t3_v9 =%d r4_main_v13 =%d reg_t8 =%d reg_t9 =%d" ,r4_main ,reg_t1 ,reg_t4 ,reg_t6 ,reg_t1_v1 ,reg_t2_v2 ,reg_t3_v3 ,reg_t2_v6 ,reg_t2_v7 ,reg_t3_v9 ,r4_main_v13 ,reg_t8 ,reg_t9);
`endif
      // state output
      // FSM.
      case (cur_st)
        `S_3: begin
          reg_t1 <= 32'd0;
          reg_t2_v6 <= 2'd1;
          r4_main <= 32'd0;
          reg_t4 <= 2'd1;
          reg_t8 <= 2'd0;
          reg_t9 <= 2'd0;
          cur_st <= `S_8;
        end
        `S_8: begin
          // channel read
          if (st_2 == 0) begin
            if (channel_param_en) begin
              st_2 <= 3;
              channel_param_ack <= 1;
          r4_main_v13 <= o_insn_2_0;
            end
          end else if (st_2 == 3) begin
            channel_param_ack <= 0;
          end
          if (( st_2 == 3)) begin
            st_2 <= 0;
          cur_st <= `S_40;
          end else begin
            cur_st <= cur_st;
          end
        end
        `S_12: begin
          // channel write
          if (st_4 == 0) begin
            channel_result_en <= 1;
            channel_result_data <= reg_t1_v1;
            if (channel_result_ack) begin
              st_4 <= 3;
              channel_result_en <= 0;
            end
          end
          if (( st_4 == 3)) begin
            st_4 <= 0;
          cur_st <= `S_3;
          end else begin
            cur_st <= cur_st;
          end
        end
        `S_40: begin
          reg_t1_v1 <= wire_t10;
          reg_t2_v2 <= wire_t11;
          reg_t3_v3 <= wire_t12;
          reg_t4 <= wire_t13;
          if (wire_t13) begin
            cur_st <= `S_43;
          end else
          cur_st <= `S_12;
        end
        `S_43: begin
          reg_t6 <= reg_t2_v2;
          reg_t4 <= 2'd0;
          reg_t9 <= 2'd1;
          reg_t8 <= 2'd1;
          reg_t2_v7 <= wire_t15;
          reg_t3_v9 <= wire_t14;
          reg_t2_v6 <= wire_t15;
          cur_st <= `S_40;
        end
      endcase
    end
  end

  // imported modules begin
  // imported modules end

  // sub modules begin
  // sub modules end

endmodule

module fib(clk, rst, channel_result_data, channel_result_en, channel_result_ack, channel_param_data, channel_param_en, channel_param_ack);
  input clk;
  input rst;
  // Channel result
  output [63:0] channel_result_data;
  output channel_result_en;
  input channel_result_ack;
  // Channel param
  input [31:0] channel_param_data;
  input channel_param_en;
  output channel_param_ack;
  fib_main fib_main_inst(.clk(clk), .rst(rst), .channel_result_data(channel_result_data), .channel_result_en(channel_result_en), .channel_result_ack(channel_result_ack), .channel_param_data(channel_param_data), .channel_param_en(channel_param_en), .channel_param_ack(channel_param_ack));
endmodule
