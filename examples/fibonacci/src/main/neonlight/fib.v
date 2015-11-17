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
  reg  reg_t5;
  reg [31:0]  reg_t7;
  reg [31:0]  reg_t1_v1;
  reg [31:0]  reg_t2_v4;
  reg [31:0]  reg_t3_v5;
  reg [31:0]  r4_main_v11;
  reg [31:0]  reg_t1_v13;
  reg [31:0]  reg_t2_v14;
  reg [31:0]  reg_t3_v15;
  reg  reg_t8;
  reg  reg_t10;
  wire [31:0]  wire_t11;
  wire [31:0]  wire_t12;
  wire [31:0]  wire_t13;
  wire  wire_t14;
  wire [31:0]  wire_t15;
  wire [31:0]  wire_t16;

  // declare state begin
 `define S_0 0
 `define S_57 57
 `define S_14 14
 `define S_15 15
 `define S_43 43
 `define S_48 48

  reg [6:0] cur_st;
  // declare state end

  // resources begin
  // branch_1


  // gt_6
  wire gt_6_d0;
  wire [31:0] gt_6_s0;
  wire [31:0] gt_6_s1;
  assign gt_6_s0 = (cur_st == `S_43) ? r4_main_v11 : (0);
  assign gt_6_s1 = (cur_st == `S_43) ? wire_t13 : (0);
  assign gt_6_d0 = (gt_6_s0 > gt_6_s1);

  // add_7
  wire [31:0] add_7_d0;
  wire [31:0] add_7_s0;
  wire [31:0] add_7_s1;
  assign add_7_s0 = (cur_st == `S_48) ? reg_t2_v14 : (0);
  assign add_7_s1 = (cur_st == `S_48) ? reg_t2_v14 : (0);
  assign add_7_d0 = (add_7_s0 + add_7_s1);

  // selector_10

  // sram_if_11

  // add_13
  wire [31:0] add_13_d0;
  wire [31:0] add_13_s0;
  wire [31:0] add_13_s1;
  assign add_13_s0 = (cur_st == `S_48) ? reg_t3_v15 : (0);
  assign add_13_s1 = (cur_st == `S_48) ? 32'd1 : (0);
  assign add_13_d0 = (add_13_s0 + add_13_s1);

  // resources end

  // insn wires begin
  assign o_insn_102_0 = data_i;
  wire [31:0] o_insn_103_0; // id:103
  assign o_insn_103_0 = data_i;
  assign o_insn_105_0 = data_i;
  wire [31:0] o_insn_95_0; // id:95
  assign o_insn_95_0 = reg_t8 ? r3_main : reg_t1_v1;
  wire [31:0] o_insn_98_0; // id:98
  assign o_insn_98_0 = reg_t5 ? reg_t2_v4 : reg_t7;
  wire [31:0] o_insn_101_0; // id:101
  assign o_insn_101_0 = reg_t10 ? r1_main : reg_t3_v5;
  wire o_insn_67_0; // id:67
  assign o_insn_67_0 = gt_6_d0;
  wire [31:0] o_insn_74_0; // id:74
  assign o_insn_74_0 = add_7_d0;
  wire [31:0] o_insn_78_0; // id:78
  assign o_insn_78_0 = add_13_d0;
  // insn wires end

  // insn result wires begin
   assign wire_t11 = o_insn_95_0;
   assign wire_t12 = o_insn_98_0;
   assign wire_t13 = o_insn_101_0;
   assign wire_t14 = o_insn_67_0;
   assign wire_t15 = o_insn_74_0;
   assign wire_t16 = o_insn_78_0;
  // insn result wires end

  // sub state regs begin
  // sub state regs end
  always @(posedge clk) begin
    if (rst) begin
      cur_st <= `S_0;
    end else begin
`ifdef NLI_DEBUG
      $display("NLI:st mod_main_main=%d", cur_st);
      $display("NLI: r1_main =%d r3_main =%d reg_t5 =%d reg_t7 =%d reg_t1_v1 =%d reg_t2_v4 =%d reg_t3_v5 =%d r4_main_v11 =%d reg_t1_v13 =%d reg_t2_v14 =%d reg_t3_v15 =%d reg_t8 =%d reg_t10 =%d" ,r1_main ,r3_main ,reg_t5 ,reg_t7 ,reg_t1_v1 ,reg_t2_v4 ,reg_t3_v5 ,r4_main_v11 ,reg_t1_v13 ,reg_t2_v14 ,reg_t3_v15 ,reg_t8 ,reg_t10);
`endif
      // state output
      write_en_o <= (cur_st == `S_14);
      // FSM.
      case (cur_st)
        `S_0: begin
          r3_main <= 32'd0;
          reg_t2_v4 <= 32'd1;
          r1_main <= 32'd0;
          reg_t8 <= 2'd1;
          reg_t5 <= 2'd1;
          reg_t10 <= 2'd1;
          addr_o <= 0;
          cur_st <= `S_57;
        end
        `S_57: begin
          r4_main_v11 <= o_insn_103_0;
          cur_st <= `S_43;
        end
        `S_14: begin
          addr_o <= 1;
          data_o <= reg_t1_v13;
          cur_st <= `S_15;
        end
        `S_15: begin
          cur_st <= `S_15;
        end
        `S_43: begin
          reg_t1_v13 <= wire_t11;
          reg_t2_v14 <= wire_t12;
          reg_t3_v15 <= wire_t13;
          reg_t5 <= wire_t14;
          if (wire_t14) begin
            cur_st <= `S_48;
          end else
          cur_st <= `S_14;
        end
        `S_48: begin
          reg_t1_v1 <= reg_t2_v14;
          reg_t8 <= 2'd0;
          reg_t10 <= 2'd0;
          reg_t7 <= wire_t15;
          reg_t5 <= 2'd0;
          r1_main <= wire_t15;
          reg_t3_v5 <= wire_t16;
          cur_st <= `S_43;
        end
      endcase
    end
  end

  // imported modules begin
  // imported modules end

  // sub modules begin
  // sub modules end

endmodule
