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
  reg [-1:0]  r7_main;
  reg  r6_main;
  reg [31:0]  r14_main;
  reg [31:0]  reg_t3_v1;
  reg [31:0]  reg_t2_v3;
  reg [31:0]  reg_t4_v4;
  reg [31:0]  reg_t4_v5;
  reg [31:0]  reg_t3_v6;
  reg [31:0]  reg_t2_v9;
  reg  r6_main_v17;
  reg [31:0]  r9_main_v18;
  reg  reg_t9;
  reg  reg_t10;
  wire  wire_t12;
  wire  wire_t13;
  wire [31:0]  wire_t14;
  wire [31:0]  wire_t15;
  wire [31:0]  wire_t16;
  wire  wire_t17;
  wire [31:0]  wire_t18;
  wire [31:0]  wire_t19;

  // declare state begin
 `define S_0 0
 `define S_65 65
 `define S_3 3
 `define S_13 13
 `define S_66 66
 `define S_20 20
 `define S_63 63
 `define S_50 50
 `define S_54 54

  reg [7:0] cur_st;
  // declare state end

  // resources begin
  // branch_1


  // eq_5

  // inv_6

  // gt_8
  wire gt_8_d0;
  wire [31:0] gt_8_s0;
  wire [31:0] gt_8_s1;
  assign gt_8_s0 = (cur_st == `S_50) ? r9_main_v18 : (0);
  assign gt_8_s1 = (cur_st == `S_50) ? wire_t16 : (0);
  assign gt_8_d0 = (gt_8_s0 > gt_8_s1);

  // add_9
  wire [31:0] add_9_d0;
  wire [31:0] add_9_s0;
  wire [31:0] add_9_s1;
  assign add_9_s0 = (cur_st == `S_54) ? reg_t3_v1 : (0);
  assign add_9_s1 = (cur_st == `S_54) ? reg_t2_v3 : (0);
  assign add_9_d0 = (add_9_s0 + add_9_s1);

  // selector_12

  // sram_if_13

  // add_15
  wire [31:0] add_15_d0;
  wire [31:0] add_15_s0;
  wire [31:0] add_15_s1;
  assign add_15_s0 = (cur_st == `S_54) ? r1_main : (0);
  assign add_15_s1 = (cur_st == `S_54) ? 32'd1 : (0);
  assign add_15_d0 = (add_15_s0 + add_15_s1);

  // resources end

  // insn wires begin
  assign o_insn_117_0 = data_i;
  wire [-1:0] o_insn_118_0; // id:118
  assign o_insn_118_0 = data_i;
  wire o_insn_5_0; // id:5
  assign o_insn_5_0 = r7_main==32'd0;
  wire o_insn_6_0; // id:6
  assign o_insn_6_0 = !wire_t12;
  assign o_insn_120_0 = data_i;
  wire [31:0] o_insn_121_0; // id:121
  assign o_insn_121_0 = data_i;
  assign o_insn_123_0 = data_i;
  wire [31:0] o_insn_110_0; // id:110
  assign o_insn_110_0 = reg_t9 ? r14_main : reg_t3_v6;
  wire [31:0] o_insn_113_0; // id:113
  assign o_insn_113_0 = reg_t10 ? reg_t2_v9 : r3_main;
  wire [31:0] o_insn_116_0; // id:116
  assign o_insn_116_0 = r6_main ? reg_t4_v5 : reg_t4_v4;
  wire o_insn_78_0; // id:78
  assign o_insn_78_0 = gt_8_d0;
  wire [31:0] o_insn_85_0; // id:85
  assign o_insn_85_0 = add_9_d0;
  wire [31:0] o_insn_89_0; // id:89
  assign o_insn_89_0 = add_15_d0;
  // insn wires end

  // insn result wires begin
   assign wire_t12 = o_insn_5_0;
   assign wire_t13 = o_insn_6_0;
   assign wire_t14 = o_insn_110_0;
   assign wire_t15 = o_insn_113_0;
   assign wire_t16 = o_insn_116_0;
   assign wire_t17 = o_insn_78_0;
   assign wire_t18 = o_insn_85_0;
   assign wire_t19 = o_insn_89_0;
  // insn result wires end

  // sub state regs begin
  // sub state regs end
  always @(posedge clk) begin
    if (rst) begin
      cur_st <= `S_0;
    end else begin
`ifdef NLI_DEBUG
      $display("NLI:st mod_main_main=%d", cur_st);
      $display("NLI: r1_main =%d r3_main =%d r7_main =%d r6_main =%d r14_main =%d reg_t3_v1 =%d reg_t2_v3 =%d reg_t4_v4 =%d reg_t4_v5 =%d reg_t3_v6 =%d reg_t2_v9 =%d r6_main_v17 =%d r9_main_v18 =%d reg_t9 =%d reg_t10 =%d" ,r1_main ,r3_main ,r7_main ,r6_main ,r14_main ,reg_t3_v1 ,reg_t2_v3 ,reg_t4_v4 ,reg_t4_v5 ,reg_t3_v6 ,reg_t2_v9 ,r6_main_v17 ,r9_main_v18 ,reg_t9 ,reg_t10);
`endif
      // state output
      write_en_o <= (cur_st == `S_20);
      // FSM.
      case (cur_st)
        `S_0: begin
          addr_o <= 0;
          cur_st <= `S_65;
        end
        `S_65: begin
          r7_main <= o_insn_118_0;
          cur_st <= `S_3;
        end
        `S_3: begin
          r6_main_v17 <= wire_t13;
          if (wire_t13) begin
            cur_st <= `S_13;
          end else
          cur_st <= `S_63;
        end
        `S_13: begin
          reg_t2_v9 <= 32'd0;
          reg_t3_v6 <= 32'd1;
          reg_t4_v4 <= 32'd0;
          reg_t9 <= 2'd0;
          reg_t10 <= 2'd1;
          r6_main <= 2'd0;
          addr_o <= 1;
          cur_st <= `S_66;
        end
        `S_66: begin
          r9_main_v18 <= o_insn_121_0;
          cur_st <= `S_50;
        end
        `S_20: begin
          addr_o <= 2;
          data_o <= reg_t2_v3;
          cur_st <= `S_63;
        end
        `S_63: begin
          cur_st <= `S_63;
        end
        `S_50: begin
          reg_t3_v1 <= wire_t14;
          reg_t2_v3 <= wire_t15;
          r1_main <= wire_t16;
          r6_main <= wire_t17;
          if (wire_t17) begin
            cur_st <= `S_54;
          end else
          cur_st <= `S_20;
        end
        `S_54: begin
          r3_main <= reg_t3_v1;
          reg_t10 <= 2'd0;
          r6_main <= 2'd1;
          reg_t9 <= 2'd1;
          r14_main <= wire_t18;
          reg_t2_v9 <= wire_t18;
          reg_t4_v5 <= wire_t19;
          cur_st <= `S_50;
        end
      endcase
    end
  end

  // imported modules begin
  // imported modules end

  // sub modules begin
  // sub modules end

endmodule

module fib(clk, rst, addr_o, write_en_o, data_o, data_i);
  input clk;
  input rst;
  // EXTERNAL_RAM
  output [31:0] addr_o;
  output write_en_o;
  output [31:0] data_o;
  input [31:0] data_i;
  mod_main mod_main_inst(.clk(clk), .rst(rst), .addr_o(addr_o), .write_en_o(write_en_o), .data_o(data_o), .data_i(data_i));
endmodule
