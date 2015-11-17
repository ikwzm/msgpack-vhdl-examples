/*
 * Copyright (C)2005-2015 AQUAXIS TECHNOLOGY.
 *  Don't remove this header.
 * When you use this source, there is a need to inherit this header.
 *
 * This software is released under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 *
 * For further information please contact.
 *  URI:    http://www.aquaxis.com/
 *  E-Mail: info(at)aquaxis.com
 */
module fib(
	input __func_clock,
	input __func_reset,
	input __func_start,
	output reg __func_done,
	output reg __func_ready,

	// Memory Singal
	input [31:0] __args_n,
	// Call Singal
	// Result Singal
	output reg [31:0] __func_result

);

reg [0:0] __sig_1;
reg [31:0] __sig_2;
reg [31:0] __sig_curr_03;
reg [31:0] __sig_i_02;
reg [31:0] __sig_next_01;
reg [31:0] __sig_4;
reg [31:0] __sig_5;
reg [0:0] __sig_exitcond;
reg [31:0] __sig_next_01_lcssa;
reg [31:0] __sig_curr_0_lcssa;
	reg [31:0] __sig_n;
localparam __state_fin_exec = 0;
localparam __state_start_req = 1;
localparam __state_start_wait = 2;
localparam __state_start_exec = 3;
localparam __state_1_exec = 4;
localparam __state_2_exec = 5;
localparam __state_3_exec = 6;
localparam __state_4_exec = 7;
localparam __state_5_exec = 8;
localparam __state_6_exec = 9;
localparam __state_7_exec = 10;
localparam __state_8_exec = 11;
localparam __state_9_exec = 12;
localparam __state_10_exec = 13;
localparam __state_11_exec = 14;
localparam __state_12_exec = 15;
localparam __state_13_exec = 16;
localparam __state_14_exec = 17;
localparam __state_15_exec = 18;
integer __state;
localparam __label_0 = 0;
localparam __label__lr_ph = 4;
localparam __label_3 = 6;
localparam __label___crit_edge_loopexit = 10;
localparam __label___crit_edge = 12;
integer __label_pre;
integer __label;
always @(posedge __func_clock or negedge __func_reset) begin
	if(!__func_reset) begin
		__state <= __state_start_req;
		__func_ready <= 1;
		__func_done <= 0;
	end else begin
	case(__state)
		__state_start_req: begin
			__state <= __state_start_wait;
		end
		__state_start_wait: begin
			if(__func_start) begin
				__state <= __state_start_exec;
				__func_ready <= 0;
				__func_done <= 0;
			__sig_n <= __args_n;
			end
		end
		__state_start_exec: begin
			__state <= __state_1_exec;
	__label_pre <= __label_0;
		end
		__state_1_exec: begin
			__state <= __state_2_exec;
		end
		__state_2_exec: begin
			__state <= __state_3_exec;
			__sig_1 <= ( $signed(__sig_n) > $signed((0)) );
			__sig_2 <= $signed(__sig_n) + $signed((-1));
		end
		__state_3_exec: begin
			__state <= (__sig_1)?__state_4_exec:__state_12_exec;
			__label <= __label_pre;
		end
		__state_4_exec: begin
			__state <= __state_5_exec;
			__label_pre <= __label__lr_ph;
		end
		__state_5_exec: begin
			__state <= __state_6_exec;
			__label <= __label_pre;
		end
		__state_6_exec: begin
			__state <= __state_7_exec;
			__label_pre <= __label_3;
		end
		__state_7_exec: begin
			__state <= __state_8_exec;
			case(__label)
				__label__lr_ph: __sig_curr_03 <= (0);
				__label_3: __sig_curr_03 <= __sig_next_01;
			endcase
			case(__label)
				__label__lr_ph: __sig_i_02 <= (0);
				__label_3: __sig_i_02 <= __sig_5;
			endcase
			case(__label)
				__label__lr_ph: __sig_next_01 <= (1);
				__label_3: __sig_next_01 <= __sig_4;
			endcase
		end
		__state_8_exec: begin
			__state <= __state_9_exec;
			__sig_4 <= $signed(__sig_curr_03) + $signed(__sig_next_01);
			__sig_5 <= $signed(__sig_i_02) + $signed((1));
			__sig_exitcond <= ( __sig_i_02 == __sig_2 );
		end
		__state_9_exec: begin
			__state <= (__sig_exitcond)?__state_10_exec:__state_6_exec;
			__label <= __label_pre;
		end
		__state_10_exec: begin
			__state <= __state_11_exec;
			__label_pre <= __label___crit_edge_loopexit;
		end
		__state_11_exec: begin
			__state <= __state_12_exec;
			__label <= __label_pre;
			case(__label)
				__label_3: __sig_next_01_lcssa <= __sig_next_01;
			endcase
		end
		__state_12_exec: begin
			__state <= __state_13_exec;
			__label_pre <= __label___crit_edge;
		end
		__state_13_exec: begin
			__state <= __state_14_exec;
			case(__label)
				__label_0: __sig_curr_0_lcssa <= (0);
				__label___crit_edge_loopexit: __sig_curr_0_lcssa <= __sig_next_01_lcssa;
			endcase
		end
		__state_14_exec: begin
			__state <= __state_fin_exec;
			__func_result <= $signed(__sig_curr_0_lcssa);
		end
		__state_15_exec: begin
			__state <= __state_fin_exec;
		end
		__state_fin_exec: begin
			__state <= __state_start_req;
			__func_ready <= 1;
			__func_done <= 1;
		end
	endcase
	end
end
endmodule
