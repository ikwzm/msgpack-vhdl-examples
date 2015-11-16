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
  reg  reg_t3;
  reg  reg_t6;
  reg [31:0]  reg_t7_v2;
  reg [31:0]  reg_t8_v3;
  reg [31:0]  reg_t9_v5;
  reg [31:0]  reg_t9_v6;
  reg [31:0]  reg_t7_v7;
  reg [31:0]  reg_t8_v8;
  reg [31:0]  reg_t9_v9;
  reg  reg_t16;
  wire  wire_t17;
  wire  wire_t18;
  wire [31:0]  wire_t19;
  wire [31:0]  wire_t20;
  wire [31:0]  wire_t21;
  wire  wire_t22;
  wire [31:0]  wire_t23;
  wire [31:0]  wire_t24;

  // declare state begin
 `define S_0 0
 `define S_91 91
 `define S_15 15
 `define S_66 66
 `define S_72 72
 `define S_77 77
 `define S_82 82
 `define S_88 88

  reg [7:0] cur_st;
  // declare state end

  // resources begin
  // branch_1


  // inv_7

  // eq_8

  // gt_9
  wire gt_9_d0;
  wire [31:0] gt_9_s0;
  wire [31:0] gt_9_s1;
  assign gt_9_s0 = (cur_st == `S_77) ? 6'd0 : (0);
  assign gt_9_s1 = (cur_st == `S_77) ? wire_t21 : (0);
  assign gt_9_d0 = (gt_9_s0 > gt_9_s1);

  // add_10
  wire [31:0] add_10_d0;
  wire [31:0] add_10_s0;
  wire [31:0] add_10_s1;
  assign add_10_s0 = (cur_st == `S_82) ? reg_t7_v7 : (0);
  assign add_10_s1 = (cur_st == `S_82) ? reg_t8_v8 : (0);
  assign add_10_d0 = (add_10_s0 + add_10_s1);

  // selector_13

  // sram_if_14

  // add_16
  wire [31:0] add_16_d0;
  wire [31:0] add_16_s0;
  wire [31:0] add_16_s1;
  assign add_16_s0 = (cur_st == `S_82) ? reg_t9_v9 : (0);
  assign add_16_s1 = (cur_st == `S_82) ? 32'd1 : (0);
  assign add_16_d0 = (add_16_s0 + add_16_s1);

  // resources end

  // insn wires begin
  wire o_insn_85_0; // id:85
  assign o_insn_85_0 = !2'd0;
  assign o_insn_151_0 = data_i;
  wire [31:0] o_insn_152_0; // id:152
  assign o_insn_152_0 = data_i;
  wire o_insn_96_0; // id:96
  assign o_insn_96_0 = 6'd0==32'd1;
  wire [31:0] o_insn_144_0; // id:144
  assign o_insn_144_0 = reg_t6 ? reg_t7_v2 : r1_main;
  wire [31:0] o_insn_147_0; // id:147
  assign o_insn_147_0 = reg_t3 ? r3_main : reg_t8_v3;
  wire [31:0] o_insn_150_0; // id:150
  assign o_insn_150_0 = reg_t16 ? reg_t9_v6 : reg_t9_v5;
  wire o_insn_115_0; // id:115
  assign o_insn_115_0 = gt_9_d0;
  wire [31:0] o_insn_120_0; // id:120
  assign o_insn_120_0 = add_10_d0;
  wire [31:0] o_insn_126_0; // id:126
  assign o_insn_126_0 = add_16_d0;
  assign o_insn_154_0 = data_i;
  // insn wires end

  // insn result wires begin
   assign wire_t17 = o_insn_85_0;
   assign wire_t18 = o_insn_96_0;
   assign wire_t19 = o_insn_144_0;
   assign wire_t20 = o_insn_147_0;
   assign wire_t21 = o_insn_150_0;
   assign wire_t22 = o_insn_115_0;
   assign wire_t23 = o_insn_120_0;
   assign wire_t24 = o_insn_126_0;
  // insn result wires end

  // sub state regs begin
  // sub state regs end
  always @(posedge clk) begin
    if (rst) begin
      cur_st <= `S_0;
    end else begin
`ifdef NLI_DEBUG
      $display("NLI:st mod_main_main=%d", cur_st);
      $display("NLI: r1_main =%d r3_main =%d reg_t3 =%d reg_t6 =%d reg_t7_v2 =%d reg_t8_v3 =%d reg_t9_v5 =%d reg_t9_v6 =%d reg_t7_v7 =%d reg_t8_v8 =%d reg_t9_v9 =%d reg_t16 =%d" ,r1_main ,r3_main ,reg_t3 ,reg_t6 ,reg_t7_v2 ,reg_t8_v3 ,reg_t9_v5 ,reg_t9_v6 ,reg_t7_v7 ,reg_t8_v8 ,reg_t9_v9 ,reg_t16);
`endif
      // state output
      write_en_o <= (cur_st == `S_88);
      // FSM.
      case (cur_st)
        `S_0: begin
          addr_o <= 0;
          reg_t6 <= wire_t17;
          cur_st <= `S_91;
        end
        `S_91: begin
          reg_t8_v3 <= o_insn_152_0;
          if (reg_t6) begin
            cur_st <= `S_66;
          end else
          cur_st <= `S_66;
        end
        `S_15: begin
          cur_st <= `S_15;
        end
        `S_66: begin
          reg_t6 <= wire_t18;
          if (wire_t18) begin
            cur_st <= `S_72;
          end else
          cur_st <= `S_72;
        end
        `S_72: begin
          r1_main <= 32'd0;
          reg_t6 <= 2'd0;
          reg_t8_v3 <= 32'd1;
          reg_t9_v5 <= 32'd1;
          reg_t3 <= 2'd0;
          reg_t16 <= 2'd0;
          cur_st <= `S_77;
        end
        `S_77: begin
          reg_t7_v7 <= wire_t19;
          reg_t8_v8 <= wire_t20;
          reg_t9_v9 <= wire_t21;
          reg_t3 <= wire_t22;
          if (wire_t22) begin
            cur_st <= `S_82;
          end else
          cur_st <= `S_88;
        end
        `S_82: begin
          r3_main <= wire_t23;
          reg_t3 <= 2'd1;
          reg_t7_v2 <= wire_t23;
          reg_t16 <= 2'd1;
          reg_t6 <= 2'd1;
          r1_main <= wire_t23;
          reg_t9_v6 <= wire_t24;
          cur_st <= `S_77;
        end
        `S_88: begin
          addr_o <= 1;
          data_o <= reg_t8_v8;
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
