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

	output reg __gm_req,
	output reg __gm_rnw,
	input __gm_done,
	output reg [31:0] __gm_adrs,
	output reg [1:0] __gm_leng,
	input [31:0] __gm_di,
	output reg [31:0] __gm_do,

	// Memory Singal
	input [31:0] __args_n,
	// Call Singal

	output reg __dummy
);

reg [0:0] __sig_1;
reg [0:0] __sig_3;
reg [31:0] __sig_4;
reg [31:0] __sig_i_03;
reg [31:0] __sig_r1_02;
reg [31:0] __sig_r0_01;
reg [31:0] __sig_6;
reg [31:0] __sig_7;
reg [0:0] __sig_exitcond;
reg [31:0] __sig_r1_02_lcssa;
reg [31:0] __sig__0;
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
localparam __state_16_exec = 19;
localparam __state_17_exec = 20;
integer __state;
localparam __label_0 = 0;
localparam __label_2 = 4;
localparam __label__lr_ph = 6;
localparam __label_5 = 8;
localparam __label__loopexit_loopexit = 12;
localparam __label__loopexit = 14;
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
		end
		__state_1_exec: begin
			__state <= __state_2_exec;
		end
		__state_2_exec: begin
			__state <= __state_3_exec;
			__sig_1 <= ( $signed(__sig_n) < $signed((1)) );
			__sig_3 <= ( __sig_n == (1) );
			__sig_4 <= $signed(__sig_n) + $signed((-1));
		end
		__state_3_exec: begin
			__state <= (__sig_1)?__state_14_exec:__state_4_exec;
		end
		__state_4_exec: begin
			__state <= __state_5_exec;
			__label <= __label_2;
		end
		__state_5_exec: begin
			__state <= (__sig_3)?__state_14_exec:__state_6_exec;
		end
		__state_6_exec: begin
			__state <= __state_7_exec;
			__label <= __label__lr_ph;
		end
		__state_7_exec: begin
			__state <= __state_8_exec;
		end
		__state_8_exec: begin
			__state <= __state_9_exec;
			__label <= __label_5;
		end
		__state_9_exec: begin
			__state <= __state_10_exec;
			case(__label)
				__label__lr_ph: __sig_i_03 <= (0);
				__label_5: __sig_i_03 <= __sig_7;
			endcase
			case(__label)
				__label__lr_ph: __sig_r1_02 <= (1);
				__label_5: __sig_r1_02 <= __sig_6;
			endcase
			case(__label)
				__label__lr_ph: __sig_r0_01 <= (0);
				__label_5: __sig_r0_01 <= __sig_r1_02;
			endcase
		end
		__state_10_exec: begin
			__state <= __state_11_exec;
			__sig_6 <= $signed(__sig_r1_02) + $signed(__sig_r0_01);
			__sig_7 <= $signed(__sig_i_03) + $signed((1));
			__sig_exitcond <= ( __sig_i_03 == __sig_4 );
		end
		__state_11_exec: begin
			__state <= (__sig_exitcond)?__state_12_exec:__state_8_exec;
		end
		__state_12_exec: begin
			__state <= __state_13_exec;
			__label <= __label__loopexit_loopexit;
		end
		__state_13_exec: begin
			__state <= __state_14_exec;
			case(__label)
				__label_5: __sig_r1_02_lcssa <= __sig_r1_02;
			endcase
		end
		__state_14_exec: begin
			__state <= __state_15_exec;
			__label <= __label__loopexit;
		end
		__state_15_exec: begin
			__state <= __state_16_exec;
			case(__label)
				__label_0: __sig__0 <= (0);
				__label_2: __sig__0 <= (1);
				__label__loopexit_loopexit: __sig__0 <= __sig_r1_02_lcssa;
			endcase
		end
		__state_16_exec: begin
			__state <= __state_fin_exec;
		end
		__state_17_exec: begin
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
