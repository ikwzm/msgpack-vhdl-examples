// 0.1.9

module mod_main(clk, rst, addr_o, write_en_o, data_o, data_i);
  input clk;
  input rst;
  // EXTERNAL_RAM
  output [31:0] addr_o;
  output write_en_o;
  output [31:0] data_o;
  input [31:0] data_i;

  reg [31:0] addr_o;
  reg write_en_o;
  reg [31:0] data_o;

  reg [31:0]  r1_main;
  reg [31:0]  r3_main;
  reg  reg_t2;
  reg  reg_t9;
  reg [31:0]  reg_t5_v3;
  reg [31:0]  reg_t7_v5;
  reg [31:0]  reg_t5_v6;
  reg [31:0]  reg_t6_v8;
  reg [31:0]  reg_t6_v9;
  reg [31:0]  reg_t7_v10;
  reg [31:0]  reg_t7_v11;
  reg [31:0]  r4_main_v17;
  reg  reg_t14;
  wire  wire_t16;
  wire  wire_t17;
  wire [31:0]  wire_t18;
  wire [31:0]  wire_t19;
  wire [31:0]  wire_t20;
  wire [31:0]  wire_t21;
  wire  wire_t22;
  wire [31:0]  wire_t23;
  wire [31:0]  wire_t24;

  // declare state begin
 `define S_3 3
 `define S_93 93
 `define S_6 6
 `define S_15 15
 `define S_65 65
 `define S_69 69
 `define S_72 72
 `define S_77 77
 `define S_82 82
 `define S_88 88
 `define S_89 89
 `define S_91 91

  reg [7:0] cur_st;
  // declare state end

  // resources begin
  // branch_1


  // gt_6
  wire gt_6_d0;
  wire [31:0] gt_6_s0;
  wire [31:0] gt_6_s1;
  assign gt_6_s0 = (cur_st == `S_6) ? 32'd1 : ((cur_st == `S_77) ? r4_main_v17 : (0));
  assign gt_6_s1 = (cur_st == `S_6) ? r4_main_v17 : ((cur_st == `S_77) ? wire_t21 : (0));
  assign gt_6_d0 = (gt_6_s0 > gt_6_s1);

  // eq_7

  // add_8
  wire [31:0] add_8_d0;
  wire [31:0] add_8_s0;
  wire [31:0] add_8_s1;
  assign add_8_s0 = (cur_st == `S_82) ? reg_t5_v3 : (0);
  assign add_8_s1 = (cur_st == `S_82) ? r1_main : (0);
  assign add_8_d0 = (add_8_s0 + add_8_s1);

  // selector_11

  // sram_if_12

  // add_14
  wire [31:0] add_14_d0;
  wire [31:0] add_14_s0;
  wire [31:0] add_14_s1;
  assign add_14_s0 = (cur_st == `S_82) ? reg_t7_v5 : (0);
  assign add_14_s1 = (cur_st == `S_82) ? 32'd1 : (0);
  assign add_14_d0 = (add_14_s0 + add_14_s1);

  // resources end

  // insn wires begin
  assign o_insn_158_0 = data_i;
  wire [31:0] o_insn_159_0; // id:159
  assign o_insn_159_0 = data_i;
  wire o_insn_82_0; // id:82
  assign o_insn_82_0 = gt_6_d0;
  wire o_insn_93_0; // id:93
  assign o_insn_93_0 = r4_main_v17==32'd1;
  wire [31:0] o_insn_151_0; // id:151
  assign o_insn_151_0 = reg_t2 ? r3_main : reg_t5_v6;
  wire [31:0] o_insn_154_0; // id:154
  assign o_insn_154_0 = reg_t14 ? reg_t6_v9 : reg_t6_v8;
  wire [31:0] o_insn_157_0; // id:157
  assign o_insn_157_0 = reg_t9 ? reg_t7_v11 : reg_t7_v10;
  wire o_insn_113_0; // id:113
  assign o_insn_113_0 = gt_6_d0;
  wire [31:0] o_insn_118_0; // id:118
  assign o_insn_118_0 = add_8_d0;
  wire [31:0] o_insn_124_0; // id:124
  assign o_insn_124_0 = add_14_d0;
  wire [31:0] o_insn_148_0; // id:148
  assign o_insn_148_0 = reg_t9 ? r3_main : r1_main;
  assign o_insn_161_0 = data_i;
  // insn wires end

  // insn result wires begin
   assign wire_t16 = o_insn_82_0;
   assign wire_t17 = o_insn_93_0;
   assign wire_t19 = o_insn_151_0;
   assign wire_t20 = o_insn_154_0;
   assign wire_t21 = o_insn_157_0;
   assign wire_t22 = o_insn_113_0;
   assign wire_t23 = o_insn_118_0;
   assign wire_t24 = o_insn_124_0;
   assign wire_t18 = o_insn_148_0;
  // insn result wires end

  // sub state regs begin
  // sub state regs end
  always @(posedge clk) begin
    if (rst) begin
      cur_st <= `S_3;
    end else begin
`ifdef NLI_DEBUG
      $display("NLI:st mod_main_main=%d", cur_st);
      $display("NLI: r1_main =%d r3_main =%d reg_t2 =%d reg_t9 =%d reg_t5_v3 =%d reg_t7_v5 =%d reg_t5_v6 =%d reg_t6_v8 =%d reg_t6_v9 =%d reg_t7_v10 =%d reg_t7_v11 =%d r4_main_v17 =%d reg_t14 =%d" ,r1_main ,r3_main ,reg_t2 ,reg_t9 ,reg_t5_v3 ,reg_t7_v5 ,reg_t5_v6 ,reg_t6_v8 ,reg_t6_v9 ,reg_t7_v10 ,reg_t7_v11 ,r4_main_v17 ,reg_t14);
`endif
      // state output
      write_en_o <= (cur_st == `S_91);
      // FSM.
      case (cur_st)
        `S_3: begin
          addr_o <= 0;
          cur_st <= `S_93;
        end
        `S_93: begin
          r4_main_v17 <= o_insn_159_0;
          cur_st <= `S_6;
        end
        `S_6: begin
          reg_t2 <= wire_t16;
          if (wire_t16) begin
            cur_st <= `S_65;
          end else
          cur_st <= `S_65;
        end
        `S_15: begin
          cur_st <= `S_15;
        end
        `S_65: begin
          reg_t14 <= wire_t17;
          if (wire_t17) begin
            cur_st <= `S_69;
          end else
          cur_st <= `S_72;
        end
        `S_69: begin
          r1_main <= 32'd1;
          reg_t9 <= 2'd0;
          cur_st <= `S_89;
        end
        `S_72: begin
          r3_main <= 32'd0;
          reg_t2 <= 2'd1;
          reg_t6_v9 <= 32'd1;
          reg_t14 <= 2'd1;
          reg_t7_v11 <= 32'd1;
          reg_t9 <= 2'd1;
          cur_st <= `S_77;
        end
        `S_77: begin
          reg_t5_v3 <= wire_t19;
          r1_main <= wire_t20;
          reg_t7_v5 <= wire_t21;
          reg_t2 <= wire_t22;
          if (wire_t22) begin
            cur_st <= `S_82;
          end else
          cur_st <= `S_88;
        end
        `S_82: begin
          reg_t6_v8 <= wire_t23;
          reg_t14 <= 2'd0;
          reg_t5_v6 <= wire_t23;
          reg_t9 <= 2'd0;
          reg_t2 <= 2'd0;
          r3_main <= wire_t23;
          reg_t7_v10 <= wire_t24;
          cur_st <= `S_77;
        end
        `S_88: begin
          r3_main <= r1_main;
          reg_t9 <= 2'd1;
          cur_st <= `S_89;
        end
        `S_89: begin
          reg_t6_v8 <= wire_t18;
          cur_st <= `S_91;
        end
        `S_91: begin
          addr_o <= 1;
          data_o <= reg_t6_v8;
          cur_st <= `S_15;
        end
      endcase
    end
  end

  // imported modules begin
  // imported modules end

  // sub modules begin
  // sub modules end

endmodule
