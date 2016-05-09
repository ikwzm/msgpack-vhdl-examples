-----------------------------------------------------------------------------------
--!     @file    axi4_types.vhd
--!     @brief   AXI4 Channel Signal Type Package.
--!     @version 1.5.5
--!     @date    2014/3/2
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2014 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief AXI4 の各種タイプ/定数を定義しているパッケージ.
-----------------------------------------------------------------------------------
package AXI4_TYPES is
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのバースト長信号のビット数.
    -------------------------------------------------------------------------------
    constant  AXI4_ALEN_WIDTH      : integer := 8;
    constant  AXI3_ALEN_WIDTH      : integer := 4;
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのバースト長信号のタイプ.
    -------------------------------------------------------------------------------
    subtype   AXI4_ALEN_TYPE       is std_logic_vector(AXI4_ALEN_WIDTH   -1 downto 0);
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルの転送サイズ信号のビット数.
    -------------------------------------------------------------------------------
    constant  AXI4_ASIZE_WIDTH     : integer := 3;
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルの転送サイズ信号のタイプ.
    -------------------------------------------------------------------------------
    subtype   AXI4_ASIZE_TYPE      is std_logic_vector(AXI4_ASIZE_WIDTH  -1 downto 0);
    constant  AXI4_ASIZE_1BYTE     : AXI4_ASIZE_TYPE := "000";
    constant  AXI4_ASIZE_2BYTE     : AXI4_ASIZE_TYPE := "001";
    constant  AXI4_ASIZE_4BYTE     : AXI4_ASIZE_TYPE := "010";
    constant  AXI4_ASIZE_8BYTE     : AXI4_ASIZE_TYPE := "011";
    constant  AXI4_ASIZE_16BYTE    : AXI4_ASIZE_TYPE := "100";
    constant  AXI4_ASIZE_32BYTE    : AXI4_ASIZE_TYPE := "101";
    constant  AXI4_ASIZE_64BYTE    : AXI4_ASIZE_TYPE := "110";
    constant  AXI4_ASIZE_128BYTE   : AXI4_ASIZE_TYPE := "111";
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのバースト種別信号のビット数.
    -------------------------------------------------------------------------------
    constant  AXI4_ABURST_WIDTH    : integer := 2;
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのバースト種別信号のタイプ.
    -------------------------------------------------------------------------------
    subtype   AXI4_ABURST_TYPE     is std_logic_vector(AXI4_ABURST_WIDTH -1 downto 0);
    constant  AXI4_ABURST_FIXED    : AXI4_ABURST_TYPE := "00";
    constant  AXI4_ABURST_INCR     : AXI4_ABURST_TYPE := "01";
    constant  AXI4_ABURST_WRAP     : AXI4_ABURST_TYPE := "10";
    constant  AXI4_ABURST_RESV     : AXI4_ABURST_TYPE := "11";
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルの排他アクセス信号のビット数.
    -------------------------------------------------------------------------------
    constant  AXI4_ALOCK_WIDTH     : integer := 1;
    constant  AXI3_ALOCK_WIDTH     : integer := 2;
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルの排他アクセス信号のタイプ.
    -------------------------------------------------------------------------------
    subtype   AXI4_ALOCK_TYPE      is std_logic_vector(AXI4_ALOCK_WIDTH  -1 downto 0);
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのキャッシュ信号のビット数.
    -------------------------------------------------------------------------------
    constant  AXI4_ACACHE_WIDTH    : integer := 4;
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのキャッシュ信号のタイプ.
    -------------------------------------------------------------------------------
    subtype   AXI4_ACACHE_TYPE     is std_logic_vector(AXI4_ACACHE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルの保護ユニットサポート信号のビット数.
    -------------------------------------------------------------------------------
    constant  AXI4_APROT_WIDTH     : integer := 3;
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルの保護ユニットサポート信号のタイプ.
    -------------------------------------------------------------------------------
    subtype   AXI4_APROT_TYPE      is std_logic_vector(AXI4_APROT_WIDTH  -1 downto 0);
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのQoS(Quality of Service)信号のビット数.
    -------------------------------------------------------------------------------
    constant  AXI4_AQOS_WIDTH      : integer := 4;
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのQoS(Quality of Service)信号のタイプ.
    -------------------------------------------------------------------------------
    subtype   AXI4_AQOS_TYPE       is std_logic_vector(AXI4_AQOS_WIDTH   -1 downto 0);
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのリージョン信号のビット数.
    -------------------------------------------------------------------------------
    constant  AXI4_AREGION_WIDTH   : integer := 4;
    -------------------------------------------------------------------------------
    --! @brief アドレスチャネルのリージョン信号のタイプ.
    -------------------------------------------------------------------------------
    subtype   AXI4_AREGION_TYPE    is std_logic_vector(AXI4_AREGION_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    --! @brief 応答信号のビット数.
    -------------------------------------------------------------------------------
    constant  AXI4_RESP_WIDTH      : integer := 2;
    -------------------------------------------------------------------------------
    --! @brief 応答信号のタイプ.
    -------------------------------------------------------------------------------
    subtype   AXI4_RESP_TYPE       is std_logic_vector(AXI4_RESP_WIDTH   -1 downto 0);
    constant  AXI4_RESP_OKAY       : AXI4_RESP_TYPE := "00";
    constant  AXI4_RESP_EXOKAY     : AXI4_RESP_TYPE := "01";
    constant  AXI4_RESP_SLVERR     : AXI4_RESP_TYPE := "10";
    constant  AXI4_RESP_DECERR     : AXI4_RESP_TYPE := "11";
    -------------------------------------------------------------------------------
    --! @brief AXI4 ADDR の最大ビット幅
    -------------------------------------------------------------------------------
    constant  AXI4_ADDR_MAX_WIDTH  : integer := 64;
    -------------------------------------------------------------------------------
    --! @brief AXI4 DATA の最大ビット幅
    -------------------------------------------------------------------------------
    constant  AXI4_DATA_MAX_WIDTH  : integer := 1024;
    -------------------------------------------------------------------------------
    --! @brief AXI4 WSTRB の最大ビット幅
    -------------------------------------------------------------------------------
    constant  AXI4_STRB_MAX_WIDTH  : integer := AXI4_DATA_MAX_WIDTH/8;
    -------------------------------------------------------------------------------
    --! @brief AXI4 USER の最大ビット幅
    -------------------------------------------------------------------------------
    constant  AXI4_USER_MAX_WIDTH  : integer := 32;
    -------------------------------------------------------------------------------
    --! @brief AXI4 ARLEN/AWLEN の最大ビット幅
    -------------------------------------------------------------------------------
    constant  AXI4_ALEN_MAX_WIDTH  : integer :=  8;
    -------------------------------------------------------------------------------
    --! @brief AXI4 ARLOCK/AWLOCK の最大ビット幅
    -------------------------------------------------------------------------------
    constant  AXI4_ALOCK_MAX_WIDTH : integer :=  2;
    -------------------------------------------------------------------------------
    --! @brief AXI4 チャネルの可変長信号のビット幅を指定するレコードタイプ.
    -------------------------------------------------------------------------------
    type      AXI4_SIGNAL_WIDTH_TYPE is record
              ID                   : integer;
              AWADDR               : integer range 1 to AXI4_USER_MAX_WIDTH;
              AWUSER               : integer range 1 to AXI4_USER_MAX_WIDTH;
              ARADDR               : integer range 1 to AXI4_USER_MAX_WIDTH;
              ARUSER               : integer range 1 to AXI4_USER_MAX_WIDTH;
              ALEN                 : integer range 4 to AXI4_ALEN_MAX_WIDTH;
              ALOCK                : integer range 1 to AXI4_ALOCK_MAX_WIDTH;
              WDATA                : integer range 8 to AXI4_DATA_MAX_WIDTH;
              WUSER                : integer range 1 to AXI4_USER_MAX_WIDTH;
              RDATA                : integer range 8 to AXI4_DATA_MAX_WIDTH;
              RUSER                : integer range 1 to AXI4_USER_MAX_WIDTH;
              BUSER                : integer range 1 to AXI4_USER_MAX_WIDTH;
    end record;
    -------------------------------------------------------------------------------
    --! @brief AXI4-Stream TDEST の最大ビット幅
    -------------------------------------------------------------------------------
    constant  AXI4_DEST_MAX_WIDTH  : integer := 32;
    -------------------------------------------------------------------------------
    --! @brief AXI4-Stream の可変長信号のビット幅を指定するレコードタイプ.
    -------------------------------------------------------------------------------
    type      AXI4_STREAM_SIGNAL_WIDTH_TYPE is record
              ID                   : integer;
              USER                 : integer range 1 to AXI4_USER_MAX_WIDTH;
              DEST                 : integer range 1 to AXI4_DEST_MAX_WIDTH;
              DATA                 : integer range 8 to AXI4_DATA_MAX_WIDTH;
    end record;
end package;
-----------------------------------------------------------------------------------
--!     @file    components.vhd                                                  --
--!     @brief   PIPEWORK COMPONENT LIBRARY DESCRIPTION                          --
--!     @version 1.5.9                                                           --
--!     @date    2016/03/13                                                      --
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>                     --
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--                                                                               --
--      Copyright (C) 2016 Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>           --
--      All rights reserved.                                                     --
--                                                                               --
--      Redistribution and use in source and binary forms, with or without       --
--      modification, are permitted provided that the following conditions       --
--      are met:                                                                 --
--                                                                               --
--        1. Redistributions of source code must retain the above copyright      --
--           notice, this list of conditions and the following disclaimer.       --
--                                                                               --
--        2. Redistributions in binary form must reproduce the above copyright   --
--           notice, this list of conditions and the following disclaimer in     --
--           the documentation and/or other materials provided with the          --
--           distribution.                                                       --
--                                                                               --
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    --
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    --
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT         --
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    --
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    --
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT      --
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    --
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     --
--                                                                               --
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief PIPEWORK COMPONENT LIBRARY DESCRIPTION                                --
-----------------------------------------------------------------------------------
package COMPONENTS is
-----------------------------------------------------------------------------------
--! @brief CHOPPER                                                               --
-----------------------------------------------------------------------------------
component CHOPPER
    -------------------------------------------------------------------------------
    -- ジェネリック変数
    -------------------------------------------------------------------------------
    generic (
        BURST       : --! @brief BURST MODE : 
                      --! バースト転送に対応するかを指定する.
                      --! * 1:バースト転送に対応する.
                      --!   0:バースト転送に対応しない.
                      --! * バースト転送に対応する場合は、CHOP信号をアサートする度に 
                      --!   PIECE_COUNT や各種出力信号が更新される.
                      --! * バースト転送に対応しない場合は、カウンタの初期値は１に設
                      --!   定され、CHOP信号が一回アサートされた時点でカウンタは停止
                      --!   する. つまり、最初のピースのサイズしか生成されない.
                      --! * 当然 BURST=0 の方が回路規模は小さくなる.
                      integer range 0 to 1 := 1;
        MIN_PIECE   : --! @brief MINIMUM PIECE SIZE :
                      --! １ピースの大きさの最小値を2のべき乗値で指定する.
                      --! * 例えば、大きさの単位がバイトの場合次のようになる.
                      --!   0=1バイト、1=2バイト、2=4バイト、3=8バイト
                      integer := 6;
        MAX_PIECE   : --! @brief MAXIMUM PIECE SIZE :
                      --! １ピースの大きさの最大値を2のべき乗値で指定する.
                      --! * 例えば、大きさの単位がバイトの場合次のようになる.
                      --!   0=1バイト、1=2バイト、2=4バイト、3=8バイト
                      --! * MAX_PIECE > MIN_PIECE の場合、１ピースの大きさを 
                      --!   SEL 信号によって選択することができる.
                      --!   SEL信号の対応するビットを'1'に設定して他のビットを'0'に
                      --!   設定することによって１ピースの大きさを指定する.
                      --! * MAX_PIECE = MIN_PIECE の場合、１ピースの大きさは 
                      --!   MIN_PIECEの値になる.
                      --!   この場合は SEL 信号は使用されない.
                      --! * MAX_PIECE と MIN_PIECE の差が大きいほど、回路規模は
                      --!   大きくなる。
                      integer := 6;
        MAX_SIZE    : --! @brief MAXIMUM SIZE :
                      --! 想定している最大の大きさを2のべき乗値で指定する.
                      --! * この回路内で、MAX_SIZE-MIN_PIECEのビット幅のカウンタを
                      --!   生成する。
                      integer := 9;
        ADDR_BITS   : --! @brief BLOCK ADDRESS BITS :
                      --! ブロックの先頭アドレスを指定する信号(ADDR信号)の
                      --! ビット幅を指定する.
                      integer := 9;
        SIZE_BITS   : --! @brief BLOCK SIZE BITS :
                      --! ブロックの大きさを指定する信号(SIZE信号)のビット幅を
                      --! 指定する.
                      integer := 9;
        COUNT_BITS  : --! @brief OUTPUT COUNT BITS :
                      --! 出力するカウンタ信号(COUNT)のビット幅を指定する.
                      --! * 出力するカウンタのビット幅は、想定している最大の大きさ
                      --!   (MAX_SIZE)-１ピースの大きさの最小値(MIN_PIECE)以上で
                      --!   なければならない.
                      --! * カウンタ信号(COUNT)を使わない場合は、エラボレーション時
                      --!   にエラーが発生しないように1以上の値を指定しておく.
                      integer := 9;
        PSIZE_BITS  : --! @brief OUTPUT PIECE SIZE BITS :
                      --! 出力するピースサイズ(PSIZE,NEXT_PSIZE)のビット幅を指定する.
                      --! * ピースサイズのビット幅は、MAX_PIECE(１ピースのサイズを
                      --!   表現できるビット数)以上でなければならない.
                      integer := 9;
        GEN_VALID   : --! @brief GENERATE VALID FLAG :
                      --! ピース有効信号(VALID/NEXT_VALID)を生成するかどうかを指定する.
                      --! * GEN_VALIDが０以外の場合は、ピース有効信号を生成する.
                      --! * GEN_VALIDが０の場合は、ピース有効信号はALL'1'になる.
                      --! * GEN_VALIDが０以外でも、この回路の上位階層で
                      --!   ピース有効をopenにしても論理上は問題ないが、
                      --!   論理合成ツールによっては、コンパイルに膨大な時間を
                      --!   要することがある.
                      --!   その場合はこの変数を０にすることで解決出来る場合がある.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 各種初期値
    -------------------------------------------------------------------------------
        ADDR        : --! @brief BLOCK ADDRESS :
                      --! ブロックの先頭アドレス.
                      --! * LOAD信号のアサート時に内部に保存される.
                      --! * 入力はADDR_BITSで示されるビット数あるが、実際に使用され
                      --!   るのは、1ピース分の下位ビットだけ.
                      in  std_logic_vector(ADDR_BITS-1 downto 0);
        SIZE        : --! @brief BLOCK SIZE :
                      --! ブロックの大きさ.
                      --! * LOAD信号のアサート時に内部に保存される.
                      in  std_logic_vector(SIZE_BITS-1 downto 0);
        SEL         : --! @brief PIECE SIZE SELECT :
                      --! １ピースの大きさを選択するための信号.
                      --! * LOAD信号のアサート時に内部に保存される.
                      --! * １ピースの大きさに対応するビットのみ'1'をセットし、他の
                      --!   ビットは'0'をセットすることで１ピースの大きさを選択する.
                      --! * もしSEL信号のうち複数のビットに'1'が設定されていた場合は
                      --!   もっとも最小値に近い値(MIN_PIECEの値)が選ばれる。
                      --! * この信号は MAX_PIECE > MIN_PIECE の場合にのみ使用される.
                      --! * この信号は MAX_PIECE = MIN_PIECE の場合は無視される.
                      in  std_logic_vector(MAX_PIECE downto MIN_PIECE);
        LOAD        : --! @brief LOAD :
                      --! ADDR,SIZE,SELを内部にロードするための信号.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 制御信号
    -------------------------------------------------------------------------------
        CHOP        : --! @brief CHOP ENABLE :
                      --! ブロックをピースに分割する信号.
                      --! * この信号のアサートによって、ピースカウンタ、各種フラグ、
                      --!   ピースサイズを更新され、次のクロックでこれらの信号が
                      --!   出力される.
                      --! * LOAD信号と同時にアサートされた場合はLOADの方が優先され、
                      --!   CHOP信号は無視される.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- ピースカウンタ/フラグ出力
    -------------------------------------------------------------------------------
        COUNT       : --! @brief PIECE COUNT :
                      --! 残りのピースの数-1を示す.
                      --! * CHOP信号のアサートによりカウントダウンする.
                      out std_logic_vector(COUNT_BITS-1 downto 0);
        NONE        : --! @brief NONE PIECE FLAG :
                      --! 残りのピースの数が０になったことを示すフラグ.
                      --! * COUNT = (others => '1') で'1'が出力される.
                      out std_logic;
        LAST        : --! @brief LAST PIECE FLAG :
                      --! 残りのピースの数が１になったことを示すフラグ.
                      --! * COUNT = (others => '0') で'1'が出力される.
                      --! * 最後のピースであることを示す.
                      out std_logic;
        NEXT_NONE   : --! @brief NONE PIECE FLAG(NEXT CYCLE) :
                      --! 次のクロックで残りのピースの数が０になることを示すフラグ.
                      out std_logic;
        NEXT_LAST   : --! @brief LAST PIECE FLAG(NEXT CYCYE) :
                      --! 次のクロックで残りのピースの数が１になることを示すフラグ.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- ピースサイズ(1ピースの容量)出力
    -------------------------------------------------------------------------------
        PSIZE       : --! @brief PIECE SIZE :
                      --! 現在のピースの大きさを示す.
                      out std_logic_vector(PSIZE_BITS-1 downto 0);
        NEXT_PSIZE  : --! @brief PIECE SIZE(NEXT CYCLE)
                      --! 次のクロックでのピースの大きさを示す.
                      out std_logic_vector(PSIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- ピース有効出力
    -------------------------------------------------------------------------------
        VALID       : --! @brief PIECE VALID FLAG :
                      --! ピース有効信号.
                      --! * 例えば、ADDR=0x0002、SIZE=11、１ピースのサイズ=4の場合、
                      --!   "1100"、"1111"、"1111"、"0001" を生成する.
                      --! * GEN_VALIDが０以外の場合にのみ有効な値を生成する.
                      --! * GEN_VALIDが０の場合は常に ALL'1' を生成する.
                      out std_logic_vector(2**(MAX_PIECE)-1 downto 0);
        NEXT_VALID  : --! @brief PIECE VALID FALG(NEXT CYCLE)
                      --! 次のクロックでのピース有効信号
                      out std_logic_vector(2**(MAX_PIECE)-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief REDUCER                                                               --
-----------------------------------------------------------------------------------
component REDUCER
    generic (
        WORD_BITS   : --! @brief WORD BITS :
                      --! １ワードのデータのビット数を指定する.
                      integer := 8;
        STRB_BITS   : --! @brief ENABLE BITS :
                      --! ワードデータのうち有効なデータであることを示す信号(STRB)
                      --! のビット数を指定する.
                      integer := 1;
        I_WIDTH     : --! @brief INPUT WORD WIDTH :
                      --! 入力側のデータのワード数を指定する.
                      integer := 1;
        O_WIDTH     : --! @brief OUTPUT WORD WIDTH :
                      --! 出力側のデータのワード数を指定する.
                      integer := 1;
        QUEUE_SIZE  : --! @brief QUEUE SIZE :
                      --! キューの大きさをワード数で指定する.
                      --! * QUEUE_SIZE=0を指定した場合は、キューの深さは自動的に
                      --!   O_WIDTH+I_WIDTH+I_WIDTH-1 に設定される.
                      --! * QUEUE_SIZE<O_WIDTH+I_WIDTH-1の場合は、キューの深さは
                      --!   自動的にO_WIDTH+I_WIDTH-1に設定される.
                      integer := 0;
        VALID_MIN   : --! @brief BUFFER VALID MINIMUM NUMBER :
                      --! VALID信号の配列の最小値を指定する.
                      integer := 0;
        VALID_MAX   : --! @brief BUFFER VALID MAXIMUM NUMBER :
                      --! VALID信号の配列の最大値を指定する.
                      integer := 0;
        O_VAL_SIZE  : --! @brief OUTPUT WORD VALID SIZE :
                      --! O_VAL 信号アサート時のキューに入っているワード数.
                      --! * キューに O_VAL_SIZE 以上のワード数が入っていると O_VAL 
                      --!   信号をアサートする.
                      --! * 互換性維持のため O_VAL_SIZE=0を指定した場合は、キューに
                      --!   O_WIDTH 以上のワード数が入っていると O_VAL 信号をアサー
                      --!   トする.
                      integer := 0;
        O_SHIFT_MIN : --! @brief OUTPUT SHIFT SIZE MINIMUM NUMBER :
                      --! O_SHIFT信号の配列の最小値を指定する.
                      integer := 1;
        O_SHIFT_MAX : --! @brief OUTPUT SHIFT SIZE MINIMUM NUMBER :
                      --! O_SHIFT信号の配列の最大値を指定する.
                      integer := 1;
        I_JUSTIFIED : --! @brief INPUT WORD JUSTIFIED :
                      --! 入力側の有効なデータが常にLOW側に詰められていることを
                      --! 示すフラグ.
                      --! * 常にLOW側に詰められている場合は、シフタが必要なくなる
                      --!   ため回路が簡単になる.
                      integer range 0 to 1 := 0;
        FLUSH_ENABLE: --! @brief FLUSH ENABLE :
                      --! FLUSH/I_FLUSHによるフラッシュ処理を有効にするかどうかを
                      --! 指定する.
                      --! * FLUSHとDONEとの違いは、DONEは最後のデータの出力時に
                      --!   キューの状態をすべてクリアするのに対して、
                      --!   FLUSHは最後のデータの出力時にSTRBだけをクリアしてVALは
                      --!   クリアしない.
                      --!   そのため次の入力データは、最後のデータの次のワード位置
                      --!   から格納される.
                      --! * フラッシュ処理を行わない場合は、0を指定すると回路が若干
                      --!   簡単になる.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 各種制御信号
    -------------------------------------------------------------------------------
        START       : --! @brief START :
                      --! 開始信号.
                      --! * この信号はOFFSETを内部に設定してキューを初期化する.
                      --! * 最初にデータ入力と同時にアサートしても構わない.
                      in  std_logic := '0';
        OFFSET      : --! @brief OFFSET :
                      --! 最初のワードの出力位置を指定する.
                      --! * START信号がアサートされた時のみ有効.
                      --! * O_WIDTH>I_WIDTHの場合、最初のワードデータを出力する際の
                      --!   オフセットを設定できる.
                      --! * 例えばWORD_BITS=8、I_WIDTH=1(1バイト入力)、O_WIDTH=4(4バイト出力)の場合、
                      --!   OFFSET="0000"に設定すると、最初に入力したバイトデータは
                      --!   1バイト目から出力される.    
                      --!   OFFSET="0001"に設定すると、最初に入力したバイトデータは
                      --!   2バイト目から出力される.    
                      --!   OFFSET="0011"に設定すると、最初に入力したバイトデータは
                      --!   3バイト目から出力される.    
                      --!   OFFSET="0111"に設定すると、最初に入力したバイトデータは
                      --!   4バイト目から出力される.    
                      in  std_logic_vector(O_WIDTH-1 downto 0) := (others => '0');
        DONE        : --! @brief DONE :
                      --! 終了信号.
                      --! * この信号をアサートすることで、キューに残っているデータ
                      --!   を掃き出す.
                      --!   その際、最後のワードと同時にO_DONE信号がアサートされる.
                      --! * FLUSH信号との違いは、FLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        FLUSH       : --! @brief FLUSH :
                      --! フラッシュ信号.
                      --! * この信号をアサートすることで、キューに残っているデータ
                      --!   を掃き出す.
                      --!   その際、最後のワードと同時にO_FLUSH信号がアサートされる.
                      --! * DONE信号との違いは、FLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        BUSY        : --! @brief BUSY :
                      --! ビジー信号.
                      --! * 最初にデータが入力されたときにアサートされる.
                      --! * 最後のデータが出力し終えたらネゲートされる.
                      out std_logic;
        VALID       : --! @brief QUEUE VALID FLAG :
                      --! キュー有効信号.
                      --! * 対応するインデックスのキューに有効なワードが入って
                      --!   いるかどうかを示すフラグ.
                      out std_logic_vector(VALID_MAX downto VALID_MIN);
    -------------------------------------------------------------------------------
    -- 入力側 I/F
    -------------------------------------------------------------------------------
        I_ENABLE    : --! @brief INPUT ENABLE :
                      --! 入力許可信号.
                      --! * この信号がアサートされている場合、キューの入力を許可する.
                      --! * この信号がネゲートされている場合、I_RDY アサートされない.
                      in  std_logic := '1';
        I_DATA      : --! @brief INPUT WORD DATA :
                      --! ワードデータ入力.
                      in  std_logic_vector(I_WIDTH*WORD_BITS-1 downto 0);
        I_STRB      : --! @brief INPUT WORD ENABLE :
                      --! ワードストローブ信号入力.
                      in  std_logic_vector(I_WIDTH*STRB_BITS-1 downto 0);
        I_DONE      : --! @brief INPUT WORD DONE :
                      --! 最終ワード信号入力.
                      --! * 最後の力ワードデータ入であることを示すフラグ.
                      --! * 基本的にはDONE信号と同じ働きをするが、I_DONE信号は
                      --!   最後のワードデータを入力する際に同時にアサートする.
                      --! * I_FLUSH信号との違いはFLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        I_FLUSH     : --! @brief INPUT WORD FLUSH :
                      --! 最終ワード信号入力.
                      --! * 最後のワードデータ入力であることを示すフラグ.
                      --! * 基本的にはFLUSH信号と同じ働きをするが、I_FLUSH信号は
                      --!   最後のワードデータを入力する際に同時にアサートする.
                      --! * I_DONE信号との違いはFLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        I_VAL       : --! @brief INPUT WORD VALID :
                      --! 入力ワード有効信号.
                      --! * I_DATA/I_STRB/I_DONE/I_FLUSHが有効であることを示す.
                      --! * I_VAL='1'and I_RDY='1'でワードデータがキューに取り込まれる.
                      in  std_logic;
        I_RDY       : --! @brief INPUT WORD READY :
                      --! 入力レディ信号.
                      --! * キューが次のワードデータを入力出来ることを示す.
                      --! * I_VAL='1'and I_RDY='1'でワードデータがキューに取り込まれる.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側 I/F
    -------------------------------------------------------------------------------
        O_ENABLE    : --! @brief OUTPUT ENABLE :
                      --! 出力許可信号.
                      --! * この信号がアサートされている場合、キューの出力を許可する.
                      --! * この信号がネゲートされている場合、O_VAL アサートされない.
                      in  std_logic := '1';
        O_DATA      : --! @brief OUTPUT WORD DATA :
                      --! ワードデータ出力.
                      out std_logic_vector(O_WIDTH*WORD_BITS-1 downto 0);
        O_STRB      : --! @brief OUTPUT WORD ENABLE :
                      --! ワードストローブ信号出力.
                      out std_logic_vector(O_WIDTH*STRB_BITS-1 downto 0);
        O_DONE      : --! @brief OUTPUT WORD DONE :
                      --! 最終ワード信号出力.
                      --! * 最後のワードデータ出力であることを示すフラグ.
                      --! * O_FLUSH信号との違いはFLUSH_ENABLEの項を参照.
                      out std_logic;
        O_FLUSH     : --! @brief OUTPUT WORD FLUSH :
                      --! 最終ワード信号出力.
                      --! * 最後のワードデータ出力であることを示すフラグ.
                      --! * O_DONE信号との違いはFLUSH_ENABLEの項を参照.
                      out std_logic;
        O_VAL       : --! @brief OUTPUT WORD VALID :
                      --! 出力ワード有効信号.
                      --! * O_DATA/O_STRB/O_DONE/O_FLUSHが有効であることを示す.
                      --! * O_VAL='1'and O_RDY='1'でワードデータがキューから取り除かれる.
                      out std_logic;
        O_RDY       : --! @brief OUTPUT WORD READY :
                      --! 出力レディ信号.
                      --! * キューから次のワードを取り除く準備が出来ていることを示す.
                      --! * O_VAL='1'and O_RDY='1'でワードデータがキューから取り除かれる.
                      in  std_logic;
        O_SHIFT     : --! @brief OUTPUT SHIFT SIZE :
                      --! 出力シフトサイズ信号.
                      --! * キューからワードを出力する際に、何ワード取り除くかを指定する.
                      --! * O_VAL='1' and O_RDY='1'の場合にのみこの信号は有効.
                      --! * 取り除くワードの位置に'1'をセットする.
                      --! * 例) O_SHIFT_MAX=3、O_SHIFT_MIN=0の場合、    
                      --!   O_SHIFT(3 downto 0)="1111" で4ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0111" で3ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0011" で2ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0001" で1ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0000" で取り除かない.    
                      --!   上記以外の値を指定した場合は動作を保証しない.
                      --! * 例) O_SHIFT_MAX=3、O_SHIFT_MIN=2の場合、    
                      --!   O_SHIFT(3 downto 2)="11" で4ワード取り除く.    
                      --!   O_SHIFT(3 downto 2)="01" で3ワード取り除く.    
                      --!   O_SHIFT(3 downto 2)="00" で2ワード取り除く.    
                      --!   上記以外の値を指定した場合は動作を保証しない.
                      --! * 例) O_SHIFT_MAX=1、O_SHIFT_MIN=1の場合、    
                      --!   O_SHIFT(1 downto 1)="1" で2ワード取り除く.    
                      --!   O_SHIFT(1 downto 1)="0" で1ワード取り除く.
                      --! * 例) O_SHIFT_MAX=0、O_SHIFT_MIN=0の場合、    
                      --!   O_SHIFT(0 downto 0)="1" で1ワード取り除く.    
                      --!   O_SHIFT(0 downto 0)="0" で取り除かない.
                      --! * 出力ワード数(O_WIDTH)分だけ取り除きたい場合は、
                      --!   O_SHIFT_MAX=O_WIDTH、O_SHIFT_MIN=O_WIDTH、
                      --!   O_SHIFT=(others => '0') としておくと良い.
                      in  std_logic_vector(O_SHIFT_MAX downto O_SHIFT_MIN) := (others => '0')
    );
end component;
-----------------------------------------------------------------------------------
--! @brief QUEUE_ARBITER                                                         --
-----------------------------------------------------------------------------------
component QUEUE_ARBITER
    generic (
        MIN_NUM     : --! @brief REQUEST MINIMUM NUMBER :
                      --! リクエストの最小番号を指定する.
                      integer := 0;
        MAX_NUM     : --! @brief REQUEST MAXIMUM NUMBER :
                      --! リクエストの最大番号を指定する.
                      integer := 7
    );
    port (
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
        ENABLE      : --! @brief ARBITORATION ENABLE :
                      --! この調停回路を有効にするかどうかを指定する.
                      --! * 幾つかの調停回路を組み合わせて使う場合、設定によっては
                      --!  この調停回路の出力を無効にしたいことがある.
                      --!  その時はこの信号を'0'にすることで簡単に出来る.
                      --! * ENABLE='1'でこの回路は調停を行う.
                      --! * ENABLE='0'でこの回路は調停を行わない.
                      --!   この場合REQUEST信号に関係なREQUEST_OおよびGRANTは'0'になる.
                      --!   リクエストキューの中身は破棄される.
                      in  std_logic := '1';
        REQUEST     : --! @brief REQUEST INPUT :
                      --! リクエスト入力.
                      in  std_logic_vector(MIN_NUM to MAX_NUM);
        GRANT       : --! @brief GRANT OUTPUT :
                      --! 調停結果出力.
                      out std_logic_vector(MIN_NUM to MAX_NUM);
        GRANT_NUM   : --! @brief GRANT NUMBER :
                      --! 許可番号.
                      --! * ただしリクエストキューに次の要求が無い場合でも、
                      --!   なんらかの番号を出力してしまう.
                      out integer   range  MIN_NUM to MAX_NUM;
        REQUEST_O   : --! @brief REQUEST OUTOUT :
                      --! リクエストキューに次の要求があることを示す信号.
                      --! * VALIDと異なり、リクエストキューに次の要求があっても、
                      --!   対応するREQUEST信号が'0'の場合はアサートされない.
                      out std_logic;
        VALID       : --! @brief REQUEST QUEUE VALID :
                      --! リクエストキューに次の要求があることを示す信号.
                      --! * REQUEST_Oと異なり、リスエストキューに次の要求があると
                      --!   対応するREQUEST信号の状態に関わらずアサートされる.
                      out std_logic;
        SHIFT       : --! @brief REQUEST QUEUE SHIFT :
                      --! リクエストキューの先頭からリクエストを取り除く信号.
                      in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief DELAY_REGISTER                                                        --
-----------------------------------------------------------------------------------
component DELAY_REGISTER
    generic (
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(IDATA/ODATA)のビット幅を指定する.
                      integer :=  8;
        DELAY_MAX   : --! @brief DELAY CYCLE MAXIMUM :
                      --! * 入力側データ(I_DATA)を出力側に伝達する際の遅延時間の
                      --!   最大値を出力側のクロック数単位で指定する.
                      --! * 詳細は次の DELAY_MIN を参照.
                      integer := 0;
        DELAY_MIN   : --! @brief DELAY CYCLE MINIMUM :
                      --! * 入力側データ(I_DATAを出力側に伝達する際の遅延時間の
                      --!   最小値を出力側のクロック数単位で指定する.
                      --! * DELAY_MAX >= DELAY_MINでなければならない.
                      --! * DELAY_MAX = DELAY_MIN の場合は回路が簡略化される.
                      --!   この際、DELAY_SEL 信号は参照されない.
                      --! * 遅延するクロック数が多いほど、そのぶんレジスタが
                      --!   増えることに注意.
                      integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 制御/状態信号
    -------------------------------------------------------------------------------
        SEL         : --! @brief DELAY CYCLE SELECT :
                      --! 遅延サイクル選択信号.
                      --! * DELAY_MAX > DELAY_MIN の場合のみ有効.
                      --! * DELAY_MAX = DELAY_MIN の場合はこの信号は無視される.
                      in  std_logic_vector(DELAY_MAX   downto DELAY_MIN);
        D_VAL       : --! @brief DELAY VALID :
                      --! 対応する遅延レジスタに有効なデータが入っていることを示す.
                      out std_logic_vector(DELAY_MAX   downto 0);
    -------------------------------------------------------------------------------
    -- 入力側 I/F
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT WORD DATA :
                      --! 入力データ.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT WORD VALID :
                      --! 入力データ有効信号.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 出力側 I/F
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT WORD DATA :
                      --! 出力データ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT WORD VALID :
                      --! 出力データ有効信号.
                      out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief DELAY_ADJUSTER                                                        --
-----------------------------------------------------------------------------------
component DELAY_ADJUSTER
    generic (
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(IDATA/ODATA)のビット幅を指定する.
                      integer :=  8;
        DELAY_MAX   : --! @brief DELAY CYCLE MAXIMUM :
                      --! * 入力側データ(I_DATA)を出力側に伝達する際の遅延時間の
                      --!   最大値を出力側のクロック数単位で指定する.
                      --! * 詳細は次の DELAY_MIN を参照.
                      integer := 0;
        DELAY_MIN   : --! @brief DELAY CYCLE MINIMUM :
                      --! * 入力側データ(I_DATAを出力側に伝達する際の遅延時間の
                      --!   最小値を出力側のクロック数単位で指定する.
                      --! * DELAY_MAX >= DELAY_MINでなければならない.
                      --! * DELAY_MAX = DELAY_MIN の場合は回路が簡略化される.
                      --!   この際、DELAY_SEL 信号は参照されない.
                      --! * 遅延するクロック数が多いほど、そのぶんレジスタが
                      --!   増えることに注意.
                      integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 制御/状態信号
    -------------------------------------------------------------------------------
        SEL         : --! @brief DELAY CYCLE SELECT :
                      --! 遅延サイクル選択信号.
                      --! * DELAY_MAX > DELAY_MIN の場合のみ有効.
                      --! * DELAY_MAX = DELAY_MIN の場合はこの信号は無視される.
                      in  std_logic_vector(DELAY_MAX   downto DELAY_MIN);
        D_VAL       : --! @brief DELAY VALID :
                      --! DELAY_REGISTERからの状態入力.
                      --! 対応する遅延レジスタに有効なデータが入っていることを示す.
                      in  std_logic_vector(DELAY_MAX   downto 0);
    -------------------------------------------------------------------------------
    -- 入力側 I/F
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT WORD DATA :
                      --! 入力データ.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT WORD VALID :
                      --! 入力データ有効信号.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 出力側 I/F
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT WORD DATA :
                      --! 出力データ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT WORD VALID :
                      --! 出力データ有効信号.
                      out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief QUEUE_REGISTER                                                        --
-----------------------------------------------------------------------------------
component QUEUE_REGISTER
    -------------------------------------------------------------------------------
    -- ジェネリック変数
    -------------------------------------------------------------------------------
    generic (
        QUEUE_SIZE  : --! @brief QUEUE SIZE :
                      --! キューの大きさをワード数で指定する.
                      integer := 1;
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(I_DATA/O_DATA/Q_DATA)のビット幅を指定する.
                      integer :=  32;
        LOWPOWER    : --! @brief LOW POWER MODE :
                      --! キューのレジスタに不必要なロードを行わないことにより、
                      --! レジスタが不必要にトグルすることを防いで消費電力を
                      --! 下げるようにする.
                      --! ただし、回路が若干増える.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT DATA  :
                      --! 入力データ信号.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT DATA VALID :
                      --! 入力データ有効信号.
                      in  std_logic;
        I_RDY       : --! @brief INPUT READY :
                      --! 入力可能信号.
                      --! キューが空いていて、入力データを受け付けることが可能で
                      --! あることを示す信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT DATA :
                      --! 出力データ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT DATA VALID :
                      --! キューレジスタに有効なデータが入っている事を示すフラグ.
                      --! * キューレジスタは1〜QUEUE_SIZEまであるが、対応する位置の
                      --!   フラグが'1'ならば有効なデータが入っている事を示す.
                      --! * この出力信号の範囲が1からではなく0から始まっている事に
                      --!   注意. これはQUEUE_SIZE=0の場合に対応するため.
                      --!   QUEUE_SIZE>0の場合は、O_VAL(0)はO_VAL(1)と同じ.
                      out std_logic_vector(QUEUE_SIZE  downto 0);
        Q_DATA      : --! @brief OUTPUT REGISTERD DATA :
                      --! レジスタ出力の出力データ.
                      --! 出力データ(O_DATA)をクロックで叩いたもの.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        Q_VAL       : --! @brief OUTPUT REGISTERD DATA VALID :
                      --! キューレジスタに有効なデータが入っている事を示すフラグ.
                      --! O_VALをクロックで叩いたもの.
                      --! * キューレジスタは1〜QUEUE_SIZEまであるが、対応する位置の
                      --!   フラグが'1'ならば有効なデータが入っている事を示す.
                      --! * この出力信号の範囲が1からではなく0から始まっている事に
                      --!   注意. これはQUEUE_SIZE=0の場合に対応するため.
                      --!   QUEUE_SIZE>0の場合は、Q_VAL(0)はQ_VAL(1)と同じ.
                      out std_logic_vector(QUEUE_SIZE  downto 0);
        Q_RDY       : --! @brief OUTPUT READY :
                      --! 出力可能信号.
                      in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief QUEUE_RECEIVER                                                        --
-----------------------------------------------------------------------------------
component QUEUE_RECEIVER
    -------------------------------------------------------------------------------
    -- ジェネリック変数
    -------------------------------------------------------------------------------
    generic (
        QUEUE_SIZE  : --! @brief QUEUE SIZE :
                      --! キューの大きさをワード数で指定する.
                      --! 構造上、キューの大きさは２以上でなければならない.
                      integer range 2 to 256 := 2;
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(I_DATA/O_DATA/Q_DATA)のビット幅を指定する.
                      integer :=  32
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側
    -------------------------------------------------------------------------------
        I_ENABLE    : --! @brief INPUT ENABLE :
                      --! 入力許可信号.
                      in  std_logic;
        I_DATA      : --! @brief INPUT DATA  :
                      --! 入力データ信号.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT DATA VALID :
                      --! 入力データ有効信号.
                      in  std_logic;
        I_RDY       : --! @brief INPUT READY :
                      --! 入力可能信号.
                      --! キューが空いていて、入力データを受け付けることが可能で
                      --! あることを示す信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT DATA :
                      --! 出力データ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT DATA VALID :
                      --! キューレジスタに有効なデータが入っている事を示すフラグ.
                      out std_logic;
        O_RDY       : --! @brief OUTPUT READY :
                      --! 出力可能信号.
                      in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief LEAST_RECENTLY_USED_SELECTOR                                          --
-----------------------------------------------------------------------------------
component LEAST_RECENTLY_USED_SELECTOR
    generic (
        ENTRY_SIZE  : --! @brief ENTRY SIZE :
                      --! エントリの数を指定する.
                      integer := 4
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- エントリ指定信号
    -------------------------------------------------------------------------------
        I_SEL       : --! @brief INPUT SELECTED ENTRY :
                      --! 選択したエントリを One-Hot で指定する.
                      --! * 選択したエントリに対応したビット位置に'1'に設定する.
                      --! * 同時に複数のエントリを指定することは出来ない.
                      in  std_logic_vector(ENTRY_SIZE-1 downto 0);
    -------------------------------------------------------------------------------
    -- エントリ出力信号
    -------------------------------------------------------------------------------
        O_SEL       : --! @brief OUTPUT LEAST RECENTLY USED ENTRY :
                      --! 最も過去に選択したエントリを出力.
                      --! * 最も過去に選択したエントリのビット位置に'1'が出力される.
                      --! * 同時に複数のエントリが選択されることはない.
                      out std_logic_vector(ENTRY_SIZE-1 downto 0);
        Q_SEL       : --! @brief REGISTERD OUTPUT LEAST RECENTLY USED ENTRY :
                      --! 最も過去に選択したエントリを出力.
                      --! * O_SEL信号を一度レジスタで叩いた結果を出力する.
                      out std_logic_vector(ENTRY_SIZE-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief SYNCRONIZER                                                           --
-----------------------------------------------------------------------------------
component SYNCRONIZER
    generic (
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(IDATA/ODATA)のビット幅を指定する.
                      integer :=  8;
        VAL_BITS    : --! @brief VALID BITS :
                      --! データ有効信号(IVAL/OVAL)のビット幅を指定する.
                      integer :=  1;
        I_CLK_RATE  : --! @brief INPUT CLOCK RATE :
                      --! O_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する. 詳細は O_CLK_RATE を参照.
                      integer :=  1;
        O_CLK_RATE  : --! @brief OUTPUT CLOCK RATE :
                      --! I_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する.
                      --! * I_CLK_RATE = 0 かつ O_CLK_RATE = 0 の場合は I_CLK と 
                      --!   O_CLK は非同期.
                      --! * I_CLK_RATE = 1 かつ O_CLK_RATE = 1 の場合は I_CLK と 
                      --!   O_CLK は完全に同期している.
                      --! * I_CLK_RATE > 1 かつ O_CLK_RATE = 1 の場合は I_CLK は 
                      --!   O_CLK のI_CLK_RATE倍の周波数.
                      --!   ただし I_CLK の立上りは O_CLK の立上りと一致している.
                      --! * I_CLK_RATE = 1 かつ O_CLK_RATE > 1 の場合は O_CLK は 
                      --!   I_CLK の O_CLK_RATE倍の周波数.
                      --!   ただし I_CLK の立上りは O_CLK の立上りと一致している.
                      --! * 例1)I_CLK_RATE=1 & O_CLK_RATE=1          \n
                      --!       I_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --!       O_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --! * 例2)I_CLK_RATE=2 & O_CLK_RATE=1          \n
                      --!       I_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --!       O_CLK _|~~~|___|~~~|___|~~~|___|~~~  \n
                      --!       I_CKE ~~~|___|~~~|___|~~~|___|~~~|_  \n
                      --! * 例3)I_CLK_RATE=3 & O_CLK_RATE=1          \n
                      --!       I_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --!       O_CLK _|~~~~~|_____|~~~~~|_____|~~~  \n
                      --!       I_CKE ~~~|_______|~~~|_______|~~~|_  \n
                      --! * 例4)I_CLK_RATE=1 & O_CLK_RATE=2          \n
                      --!       I_CLK _|~~~|___|~~~|___|~~~|___|~~~  \n
                      --!       O_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --!       O_CKE ~~~|___|~~~|___|~~~|___|~~~|_  \n
                      integer :=  1;
        I_CLK_FLOP  : --! @brief INPUT CLOCK FLOPPING :
                      --! 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)が非同期
                      --! の場合に、出力側のFFからの制御信号を入力側のFFで叩く段数
                      --! を指定する.
                      --! * FFで叩くのはメタステーブルの発生による誤動作を防ぐため.
                      --!   メタステーブルの意味が分からない人は、この変数を変更す
                      --!   るのはやめたほうがよい。
                      integer range 0 to 2 := 2;
        O_CLK_FLOP  : --! @brief OUTPUT CLOCK FLOPPING :
                      --! 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)が非同期
                      --! の場合に、入力側のFFからの制御信号を出力側のFFで叩く段数
                      --! を指定する.
                      --! * FFで叩くのはメタステーブルの発生による誤動作を防ぐため.
                      --!   メタステーブルの意味が分からない人は、この変数を変更す
                      --!   るのはやめたほうがよい.
                      integer range 0 to 2 := 2;
        I_CLK_FALL  : --! @brief USE INPUT CLOCK FALL :
                      --! 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)が非同期
                      --! の場合に、入力側のクロック(I_CLK)の立ち下がりを使うかどう
                      --! かを指定する.
                      --! * この変数は後方互換性のために存在する. 現在は未使用.
                      --! * I_CLK_FALL = 0 の場合は使わない.
                      --! * I_CLK_FALL = 1 の場合は使う.
                      integer range 0 to 1 :=  0;
        O_CLK_FALL  : --! @brief USE OUTPUT CLOCK FALL :
                      --! 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)が非同期
                      --! の場合に、出力側のクロック(OCLK)の立ち下がりを使うかどう
                      --! かを指定する.
                      --! * O_CLK_FALL = 0 の場合は使わない.
                      --! * O_CLK_FALL = 1 の場合は使う.
                      integer range 0 to 1 :=  0;
        O_CLK_REGS  : --! @brief REGISTERD OUTPUT :
                      --! 出力側の各種信号(O_VAL/O_DATA)をレジスタ出力するかどうか
                      --! を指定する.
                      --! * この変数は I_CLK_RATE > 0 の場合のみ有効. 
                      --!   I_CLK_RATE = 0 の場合は、常にレジスタ出力になる.
                      --! * O_CLK_REGS = 0 の場合はレジスタ出力しない.
                      --! * O_CLK_REGS = 1 の場合はレジスタ出力する.
                      integer range 0 to 1 :=  0
    );
    port (
    -------------------------------------------------------------------------------
    -- リセット信号
    -------------------------------------------------------------------------------
        RST         : --! @brief RESET :
                      --! 非同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        I_CLK       : --! @brief INPUT CLOCK :
                      --! 入力側のクロック信号.
                      in  std_logic;
        I_CLR       : --! @brief INPUT CLEAR :
                      --! 入力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側の制御信号
    -------------------------------------------------------------------------------
        I_CKE       : --! @brief INPUT CLOCK ENABLE :
                      --! 入力側のクロック(I_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とOCLKの立上り時が同じ時にアサートするよ
                      --!   うに入力されなければならない.
                      --! * この信号は I_CLK_RATE > 1 かつ O_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側のデータ信号/有効信号/可能信号
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT DATA :
                      --! 入力データ.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT VALID :
                      --! 入力有効信号.
                      --! * この信号がアサートされている時はI_DATAに有効なデータが
                      --!   入力されていなければならない。
                      in  std_logic_vector(VAL_BITS -1 downto 0);
        I_RDY       : --! @brief INPUT READY :
                      --! 入力可能信号.
                      --! * この信号がアサートされている場合にのみ、I_VAL,I_DATAを
                      --!   受け付けて、出力側に転送する.
                      --! * この信号がネゲートされている場合は、I_VAL,I_DATAは無視
                      --!   される.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側のクロック
    -------------------------------------------------------------------------------
        O_CLK       : --! @brief OUTPUT CLK :
                      --! 出力側のクロック信号.
                      in  std_logic;
        O_CLR       : --! @brief OUTPUT CLEAR :
                      --! 出力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 出力側の制御信号
    -------------------------------------------------------------------------------
        O_CKE       : --! @brief OUTPUT CLOCK ENABLE :
                      --! 出力側のクロック(O_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とO_CLKの立上り時が同じ時にアサートする
                      --!   ように入力されなければならない.
                      --! * この信号は O_CLK_RATE > 1 かつ I_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 出力側のデータ信号/有効信号
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT DATA :
                      --! 出力データ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT VALID :
                      --! 出力有効信号.
                      --! * この信号がアサートされている時はODATAに有効なデータが出
                      --!   力されていることを示す.
                      out std_logic_vector(VAL_BITS -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief SYNCRONIZER_INPUT_PENDING_REGISTER                                    --
-----------------------------------------------------------------------------------
component SYNCRONIZER_INPUT_PENDING_REGISTER
    generic (
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(IDATA/ODATA)のビット幅を指定する.
                      integer :=  8;
        OPERATION   : --! @brief PENDING OPERATION :
                      --! ペンディング(出力待ち)時に次のIVALがアサートされた時に
                      --! データをどう扱うを指定する.
                      --! * OPERATION = 0 の場合は常に新しい入力データで上書きされる. 
                      --! * OPERATION = 1 の場合は入力データ(IDATA)と
                      --!   ペンディングデータとをビット単位で論理和して
                      --!   新しいペンディングデータとする.
                      --!   主に入力データがフラグ等の場合に使用する.
                      --! * OPERATION = 2 の場合は入力データ(IDATA)と
                      --!   ペンディングデータとを加算して
                      --!   新しいペンディングデータとする.
                      --!   主に入力データがカウンタ等の場合に使用する.
                      integer range 0 to 2 := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側 I/F
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT DATA :
                      --! 入力データ.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT VALID :
                      --! 入力有効信号.
                      --! * この信号がアサートされている時はI_DATAに有効なデータが
                      --!   入力されていなければならない。
                      in  std_logic;
        I_PAUSE     : --! @brief INPUT PAUSE :
                      --! * 入力側の情報(I_VAL,I_DATA)を、出力側(O_VAL,O_DATA)に
                      --!   出力するのを一時的に中断する。
                      --! * この信号がアサートされている間に入力された入力側の情報(
                      --!   I_VAL,I_DATA)は、出力側(O_VAL,O_DATA)には出力されず、
                      --!   ペンディングレジスタに保持される。
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側(PENDING) I/F
    -------------------------------------------------------------------------------
        P_DATA      : --! @brief PENDING DATA :
                      --! 現在ペンディング中のデータ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        P_VAL       : --! @brief PENDING VALID :
                      --! 現在ペンディング中のデータがあることを示すフラグ.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側 I/F
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT DATA :
                      --! 出力データ.
                      --! * SYNCRONIZERのI_DATAに接続する.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT VALID :
                      --! 出力有効信号.
                      --! * SYNCRONIZERのI_VALに接続する.
                      --! * この信号がアサートされている時はO_DATAに有効なデータが
                      --!   出力されていることを示す.
                      out std_logic;
        O_RDY       : --! @brief OUTPUT READY :
                      --! 出力許可信号.
                      --! * SYNCRONIZERのI_RDYに接続する.
                      in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief SDPRAM                                                                --
-----------------------------------------------------------------------------------
component SDPRAM
    generic (
        DEPTH   : --! @brief SDPRAM DEPTH :
                  --! メモリの深さ(ビット単位)を2のべき乗値で指定する.
                  --! 例 DEPTH=10 => 2**10=1024bit
                  integer := 10;
        RWIDTH  : --! @brief SDPRAM READ DATA PORT WIDTH :
                  --! リードデータ(RDATA)の幅(ビット数)を2のべき乗値で指定する.
                  --! 例 RWIDTH=5 => 2**5=32bit
                  integer := 5;   
        WWIDTH  : --! @brief SDPRAM WRITE DATA PORT WIDTH :
                  --! ライトデータ(WDATA)の幅(ビット数)を2のべき乗値で指定する.
                  integer := 6;   
        WEBIT   : --! @brief SDPRAM WRITE ENABLE WIDTH :
                  --! ライトイネーブル信号(WE)の幅(ビット数)を2のべき乗値で指定する.
                  --! 例 WEBIT=0 => 2**0=1bit
                  --!    WEBIT=2 => 2**2=4bit
                  integer := 0;
        ID      : --! @brief SDPRAM IDENTIFIER :
                  --! どのモジュールで使われているかを示す識別番号.
                  integer := 0 
    );
    port (
        WCLK    : --! @brief WRITE CLOCK :
                  --! ライトクロック信号
                  in  std_logic;
        WE      : --! @brief WRITE ENABLE :
                  --! ライトイネーブル信号
                  in  std_logic_vector(2**WEBIT-1 downto 0);
        WADDR   : --! @brief WRITE ADDRESS :
                  --! ライトアドレス信号
                  in  std_logic_vector(DEPTH-1 downto WWIDTH);
        WDATA   : --! @brief WRITE DATA :
                  --! ライトデータ信号
                  in  std_logic_vector(2**WWIDTH-1 downto 0);
        RCLK    : --! @brief READ CLOCK :
                  --! リードクロック信号
                  in  std_logic;
        RADDR   : --! @brief READ ADDRESS :
                  --! リードアドレス信号
                  in  std_logic_vector(DEPTH-1 downto RWIDTH);
        RDATA   : --! @brief READ DATA :
                  --! リードデータ信号
                  out std_logic_vector(2**RWIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief COUNT_DOWN_REGISTER                                                   --
-----------------------------------------------------------------------------------
component COUNT_DOWN_REGISTER
    generic (
        VALID       : --! @brief COUNTER VALID :
                      --! このカウンターを有効にするかどうかを指定する.
                      --! * VALID=0 : このカウンターは常に無効.
                      --! * VALID=1 : このカウンターは常に有効.
                      integer range 0 to 1 := 1;
        BITS        : --! @brief  COUNTER BITS :
                      --! カウンターのビット数を指定する.
                      --! * BIT=0の場合、このカウンターは常に無効になる.
                      integer := 32;
        REGS_BITS   : --! @brief REGISTER ACCESS INTERFACE BITS :
                      --! レジスタアクセスインターフェースのビット数を指定する.
                      integer := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- レジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        REGS_WEN    : --! @brief REGISTER WRITE ENABLE :
                      --! カウンタレジスタ書き込み制御信号.
                      --! * 書き込みを行うビットに'1'をセットする.  
                      --!   この信号に１がセットされたビットの位置に、REGS_DINの値
                      --!   がカウンタレジスタにセットされる.
                      in  std_logic_vector(REGS_BITS-1 downto 0);
        REGS_WDATA  : --! @brief REGISTER WRITE DATA :
                      --! カウンタレジスタ書き込みデータ.
                      in  std_logic_vector(REGS_BITS-1 downto 0);
        REGS_RDATA  : --! @brief REGISTER READ DATA :
                      --! カウンタレジスタ読み出しデータ.
                      out std_logic_vector(REGS_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- カウントインターフェース
    -------------------------------------------------------------------------------
        DN_ENA      : --! @brief COUNT DOWN ENABLE :
                      --! カウントダウン許可信号.
                      --! * この信号が'1'の場合、DN_VAL信号およびDN_SIZE信号による
                      --!   カウントダウンが許可される.
                      --! * この信号が'1'の場合、REGS_WEN信号およびREGS_WDATA信号に
                      --!   よるレジスタ書き込みは無視される.
                      --! * この信号が'0'の場合、DN_VAL信号およびDN_SIZE信号による
                      --!   カウントダウンは無視される.
                      in  std_logic;
        DN_VAL      : --! @brief COUNT DOWN SIZE VALID :
                      --! カウントダウン有効信号.
                      --! * この信号が'1'の場合、DN_SIZEで指定された数だけカウンタ
                      --!   ーの値がアップする.
                      in  std_logic;
        DN_SIZE     : --! @brief COUNT DOWN SIZE :
                      --! カウントダウンサイズ信号.
                      in  std_logic_vector;
    -------------------------------------------------------------------------------
    -- カウンター出力
    -------------------------------------------------------------------------------
        COUNTER     : --! @brief COUNTER OUTPUT :
                      --! カウンタの値を出力.
                      out std_logic_vector;
        ZERO        : --! @brief COUNTER ZERO FLAG :
                      --! カウンタの値が0になったことを示すフラグ.
                      out std_logic;
        NEG         : --! @brief COUNTER ZERO FLAG :
                      --! カウンタの値が負になりそうだったことを示すフラグ.
                      --! * このフラグはDN_ENA信号が'1'の時のみ有効.
                      --! * このフラグはDN_ENA信号が'0'の時はクリアされる.
                      out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief COUNT_UP_REGISTER                                                     --
-----------------------------------------------------------------------------------
component COUNT_UP_REGISTER
    generic (
        VALID       : --! @brief COUNTER VALID :
                      --! このカウンターを有効にするかどうかを指定する.
                      --! * VALID=0 : このカウンターは常に無効.
                      --! * VALID=1 : このカウンターは常に有効.
                      integer range 0 to 1 := 1;
        BITS        : --! @brief  COUNTER BITS :
                      --! カウンターのビット数を指定する.
                      --! * BIT=0の場合、このカウンターは常に無効になる.
                      integer := 32;
        REGS_BITS   : --! @brief REGISTER ACCESS INTERFACE BITS :
                      --! レジスタアクセスインターフェースのビット数を指定する.
                      integer := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- レジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        REGS_WEN    : --! @brief REGISTER WRITE ENABLE :
                      --! カウンタレジスタ書き込み制御信号.
                      --! * 書き込みを行うビットに'1'をセットする.  
                      --!   この信号に１がセットされたビットの位置に、REGS_DINの値
                      --!   がカウンタレジスタにセットされる.
                      in  std_logic_vector(REGS_BITS-1 downto 0);
        REGS_WDATA  : --! @brief REGISTER WRITE DATA :
                      --! カウンタレジスタ書き込みデータ.
                      in  std_logic_vector(REGS_BITS-1 downto 0);
        REGS_RDATA  : --! @brief REGISTER READ DATA :
                      --! カウンタレジスタ読み出しデータ.
                      out std_logic_vector(REGS_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- カウントインターフェース
    -------------------------------------------------------------------------------
        UP_ENA      : --! @brief COUNT UP ENABLE :
                      --! カウントアップ許可信号.
                      --! * この信号が'1'の場合、UP_VAL信号およびUP_SIZE信号による
                      --!   カウントアップが許可される.
                      --! * この信号が'1'の場合、REGS_WEN信号およびREGS_WDATA信号に
                      --!   よるレジスタ書き込みは無視される.
                      --! * この信号が'0'の場合、UP_VAL信号およびUP_SIZE信号による
                      --!   カウントアップは無視される.
                      in  std_logic;
        UP_VAL      : --! @brief COUNT UP SIZE VALID :
                      --! カウントアップ有効信号.
                      --! * この信号が'1'の場合、UP_SIZEで指定された数だけカウンタ
                      --!   ーの値がアップする.
                      in  std_logic;
        UP_BEN      : --! @brief COUNT UP BIT ENABLE :
                      --! カウントアップビット有効信号.
                      --! * この信号が'1'の位置のビットのみ、カウンタアップを有効に
                      --!   する.
                      in  std_logic_vector;
        UP_SIZE     : --! @brief COUNT UP SIZE :
                      --! カウントアップサイズ信号.
                      in  std_logic_vector;
    -------------------------------------------------------------------------------
    -- カウンター出力
    -------------------------------------------------------------------------------
        COUNTER     : --! @brief COUNTER OUTPUT :
                      --! カウンタの値を出力.
                      out std_logic_vector
    );
end component;
-----------------------------------------------------------------------------------
--! @brief POOL_INTAKE_PORT                                                      --
-----------------------------------------------------------------------------------
component POOL_INTAKE_PORT
    generic (
        UNIT_BITS       : --! @brief UNIT BITS :
                          --! イネーブル信号(PORT_DVAL,POOL_DVAL)、
                          --! ポインタ(POOL_PTR)のサイズカウンタ(PUSH_SIZE)の
                          --! 基本単位をビット数で指定する.
                          --! 普通はUNIT_BITS=8(８ビット単位)にしておく.
                          integer := 8;
        WORD_BITS       : --! @brief WORD BITS :
                          --! １ワードのデータのビット数を指定する.
                          integer := 8;
        PORT_DATA_BITS  : --! @brief INTAKE PORT DATA BITS :
                          --! PORT_DATA のビット数を指定する.
                          integer := 32;
        POOL_DATA_BITS  : --! @brief POOL BUFFER DATA BITS :
                          --! POOL_DATA のビット数を指定する.
                          integer := 32;
        SEL_BITS        : --! @brief SELECT BITS :
                          --! XFER_SEL、PUSH_VAL、POOL_WEN のビット数を指定する.
                          integer := 1;
        SIZE_BITS       : --! @brief POOL_SIZE BITS :
                          --! POOL_SIZE のビット数を指定する.
                          integer := 16;
        PTR_BITS        : --! @brief POOL BUFFER POINTER BITS:
                          --! START_PTR、POOL_PTR のビット数を指定する.
                          integer := 16;
        QUEUE_SIZE      : --! @brief QUEUE SIZE :
                          --! キューの大きさをワード数で指定する.
                          --! * QUEUE_SIZE=0を指定した場合は、キューの深さは自動的に
                          --!   (PORT_DATA_BITS/WORD_BITS)+(POOL_DATA_BITS/WORD_BITS)
                          --!   に設定される.
                          integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        START           : --! @brief START :
                          --! 開始信号.
                          --! * この信号はSTART_PTR/XFER_LAST/XFER_SELを内部に設定
                          --!   してこのモジュールを初期化しする.
                          --! * 最初にデータ入力と同時にアサートしても構わない.
                          in  std_logic;
        START_PTR       : --! @brief START POOL BUFFER POINTER :
                          --! 書き込み開始ポインタ.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(PTR_BITS-1 downto 0);
        XFER_LAST       : --! @brief TRANSFER LAST :
                          --! 最後のトランザクションであることを示すフラグ.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic;
        XFER_SEL        : --! @brief TRANSFER SELECT :
                          --! 選択信号. PUSH_VAL、POOL_WENの生成に使う.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(SEL_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Intake Port Signals.
    -------------------------------------------------------------------------------
        PORT_ENABLE     : --! @brief INTAKE PORT ENABLE :
                          --! 動作許可信号.
                          --! * この信号がアサートされている場合、キューの入出力を
                          --!   許可する.
                          --! * この信号がネゲートされている場合、PORT_RDY はアサー
                          --!   トされない.
                          in  std_logic := '1';
        PORT_DATA       : --! @brief INTAKE PORT DATA :
                          --! ワードデータ入力.
                          in  std_logic_vector(PORT_DATA_BITS-1 downto 0);
        PORT_DVAL       : --! @brief INTAKE PORT DATA VALID :
                          --! ポートからデータを入力する際のユニット単位での有効信号.
                          in  std_logic_vector(PORT_DATA_BITS/UNIT_BITS-1 downto 0);
        PORT_ERROR      : --! @brief INTAKE PORT ERROR :
                          --! データ入力中にエラーが発生したことを示すフラグ.
                          in  std_logic;
        PORT_LAST       : --! @brief INTAKE DATA LAST :
                          --! 最終ワード信号入力.
                          --! * 最後のワードデータ入力であることを示すフラグ.
                          in  std_logic;
        PORT_VAL        : --! @brief INTAKE PORT VALID :
                          --! 入力ワード有効信号.
                          --! * PORT_DATA/PORT_DVAL/PORT_LAST/PORT_ERRが有効であることを示す.
                          --! * PORT_VAL='1'and PORT_RDY='1'で上記信号がキューに取り込まれる.
                          in  std_logic;
        PORT_RDY        : --! @brief INTAKE PORT READY :
                          --! 入力レディ信号.
                          --! * キューが次のワードデータを入力出来ることを示す.
                          --! * PORT_VAL='1'and PORT_RDY='1'で上記信号がキューに取り込まれる.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- Push Size Signals.
    -------------------------------------------------------------------------------
        PUSH_VAL        : --! @brief PUSH VALID: 
                          --! PUSH_LAST/PUSH_ERROR/PUSH_SIZEが有効であることを示す信号.
                          out std_logic_vector(SEL_BITS-1 downto 0);
        PUSH_LAST       : --! @brief PUSH LAST : 
                          --! 最後の転送"した"ワードであることを示すフラグ.
                          out std_logic;
        PUSH_XFER_LAST  : --! @brief PUSH TRANSFER LAST :
                          --! 最後のトランザクションであることを示すフラグ.
                          out std_logic;
        PUSH_XFER_DONE  : --! @brief PUSH TRANSFER DONE :
                          --! 最後のトランザクションの最後の転送"した"ワードである
                          --! ことを示すフラグ.
                          out std_logic;
        PUSH_ERROR      : --! @brief PUSH ERROR : 
                          --! 転送"した事"がエラーだった事を示すフラグ.
                          out std_logic;
        PUSH_SIZE       : --! @brief PUSH SIZE :
                          --! 転送"した"バイト数を出力する.
                          out std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Pool Buffer Interface Signals.
    -------------------------------------------------------------------------------
        POOL_WEN        : --! @brief POOL BUFFER WRITE ENABLE :
                          --! バッファにデータをライトすることを示す.
                          out std_logic_vector(SEL_BITS-1 downto 0);
        POOL_DVAL       : --! @brief POOL BUFFER DATA VALID :
                          --! バッファにデータをライトする際のユニット単位での有効
                          --! 信号.
                          --! * POOL_WEN='1'の場合にのみ有効.
                          --! * POOL_WEN='0'の場合のこの信号の値は不定.
                          out std_logic_vector(POOL_DATA_BITS/UNIT_BITS-1 downto 0);
        POOL_DATA       : --! @brief POOL BUFFER WRITE DATA :
                          --! バッファへライトするデータを出力する.
                          out std_logic_vector(POOL_DATA_BITS-1 downto 0);
        POOL_PTR        : --! @brief POOL BUFFER WRITE POINTER :
                          --! ライト時にデータを書き込むバッファの位置を出力する.
                          out std_logic_vector(PTR_BITS-1 downto 0);
        POOL_RDY        : --! @brief POOL BUFFER WRITE READY :
                          --! バッファにデータを書き込み可能な事をを示す.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Status Signals.
    -------------------------------------------------------------------------------
        BUSY            : --! @brief QUEUE BUSY :
                          --! キューが動作中であることを示す信号.
                          --! * 最初にデータが入力されたときにアサートされる.
                          --! * 最後のデータが出力し終えたらネゲートされる.
                          out  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief POOL_OUTLET_PORT                                                      --
-----------------------------------------------------------------------------------
component POOL_OUTLET_PORT
    generic (
        UNIT_BITS       : --! @brief UNIT BITS :
                          --! イネーブル信号(PORT_DVAL,POOL_DVAL)、
                          --! ポインタ(POOL_PTR)のサイズカウンタ(PUSH_SIZE)の
                          --! 基本単位をビット数で指定する.
                          --! 普通はUNIT_BITS=8(８ビット単位)にしておく.
                          integer := 8;
        WORD_BITS       : --! @brief WORD BITS :
                          --! １ワードのデータのビット数を指定する.
                          integer := 8;
        PORT_DATA_BITS  : --! @brief OUTLET PORT DATA BITS :
                          --! PORT_DATA のビット数を指定する.
                          integer := 32;
        POOL_DATA_BITS  : --! @brief POOL BUFFER DATA BITS :
                          --! POOL_DATA のビット数を指定する.
                          integer := 32;
        PORT_PTR_BITS   : --! @brief PORT POINTER BITS:
                          --! START_PORT_PTR のビット数を指定する.
                          integer := 16;
        POOL_PTR_BITS   : --! @brief POOL BUFFER POINTER BITS:
                          --! START_POOL_PTR、POOL_PTR のビット数を指定する.
                          integer := 16;
        SEL_BITS        : --! @brief SELECT BITS :
                          --! XFER_SEL、PUSH_VAL、POOL_WEN のビット数を指定する.
                          integer := 1;
        SIZE_BITS       : --! @brief PORT_SIZE BITS :
                          --! PORT_SIZE のビット数を指定する.
                          integer := 16;
        POOL_SIZE_VALID : --! @brief POOL_SIZE VALID :
                          --! POOL_SIZE が有効が有効かどうかを指定する.
                          --! * POOL_SIZE_VALID=0の場合、POOL_SIZE 信号は無効。
                          --!   この場合、入力ユニット数は POOL_DVAL 信号から生成さ
                          --!   れる.
                          integer := 1;
        QUEUE_SIZE      : --! @brief QUEUE SIZE :
                          --! キューの大きさをワード数で指定する.
                          --! * QUEUE_SIZE<0 かつ PORT_DATA_BITS=WORD_BITS かつ
                          --!   POOL_DATA_BITS=WORD_BITS の場合、キューは生成しない.
                          --! * QUEUE_SIZE=0を指定した場合は、キューの深さは自動的に
                          --!   (PORT_DATA_BITS/WORD_BITS)+(POOL_DATA_BITS/WORD_BITS)
                          --!   に設定される.
                          integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        START           : --! @brief START :
                          --! 開始信号.
                          --! * この信号はSTART_PTR/XFER_LAST/XFER_SELを内部に設定
                          --!   してこのモジュールを初期化しする.
                          --! * 最初にデータ入力と同時にアサートしても構わない.
                          in  std_logic;
        START_POOL_PTR  : --! @brief START POOL BUFFER POINTER :
                          --! 書き込み開始ポインタ.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(POOL_PTR_BITS-1 downto 0);
        START_PORT_PTR  : --! @brief START PORT POINTER :
                          --! 書き込み開始ポインタ.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(PORT_PTR_BITS-1 downto 0);
        XFER_LAST       : --! @brief TRANSFER LAST :
                          --! 最後のトランザクションであることを示すフラグ.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic;
        XFER_SEL        : --! @brief TRANSFER SELECT :
                          --! 選択信号. PUSH_VAL、POOL_WENの生成に使う.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(SEL_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Outlet Port Signals.
    -------------------------------------------------------------------------------
        PORT_DATA       : --! @brief OUTLET PORT DATA :
                          --! ワードデータ出力.
                          out std_logic_vector(PORT_DATA_BITS-1 downto 0);
        PORT_DVAL       : --! @brief OUTLET PORT DATA VALID :
                          --! ポートからデータを出力する際のユニット単位での有効信号.
                          out std_logic_vector(PORT_DATA_BITS/UNIT_BITS-1 downto 0);
        PORT_LAST       : --! @brief OUTLET DATA LAST :
                          --! 最終ワード信号出力.
                          --! * 最後のワードデータ出力であることを示すフラグ.
                          out std_logic;
        PORT_ERROR      : --! @brief OUTLET ERROR :
                          --! エラー出力
                          --! * エラーが発生したことをし示すフラグ.
                          out std_logic;
        PORT_SIZE       : --! @brief OUTLET DATA SIZE :
                          --! 出力バイト数
                          --! * ポートからのデータの出力ユニット数.
                          out std_logic_vector(SIZE_BITS-1 downto 0);
        PORT_VAL        : --! @brief OUTLET PORT VALID :
                          --! 出力ワード有効信号.
                          --! * PORT_DATA/PORT_DVAL/PORT_LAST/PORT_SIZEが有効である
                          --!   ことを示す.
                          out std_logic;
        PORT_RDY        : --! @brief OUTLET PORT READY :
                          --! 出力レディ信号.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Pull Size Signals.
    -------------------------------------------------------------------------------
        PULL_VAL        : --! @brief PULL VALID: 
                          --! PULL_LAST/PULL_ERR/PULL_SIZEが有効であることを示す.
                          out std_logic_vector(SEL_BITS-1 downto 0);
        PULL_LAST       : --! @brief PULL LAST : 
                          --! 最後の入力"した事"を示すフラグ.
                          out std_logic;
        PULL_XFER_LAST  : --! @brief PULL TRANSFER LAST :
                          --! 最後のトランザクションであることを示すフラグ.
                          out std_logic;
        PULL_XFER_DONE  : --! @brief PULL TRANSFER DONE :
                          --! 最後のトランザクションの最後の転送"した"ワードである
                          --! ことを示すフラグ.
                          out std_logic;
        PULL_ERROR      : --! @brief PULL ERROR : 
                          --! エラーが発生したことをし示すフラグ.
                          out std_logic;
        PULL_SIZE       : --! @brief PUSH SIZE :
                          --! 入力"した"バイト数を出力する.
                          out std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Pool Buffer Interface Signals.
    -------------------------------------------------------------------------------
        POOL_REN        : --! @brief POOL BUFFER READ ENABLE :
                          --! バッファからデータをリードすることを示す.
                          out std_logic_vector(SEL_BITS-1 downto 0);
        POOL_PTR        : --! @brief POOL BUFFER WRITE POINTER :
                          --! リード時にデータをリードするバッファの位置を出力する.
                          out std_logic_vector(POOL_PTR_BITS-1 downto 0);
        POOL_DATA       : --! @brief POOL BUFFER WRITE DATA :
                          --! バッファからリードされたデータを入力する.
                          in  std_logic_vector(POOL_DATA_BITS-1 downto 0);
        POOL_DVAL       : --! @brief POOL BUFFER DATA VALID :
                          --! バッファからデータをリードする際のユニット単位での
                          --! 有効信号.
                          in  std_logic_vector(POOL_DATA_BITS/UNIT_BITS-1 downto 0);
        POOL_SIZE       : --! @brief POOL BUFFER DATA SIZE :
                          --! 入力バイト数
                          --! * バッファからのデータの入力ユニット数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
        POOL_ERROR      : --! @brief POOL BUFFER ERROR :
                          --! データ転送中にエラーが発生したことを示すフラグ.
                          in  std_logic;
        POOL_LAST       : --! @brief POOL BUFFER DATA LAST :
                          --! 最後の入力データであることを示す.
                          in  std_logic;
        POOL_VAL        : --! @brief POOL BUFFER DATA VALID :
                          --! バッファからリードしたデータが有効である事を示す信号.
                          in  std_logic;
        POOL_RDY        : --! @brief POOL BUFFER WRITE READY :
                          --! バッファからデータを読み込み可能な事をを示す.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- Status Signals.
    -------------------------------------------------------------------------------
        POOL_BUSY       : --! @brief POOL BUFFER BUSY :
                          --! バッファからデータリード中であることを示す信号.
                          --! * START信号がアサートされたときにアサートされる.
                          --! * 最後のデータが入力されたネゲートされる.
                          out std_logic;
        POOL_DONE       : --! @brief POOL BUFFER DONE :
                          --! 次のクロックで POOL_BUSY がネゲートされることを示す.
                          out std_logic;
        BUSY            : --! @brief QUEUE BUSY :
                          --! キューが動作中であることを示す信号.
                          --! * START信号がアサートされたときにアサートされる.
                          --! * 最後のデータが出力し終えたらネゲートされる.
                          out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief FLOAT_INTAKE_VALVE                                                    --
-----------------------------------------------------------------------------------
component FLOAT_INTAKE_VALVE
    generic (
        COUNT_BITS      : --! @brief COUNTER BITS :
                          --! 内部カウンタのビット数を指定する.
                          integer := 32;
        SIZE_BITS       : --! @brief SIZE BITS :
                          --! サイズ信号のビット数を指定する.
                          integer := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock & Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        RESET           : --! @brief RESET REQUEST :
                          --! 強制的に内部状態をリセットする事を指示する信号.
                          in  std_logic := '0';
        PAUSE           : --! @brief PAUSE REQUEST :
                          --! 強制的にフローを一時的に停止する事を指示する信号.
                          in  std_logic := '0';
        STOP            : --! @brief STOP  REQUEST :
                          --! 強制的にフローを中止する事を指示する信号.
                          in  std_logic := '0';
        INTAKE_OPEN     : --! @brief INTAKE VALVE OPEN FLAG :
                          --! 入力(INTAKE)側のバルブが開いている事を示すフラグ.
                          in  std_logic;
        OUTLET_OPEN     : --! @brief OUTLET VALVE OPEN FLAG :
                          --! 出力(OUTLET)側のバルブが開いている事を示すフラグ.
                          in  std_logic;
        POOL_SIZE       : --! @brief POOL SIZE :
                          --! プールの大きさをバイト数で指定する.
                          in  std_logic_vector(COUNT_BITS-1 downto 0);
        FLOW_READY_LEVEL: --! @brief FLOW READY LEVEL :
                          --! 一時停止する/しないを指示するための閾値.
                          --! * フローカウンタの値がこの値以下の時に入力を開始する.
                          --! * フローカウンタの値がこの値を越えた時に入力を一時停止.
                          in  std_logic_vector(COUNT_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Flow Counter Load Signals.
    -------------------------------------------------------------------------------
        LOAD            : --! @breif LOAD FLOW COUNTER :
                          --! フローカウンタに値をロードする事を指示する信号.
                          in  std_logic := '0';
        LOAD_COUNT      : --! @brief LOAD FLOW COUNTER VALUE :
                          --! LOAD='1'にフローカウンタにロードする値.
                          in  std_logic_vector(COUNT_BITS-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    -- Push Size Signals.
    -------------------------------------------------------------------------------
        PUSH_VALID      : --! @brief PUSH VALID :
                          --! PUSH_LAST/PUSH_SIZEが有効であることを示す信号.
                          in  std_logic := '0';
        PUSH_LAST       : --! @brief PUSH LAST :
                          --! 最後の入力であることを示す信号.
                          in  std_logic := '0';
        PUSH_SIZE       : --! @brief PUSH SIZE :
                          --! 入力したバイト数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    -- Pull Size Signals.
    -------------------------------------------------------------------------------
        PULL_VALID      : --! @brief PULL VALID :
                          --! PULL_LAST/PULL_SIZEが有効であることを示す信号.
                          in  std_logic := '0';
        PULL_LAST       : --! @brief PULL LAST :
                          --! 最後の出力であることを示す信号.
                          in  std_logic := '0';
        PULL_SIZE       : --! @brief PULL SIZE :
                          --! 出力したバイト数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    -- Intake Flow Control Signals.
    -------------------------------------------------------------------------------
        FLOW_READY      : --! @brief FLOW INTAKE READY :
                          --! 転送を一時的に止めたり、再開することを指示する信号.
                          --! * FLOW_READY='1' : 再開.
                          --! * FLOW_PAUSE='0' : 一時停止.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 以下の時に
                          --!   '1'を出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL を越えた時に
                          --!   '0'を出力する.
                          out std_logic;
        FLOW_PAUSE      : --! @brief FLOW INTAKE PAUSE :
                          --! 転送を一時的に止めたり、再開することを指示する信号.
                          --! * FLOW_PAUSE='0' : 再開.
                          --! * FLOW_PAUSE='1' : 一時停止.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 以下の時に
                          --!   '0'を出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL を越えた時に
                          --!   '1'を出力する.
                          out std_logic;
        FLOW_STOP       : --! @brief FLOW INTAKE STOP :
                          --! 転送の中止を指示する信号.
                          --! * FLOW_STOP='1' : 中止を指示.
                          out std_logic;
        FLOW_LAST       : --! @brief FLOW INTAKE LAST :
                          --! INTAKE側では未使用. 常に'0'が出力.
                          out std_logic;
        FLOW_SIZE       : --! @brief FLOW INTAKE ENABLE SIZE :
                          --! 入力可能なバイト数
                          out std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Flow Counter Signals.
    -------------------------------------------------------------------------------
        FLOW_COUNT      : --! @brief FLOW COUNTER :
                          --! 現在のフローカウンタの値を出力.
                          out std_logic_vector(COUNT_BITS-1 downto 0);
        FLOW_ZERO       : --! @brief FLOW COUNTER is ZERO :
                          --! フローカウンタの値が0になったことを示すフラグ.
                          out std_logic;
        FLOW_POS        : --! @brief FLOW COUNTER is POSitive :
                          --! フローカウンタの値が正(>0)になったことを示すフラグ.
                          out std_logic;
        FLOW_NEG        : --! @brief FLOW COUNTER is NEGative :
                          --! フローカウンタの値が負(<0)になったことを示すフラグ.
                          out std_logic;
        PAUSED          : --! @brief PAUSE FLAG :
                          --! 現在一時停止中であることを示すフラグ.
                          out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief FLOAT_INTAKE_MANIFOLD_VALVE                                           --
-----------------------------------------------------------------------------------
component FLOAT_INTAKE_MANIFOLD_VALVE
    generic (
        FIXED_CLOSE     : --! @brief FIXED VALVE CLOSE :
                          --! フローカウンタによるフロー制御を行わず、常に栓が閉じ
                          --! た状態にするか否かを指定する.
                          --! * FIXED_CLOSE=1 : 常に栓が閉じた状態にする.
                          --! * FIXED_CLOSE=0 : 栓の状態は他の変数に依存する.
                          integer range 0 to 1 := 0;
        FIXED_FLOW_OPEN : --! @brief FIXED VALVE FLOE OPEN :
                          --! フローカウンタによるフロー制御を行わず、常にフロー栓
                          --! が開いた状態にするか否かを指定する.
                          --! * FIXED_FLOW_OPEN=1 : 常にフロー栓が開いた状態にする.
                          --! * FIXED_FLOW_OPEN=0 : フロー栓の状態は他の変数に依存
                          --!   する.
                          integer range 0 to 1 := 0;
        FIXED_POOL_OPEN : --! @brief FIXED VALVE POOL OPEN :
                          --! プールカウンタによるフロー制御を行わず、常にプール栓
                          --! が開いた状態にするか否かを指定する.
                          --! * FIXED_POOL_OPEN=1 : 常にプール栓が開いた状態にする.
                          --! * FIXED_POOL_OPEN=0 : プール栓の状態は他の変数に依存
                          --!   する.
                          integer range 0 to 1 := 0;
        USE_PULL_RSV    : --! @brief USE PULL RESERVE SIGNALS :
                          --! フローカウンタの減算に PULL_RSV_SIZE を使うか 
                          --! PULL_FIX_SIZE を使うかを指定する.
                          --! * USE_PULL_RSV=1 : フローカウンタの減算にPULL_RSV_SIZE
                          --!   (入力する予定(RESERVE)のバイト数)を使う.
                          --! * USE_PULL_RSV=0 : フローカウンタの減算にPULL_FIN_SIZE
                          --!   (入力が確定(FINAL)したバイト数)を使う.
                          integer range 0 to 1 := 0;
        USE_POOL_PUSH   : --! @brief USE POOL PUSH SIGNALS :
                          --! プールカウンタの加算に FLOW_PUSH_SIZE を使うか 
                          --! POOL_PUSH_SIZE を使うかを指定する.
                          --! * USE_POOL_PUSH=1 : フローカウンタの加算に
                          --!   POOL_PUSH_SIZEを使う.
                          --! * USE_POOL_PUSH=0 : プールカウンタの加算に
                          --!   FLOW_PUSH_SIZEを使う.
                          integer range 0 to 1 := 1;
        COUNT_BITS      : --! @brief COUNTER BITS :
                          --! 内部カウンタのビット数を指定する.
                          integer := 32;
        SIZE_BITS       : --! @brief SIZE BITS :
                          --! サイズ信号のビット数を指定する.
                          integer := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock & Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        RESET           : --! @brief RESET REQUEST :
                          --! 強制的に内部状態をリセットする事を指示する信号.
                          in  std_logic;
        PAUSE           : --! @brief PAUSE REQUEST :
                          --! 強制的にフローを一時的に停止する事を指示する信号.
                          in  std_logic;
        STOP            : --! @brief STOP  REQUEST :
                          --! 強制的にフローを中止する事を指示する信号.
                          in  std_logic;
        INTAKE_OPEN     : --! @brief INTAKE VALVE OPEN FLAG :
                          --! 入力(INTAKE)側の栓が開いている事を示すフラグ.
                          in  std_logic;
        OUTLET_OPEN     : --! @brief OUTLET VALVE OPEN FLAG :
                          --! 出力(OUTLET)側の栓が開いている事を示すフラグ.
                          in  std_logic;
        POOL_SIZE       : --! @brief POOL SIZE :
                          --! プールの大きさをバイト数で指定する.
                          in  std_logic_vector(COUNT_BITS-1 downto 0);
        FLOW_READY_LEVEL: --! @brief FLOW READY LEVEL :
                          --! 一時停止する/しないを指示するための閾値.
                          --! フローカウンタの値がこの値以下の時に入力を開始する.
                          --! フローカウンタの値がこの値を越えた時に入力を一時停止.
                          in  std_logic_vector(COUNT_BITS-1 downto 0);
        POOL_READY_LEVEL: --! @brief POOL READY LEVEL :
                          --! PULL_FIN_SIZEによるプールカウンタの減算結果が、この値
                          --! 以下の時にPOOL_READY 信号をアサートする.
                          in  std_logic_vector(COUNT_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Pull Final Size Signals.
    -------------------------------------------------------------------------------
        PULL_FIN_VALID  : --! @brief PULL FINAL VALID :
                          --! PULL_FIN_LAST/PULL_FIN_SIZEが有効であることを示す信号.
                          --! * 栓が固定(Fixed)モードの場合は未使用.
                          in  std_logic;
        PULL_FIN_LAST   : --! @brief PULL FINAL LAST :
                          --! 最後のPULL_FIN入力であることを示す信号.
                          --! * 栓が固定(Fixed)モードの場合は未使用.
                          in  std_logic;
        PULL_FIN_SIZE   : --! @brief PUSH RESERVE SIZE :
                          --! 出力が確定(FINAL)したバイト数.
                          --! * 栓が固定(Fixed)モードの場合は未使用.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Pull Reserve Size Signals.
    -------------------------------------------------------------------------------
        PULL_RSV_VALID  : --! @brief PULL RESERVE VALID :
                          --! PULL_RSV_LAST/PULL_RSV_SIZEが有効であることを示す信号.
                          --! * バルブが固定(Fixed)モードの場合は未使用.
                          --! * USE_PULL_RSV=0 の場合は未使用.
                          in  std_logic;
        PULL_RSV_LAST   : --! @brief PULL RESERVE LAST :
                          --! 最後のPULL_RSV入力であることを示す信号.
                          --! * バルブが固定(Fixed)モードの場合は未使用.
                          --! * USE_PULL_RSV=0 の場合は未使用.
                          in  std_logic;
        PULL_RSV_SIZE   : --! @brief PULL RESERVE SIZE :
                          --! 出力する予定(RESERVE)のバイト数.
                          --! * バルブが固定(Fixed)モードの場合は未使用.
                          --! * USE_PULL_RSV=0 の場合は未使用.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Intake Flow Push Size Signals.
    -------------------------------------------------------------------------------
        FLOW_PUSH_VALID : --! @brief FLOW PUSH VALID :
                          --! FLOW_PUSH_LAST/FLOW_PUSH_SIZEが有効であることを示す信号.
                          in  std_logic;
        FLOW_PUSH_LAST  : --! @brief FLOW PUSH LAST :
                          --! 最後の入力であることを示す信号.
                          in  std_logic;
        FLOW_PUSH_SIZE  : --! @brief FLOW PUSH SIZE :
                          --! 入力したバイト数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Intake Flow Control Signals.
    -------------------------------------------------------------------------------
        FLOW_READY      : --! @brief FLOW INTAKE READY :
                          --! 転送を一時的に止めたり、再開することを指示する信号.
                          --! * FLOW_READY='1' : 再開.
                          --! * FLOW_READY='0' : 一時停止.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常に'0'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常に'1'を
                          --!   出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 以下の時に
                          --!   '1'を出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL を越えた時に
                          --!   '0'を出力する.
                          out std_logic;
        FLOW_PAUSE      : --! @brief FLOW INTAKE PAUSE :
                          --! 転送を一時的に止めたり、再開することを指示する信号.
                          --! * FLOW_PAUSE='0' : 再開.
                          --! * FLOW_PAUSE='1' : 一時停止.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常に'1'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常に'0'を
                          --!   出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 以下の時に
                          --!   '0'を出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL を越えた時に
                          --!   '1'を出力する.
                          out std_logic;
        FLOW_STOP       : --! @brief FLOW INTAKE STOP :
                          --! 転送の中止を指示する信号.
                          --! * FLOW_PAUSE=1 : 中止.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常に'1'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常に'0'を
                          --!   出力する.
                          out std_logic;
        FLOW_LAST       : --! @brief FLOW INTAKE LAST :
                          --! INTAKE側では未使用. 常に'0'を出力.
                          out std_logic;
        FLOW_SIZE       : --! @brief FLOW INTAKE ENABLE SIZE :
                          --! 入力可能なバイト数
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常にALL'0'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常にALL'1'を
                          --!   出力する.
                          out std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Intake Flow Counter.
    -------------------------------------------------------------------------------
        FLOW_COUNT      : --! @brief FLOW COUNTER :
                          --! 現在のフローカウンタの値を出力.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常にALL'0'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常にALL'1'を
                          --!   出力する.
                          out std_logic_vector(COUNT_BITS-1 downto 0);
        FLOW_ZERO       : --! @brief FLOW COUNTER is ZERO :
                          --! フローカウンタの値が0になったことを示すフラグ.
                          out std_logic;
        FLOW_POS        : --! @brief FLOW COUNTER is POSitive :
                          --! フローカウンタの値が正(>0)になったことを示すフラグ.
                          out std_logic;
        FLOW_NEG        : --! @brief FLOW COUNTER is NEGative :
                          --! フローカウンタの値が負(<0)になったことを示すフラグ.
                          out std_logic;
        PAUSED          : --! @brief PAUSE FLAG :
                          --! 現在一時停止中であることを示すフラグ.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- Intake Pool Size Signals.
    -------------------------------------------------------------------------------
        POOL_PUSH_RESET : --! @brief POOL PUSH RESET :
                          --! POOL COUNTER の値をリセットすることを指示する信号.
                          --! * この信号をアサートすることにより、FLOW COUNTER の値
                          --!   を POOL COUNTER にセットする.
                          --! * POOL COUNTER をリセットすることにより、再送、再出力
                          --!   に対応することが出来る.
                          in  std_logic;
        POOL_PUSH_VALID : --! @brief POOL PUSH VALID :
                          --! POOL_PUSH_SIZEが有効であることを示す信号.
                          in  std_logic;
        POOL_PUSH_LAST  : --! @brief POOL PUSH LAST :
                          --! 最後のPOOL_PUSH入力であることを示す信号.
                          in  std_logic;
        POOL_PUSH_SIZE  : --! @brief FLOW PUSH SIZE :
                          --! 入力したバイト数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Intake Pool Counter.
    -------------------------------------------------------------------------------
        POOL_COUNT      : --! @brief POOL COUNT :
                          --! 現在のプールカウンタの値を出力.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常にALL'0'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_POOL_OPEN=1)の時は常にALL'1'を
                          --!   出力する.
                          out std_logic_vector(COUNT_BITS-1 downto 0);
        POOL_READY      : --! @brief POOL READY :
                          --! プールカウンタの値が POOL_READY_LEVEL 以下であること
                          --! を示すフラグ.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常に'0'を出力す
                          --!   る.
                          --! * バルブが開固定(FIXED_POOL_OPEN=1)の時は常に'1'を出
                          --!   力する.
                          out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief FLOAT_OUTLET_VALVE                                                    --
-----------------------------------------------------------------------------------
component FLOAT_OUTLET_VALVE
    generic (
        COUNT_BITS      : --! @brief COUNTER BITS :
                          --! 内部カウンタのビット数を指定する.
                          integer := 32;
        SIZE_BITS       : --! @brief SIZE BITS :
                          --! サイズ信号のビット数を指定する.
                          integer := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock & Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        RESET           : --! @brief RESET REQUEST :
                          --! 強制的に内部状態をリセットする事を指示する信号.
                          in  std_logic := '0';
        PAUSE           : --! @brief PAUSE REQUEST :
                          --! 強制的にフローを一時的に停止する事を指示する信号.
                          in  std_logic := '0';
        STOP            : --! @brief STOP  REQUEST :
                          --! 強制的にフローを中止する事を指示する信号.
                          in  std_logic := '0';
        INTAKE_OPEN     : --! @brief INTAKE VALVE OPEN FLAG :
                          --! 入力(INTAKE)側のバルブが開いている事を示すフラグ.
                          in  std_logic;
        OUTLET_OPEN     : --! @brief OUTLET VALVE OPEN FLAG :
                          --! 出力(OUTLET)側のバルブが開いている事を示すフラグ.
                          in  std_logic;
        FLOW_READY_LEVEL: --! @brief FLOW READY LEVEL :
                          --! 一時停止する/しないを指示するための閾値.
                          --! * フローカウンタの値がこの値以上の時に出力を開始する.
                          --! * フローカウンタの値がこの値未満の時に出力を一時停止.
                          in  std_logic_vector(COUNT_BITS-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    -- Flow Counter Load Signals.
    -------------------------------------------------------------------------------
        LOAD            : --! @breif LOAD FLOW COUNTER :
                          --! フローカウンタに値をロードする事を指示する信号.
                          in  std_logic := '0';
        LOAD_COUNT      : --! @brief LOAD FLOW COUNTER VALUE :
                          --! LOAD='1'にフローカウンタにロードする値.
                          in  std_logic_vector(COUNT_BITS-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    -- Push Size Signals.
    -------------------------------------------------------------------------------
        PUSH_VALID      : --! @brief PUSH VALID :
                          --! PUSH_LAST/PUSH_SIZEが有効であることを示す信号.
                          in  std_logic := '0';
        PUSH_LAST       : --! @brief PUSH LAST :
                          --! 最後の入力であることを示す信号.
                          in  std_logic := '0';
        PUSH_SIZE       : --! @brief PUSH SIZE :
                          --! 入力したバイト数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    -- Pull Size Signals.
    -------------------------------------------------------------------------------
        PULL_VALID      : --! @brief PULL VALID :
                          --! PULL_LAST/PULL_SIZEが有効であることを示す信号.
                          in  std_logic := '0';
        PULL_LAST       : --! @brief PULL LAST :
                          --! 最後の出力であることを示す信号.
                          in  std_logic := '0';
        PULL_SIZE       : --! @brief PULL SIZE :
                          --! 出力したバイト数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    -- Outlet Flow Control Signals.
    -------------------------------------------------------------------------------
        FLOW_READY      : --! @brief FLOW OUTLET READY :
                          --! 転送を一時的に止めたり、再開することを指示する信号.
                          --! * FLOW_READY='1' : 再開.
                          --! * FLOW_READY='0' : 一時停止.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 以上の時に
                          --!   '1'を出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 未満の時に
                          --!   '0'を出力する.
                          out std_logic;
        FLOW_PAUSE      : --! @brief FLOW OUTLET PAUSE :
                          --! 転送を一時的に止めたり、再開することを指示する信号.
                          --! * FLOW_PAUSE='0' : 再開.
                          --! * FLOW_PAUSE='1' : 一時停止.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 以上の時に
                          --!   '0'を出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 未満の時に
                          --!   '1'を出力する.
                          out std_logic;
        FLOW_STOP       : --! @brief FLOW OUTLET STOP :
                          --! 転送の中止を指示する信号.
                          --! * FLOW_STOP='1' : 中止を指示.
                          out std_logic;
        FLOW_LAST       : --! @brief FLOW OUTLET LAST :
                          --! 入力側から最後の入力を示すフラグがあったことを示す.
                          out std_logic;
        FLOW_SIZE       : --! @brief FLOW OUTLET ENABLE SIZE :
                          --! 出力可能なバイト数
                          out std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Flow Counter Signals.
    -------------------------------------------------------------------------------
        FLOW_COUNT      : --! @brief FLOW COUNTER :
                          --! 現在のフローカウンタの値を出力.
                          out std_logic_vector(COUNT_BITS-1 downto 0);
        FLOW_ZERO       : --! @brief FLOW COUNTER is ZERO :
                          --! フローカウンタの値が0になったことを示すフラグ.
                          out std_logic;
        FLOW_POS        : --! @brief FLOW COUNTER is POSitive :
                          --! フローカウンタの値が正(>0)になったことを示すフラグ.
                          out std_logic;
        FLOW_NEG        : --! @brief FLOW COUNTER is NEGative :
                          --! フローカウンタの値が負(<0)になったことを示すフラグ.
                          out std_logic;
        PAUSED          : --! @brief PAUSE FLAG :
                          --! 現在一時停止中であることを示すフラグ.
                          out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief FLOAT_OUTLET_MANIFOLD_VALVE                                           --
-----------------------------------------------------------------------------------
component FLOAT_OUTLET_MANIFOLD_VALVE
    generic (
        FIXED_CLOSE     : --! @brief FIXED VALVE CLOSE :
                          --! フローカウンタによるフロー制御を行わず、常に栓が閉じ
                          --! た状態にするか否かを指定する.
                          --! * FIXED_CLOSE=1 : 常に栓が閉じた状態にする.
                          --! * FIXED_CLOSE=0 : 栓の状態は他の変数に依存する.
                          integer range 0 to 1 := 0;
        FIXED_FLOW_OPEN : --! @brief FIXED VALVE FLOE OPEN :
                          --! フローカウンタによるフロー制御を行わず、常にフロー栓
                          --! が開いた状態にするか否かを指定する.
                          --! * FIXED_FLOW_OPEN=1 : 常にフロー栓が開いた状態にする.
                          --! * FIXED_FLOW_OPEN=0 : フロー栓の状態は他の変数に依存
                          --!   する.
                          integer range 0 to 1 := 0;
        FIXED_POOL_OPEN : --! @brief FIXED VALVE POOL OPEN :
                          --! プールカウンタによるフロー制御を行わず、常にプール栓
                          --! が開いた状態にするか否かを指定する.
                          --! * FIXED_POOL_OPEN=1 : 常にプール栓が開いた状態にする.
                          --! * FIXED_POOL_OPEN=0 : プール栓の状態は他の変数に依存
                          --!   する.
                          integer range 0 to 1 := 0;
        USE_PUSH_RSV    : --! @brief USE PUSH RESERVE SIGNALS :
                          --! フローカウンタの加算に PUSH_RSV_SIZE を使うか 
                          --! PUSH_FIX_SIZE を使うかを指定する.
                          --! * USE_PUSH_RSV=1 : フローカウンタの加算にPUSH_RSV_SIZE
                          --!   (入力する予定(RESERVE)のバイト数)を使う.
                          --! * USE_PUSH_RSV=0 : フローカウンタの加算にPUSH_FIN_SIZE
                          --!   (入力が確定(FINAL)したバイト数)を使う.
                          integer range 0 to 1 := 0;
        USE_POOL_PULL   : --! @brief USE POOL PULL SIGNALS :
                          --! プールカウンタの減算に FLOW_PULL_SIZE を使うか 
                          --! POOL_PULL_SIZE を使うかを指定する.
                          --! * USE_POOL_PULL=1 : フローカウンタの加算に
                          --!   POOL_PULL_SIZEを使う.
                          --! * USE_POOL_PULL=0 : プールカウンタの減算に
                          --!   FLOW_PULL_SIZEを使う.
                          integer range 0 to 1 := 1;
        COUNT_BITS      : --! @brief COUNTER BITS :
                          --! 内部カウンタのビット数を指定する.
                          integer := 32;
        SIZE_BITS       : --! @brief SIZE BITS :
                          --! サイズ信号のビット数を指定する.
                          integer := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock & Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        RESET           : --! @brief RESET REQUEST :
                          --! 強制的に内部状態をリセットする事を指示する信号.
                          in  std_logic;
        PAUSE           : --! @brief PAUSE REQUEST :
                          --! 強制的にフローを一時的に停止する事を指示する信号.
                          in  std_logic;
        STOP            : --! @brief STOP  REQUEST :
                          --! 強制的にフローを中止する事を指示する信号.
                          in  std_logic;
        INTAKE_OPEN     : --! @brief INTAKE VALVE OPEN FLAG :
                          --! 入力(INTAKE)側の栓が開いている事を示すフラグ.
                          in  std_logic;
        OUTLET_OPEN     : --! @brief OUTLET VALVE OPEN FLAG :
                          --! 出力(OUTLET)側の栓が開いている事を示すフラグ.
                          in  std_logic;
        FLOW_READY_LEVEL: --! @brief FLOW READY LEVEL :
                          --! 一時停止する/しないを指示するための閾値.
                          --! フローカウンタの値がこの値以上の時に転送を開始する.
                          --! フローカウンタの値がこの値未満の時に転送を一時停止.
                          in  std_logic_vector(COUNT_BITS-1 downto 0);
        POOL_READY_LEVEL: --! @brief POOL READY LEVEL :
                          --! PUSH_FIN_SIZEによるフローカウンタの加算結果が、この値
                          --! 以上の時にPOOL_READY 信号をアサートする.
                          in  std_logic_vector(COUNT_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Push Final Size Signals.
    -------------------------------------------------------------------------------
        PUSH_FIN_VALID  : --! @brief PUSH FINAL VALID :
                          --! PUSH_FIN_LAST/PUSH_FIN_SIZEが有効であることを示す信号.
                          --! * 栓が固定(Fixed)モードの場合は未使用.
                          in  std_logic;
        PUSH_FIN_LAST   : --! @brief PUSH FINAL LAST :
                          --! 最後のPUSH_FIN入力であることを示す信号.
                          --! * 栓が固定(Fixed)モードの場合は未使用.
                          in  std_logic;
        PUSH_FIN_SIZE   : --! @brief PUSH FINAL SIZE :
                          --! 入力が確定(FINAL)したバイト数.
                          --! * 栓が固定(Fixed)モードの場合は未使用.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Push Reserve Size Signals.
    -------------------------------------------------------------------------------
        PUSH_RSV_VALID  : --! @brief PUSH RESERVE VALID :
                          --! PUSH_RSV_LAST/PUSH_RSV_SIZEが有効であることを示す信号.
                          --! * バルブが固定(Fixed)モードの場合は未使用.
                          --! * USE_PUSH_RSV=0 の場合は未使用.
                          in  std_logic;
        PUSH_RSV_LAST   : --! @brief PUSH RESERVE LAST :
                          --! 最後のPUSH_RSV入力であることを示す信号.
                          --! * バルブが固定(Fixed)モードの場合は未使用.
                          --! * USE_PUSH_RSV=0 の場合は未使用.
                          in  std_logic;
        PUSH_RSV_SIZE   : --! @brief PUSH RESERVE SIZE :
                          --! 入力する予定(RESERVE)のバイト数.
                          --! * バルブが固定(Fixed)モードの場合は未使用.
                          --! * USE_PUSH_RSV=0 の場合は未使用.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Outlet Flow Pull Size Signals.
    -------------------------------------------------------------------------------
        FLOW_PULL_VALID : --! @brief FLOW PULL VALID :
                          --! FLOW_PULL_LAST/FLOW_PULL_SIZEが有効であることを示す信号.
                          in  std_logic;
        FLOW_PULL_LAST  : --! @brief FLOW PULL LAST :
                          --! 最後の出力であることを示す信号.
                          in  std_logic;
        FLOW_PULL_SIZE  : --! @brief FLOW PULL SIZE :
                          --! 出力したバイト数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Outlet Flow Control Signals.
    -------------------------------------------------------------------------------
        FLOW_READY      : --! @brief FLOW OUTLET READY :
                          --! 転送を一時的に止めたり、再開することを指示する信号.
                          --! * FLOW_READY='1' : 再開.
                          --! * FLOW_READY='0' : 一時停止.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常に'0'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常に'1'を
                          --!   出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 以上の時に
                          --!   '1'を出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 未満の時に
                          --!   '0'を出力する.
                          out std_logic;
        FLOW_PAUSE      : --! @brief FLOW OUTLET PAUSE :
                          --! 転送を一時的に止めたり、再開することを指示する信号.
                          --! * FLOW_PAUSE='0' : 再開.
                          --! * FLOW_PAUSE='1' : 一時停止.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常に'1'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常に'0'を
                          --!   出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 以上の時に
                          --!   '0'を出力する.
                          --! * フローカウンタの値が FLOW_READY_LEVEL 未満の時に
                          --!   '1'を出力する.
                          out std_logic;
        FLOW_STOP       : --! @brief FLOW OUTLET STOP :
                          --! 転送の中止を指示する信号.
                          --! * FLOW_PAUSE=1 : 中止.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常に'1'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常に'0'を
                          --!   出力する.
                          out std_logic;
        FLOW_LAST       : --! @brief FLOW OUTLET LAST :
                          --! 入力側から最後の入力を示すフラグがあったことを示す.
                          out std_logic;
        FLOW_SIZE       : --! @brief FLOW OUTLET ENABLE SIZE :
                          --! 出力可能なバイト数
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常にALL'0'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常にALL'1'を
                          --!   出力する.
                          out std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Outlet Flow Counter.
    -------------------------------------------------------------------------------
        FLOW_COUNT      : --! @brief FLOW COUNTER :
                          --! 現在のフローカウンタの値を出力.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常にALL'0'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_FLOW_OPEN=1)の時は常にALL'1'を
                          --!   出力する.
                          out std_logic_vector(COUNT_BITS-1 downto 0);
        FLOW_ZERO       : --! @brief FLOW COUNTER is ZERO :
                          --! フローカウンタの値が0になったことを示すフラグ.
                          out std_logic;
        FLOW_POS        : --! @brief FLOW COUNTER is POSitive :
                          --! フローカウンタの値が正(>0)になったことを示すフラグ.
                          out std_logic;
        FLOW_NEG        : --! @brief FLOW COUNTER is NEGative :
                          --! フローカウンタの値が負(<0)になったことを示すフラグ.
                          out std_logic;
        PAUSED          : --! @brief PAUSE FLAG :
                          --! 現在一時停止中であることを示すフラグ.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- Outlet Pool Size Signals.
    -------------------------------------------------------------------------------
        POOL_PULL_RESET : --! @brief POOL PULL RESET :
                          --! POOL COUNTER の値をリセットすることを指示する信号.
                          --! * この信号をアサートすることにより、FLOW COUNTER の値
                          --!   を POOL COUNTER にセットする.
                          --! * POOL COUNTER をリセットすることにより、再送、再出力
                          --!   に対応することが出来る.
                          in  std_logic;
        POOL_PULL_VALID : --! @brief POOL PULL VALID :
                          --! POOL_PULL_SIZEが有効であることを示す信号.
                          in  std_logic;
        POOL_PULL_LAST  : --! @brief POOL PULL LAST :
                          --! 最後のPOOL_PULL入力であることを示す信号.
                          in  std_logic;
        POOL_PULL_SIZE  : --! @brief FLOW PULL SIZE :
                          --! 出力したバイト数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Outlet Pool Counter.
    -------------------------------------------------------------------------------
        POOL_COUNT      : --! @brief POOL COUNT :
                          --! 現在のプールカウンタの値を出力.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常にALL'0'を出力
                          --!   する.
                          --! * バルブが開固定(FIXED_POOL_OPEN=1)の時は常にALL'1'を
                          --!   出力する.
                          out std_logic_vector(COUNT_BITS-1 downto 0);
        POOL_READY      : --! @brief POOL READY :
                          --! プールカウンタの値が POOL_READY_LEVEL 以上であること
                          --! を示すフラグ.
                          --! * バルブが閉固定(FIXED_CLOSE=1)の時は常に'0'を出力す
                          --!   る.
                          --! * バルブが開固定(FIXED_POOL_OPEN=1)の時は常に'1'を出
                          --!   力する.
                          out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief REGISTER_ACCESS_DECODER                                               --
-----------------------------------------------------------------------------------
component REGISTER_ACCESS_DECODER
    generic (
        ADDR_WIDTH  : --! @brief REGISTER ADDRESS WIDTH :
                      --! レジスタアクセスインターフェースのアドレスのビット幅を指
                      --! 定する.
                      integer := 8;
        DATA_WIDTH  : --! @brief REGISTER DATA WIDTH :
                      --! レジスタアクセスインターフェースのデータのビット幅を指定
                      --! する.
                      integer := 32;
        WBIT_MIN    : --! @brief REGISTER WRITE BIT MIN INDEX :
                      integer := 0;
        WBIT_MAX    : --! @brief REGISTER WRITE BIT MAX INDEX :
                      integer := (2**8)*8-1;
        RBIT_MIN    : --! @brief REGISTER READ  BIT MIN INDEX :
                      integer := 0;
        RBIT_MAX    : --! @brief REGISTER READ  BIT MAX INDEX :
                      integer := (2**8)*8-1
    );
    port (
    -------------------------------------------------------------------------------
    -- 入力側のレジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        REGS_REQ    : --! @brief REGISTER ACCESS REQUEST :
                      --! レジスタアクセス要求信号.
                      in  std_logic;
        REGS_WRITE  : --! @brief REGISTER WRITE ACCESS :
                      --! レジスタライトアクセス信号.
                      --! * この信号が'1'の時はライトアクセスを行う.
                      --! * この信号が'0'の時はリードアクセスを行う.
                      in  std_logic;
        REGS_ADDR   : --! @brief REGISTER ACCESS ADDRESS :
                      --! レジスタアクセスアドレス信号.
                      in  std_logic_vector(ADDR_WIDTH  -1 downto 0);
        REGS_BEN    : --! @brief REGISTER BYTE ENABLE :
                      --! レジスタアクセスバイトイネーブル信号.
                      in  std_logic_vector(DATA_WIDTH/8-1 downto 0);
        REGS_WDATA  : --! @brief REGISTER ACCESS WRITE DATA :
                      --! レジスタアクセスライトデータ.
                      in  std_logic_vector(DATA_WIDTH  -1 downto 0);
        REGS_RDATA  : --! @brief REGISTER ACCESS READ DATA :
                      --! レジスタアクセスリードデータ.
                      out std_logic_vector(DATA_WIDTH  -1 downto 0);
        REGS_ACK    : --! @brief REGISTER ACCESS ACKNOWLEDGE :
                      --! レジスタアクセス応答信号.
                      out std_logic;
        REGS_ERR    : --! @brief REGISTER ACCESS ERROR ACKNOWLEDGE :
                      --! レジスタアクセスエラー応答信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- レジスタライトデータ/ロード出力
    -------------------------------------------------------------------------------
        W_DATA      : out std_logic_vector(WBIT_MAX downto WBIT_MIN);
        W_LOAD      : out std_logic_vector(WBIT_MAX downto WBIT_MIN);
    -------------------------------------------------------------------------------
    -- レジスタリードデータ入力
    -------------------------------------------------------------------------------
        R_DATA      : in  std_logic_vector(RBIT_MAX downto RBIT_MIN)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief REGISTER_ACCESS_SYNCRONIZER                                           --
-----------------------------------------------------------------------------------
component REGISTER_ACCESS_SYNCRONIZER
    generic (
        ADDR_WIDTH  : --! @brief REGISTER ADDRESS WIDTH :
                      --! レジスタアクセスインターフェースのアドレスのビット幅を指
                      --! 定する.
                      integer := 32;
        DATA_WIDTH  : --! @brief REGISTER DATA WIDTH :
                      --! レジスタアクセスインターフェースのデータのビット幅を指定
                      --! する.
                      integer := 32;
        I_CLK_RATE  : --! @brief INPUT CLOCK RATE :
                      --! O_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する. 
                      --! 詳細は PipeWork.Components の SYNCRONIZER を参照.
                      integer :=  1;
        O_CLK_RATE  : --! @brief OUTPUT CLOCK RATE :
                      --! I_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する.
                      --! 詳細は PipeWork.Components の SYNCRONIZER を参照.
                      integer :=  1;
        O_CLK_REGS  : --! @brief REGISTERD OUTPUT :
                      --! 出力側の各種信号(O_REQ/O_WRITE/O_WDATA/O_BEN)をレジスタ
                      --! 出力するかどうかを指定する.
                      --! * この変数は I_CLK_RATE > 0 の場合のみ有効. 
                      --!   I_CLK_RATE = 0 の場合は、常にレジスタ出力になる.
                      --! * O_CLK_REGS = 0 の場合はレジスタ出力しない.
                      --! * O_CLK_REGS = 1 の場合はレジスタ出力する.
                      integer range 0 to 1 :=  0
    );
    port (
    -------------------------------------------------------------------------------
    -- リセット信号
    -------------------------------------------------------------------------------
        RST         : --! @brief RESET :
                      --! 非同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        I_CLK       : --! @brief INPUT CLOCK :
                      --! 入力側のクロック信号.
                      in  std_logic;
        I_CLR       : --! @brief INPUT CLEAR :
                      --! 入力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
        I_CKE       : --! @brief INPUT CLOCK ENABLE :
                      --! 入力側のクロック(I_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とOCLKの立上り時が同じ時にアサートするよ
                      --!   うに入力されなければならない.
                      --! * この信号は I_CLK_RATE > 1 かつ O_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- 入力側のレジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        I_REQ       : --! @brief INPUT REGISTER ACCESS REQUEST :
                      --! レジスタアクセス要求信号.
                      in  std_logic;
        I_SEL       : --! @brief INPUT REGISTER ACCESS SELECT :
                      --! レジスタアクセス選択信号.
                      --! * I_REQ='1'の際、この信号が'1'の時にのみレジスタアクセス
                      --!   を開始する.
                      in  std_logic := '1';
        I_WRITE     : --! @brief INPUT REGISTER WRITE ACCESS :
                      --! レジスタライトアクセス信号.
                      --! * この信号が'1'の時はライトアクセスを行う.
                      --! * この信号が'0'の時はリードアクセスを行う.
                      in  std_logic;
        I_ADDR      : --! @brief INPUT REGISTER ACCESS ADDRESS :
                      --! レジスタアクセスアドレス信号.
                      in  std_logic_vector(ADDR_WIDTH  -1 downto 0);
        I_BEN       : --! @brief INPUT REGISTER BYTE ENABLE :
                      --! レジスタアクセスバイトイネーブル信号.
                      in  std_logic_vector(DATA_WIDTH/8-1 downto 0);
        I_WDATA     : --! @brief INPUT REGISTER ACCESS WRITE DATA :
                      --! レジスタアクセスライトデータ.
                      in  std_logic_vector(DATA_WIDTH  -1 downto 0);
        I_RDATA     : --! @brief INPUT REGISTER ACCESS READ DATA :
                      --! レジスタアクセスリードデータ.
                      out std_logic_vector(DATA_WIDTH  -1 downto 0);
        I_ACK       : --! @brief INPUT REGISTER ACCESS ACKNOWLEDGE :
                      --! レジスタアクセス応答信号.
                      out std_logic;
        I_ERR       : --! @brief INPUT REGISTER ACCESS ERROR ACKNOWLEDGE :
                      --! レジスタアクセスエラー応答信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        O_CLK       : --! @brief OUTPUT CLK :
                      --! 出力側のクロック信号.
                      in  std_logic;
        O_CLR       : --! @brief OUTPUT CLEAR :
                      --! 出力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
        O_CKE       : --! @brief OUTPUT CLOCK ENABLE :
                      --! 出力側のクロック(O_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とO_CLKの立上り時が同じ時にアサートする
                      --!   ように入力されなければならない.
                      --! * この信号は O_CLK_RATE > 1 かつ I_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- 出力側のレジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        O_REQ       : --! @brief OUTNPUT REGISTER ACCESS REQUEST :
                      --! レジスタアクセス要求信号.
                      out std_logic;
        O_WRITE     : --! @brief OUTPUT REGISTER WRITE ACCESS :
                      --! レジスタライトアクセス信号.
                      --! * この信号が'1'の時はライトアクセスを行う.
                      --! * この信号が'0'の時はリードアクセスを行う.
                      out std_logic;
        O_ADDR      : --! @brief OUTPUT REGISTER ACCESS ADDRESS :
                      --! レジスタアクセスアドレス信号.
                      out std_logic_vector(ADDR_WIDTH  -1 downto 0);
        O_BEN       : --! @brief OUTPUT REGISTER BYTE ENABLE :
                      --! レジスタアクセスバイトイネーブル信号.
                      out std_logic_vector(DATA_WIDTH/8-1 downto 0);
        O_WDATA     : --! @brief OUTPUT REGISTER ACCESS WRITE DATA :
                      --! レジスタアクセスライトデータ.
                      out std_logic_vector(DATA_WIDTH  -1 downto 0);
        O_RDATA     : --! @brief OUTPUT REGISTER ACCESS READ DATA :
                      --! レジスタアクセスリードデータ.
                      in  std_logic_vector(DATA_WIDTH  -1 downto 0);
        O_ACK       : --! @brief OUTPUT REGISTER ACCESS ACKNOWLEDGE :
                      --! レジスタアクセス応答信号.
                      in  std_logic;
        O_ERR       : --! @brief OUTPUT REGISTER ACCESS ERROR ACKNOWLEDGE :
                      --! レジスタアクセスエラー応答信号.
                      in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief REGISTER_ACCESS_ADAPTER                                               --
-----------------------------------------------------------------------------------
component REGISTER_ACCESS_ADAPTER
    generic (
        ADDR_WIDTH  : --! @brief REGISTER ADDRESS WIDTH :
                      --! レジスタアクセスインターフェースのアドレスのビット幅を指
                      --! 定する.
                      integer := 8;
        DATA_WIDTH  : --! @brief REGISTER DATA WIDTH :
                      --! レジスタアクセスインターフェースのデータのビット幅を指定
                      --! する.
                      integer := 32;
        WBIT_MIN    : --! @brief REGISTER WRITE BIT MIN INDEX :
                      integer := 0;
        WBIT_MAX    : --! @brief REGISTER WRITE BIT MAX INDEX :
                      integer := (2**8)*8-1;
        RBIT_MIN    : --! @brief REGISTER READ  BIT MIN INDEX :
                      integer := 0;
        RBIT_MAX    : --! @brief REGISTER READ  BIT MAX INDEX :
                      integer := (2**8)*8-1;
        I_CLK_RATE  : --! @brief INPUT CLOCK RATE :
                      --! O_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する. 
                      --! 詳細は PipeWork.Components の SYNCRONIZER を参照.
                      integer :=  1;
        O_CLK_RATE  : --! @brief OUTPUT CLOCK RATE :
                      --! I_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する.
                      --! 詳細は PipeWork.Components の SYNCRONIZER を参照.
                      integer :=  1;
        O_CLK_REGS  : --! @brief REGISTERD OUTPUT :
                      --! 出力側の各種信号(O_REQ/O_WRITE/O_WDATA/O_BEN)をレジスタ
                      --! 出力するかどうかを指定する.
                      --! * この変数は I_CLK_RATE > 0 の場合のみ有効. 
                      --!   I_CLK_RATE = 0 の場合は、常にレジスタ出力になる.
                      --! * O_CLK_REGS = 0 の場合はレジスタ出力しない.
                      --! * O_CLK_REGS = 1 の場合はレジスタ出力する.
                      integer range 0 to 1 :=  0
    );
    port (
    -------------------------------------------------------------------------------
    -- リセット信号
    -------------------------------------------------------------------------------
        RST         : --! @brief RESET :
                      --! 非同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        I_CLK       : --! @brief INPUT CLOCK :
                      --! 入力側のクロック信号.
                      in  std_logic;
        I_CLR       : --! @brief INPUT CLEAR :
                      --! 入力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
        I_CKE       : --! @brief INPUT CLOCK ENABLE :
                      --! 入力側のクロック(I_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とOCLKの立上り時が同じ時にアサートするよ
                      --!   うに入力されなければならない.
                      --! * この信号は I_CLK_RATE > 1 かつ O_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- 入力側のレジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        I_REQ       : --! @brief REGISTER ACCESS REQUEST :
                      --! レジスタアクセス要求信号.
                      in  std_logic;
        I_SEL       : --! @brief INPUT REGISTER ACCESS SELECT :
                      --! レジスタアクセス選択信号.
                      --! * I_REQ='1'の際、この信号が'1'の時にのみレジスタアクセス
                      --!   を開始する.
                      in  std_logic := '1';
        I_WRITE     : --! @brief REGISTER WRITE ACCESS :
                      --! レジスタライトアクセス信号.
                      --! * この信号が'1'の時はライトアクセスを行う.
                      --! * この信号が'0'の時はリードアクセスを行う.
                      in  std_logic;
        I_ADDR      : --! @brief REGISTER ACCESS ADDRESS :
                      --! レジスタアクセスアドレス信号.
                      in  std_logic_vector(ADDR_WIDTH  -1 downto 0);
        I_BEN       : --! @brief REGISTER BYTE ENABLE :
                      --! レジスタアクセスバイトイネーブル信号.
                      in  std_logic_vector(DATA_WIDTH/8-1 downto 0);
        I_WDATA     : --! @brief REGISTER ACCESS WRITE DATA :
                      --! レジスタアクセスライトデータ.
                      in  std_logic_vector(DATA_WIDTH  -1 downto 0);
        I_RDATA     : --! @brief REGISTER ACCESS READ DATA :
                      --! レジスタアクセスリードデータ.
                      out std_logic_vector(DATA_WIDTH  -1 downto 0);
        I_ACK       : --! @brief REGISTER ACCESS ACKNOWLEDGE :
                      --! レジスタアクセス応答信号.
                      out std_logic;
        I_ERR       : --! @brief REGISTER ACCESS ERROR ACKNOWLEDGE :
                      --! レジスタアクセスエラー応答信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        O_CLK       : --! @brief OUTPUT CLK :
                      --! 出力側のクロック信号.
                      in  std_logic;
        O_CLR       : --! @brief OUTPUT CLEAR :
                      --! 出力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
        O_CKE       : --! @brief OUTPUT CLOCK ENABLE :
                      --! 出力側のクロック(O_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とO_CLKの立上り時が同じ時にアサートする
                      --!   ように入力されなければならない.
                      --! * この信号は O_CLK_RATE > 1 かつ I_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- レジスタライトデータ/ロード出力
    -------------------------------------------------------------------------------
        O_WDATA     : out std_logic_vector(WBIT_MAX downto WBIT_MIN);
        O_WLOAD     : out std_logic_vector(WBIT_MAX downto WBIT_MIN);
    -------------------------------------------------------------------------------
    -- レジスタリードデータ入力
    -------------------------------------------------------------------------------
        O_RDATA     : in  std_logic_vector(RBIT_MAX downto RBIT_MIN)
    );
end component;
end COMPONENTS;
-----------------------------------------------------------------------------------
--!     @file    queue_register.vhd
--!     @brief   QUEUE REGISTER MODULE :
--!              フリップフロップベースの比較的浅いキュー.
--!     @version 1.5.0
--!     @date    2013/4/2
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012,2013 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   QUEUE REGISTER
--!          フリップフロップベースの比較的浅いキュー.
--!        * フリップフロップを使っているのでキューの段数が大きいと
--!          それなりに回路規模が大きくなることに注意.
-----------------------------------------------------------------------------------
entity  QUEUE_REGISTER is
    -------------------------------------------------------------------------------
    -- ジェネリック変数
    -------------------------------------------------------------------------------
    generic (
        QUEUE_SIZE  : --! @brief QUEUE SIZE :
                      --! キューの大きさをワード数で指定する.
                      integer := 1;
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(I_DATA/O_DATA/Q_DATA)のビット幅を指定する.
                      integer :=  32;
        LOWPOWER    : --! @brief LOW POWER MODE :
                      --! キューのレジスタに不必要なロードを行わないことにより、
                      --! レジスタが不必要にトグルすることを防いで消費電力を
                      --! 下げるようにする.
                      --! ただし、回路が若干増える.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT DATA  :
                      --! 入力データ信号.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT DATA VALID :
                      --! 入力データ有効信号.
                      in  std_logic;
        I_RDY       : --! @brief INPUT READY :
                      --! 入力可能信号.
                      --! キューが空いていて、入力データを受け付けることが可能で
                      --! あることを示す信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT DATA :
                      --! 出力データ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT DATA VALID :
                      --! キューレジスタに有効なデータが入っている事を示すフラグ.
                      --! * キューレジスタは1〜QUEUE_SIZEまであるが、対応する位置の
                      --!   フラグが'1'ならば有効なデータが入っている事を示す.
                      --! * この出力信号の範囲が1からではなく0から始まっている事に
                      --!   注意. これはQUEUE_SIZE=0の場合に対応するため.
                      --!   QUEUE_SIZE>0の場合は、O_VAL(0)はO_VAL(1)と同じ.
                      out std_logic_vector(QUEUE_SIZE  downto 0);
        Q_DATA      : --! @brief OUTPUT REGISTERD DATA :
                      --! レジスタ出力の出力データ.
                      --! 出力データ(O_DATA)をクロックで叩いたもの.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        Q_VAL       : --! @brief OUTPUT REGISTERD DATA VALID :
                      --! キューレジスタに有効なデータが入っている事を示すフラグ.
                      --! O_VALをクロックで叩いたもの.
                      --! * キューレジスタは1〜QUEUE_SIZEまであるが、対応する位置の
                      --!   フラグが'1'ならば有効なデータが入っている事を示す.
                      --! * この出力信号の範囲が1からではなく0から始まっている事に
                      --!   注意. これはQUEUE_SIZE=0の場合に対応するため.
                      --!   QUEUE_SIZE>0の場合は、Q_VAL(0)はQ_VAL(1)と同じ.
                      out std_logic_vector(QUEUE_SIZE  downto 0);
        Q_RDY       : --! @brief OUTPUT READY :
                      --! 出力可能信号.
                      in  std_logic
    );
end QUEUE_REGISTER;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
architecture RTL of QUEUE_REGISTER is
begin
    -------------------------------------------------------------------------------
    --  QUEUE_SIZE=0の場合はなにもしない
    -------------------------------------------------------------------------------
    QUEUE_SIZE_EQ_0: if (QUEUE_SIZE = 0) generate
        O_DATA   <= I_DATA;
        Q_DATA   <= I_DATA;
        O_VAL(0) <= I_VAL;
        Q_VAL(0) <= I_VAL;
        I_RDY    <= Q_RDY;
    end generate;
    -------------------------------------------------------------------------------
    -- QUEUE_SIZE>0の場合
    -------------------------------------------------------------------------------
    QUEUE_SIZE_GT_0: if (QUEUE_SIZE > 0) generate
        subtype  QUEUE_DATA_TYPE   is std_logic_vector(DATA_BITS-1 downto 0);
        constant QUEUE_DATA_NULL    : std_logic_vector(DATA_BITS-1 downto 0) := (others => '0');
        type     QUEUE_DATA_VECTOR is array (natural range <>) of QUEUE_DATA_TYPE;
        constant FIRST_OF_QUEUE     : integer := 1;
        constant LAST_OF_QUEUE      : integer := QUEUE_SIZE;
        signal   next_queue_data    : QUEUE_DATA_VECTOR(LAST_OF_QUEUE downto FIRST_OF_QUEUE);
        signal   curr_queue_data    : QUEUE_DATA_VECTOR(LAST_OF_QUEUE downto FIRST_OF_QUEUE);
        signal   queue_data_load    : std_logic_vector (LAST_OF_QUEUE downto FIRST_OF_QUEUE);
        signal   next_queue_valid   : std_logic_vector (LAST_OF_QUEUE downto FIRST_OF_QUEUE);
        signal   curr_queue_valid   : std_logic_vector (LAST_OF_QUEUE downto FIRST_OF_QUEUE);
    begin
        ---------------------------------------------------------------------------
        -- next_queue_valid : 次のクロックでのキューの状態を示すフラグ.
        -- queue_data_load  : 次のクロックでcurr_queue_dataにnext_queue_dataの値を
        --                    ロードすることを示すフラグ.
        ---------------------------------------------------------------------------
        process (I_VAL, Q_RDY, curr_queue_valid) begin
            for i in FIRST_OF_QUEUE to LAST_OF_QUEUE loop
                -------------------------------------------------------------------
                -- 自分のキューにデータが格納されている場合...
                -------------------------------------------------------------------
                if (curr_queue_valid(i) = '1') then
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されていて、
                    -- かつ自分がキューの最後ならば、
                    -- Q_RDY='1'で自分のキューをクリアする.
                    ---------------------------------------------------------------
                    if (i = LAST_OF_QUEUE) then
                        if (Q_RDY = '1') then
                            next_queue_valid(i) <= '0';
                        else
                            next_queue_valid(i) <= '1';
                        end if;
                        queue_data_load(i) <= '0';
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されていて、
                    -- かつ自分がキューの最後でなくて、
                    -- かつ後ろのキューにデータが入っているならば、
                    -- Q_RDY='1'で後ろのキューのデータを自分のキューに格納する.
                    ---------------------------------------------------------------
                    elsif (curr_queue_valid(i+1) = '1') then
                        next_queue_valid(i) <= '1';
                        if (Q_RDY = '1') then
                            queue_data_load(i) <= '1';
                        else
                            queue_data_load(i) <= '0';
                        end if;
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されていて、
                    -- かつ自分がキューの最後でなくて、
                    -- かつ後ろのキューにデータが入っていないならば、
                    -- I_VAL='0' かつ Q_RDY='1'ならば自分のキューをクリアする. 
                    -- I_VAL='1' かつ Q_RDY='1'ならばI_DATAを自分のキューに格納する.
                    ---------------------------------------------------------------
                    else
                        if (I_VAL = '0' and Q_RDY = '1') then
                            next_queue_valid(i) <= '0';
                        else
                            next_queue_valid(i) <= '1';
                        end if;
                        if (LOWPOWER > 0 and I_VAL = '1' and Q_RDY = '1') or
                           (LOWPOWER = 0                 and Q_RDY = '1') then
                            queue_data_load(i)  <= '1';
                        else
                            queue_data_load(i)  <= '0';
                        end if;
                    end if;
                -------------------------------------------------------------------
                -- 自分のところにデータが格納されていない場合...
                -------------------------------------------------------------------
                else -- if (curr_queue_valid(i) = '0') then
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されてなくて、
                    -- かつ自分がキューの先頭ならば、
                    -- I_VAL='1'で自分のキューにデータを格納する.
                    ---------------------------------------------------------------
                    if    (i = FIRST_OF_QUEUE) then
                        if (I_VAL = '1') then
                            next_queue_valid(i) <= '1';
                            queue_data_load(i)  <= '1';
                        else
                            next_queue_valid(i) <= '0';
                            queue_data_load(i)  <= '0';
                        end if;
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されてなくて、
                    -- かつ自分がキューの先頭なくて、
                    -- かつ前のキューにデータが格納されているならば、
                    -- I_VAL='1'かつQ_RDY='0'で自分のキューにデータを格納する.
                    ---------------------------------------------------------------
                    elsif (curr_queue_valid(i-1) = '1') then
                        if (I_VAL = '1' and Q_RDY = '0') then
                            next_queue_valid(i) <= '1';
                        else
                            next_queue_valid(i) <= '0';
                        end if;
                        if (LOWPOWER = 0) or
                           (LOWPOWER > 0 and I_VAL = '1' and Q_RDY = '0') then
                            queue_data_load(i)  <= '1';
                        else
                            queue_data_load(i)  <= '0';
                        end if;
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されてなくて、
                    -- かつ自分がキューの先頭なくて、
                    -- かつ前のキューにデータが格納されていないならば、
                    -- キューは空のまま.
                    ---------------------------------------------------------------
                    else
                            next_queue_valid(i) <= '0';
                            queue_data_load(i)  <= '0';
                    end if;
                end if;
            end loop;
        end process;
        ---------------------------------------------------------------------------
        -- next_queue_data  : 次のクロックでキューに格納されるデータ.
        ---------------------------------------------------------------------------
        process (I_DATA, queue_data_load, curr_queue_data, curr_queue_valid) begin
            for i in FIRST_OF_QUEUE to LAST_OF_QUEUE loop
                if (queue_data_load(i) = '1') then
                    if    (i = LAST_OF_QUEUE) then
                        next_queue_data(i) <= I_DATA;
                    elsif (curr_queue_valid(i+1) = '1') then
                        next_queue_data(i) <= curr_queue_data(i+1);
                    else
                        next_queue_data(i) <= I_DATA;
                    end if;
                else
                        next_queue_data(i) <= curr_queue_data(i);
                end if;
            end loop;
        end process;
        ---------------------------------------------------------------------------
        -- curr_queue_data  : 現在、キューに格納されているデータ.
        -- curr_queue_valid : 現在、キューにデータが格納されていることを示すフラグ.
        -- I_RDY            : キューにデータが格納することが出来ることを示すフラグ.
        ---------------------------------------------------------------------------
        process (CLK, RST) begin
            if     (RST = '1') then
                   curr_queue_data  <= (others => QUEUE_DATA_NULL);
                   curr_queue_valid <= (others => '0');
                   I_RDY            <= '0';
            elsif  (CLK'event and CLK = '1') then
               if (CLR = '1') then
                   curr_queue_data  <= (others => QUEUE_DATA_NULL);
                   curr_queue_valid <= (others => '0');
                   I_RDY            <= '0';
               else
                   curr_queue_data  <= next_queue_data;
                   curr_queue_valid <= next_queue_valid;
                   I_RDY            <= not next_queue_valid(LAST_OF_QUEUE);
               end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- 各種出力信号
        ---------------------------------------------------------------------------
        O_DATA                     <= next_queue_data (FIRST_OF_QUEUE);
        Q_DATA                     <= curr_queue_data (FIRST_OF_QUEUE);
        O_VAL(0)                   <= next_queue_valid(FIRST_OF_QUEUE);
        O_VAL(QUEUE_SIZE downto 1) <= next_queue_valid;
        Q_VAL(0)                   <= curr_queue_valid(FIRST_OF_QUEUE);
        Q_VAL(QUEUE_SIZE downto 1) <= curr_queue_valid;
    end generate;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    reducer.vhd
--!     @brief   REDUCER MODULE :
--!              異なるデータ幅のパスを継ぐためのアダプタ
--!     @version 1.5.8
--!     @date    2015/9/20
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2015 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   REDUCER :
--!          異なるデータ幅のパスを継ぐためのアダプタ.
--!        * REDUCER とは配管用語で径違い継ぎ手、つまり直径違う配管(パイプ)を接続
--!          するために用いる管継手のことです.
--!        * 論理回路の世界でも、ビット幅の異なるデータパスどうしを継ぐことが多い
--!          のでこのような汎用のアダプタを作って REDUCER という名前をつけました.
--!        * ちょっと汎用的に作りすぎたせいか、多少回路が冗長です.
--!          特にI_WIDTHが大きいとかなり大きな回路になってしまいます.
--!          例えば32bit入力64bit出力の場合、
--!          WORD_BITS=8 、STRB_BITS=1、I_WIDTH=4、O_WIDTH=8 とするよりも、
--!          WORD_BITS=32、STRB_BITS=4、I_WIDTH=1、O_WIDTH=2 としたほうが
--!          回路はコンパクトになります.
--!        * O_WIDTH>I_WIDTHの場合、最初のワードデータを出力する際のオフセットを
--!          設定できます. 詳細はOFFSETの項を参照.
-----------------------------------------------------------------------------------
entity  REDUCER is
    generic (
        WORD_BITS   : --! @brief WORD BITS :
                      --! １ワードのデータのビット数を指定する.
                      integer := 8;
        STRB_BITS   : --! @brief ENABLE BITS :
                      --! ワードデータのうち有効なデータであることを示す信号(STRB)
                      --! のビット数を指定する.
                      integer := 1;
        I_WIDTH     : --! @brief INPUT WORD WIDTH :
                      --! 入力側のデータのワード数を指定する.
                      integer := 1;
        O_WIDTH     : --! @brief OUTPUT WORD WIDTH :
                      --! 出力側のデータのワード数を指定する.
                      integer := 1;
        QUEUE_SIZE  : --! @brief QUEUE SIZE :
                      --! キューの大きさをワード数で指定する.
                      --! * QUEUE_SIZE=0を指定した場合は、キューの深さは自動的に
                      --!   O_WIDTH+I_WIDTH+I_WIDTH-1 に設定される.
                      --! * QUEUE_SIZE<O_WIDTH+I_WIDTH-1の場合は、キューの深さは
                      --!   自動的にO_WIDTH+I_WIDTH-1に設定される.
                      integer := 0;
        VALID_MIN   : --! @brief BUFFER VALID MINIMUM NUMBER :
                      --! VALID信号の配列の最小値を指定する.
                      integer := 0;
        VALID_MAX   : --! @brief BUFFER VALID MAXIMUM NUMBER :
                      --! VALID信号の配列の最大値を指定する.
                      integer := 0;
        O_VAL_SIZE  : --! @brief OUTPUT WORD VALID SIZE :
                      --! O_VAL 信号アサート時のキューに入っているワード数.
                      --! * キューに O_VAL_SIZE 以上のワード数が入っていると O_VAL 
                      --!   信号をアサートする.
                      --! * 互換性維持のため O_VAL_SIZE=0を指定した場合は、キューに
                      --!   O_WIDTH 以上のワード数が入っていると O_VAL 信号をアサー
                      --!   トする.
                      integer := 0;
        O_SHIFT_MIN : --! @brief OUTPUT SHIFT SIZE MINIMUM NUMBER :
                      --! O_SHIFT信号の配列の最小値を指定する.
                      integer := 1;
        O_SHIFT_MAX : --! @brief OUTPUT SHIFT SIZE MINIMUM NUMBER :
                      --! O_SHIFT信号の配列の最大値を指定する.
                      integer := 1;
        I_JUSTIFIED : --! @brief INPUT WORD JUSTIFIED :
                      --! 入力側の有効なデータが常にLOW側に詰められていることを
                      --! 示すフラグ.
                      --! * 常にLOW側に詰められている場合は、シフタが必要なくなる
                      --!   ため回路が簡単になる.
                      integer range 0 to 1 := 0;
        FLUSH_ENABLE: --! @brief FLUSH ENABLE :
                      --! FLUSH/I_FLUSHによるフラッシュ処理を有効にするかどうかを
                      --! 指定する.
                      --! * FLUSHとDONEとの違いは、DONEは最後のデータの出力時に
                      --!   キューの状態をすべてクリアするのに対して、
                      --!   FLUSHは最後のデータの出力時にSTRBだけをクリアしてVALは
                      --!   クリアしない.
                      --!   そのため次の入力データは、最後のデータの次のワード位置
                      --!   から格納される.
                      --! * フラッシュ処理を行わない場合は、0を指定すると回路が若干
                      --!   簡単になる.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 各種制御信号
    -------------------------------------------------------------------------------
        START       : --! @brief START :
                      --! 開始信号.
                      --! * この信号はOFFSETを内部に設定してキューを初期化する.
                      --! * 最初にデータ入力と同時にアサートしても構わない.
                      in  std_logic := '0';
        OFFSET      : --! @brief OFFSET :
                      --! 最初のワードの出力位置を指定する.
                      --! * START信号がアサートされた時のみ有効.
                      --! * O_WIDTH>I_WIDTHの場合、最初のワードデータを出力する際の
                      --!   オフセットを設定できる.
                      --! * 例えばWORD_BITS=8、I_WIDTH=1(1バイト入力)、O_WIDTH=4(4バイト出力)の場合、
                      --!   OFFSET="0000"に設定すると、最初に入力したバイトデータは
                      --!   1バイト目から出力される.    
                      --!   OFFSET="0001"に設定すると、最初に入力したバイトデータは
                      --!   2バイト目から出力される.    
                      --!   OFFSET="0011"に設定すると、最初に入力したバイトデータは
                      --!   3バイト目から出力される.    
                      --!   OFFSET="0111"に設定すると、最初に入力したバイトデータは
                      --!   4バイト目から出力される.    
                      in  std_logic_vector(O_WIDTH-1 downto 0) := (others => '0');
        DONE        : --! @brief DONE :
                      --! 終了信号.
                      --! * この信号をアサートすることで、キューに残っているデータ
                      --!   を掃き出す.
                      --!   その際、最後のワードと同時にO_DONE信号がアサートされる.
                      --! * FLUSH信号との違いは、FLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        FLUSH       : --! @brief FLUSH :
                      --! フラッシュ信号.
                      --! * この信号をアサートすることで、キューに残っているデータ
                      --!   を掃き出す.
                      --!   その際、最後のワードと同時にO_FLUSH信号がアサートされる.
                      --! * DONE信号との違いは、FLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        BUSY        : --! @brief BUSY :
                      --! ビジー信号.
                      --! * 最初にデータが入力されたときにアサートされる.
                      --! * 最後のデータが出力し終えたらネゲートされる.
                      out std_logic;
        VALID       : --! @brief QUEUE VALID FLAG :
                      --! キュー有効信号.
                      --! * 対応するインデックスのキューに有効なワードが入って
                      --!   いるかどうかを示すフラグ.
                      out std_logic_vector(VALID_MAX downto VALID_MIN);
    -------------------------------------------------------------------------------
    -- 入力側 I/F
    -------------------------------------------------------------------------------
        I_ENABLE    : --! @brief INPUT ENABLE :
                      --! 入力許可信号.
                      --! * この信号がアサートされている場合、キューの入力を許可する.
                      --! * この信号がネゲートされている場合、I_RDY アサートされない.
                      in  std_logic := '1';
        I_DATA      : --! @brief INPUT WORD DATA :
                      --! ワードデータ入力.
                      in  std_logic_vector(I_WIDTH*WORD_BITS-1 downto 0);
        I_STRB      : --! @brief INPUT WORD ENABLE :
                      --! ワードストローブ信号入力.
                      in  std_logic_vector(I_WIDTH*STRB_BITS-1 downto 0);
        I_DONE      : --! @brief INPUT WORD DONE :
                      --! 最終ワード信号入力.
                      --! * 最後の力ワードデータ入であることを示すフラグ.
                      --! * 基本的にはDONE信号と同じ働きをするが、I_DONE信号は
                      --!   最後のワードデータを入力する際に同時にアサートする.
                      --! * I_FLUSH信号との違いはFLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        I_FLUSH     : --! @brief INPUT WORD FLUSH :
                      --! 最終ワード信号入力.
                      --! * 最後のワードデータ入力であることを示すフラグ.
                      --! * 基本的にはFLUSH信号と同じ働きをするが、I_FLUSH信号は
                      --!   最後のワードデータを入力する際に同時にアサートする.
                      --! * I_DONE信号との違いはFLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        I_VAL       : --! @brief INPUT WORD VALID :
                      --! 入力ワード有効信号.
                      --! * I_DATA/I_STRB/I_DONE/I_FLUSHが有効であることを示す.
                      --! * I_VAL='1'and I_RDY='1'でワードデータがキューに取り込まれる.
                      in  std_logic;
        I_RDY       : --! @brief INPUT WORD READY :
                      --! 入力レディ信号.
                      --! * キューが次のワードデータを入力出来ることを示す.
                      --! * I_VAL='1'and I_RDY='1'でワードデータがキューに取り込まれる.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側 I/F
    -------------------------------------------------------------------------------
        O_ENABLE    : --! @brief OUTPUT ENABLE :
                      --! 出力許可信号.
                      --! * この信号がアサートされている場合、キューの出力を許可する.
                      --! * この信号がネゲートされている場合、O_VAL アサートされない.
                      in  std_logic := '1';
        O_DATA      : --! @brief OUTPUT WORD DATA :
                      --! ワードデータ出力.
                      out std_logic_vector(O_WIDTH*WORD_BITS-1 downto 0);
        O_STRB      : --! @brief OUTPUT WORD ENABLE :
                      --! ワードストローブ信号出力.
                      out std_logic_vector(O_WIDTH*STRB_BITS-1 downto 0);
        O_DONE      : --! @brief OUTPUT WORD DONE :
                      --! 最終ワード信号出力.
                      --! * 最後のワードデータ出力であることを示すフラグ.
                      --! * O_FLUSH信号との違いはFLUSH_ENABLEの項を参照.
                      out std_logic;
        O_FLUSH     : --! @brief OUTPUT WORD FLUSH :
                      --! 最終ワード信号出力.
                      --! * 最後のワードデータ出力であることを示すフラグ.
                      --! * O_DONE信号との違いはFLUSH_ENABLEの項を参照.
                      out std_logic;
        O_VAL       : --! @brief OUTPUT WORD VALID :
                      --! 出力ワード有効信号.
                      --! * O_DATA/O_STRB/O_DONE/O_FLUSHが有効であることを示す.
                      --! * O_VAL='1'and O_RDY='1'でワードデータがキューから取り除かれる.
                      out std_logic;
        O_RDY       : --! @brief OUTPUT WORD READY :
                      --! 出力レディ信号.
                      --! * キューから次のワードを取り除く準備が出来ていることを示す.
                      --! * O_VAL='1'and O_RDY='1'でワードデータがキューから取り除かれる.
                      in  std_logic;
        O_SHIFT     : --! @brief OUTPUT SHIFT SIZE :
                      --! 出力シフトサイズ信号.
                      --! * キューからワードを出力する際に、何ワード取り除くかを指定する.
                      --! * O_VAL='1' and O_RDY='1'の場合にのみこの信号は有効.
                      --! * 取り除くワードの位置に'1'をセットする.
                      --! * 例) O_SHIFT_MAX=3、O_SHIFT_MIN=0の場合、    
                      --!   O_SHIFT(3 downto 0)="1111" で4ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0111" で3ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0011" で2ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0001" で1ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0000" で取り除かない.    
                      --!   上記以外の値を指定した場合は動作を保証しない.
                      --! * 例) O_SHIFT_MAX=3、O_SHIFT_MIN=2の場合、    
                      --!   O_SHIFT(3 downto 2)="11" で4ワード取り除く.    
                      --!   O_SHIFT(3 downto 2)="01" で3ワード取り除く.    
                      --!   O_SHIFT(3 downto 2)="00" で2ワード取り除く.    
                      --!   上記以外の値を指定した場合は動作を保証しない.
                      --! * 例) O_SHIFT_MAX=1、O_SHIFT_MIN=1の場合、    
                      --!   O_SHIFT(1 downto 1)="1" で2ワード取り除く.    
                      --!   O_SHIFT(1 downto 1)="0" で1ワード取り除く.
                      --! * 例) O_SHIFT_MAX=0、O_SHIFT_MIN=0の場合、    
                      --!   O_SHIFT(0 downto 0)="1" で1ワード取り除く.    
                      --!   O_SHIFT(0 downto 0)="0" で取り除かない.
                      --! * 出力ワード数(O_WIDTH)分だけ取り除きたい場合は、
                      --!   O_SHIFT_MAX=O_WIDTH、O_SHIFT_MIN=O_WIDTH、
                      --!   O_SHIFT=(others => '0') としておくと良い.
                      in  std_logic_vector(O_SHIFT_MAX downto O_SHIFT_MIN) := (others => '0')
    );
end REDUCER;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
architecture RTL of REDUCER is
    -------------------------------------------------------------------------------
    --! @brief ワード単位でデータ/データストローブ信号/ワード有効フラグをまとめておく.
    -------------------------------------------------------------------------------
    type      WORD_TYPE    is record
              DATA          : std_logic_vector(WORD_BITS-1 downto 0);
              STRB          : std_logic_vector(STRB_BITS-1 downto 0);
              VAL           : boolean;
    end record;
    -------------------------------------------------------------------------------
    --! @brief WORD TYPE の初期化時の値.
    -------------------------------------------------------------------------------
    constant  WORD_NULL     : WORD_TYPE := (DATA => (others => '0'),
                                            STRB => (others => '0'),
                                            VAL  => FALSE);
    -------------------------------------------------------------------------------
    --! @brief WORD TYPE の配列の定義.
    -------------------------------------------------------------------------------
    type      WORD_VECTOR  is array (INTEGER range <>) of WORD_TYPE;
    -------------------------------------------------------------------------------
    --! @brief 整数の最小値を求める関数.
    -------------------------------------------------------------------------------
    function  minimum(L,R : integer) return integer is
    begin
        if (L < R) then return L;
        else            return R;
        end if;
    end function;
    -------------------------------------------------------------------------------
    --! @brief 指定されたベクタのリダクション論理和を求める.
    -------------------------------------------------------------------------------
    function  or_reduce(Arg : std_logic_vector) return std_logic is
        variable result : std_logic;
    begin
        result := '0';
        for i in Arg'range loop
            result := result or Arg(i);
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief 入力信号のうち最も低い位置の'1'だけを取り出す関数.
    -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    -- 例) Data(0 to 3) = "1110" => SEL(0 to 3) = "1000"
    --     Data(0 to 3) = "0111" => SEL(0 to 3) = "0100"
    --     Data(0 to 3) = "0011" => SEL(0 to 3) = "0010"
    --     Data(0 to 3) = "0001" => SEL(0 to 3) = "0001"
    --     Data(0 to 3) = "0000" => SEL(0 to 3) = "0000"
    --     Data(0 to 3) = "0101" => SEL(0 to 3) = "0101" <- このような入力は禁止
    -------------------------------------------------------------------------------
    function  priority_selector(
                 Data    : std_logic_vector
    )            return    std_logic_vector
    is
        variable result  : std_logic_vector(Data'range);
    begin
        for i in Data'range loop
            if (i = Data'low) then
                result(i) := Data(i);
            else
                result(i) := Data(i) and (not Data(i-1));
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief ワードの配列からSELで指定されたワードを選択する関数.
    -------------------------------------------------------------------------------
    function  select_word(
                 WORDS   :  WORD_VECTOR;
                 SEL     :  std_logic_vector
    )            return     WORD_TYPE
    is
        alias    i_words :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        alias    i_sel   :  std_logic_vector(0 to   SEL'length-1) is SEL;
        variable result  :  WORD_TYPE;
        variable s_vec   :  std_logic_vector(0 to WORDS'length-1);
    begin
        for n in WORD_BITS-1 downto 0 loop
            for i in i_words'range loop
                if (i_sel'low <= i and i <= i_sel'high) then
                    s_vec(i) := i_words(i).DATA(n) and i_sel(i);
                else
                    s_vec(i) := '0';
                end if;
            end loop;
            result.DATA(n) := or_reduce(s_vec);
        end loop;
        for n in STRB_BITS-1 downto 0 loop
            for i in i_words'range loop
                if (i_sel'low <= i and i <= i_sel'high) then
                    s_vec(i) := i_words(i).STRB(n) and i_sel(i);
                else
                    s_vec(i) := '0';
                end if;
            end loop;
            result.STRB(n) := or_reduce(s_vec);
        end loop;
        for i in i_words'range loop
            if (i_sel'low <= i and i <= i_sel'high) then
                if (i_words(i).VAL and i_sel(i) = '1') then
                    s_vec(i) := '1';
                else
                    s_vec(i) := '0';
                end if;
            else
                    s_vec(i) := '0';
            end if;
        end loop;
        result.VAL := (or_reduce(s_vec) = '1');
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューの最後にワードを追加した新しいキューを求める関数.
    -------------------------------------------------------------------------------
    function  append_words(
                 QUEUE   :  WORD_VECTOR;
                 WORDS   :  WORD_VECTOR
    )            return     WORD_VECTOR
    is
        alias    i_vec   :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        variable i_val   :  std_logic_vector(0 to WORDS'length-1);
        variable i_sel   :  std_logic_vector(0 to WORDS'length-1);
        type     bv      is array (INTEGER range <>) of boolean;
        variable q_val   :  bv(QUEUE'low to QUEUE'high);
        variable result  :  WORD_VECTOR     (QUEUE'range);
    begin
        for q in QUEUE'range loop
            q_val(q) := QUEUE(q).VAL;
        end loop;
        for q in QUEUE'range loop 
            if (q_val(q) = FALSE) then
                for i in i_val'range loop
                    if (q-i-1 >= QUEUE'low) then
                        if (q_val(q-i-1)) then
                            i_val(i) := '1';
                        else
                            i_val(i) := '0';
                        end if;
                    else
                            i_val(i) := '1';
                    end if;
                end loop;
                i_sel := priority_selector(i_val);
                result(q) := select_word(WORDS=>i_vec, SEL=>i_sel);
            else
                result(q) := QUEUE(q);
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief O_SHIFT信号からONE-HOTのセレクト信号を生成する関数.
    -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    -- 例) SHIFT(3 downto 0)="0000" => SEL(0 to 4)=(0=>'1',1=>'0',2=>'0',3=>'0',4=>'0')
    --     SHIFT(3 downto 0)="0001" => SEL(0 to 4)=(0=>'0',1=>'1',2=>'0',3=>'0',4=>'0')
    --     SHIFT(3 downto 0)="0011" => SEL(0 to 4)=(0=>'0',1=>'0',2=>'1',3=>'0',4=>'0')
    --     SHIFT(3 downto 0)="0111" => SEL(0 to 4)=(0=>'0',1=>'0',2=>'0',3=>'1',4=>'0')
    --     SHIFT(3 downto 0)="1111" => SEL(0 to 4)=(0=>'0',1=>'0',2=>'0',3=>'0',4=>'1')
    -------------------------------------------------------------------------------
    function  shift_to_selector(
                 SHIFT   :  std_logic_vector;
                 MIN     :  integer;
                 MAX     :  integer
    )            return     std_logic_vector
    is
        variable result  :  std_logic_vector(MIN to MAX);
    begin
        for i in result'range loop
            if    (i < SHIFT'low ) then
                    result(i) := '0';
            elsif (i = SHIFT'low ) then
                if (SHIFT(i) = '0') then
                    result(i) := '1';
                else
                    result(i) := '0';
                end if;
            elsif (i <= SHIFT'high) then
                if (SHIFT(i) = '0' and SHIFT(i-1) = '1') then
                    result(i) := '1';
                else
                    result(i) := '0';
                end if;
            elsif (i = SHIFT'high+1) then
                if (SHIFT(i-1) = '1') then
                    result(i) := '1';
                else
                    result(i) := '0';
                end if;
            else
                    result(i) := '0';
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief ワード配列の有効なデータをLOW側に詰めたワード配列を求める関数.
    -------------------------------------------------------------------------------
    function  justify_words(
                 WORDS   :  WORD_VECTOR
    )            return     WORD_VECTOR
    is
        alias    i_vec   :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        variable i_val   :  std_logic_vector(0 to WORDS'length-1);
        variable s_vec   :  WORD_VECTOR     (0 to WORDS'length-1);
        variable s_sel   :  std_logic_vector(0 to WORDS'length-1);
        variable result  :  WORD_VECTOR     (0 to WORDS'length-1);
    begin
        for i in i_vec'range loop
            if (i_vec(i).VAL) then
                i_val(i) := '1';
            else
                i_val(i) := '0';
            end if;
        end loop;
        s_sel := priority_selector(i_val);
        for i in result'range loop
            result(i) := select_word(
                WORDS => i_vec(i to WORDS'length-1  ),
                SEL   => s_sel(0 to WORDS'length-i-1)
            );
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューを指定した分だけLOW側にシフトした新しいキューを求める関数.
    -------------------------------------------------------------------------------
    function  shift_words(
                 WORDS   :  WORD_VECTOR;
                 SHIFT   :  std_logic_vector
    )            return     WORD_VECTOR
    is
        alias    i_vec   :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        variable i_sel   :  std_logic_vector(0 to SHIFT'high  +1);
        variable result  :  WORD_VECTOR     (0 to WORDS'length-1);
    begin
        i_sel := shift_to_selector(SHIFT, i_sel'low, i_sel'high);
        for i in result'range loop
            result(i) := select_word(
                WORDS => i_vec(i to minimum(i+i_sel'high,i_vec'high)),
                SEL   => i_sel
            );
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューから指定した分だけキューに残して残りを削除したキューを求める関数.
    -------------------------------------------------------------------------------
    function  flush_words(
                 WORDS   :  WORD_VECTOR;
                 SHIFT   :  std_logic_vector
    )            return     WORD_VECTOR
    is
        alias    i_vec   :  WORD_VECTOR(0 to WORDS'length-1) is WORDS;
        variable result  :  WORD_VECTOR(0 to WORDS'length-1);
    begin
        for i in result'range loop
            if    (i <  SHIFT'low ) then
                result(i).VAL := i_vec(i).VAL;
            elsif (i <= SHIFT'high) then
                result(i).VAL := i_vec(i).VAL and (SHIFT(i) = '1');
            else
                result(i).VAL := FALSE;
            end if;
            result(i).DATA := (others => '0');
            result(i).STRB := (others => '0');
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューに入っているワード数がSHIFTで指定された数未満かどうかを求める関数
    -------------------------------------------------------------------------------
    function  words_less_than_shift_size(
                 WORDS   :  WORD_VECTOR;
                 SHIFT   :  std_logic_vector
    )            return     boolean
    is
        alias    i_vec   :  WORD_VECTOR(0 to WORDS'length-1) is WORDS;
        variable result  :  boolean;
    begin
        result := FALSE;
        for i in SHIFT'high downto i_vec'low loop
            if (i < SHIFT'low) then
                if (i_vec(i).VAL = FALSE) then
                    result := TRUE;
                end if;
            else
                if (i_vec(i).VAL = FALSE and SHIFT(i) = '1') then
                    result := TRUE;
                end if;
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューに入っているワード数がSHIFTで指定された数を越えているかどうかを求める関数
    -------------------------------------------------------------------------------
    function  words_more_than_shift_size(
                 WORDS   :  WORD_VECTOR;
                 SHIFT   :  std_logic_vector
    )            return     boolean
    is
        alias    i_vec   :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        variable i_sel   :  std_logic_vector(0 to SHIFT'high  +1);
        variable result  :  boolean;
    begin
        i_sel  := shift_to_selector(SHIFT, i_sel'low, i_sel'high);
        result := FALSE;
        for i in i_vec'range loop
            if (i_sel'low <= i and i <= i_sel'high) then
                if (i_sel(i) = '1' and i_vec(i).VAL) then
                    result := TRUE;
                end if;
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューのサイズを計算する関数.
    -------------------------------------------------------------------------------
    function  QUEUE_DEPTH return integer is begin
        if (QUEUE_SIZE > 0) then
            if (QUEUE_SIZE >= O_WIDTH+I_WIDTH-1) then
                return QUEUE_SIZE;
            else
                assert (QUEUE_SIZE >= I_WIDTH+O_WIDTH-1)
                    report "require QUEUE_SIZE >= I_WIDTH+O_WIDTH-1" severity WARNING;
                return O_WIDTH+I_WIDTH-1;
            end if;
        else
                return O_WIDTH+I_WIDTH+I_WIDTH-1;
        end if;
    end function;
    -------------------------------------------------------------------------------
    --! @brief 現在のキューの状態.
    -------------------------------------------------------------------------------
    signal    curr_queue    : WORD_VECTOR(0 to QUEUE_DEPTH-1);
    -------------------------------------------------------------------------------
    --! @brief 1ワード分のイネーブル信号がオール0であることを示す定数.
    -------------------------------------------------------------------------------
    constant  STRB_NULL     : std_logic_vector(STRB_BITS-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    --! @brief FLUSH 出力フラグ.
    -------------------------------------------------------------------------------
    signal    flush_output  : std_logic;
    -------------------------------------------------------------------------------
    --! @brief FLUSH 保留フラグ.
    -------------------------------------------------------------------------------
    signal    flush_pending : std_logic;
    -------------------------------------------------------------------------------
    --! @brief DONE 出力フラグ.
    -------------------------------------------------------------------------------
    signal    done_output   : std_logic;
    -------------------------------------------------------------------------------
    --! @brief DONE 保留フラグ.
    -------------------------------------------------------------------------------
    signal    done_pending  : std_logic;
    -------------------------------------------------------------------------------
    --! @brief O_VAL信号を内部で使うための信号.
    -------------------------------------------------------------------------------
    signal    o_valid       : std_logic;
    -------------------------------------------------------------------------------
    --! @brief I_RDY信号を内部で使うための信号.
    -------------------------------------------------------------------------------
    signal    i_ready       : std_logic;
    -------------------------------------------------------------------------------
    --! @brief BUSY信号を内部で使うための信号.
    -------------------------------------------------------------------------------
    signal    curr_busy     : std_logic;
begin
    -------------------------------------------------------------------------------
    -- メインプロセス
    -------------------------------------------------------------------------------
    process (CLK, RST) 
        variable    in_words          : WORD_VECTOR(0 to I_WIDTH-1);
        variable    next_queue        : WORD_VECTOR(curr_queue'range);
        variable    next_valid_output : boolean;
        variable    next_flush_output : std_logic;
        variable    next_flush_pending: std_logic;
        variable    next_flush_fall   : std_logic;
        variable    next_done_output  : std_logic;
        variable    next_done_pending : std_logic;
        variable    next_done_fall    : std_logic;
        variable    pending_flag      : boolean;
        variable    flush_output_done : boolean;
        variable    flush_output_last : boolean;
    begin
        if (RST = '1') then
                curr_queue    <= (others => WORD_NULL);
                flush_output  <= '0';
                flush_pending <= '0';
                done_output   <= '0';
                done_pending  <= '0';
                i_ready       <= '0';
                o_valid       <= '0';
                curr_busy     <= '0';
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_queue    <= (others => WORD_NULL);
                flush_output  <= '0';
                flush_pending <= '0';
                done_output   <= '0';
                done_pending  <= '0';
                i_ready       <= '0';
                o_valid       <= '0';
                curr_busy     <= '0';
            else
                -------------------------------------------------------------------
                -- 次のクロックでのキューの状態を示す変数に現在のキューの状態をセット.
                -------------------------------------------------------------------
                next_queue := curr_queue;
                -------------------------------------------------------------------
                -- キュー初期化時は、OFFSETで指定された分だけ、あらかじめキューに
                -- ダミーのデータを入れておく.
                -------------------------------------------------------------------
                if (START = '1') then
                    for i in next_queue'range loop
                        if (i < O_WIDTH-1) then
                            next_queue(i).VAL := (OFFSET(i) = '1');
                        else
                            next_queue(i).VAL := FALSE;
                        end if;
                        next_queue(i).DATA := (others => '0');
                        next_queue(i).STRB := (others => '0');
                    end loop;
                end if;
                -------------------------------------------------------------------
                -- データ入力時は、キューに入力されたワードを追加する.
                -------------------------------------------------------------------
                if (I_VAL = '1' and i_ready = '1') then
                    for i in in_words'range loop
                        in_words(i).DATA :=  I_DATA((i+1)*WORD_BITS-1 downto i*WORD_BITS);
                        in_words(i).STRB :=  I_STRB((i+1)*STRB_BITS-1 downto i*STRB_BITS);
                        in_words(i).VAL  := (I_STRB((i+1)*STRB_BITS-1 downto i*STRB_BITS) /= STRB_NULL);
                    end loop;
                    if (I_JUSTIFIED     = 0) and
                       (in_words'length > 1) then
                        in_words := justify_words(in_words);
                    end if;
                    next_queue := append_words(next_queue, in_words);
                end if;
                -------------------------------------------------------------------
                -- データ出力時は、キューの先頭からO_SHIFTで指定された分だけ、
                -- データを取り除く.
                -------------------------------------------------------------------
                if (o_valid = '1' and O_RDY = '1') then
                    if (FLUSH_ENABLE >  0 ) and
                       (flush_output = '1') then
                        flush_output_last :=     words_less_than_shift_size(next_queue, O_SHIFT);
                        flush_output_done := not words_more_than_shift_size(next_queue, O_SHIFT);
                    else
                        flush_output_last := FALSE;
                        flush_output_done := FALSE;
                    end if;
                    if (flush_output_last) then
                        next_queue := flush_words(next_queue, O_SHIFT);
                    else
                        next_queue := shift_words(next_queue, O_SHIFT);
                    end if;
                else
                        flush_output_last := FALSE;
                        flush_output_done := FALSE;
                end if;
                -------------------------------------------------------------------
                -- 次のクロックでのキューの状態をレジスタに保持
                -------------------------------------------------------------------
                curr_queue <= next_queue;
                -------------------------------------------------------------------
                -- 次のクロックでのキューの状態でO_WIDTHの位置にデータが入って
                -- いるか否かをチェック.
                -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                -- この位置にデータがある場合は、O_DONE、O_FLUSH はまだアサートせ
                -- ずに、一旦ペンディングしておく.
                -------------------------------------------------------------------
                if (next_queue'high >= O_WIDTH) then
                    pending_flag := (next_queue(O_WIDTH).VAL);
                else
                    pending_flag := FALSE;
                end if;
                -------------------------------------------------------------------
                -- FLUSH制御
                -------------------------------------------------------------------
                if    (FLUSH_ENABLE = 0) then
                        next_flush_output  := '0';
                        next_flush_pending := '0';
                        next_flush_fall    := '0';
                elsif (flush_output = '1') then
                    if (flush_output_done) then
                        next_flush_output  := '0';
                        next_flush_pending := '0';
                        next_flush_fall    := '1';
                    else
                        next_flush_output  := '1';
                        next_flush_pending := '0';
                        next_flush_fall    := '0';
                    end if;
                elsif (flush_pending = '1') or
                      (FLUSH         = '1') or
                      (I_VAL = '1' and i_ready = '1' and I_FLUSH = '1') then
                    if (pending_flag) then
                        next_flush_output  := '0';
                        next_flush_pending := '1';
                        next_flush_fall    := '0';
                    else
                        next_flush_output  := '1';
                        next_flush_pending := '0';
                        next_flush_fall    := '0';
                    end if;
                else
                        next_flush_output  := '0';
                        next_flush_pending := '0';
                        next_flush_fall    := '0';
                end if;
                flush_output  <= next_flush_output;
                flush_pending <= next_flush_pending;
                -------------------------------------------------------------------
                -- DONE制御
                -------------------------------------------------------------------
                if    (done_output = '1') then
                    if (next_queue(next_queue'low).VAL = FALSE) then
                        next_done_output   := '0';
                        next_done_pending  := '0';
                        next_done_fall     := '1';
                    else
                        next_done_output   := '1';
                        next_done_pending  := '0';
                        next_done_fall     := '0';
                    end if;
                elsif (done_pending = '1') or
                      (DONE         = '1') or
                      (I_VAL = '1' and i_ready = '1' and I_DONE = '1') then
                    if (pending_flag) then
                        next_done_output   := '0';
                        next_done_pending  := '1';
                        next_done_fall     := '0';
                    else
                        next_done_output   := '1';
                        next_done_pending  := '0';
                        next_done_fall     := '0';
                    end if;
                else
                        next_done_output   := '0';
                        next_done_pending  := '0';
                        next_done_fall     := '0';
                end if;
                done_output   <= next_done_output;
                done_pending  <= next_done_pending;
                -------------------------------------------------------------------
                -- 出力有効信号の生成.
                -------------------------------------------------------------------
                if (O_VAL_SIZE = 0) then
                    next_valid_output := next_queue(O_WIDTH   -1).VAL;
                else
                    next_valid_output := next_queue(O_VAL_SIZE-1).VAL;
                end if;
                if (O_ENABLE = '1') and
                   ((next_done_output  = '1') or
                    (next_flush_output = '1') or
                    (next_valid_output = TRUE)) then
                    o_valid <= '1';
                else
                    o_valid <= '0';
                end if;
                -------------------------------------------------------------------
                -- 入力可能信号の生成.
                -------------------------------------------------------------------
                if (I_ENABLE = '1') and 
                   (next_done_output  = '0' and next_done_pending  = '0') and
                   (next_flush_output = '0' and next_flush_pending = '0') and
                   (next_queue(next_queue'length-I_WIDTH).VAL = FALSE) then
                    i_ready <= '1';
                else
                    i_ready <= '0';
                end if;
                -------------------------------------------------------------------
                -- 現在処理中であることを示すフラグ.
                -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                -- 最初に入力があった時点で'1'になり、O_DONEまたはO_FLUSHが出力完了
                -- した時点で'0'になる。
                -------------------------------------------------------------------
                if (curr_busy = '1') then
                    if (next_flush_fall = '1') or
                       (next_done_fall  = '1') then
                        curr_busy <= '0';
                    else
                        curr_busy <= '1';
                    end if;
                else
                    if (I_VAL = '1' and i_ready = '1') then
                        curr_busy <= '1';
                    else
                        curr_busy <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- 各種出力信号の生成.
    -------------------------------------------------------------------------------
    O_FLUSH <= flush_output when(FLUSH_ENABLE > 0) else '0';
    O_DONE  <= done_output;
    O_VAL   <= o_valid;
    I_RDY   <= i_ready;
    BUSY    <= curr_busy;
    process (curr_queue) begin
        for i in 0 to O_WIDTH-1 loop
            O_DATA((i+1)*WORD_BITS-1 downto i*WORD_BITS) <= curr_queue(i).DATA;
            O_STRB((i+1)*STRB_BITS-1 downto i*STRB_BITS) <= curr_queue(i).STRB;
        end loop;
        for i in VALID'range loop
            if (curr_queue'low <= i and i <= curr_queue'high) then
                if (curr_queue(i).VAL) then
                    VALID(i) <= '1';
                else
                    VALID(i) <= '0';
                end if;
            else
                    VALID(i) <= '0';
            end if;
        end loop;
    end process;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    axi4_components.vhd                                             --
--!     @brief   PIPEWORK AXI4 LIBRARY DESCRIPTION                               --
--!     @version 1.5.9                                                           --
--!     @date    2016/01/07                                                      --
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>                     --
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--                                                                               --
--      Copyright (C) 2016 Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>           --
--      All rights reserved.                                                     --
--                                                                               --
--      Redistribution and use in source and binary forms, with or without       --
--      modification, are permitted provided that the following conditions       --
--      are met:                                                                 --
--                                                                               --
--        1. Redistributions of source code must retain the above copyright      --
--           notice, this list of conditions and the following disclaimer.       --
--                                                                               --
--        2. Redistributions in binary form must reproduce the above copyright   --
--           notice, this list of conditions and the following disclaimer in     --
--           the documentation and/or other materials provided with the          --
--           distribution.                                                       --
--                                                                               --
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    --
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    --
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT         --
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    --
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    --
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT      --
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    --
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     --
--                                                                               --
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
-----------------------------------------------------------------------------------
--! @brief PIPEWORK AXI4 LIBRARY DESCRIPTION                                     --
-----------------------------------------------------------------------------------
package AXI4_COMPONENTS is
-----------------------------------------------------------------------------------
--! @brief AXI4_MASTER_ADDRESS_CHANNEL_CONTROLLER                                --
-----------------------------------------------------------------------------------
component AXI4_MASTER_ADDRESS_CHANNEL_CONTROLLER
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        VAL_BITS        : --! @brief VALID BITS :
                          --! REQ_VAL、ACK_VAL のビット数を指定する.
                          integer := 1;
        DATA_SIZE       : --! @brief DATA SIZE :
                          --! データバスのバイト数を"２のべき乗値"で指定する.
                          integer := 6;
        ADDR_BITS       : --! @brief ADDRESS BITS :
                          --! アドレス信号のビット数を指定する.
                          integer := 32;
        ALEN_BITS       : --! @brief BURST LENGTH BITS :
                          --! バースト長を示す信号のビット幅を指定する.
                          integer := AXI4_ALEN_WIDTH;
        REQ_SIZE_BITS   : --! @brief REQUEST SIZE BITS :
                          --! REQ_SIZE信号のビット数を指定する.
                          --! * REQ_SIZE信号が無効(REQ_SIZE_ENABLE=0)の場合でもエラ
                          --!   ーが発生しないように、REQ_SIZE_BITS>0にしておかなけ
                          --!   ればならない.
                          integer := 32;
        REQ_SIZE_VALID  : --! @brief REQUEST SIZE VALID :
                          --! REQ_SIZE信号を有効にするかどうかを指定する.
                          --! * REQ_SIZE_VALID=0で無効.
                          --! * REQ_SIZE_VALID=1で有効.
                          integer range 0 to 1 :=  1;
        FLOW_VALID      : --! @brief FLOW VALID :
                          --! FLOW_PAUSE、FLOW_STOP、FLOW_SIZE、FLOW_LAST信号を有効
                          --! にするかどうかを指定する.
                          --! * FLOW_VALID=0で無効.
                          --! * FLOW_VALID=1で有効.
                          integer range 0 to 1 := 1;
        XFER_SIZE_BITS  : --! @brief TRANSFER SIZE BITS :
                          --! ACK_SIZE/FLOW_SIZE信号のビット数を指定する.
                          integer := 4;
        XFER_MIN_SIZE   : --! @brief TRANSFER MINIMUM SIZE :
                          --! 一回の転送サイズの最小バイト数を２のべき乗で指定する.
                          integer := 4;
        XFER_MAX_SIZE   : --! @brief TRANSFER MAXIMUM SIZE :
                          --! 一回の転送サイズの最大バイト数を２のべき乗で指定する.
                          integer := 4;
        ACK_REGS        : --! @brief COMMAND ACKNOWLEDGE SIGNALS REGSITERED OUT :
                          --! Command Acknowledge Signals の出力をレジスタ出力に
                          --! するか否かを指定する.
                          --! * ACK_REGS=0で組み合わせ出力.
                          --! * ACK_REGS=1でレジスタ出力.
                          integer range 0 to 1 := 0
    );
    port(
    ------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    ------------------------------------------------------------------------------
        CLK             : in    std_logic;
        RST             : in    std_logic;
        CLR             : in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Address Channel Signals.
    ------------------------------------------------------------------------------
        AADDR           : out   std_logic_vector(ADDR_BITS     -1 downto 0);
        ALEN            : out   std_logic_vector(ALEN_BITS     -1 downto 0);
        ASIZE           : out   AXI4_ASIZE_TYPE;
        AVALID          : out   std_logic;
        AREADY          : in    std_logic;
    -------------------------------------------------------------------------------
    -- Command Request Signals.
    -------------------------------------------------------------------------------
        REQ_ADDR        : in    std_logic_vector(ADDR_BITS     -1 downto 0);
        REQ_SIZE        : in    std_logic_vector(REQ_SIZE_BITS -1 downto 0);
        REQ_FIRST       : in    std_logic;
        REQ_LAST        : in    std_logic;
        REQ_SPECULATIVE : in    std_logic;
        REQ_SAFETY      : in    std_logic;
        REQ_VAL         : in    std_logic_vector(VAL_BITS      -1 downto 0);
        REQ_RDY         : out   std_logic;
    -------------------------------------------------------------------------------
    -- Command Acknowledge Signals.
    -------------------------------------------------------------------------------
        ACK_VAL         : out   std_logic_vector(VAL_BITS      -1 downto 0);
        ACK_NEXT        : out   std_logic;
        ACK_LAST        : out   std_logic;
        ACK_ERROR       : out   std_logic;
        ACK_STOP        : out   std_logic;
        ACK_NONE        : out   std_logic;
        ACK_SIZE        : out   std_logic_vector(XFER_SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Flow Control Signals.
    -------------------------------------------------------------------------------
        FLOW_PAUSE      : in    std_logic := '0';
        FLOW_STOP       : in    std_logic := '0';
        FLOW_LAST       : in    std_logic := '1';
        FLOW_SIZE       : in    std_logic_vector(XFER_SIZE_BITS-1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Transfer Size Select Signals.
    -------------------------------------------------------------------------------
        XFER_SIZE_SEL   : in    std_logic_vector(XFER_MAX_SIZE    downto XFER_MIN_SIZE) := (others => '1');
    -------------------------------------------------------------------------------
    -- Transfer Request Signals.
    -------------------------------------------------------------------------------
        XFER_REQ_ADDR   : out   std_logic_vector(ADDR_BITS     -1 downto 0);
        XFER_REQ_SIZE   : out   std_logic_vector(XFER_MAX_SIZE    downto 0);
        XFER_REQ_SEL    : out   std_logic_vector(VAL_BITS      -1 downto 0);
        XFER_REQ_ALEN   : out   std_logic_vector(ALEN_BITS     -1 downto 0);
        XFER_REQ_FIRST  : out   std_logic;
        XFER_REQ_LAST   : out   std_logic;
        XFER_REQ_NEXT   : out   std_logic;
        XFER_REQ_SAFETY : out   std_logic;
        XFER_REQ_NOACK  : out   std_logic;
        XFER_REQ_VAL    : out   std_logic;
        XFER_REQ_RDY    : in    std_logic;
    -------------------------------------------------------------------------------
    -- Transfer Response Signals.
    -------------------------------------------------------------------------------
        XFER_ACK_SIZE   : in    std_logic_vector(XFER_MAX_SIZE    downto 0);
        XFER_ACK_VAL    : in    std_logic;
        XFER_ACK_NEXT   : in    std_logic;
        XFER_ACK_LAST   : in    std_logic;
        XFER_ACK_ERR    : in    std_logic;
    -------------------------------------------------------------------------------
    -- Transfer Status Signals.
    -------------------------------------------------------------------------------
        XFER_BUSY       : in    std_logic_vector(VAL_BITS      -1 downto 0);
        XFER_DONE       : in    std_logic_vector(VAL_BITS      -1 downto 0);
        XFER_ERROR      : in    std_logic_vector(VAL_BITS      -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_MASTER_TRANSFER_QUEUE                                            --
-----------------------------------------------------------------------------------
component AXI4_MASTER_TRANSFER_QUEUE
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        SEL_BITS        : --! @brief SELECT BITS :
                          --! I_SEL、O_SEL のビット数を指定する.
                          integer := 1;
        SIZE_BITS       : --! @brief SIZE BITS:
                          --! I_SIZE、O_SIZE信号のビット数を指定する.
                          integer := 32;
        ADDR_BITS       : --! @brief ADDR BITS:
                          --! I_ADDR、O_ADDR信号のビット数を指定する.
                          integer := 32;
        ALEN_BITS       : --! @brief ALEN BITS:
                          --! I_ALEN、O_ALEN信号のビット数を指定する.
                          integer := 32;
        PTR_BITS        : --! @brief PTR BITS:
                          --! I_PTR、O_PTR信号のビット数を指定する.
                          integer := 32;
        QUEUE_SIZE      : --! @brief RESPONSE QUEUE SIZE :
                          --! キューの大きさを指定する.
                          integer := 1
    );
    port(
    ------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    ------------------------------------------------------------------------------
        CLK             : in    std_logic;
        RST             : in    std_logic;
        CLR             : in    std_logic;
    ------------------------------------------------------------------------------
    -- 
    ------------------------------------------------------------------------------
        I_VALID         : in    std_logic;
        I_SEL           : in    std_logic_vector( SEL_BITS-1 downto 0);
        I_SIZE          : in    std_logic_vector(SIZE_BITS-1 downto 0);
        I_ADDR          : in    std_logic_vector(ADDR_BITS-1 downto 0);
        I_ALEN          : in    std_logic_vector(ALEN_BITS-1 downto 0);
        I_PTR           : in    std_logic_vector( PTR_BITS-1 downto 0);
        I_NEXT          : in    std_logic;
        I_LAST          : in    std_logic;
        I_FIRST         : in    std_logic;
        I_SAFETY        : in    std_logic;
        I_NOACK         : in    std_logic;
        I_READY         : out   std_logic;
    ------------------------------------------------------------------------------
    -- 
    ------------------------------------------------------------------------------
        Q_VALID         : out   std_logic;
        Q_SEL           : out   std_logic_vector( SEL_BITS-1 downto 0);
        Q_SIZE          : out   std_logic_vector(SIZE_BITS-1 downto 0);
        Q_ADDR          : out   std_logic_vector(ADDR_BITS-1 downto 0);
        Q_ALEN          : out   std_logic_vector(ALEN_BITS-1 downto 0);
        Q_PTR           : out   std_logic_vector( PTR_BITS-1 downto 0);
        Q_NEXT          : out   std_logic;
        Q_LAST          : out   std_logic;
        Q_FIRST         : out   std_logic;
        Q_SAFETY        : out   std_logic;
        Q_NOACK         : out   std_logic;
        Q_READY         : in    std_logic;
    ------------------------------------------------------------------------------
    -- 
    ------------------------------------------------------------------------------
        O_VALID         : out   std_logic;
    ------------------------------------------------------------------------------
    -- 
    ------------------------------------------------------------------------------
        BUSY            : out   std_logic_vector( SEL_BITS-1 downto 0);
        DONE            : out   std_logic_vector( SEL_BITS-1 downto 0);
        EMPTY           : out   std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_MASTER_READ_INTERFACE                                            --
-----------------------------------------------------------------------------------
component AXI4_MASTER_READ_INTERFACE
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 リードアドレスチャネルのARADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 READ DATA CHANNEL DATA WIDTH :
                          --! AXI4 リードデータチャネルのRDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびリードデータチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        VAL_BITS        : --! @brief VALID BITS :
                          --! REQ_VAL、ACK_VAL のビット数を指定する.
                          integer := 1;
        REQ_SIZE_BITS   : --! @brief REQUEST SIZE BITS:
                          --! REQ_SIZE信号のビット数を指定する.
                          integer := 32;
        REQ_SIZE_VALID  : --! @brief REQUEST SIZE VALID :
                          --! REQ_SIZE信号を有効にするかどうかを指定する.
                          --! * REQ_SIZE_VALID=0で無効.
                          --! * REQ_SIZE_VALID=1で有効.
                          integer range 0 to 1 :=  1;
        FLOW_VALID      : --! @brief FLOW VALID :
                          --! FLOW_PAUSE、FLOW_STOP、FLOW_SIZE、FLOW_LAST信号を有効
                          --! にするかどうかを指定する.
                          --! * FLOW_VALID=0で無効.
                          --! * FLOW_VALID=1で有効.
                          integer range 0 to 1 := 1;
        BUF_DATA_WIDTH  : --! @brief BUFFER DATA WIDTH :
                          --! バッファのビット幅を指定する.
                          integer := 32;
        BUF_PTR_BITS    : --! @brief BUFFER POINTER BITS :
                          --! バッファポインタなどを表す信号のビット数を指定する.
                          integer := 8;
        ALIGNMENT_BITS  : --! @brief ALIGNMENT BITS :
                          --! アライメントサイズのビット数を指定する.
                          integer := 8;
        XFER_SIZE_BITS  : --! @brief Transfer Size Bits :
                          --! １回の転送バイト数入出力信号(ACK_SIZE/FLOW_SIZE/
                          --! PULL_SIZE/PUSH_SIZEなど)のビット幅を指定する.
                          integer := 12;
        XFER_MIN_SIZE   : --! @brief TRANSFER MINIMUM SIZE :
                          --! 一回の転送サイズの最小バイト数を２のべき乗で指定する.
                          integer := 4;
        XFER_MAX_SIZE   : --! @brief TRANSFER MAXIMUM SIZE :
                          --! 一回の転送サイズの最大バイト数を２のべき乗で指定する.
                          integer := 4;
        QUEUE_SIZE      : --! @brief TRANSACTION QUEUE SIZE :
                          --! キューの大きさを指定する.
                          integer := 1;
        RDATA_REGS      : --! @brief RDATA REGISTER TYPE :
                          --! RDATA/RRESP/RLAST/RVALID の入力をどうするか指定する.
                          --! * RDATA_REGS=0 スルー入力(レジスタは通さない).
                          --! * RDATA_REGS=1 １段だけレジスタを通す. 
                          --!   ただしバースト転送時には１サイクル毎にウェイトが入る.
                          --! * RDATA_REGS=2 ２段のレジスタを通す.
                          --! * RDATA_REGS=3 ３段のレジスタを通す.
                          --!   このモードの場合、必ずRDATA/RRESPは一つのレジスタ
                          --!   で受けるので外部インターフェース向き.
                          integer := 0;
        ACK_REGS        : --! @brief COMMAND ACKNOWLEDGE SIGNALS REGSITERED OUT :
                          --! Command Acknowledge Signals の出力をレジスタ出力に
                          --! するか否かを指定する.
                          --! * ACK_REGS=0で組み合わせ出力.
                          --! * ACK_REGS=1でレジスタ出力.
                          integer range 0 to 1 := 0
    );
    port(
    ------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    ------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Read Address Channel Signals.
    ------------------------------------------------------------------------------
        ARID            : --! @brief Read address ID.
                          --! This signal is identification tag for the read
                          --! address group of singals.
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        ARADDR          : --! @brief Read address.  
                          --! The read address gives the address of the first
                          --! transfer in a read burst transaction.
                          out   std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        ARLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          out   std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        ARSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          out   AXI4_ASIZE_TYPE;
        ARBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          out   AXI4_ABURST_TYPE;
        ARLOCK          : --! @brief Lock type.
                          --! This signal provides additional information about
                          --! the atomic characteristics of the transfer.
                          out   std_logic_vector(AXI4_ALOCK_WIDTH -1 downto 0);
        ARCACHE         : --! @brief Memory type.
                          --! This signal indicates how transactions are required
                          --! to progress through a system.
                          out   AXI4_ACACHE_TYPE;
        ARPROT          : --! @brief Protection type.
                          --! This signal indicates the privilege and security
                          --! level of the transaction, and wherther the
                          --! transaction is a data access or an instruction access.
                          out   AXI4_APROT_TYPE;
        ARQOS           : --! @brief Quality of Service, QoS.
                          --! QoS identifier sent for each read transaction.
                          out   AXI4_AQOS_TYPE;
        ARREGION        : --! @brief Region identifier.
                          --! Permits a single physical interface on a slave to be
                          --! used for multiple logical interfaces.
                          out   AXI4_AREGION_TYPE;
        ARVALID         : --! @brief Read address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          out   std_logic;
        ARREADY         : --! @brief Read address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Read Data Channel Signals.
    ------------------------------------------------------------------------------
        RID             : --! @brief Read ID tag.
                          --! This signal is the identification tag for the read
                          --! data group of signals generated by the slave.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        RDATA           : --! @brief Read data.
                          in    std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        RRESP           : --! @brief Read response.
                          --! This signal indicates the status of the read transaction.
                          in    AXI4_RESP_TYPE;
        RLAST           : --! @brief Read last.
                          --! This signal indicates the last transfer in a read burst.
                          in    std_logic;
        RVALID          : --! @brief Read data valid.
                          --! This signal indicates that the channel is signaling
                          --! the required read data.
                          in    std_logic;
        RREADY          : --! @brief Read data ready.
                          --! This signal indicates that the master can accept the
                          --! read data and response information.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- Command Request Signals.
    -------------------------------------------------------------------------------
        XFER_SIZE_SEL   : --! @brief Max Transfer Size Select Signal.
                          --! 一回の転送サイズの最大バイト数を指定する.  
                          --! * XFER_MAX_SIZE=XFER_MIN_SIZEの場合は、この信号は無視
                          --!   される.
                          in    std_logic_vector(XFER_MAX_SIZE downto XFER_MIN_SIZE)
                          := (others => '1');
        REQ_ADDR        : --! @brief Request Address.
                          --! 転送開始アドレスを指定する.  
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        REQ_SIZE        : --! @brief Request Transfer Size.
                          --! 転送したいバイト数を指定する. 
                          --! * REQ_SIZE_VALID=0の場合は、この信号は無視される.
                          --! * この値が後述の XFER_SIZE_SEL 信号で示される最大転送
                          --!   バイト数および FLOW_SIZE 信号で示される転送バイト数
                          --!   を越える場合は、そちらの方が優先される.
                          in    std_logic_vector(REQ_SIZE_BITS    -1 downto 0);
        REQ_ID          : --! @brief Request ID.
                          --! ARID の値を指定する.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        REQ_BURST       : --! @brief Request Burst type.
                          --! バーストタイプを指定する.  
                          --! * このモジュールでは AXI4_ABURST_INCR と AXI4_ABURST_FIXED
                          --!   のみをサポートしている.
                          in    AXI4_ABURST_TYPE;
        REQ_LOCK        : --! @brief Request Lock type.
                          --! ARLOCK の値を指定する.
                          in    std_logic_vector(AXI4_ALOCK_WIDTH -1 downto 0);
        REQ_CACHE       : --! @brief Request Memory type.
                          --! ARCACHE の値を指定する.
                          in    AXI4_ACACHE_TYPE;
        REQ_PROT        : --! @brief Request Protection type.
                          --! ARPROT の値を指定する.
                          in    AXI4_APROT_TYPE;
        REQ_QOS         : --! @brief Request Quality of Service.
                          --! ARQOS の値を指定する.
                          in    AXI4_AQOS_TYPE;
        REQ_REGION      : --! @brief Request Region identifier.
                          --! ARREGION の値を指定する.
                          in    AXI4_AREGION_TYPE;
        REQ_BUF_PTR     : --! @brief Request Write Buffer Pointer.
                          --! ライトバッファの先頭ポインタの値を指定する.
                          --! * ライトバッファのこのポインタの位置からRDATAを書き込
                          --!   む.
                          in    std_logic_vector(BUF_PTR_BITS     -1 downto 0);
        REQ_FIRST       : --! @brief Request First Transaction.
                          --! 最初のトランザクションであることを示す.
                          --! * REQ_FIRST=1の場合、内部状態を初期化してからトランザ
                          --!   クションを開始する.
                          in    std_logic;
        REQ_LAST        : --! @brief Request Last Transaction.
                          --! 最後のトランザクションであることを示す.
                          --! * REQ_LAST=1の場合、Acknowledge を返す際に、すべての
                          --!   トランザクションが終了していると、ACK_LAST 信号をア
                          --!   サートする.
                          --! * REQ_LAST=0の場合、Acknowledge を返す際に、すべての
                          --!   トランザクションが終了していると、ACK_NEXT 信号をア
                          --!   サートする.
                          in    std_logic;
        REQ_SPECULATIVE : --! @brief Request Speculative Mode.
                          --! Acknowledge を返すタイミングを投機モードで行うかどう
                          --! かを指定する.
                          in    std_logic;
        REQ_SAFETY      : --! @brief Request Safety Mode.
                          --! Acknowledge を返すタイミングを安全モードで行うかどう
                          --! かを指定する.
                          --! * REQ_SAFETY=1の場合、スレーブから最初の Read Data が
                          --!   帰ってきた時点で Acknowledge を返す.
                          --! * REQ_SAFETY=0の場合、スレーブから最後の Read Data が
                          --!   帰ってきた時点で Acknowledge を返す.
                          in    std_logic;
        REQ_VAL         : --! @brief Request Valid Signal.
                          --! 上記の各種リクエスト信号が有効であることを示す.
                          --! * この信号のアサートでもってトランザクションを開始する.
                          --! * 一度この信号をアサートすると Acknowledge を返すまで、
                          --!   この信号はアサートされなくてはならない.
                          in    std_logic_vector(VAL_BITS-1 downto 0);
        REQ_RDY         : --! @brief Request Ready Signal.
                          --! 上記の各種リクエスト信号を受け付け可能かどうかを示す.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- Command Acknowledge Signals.
    -------------------------------------------------------------------------------
        ACK_VAL         : --! @brief Acknowledge Valid Signal.
                          --! 上記の Command Request の応答信号.
                          --! 下記の 各種 Acknowledge 信号が有効である事を示す.
                          --! * この信号のアサートでもって、Command Request が受け
                          --!   付けられたことを示す. ただし、あくまでも Request が
                          --!   受け付けられただけであって、必ずしもトランザクショ
                          --!   ンが完了したわけではないことに注意.
                          --! * この信号は Request につき１クロックだけアサートされ
                          --!   る.
                          --! * この信号がアサートされたら、アプリケーション側は速
                          --!   やかに REQ_VAL 信号をネゲートして Request を取り下
                          --!   げるか、REQ_VALをアサートしたままで次の Request 情
                          --!   報を用意しておかなければならない.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        ACK_NEXT        : --! @brief Acknowledge with need Next transaction.
                          --! すべてのトランザクションが終了かつ REQ_LAST=0 の場合、
                          --! この信号がアサートされる.
                          out   std_logic;
        ACK_LAST        : --! @brief Acknowledge with Last transaction.
                          --! すべてのトランザクションが終了かつ REQ_LAST=1 の場合、
                          --! この信号がアサートされる.
                          out   std_logic;
        ACK_ERROR       : --! @brief Acknowledge with Error.
                          --! トランザクション中になんらかのエラーが発生した場合、
                          --! この信号がアサートされる.
                          out   std_logic;
        ACK_STOP        : --! @brief Acknowledge with Stop operation.
                          --! トランザクションが中止された場合、この信号がアサート
                          --! される.
                          out   std_logic;
        ACK_NONE        : --! @brief Acknowledge with None Request transfer size.
                          --! REQ_SIZE=0 の Request だった場合、この信号がアサート
                          --! される.
                          out   std_logic;
        ACK_SIZE        : --! @brief Acknowledge transfer size.
                          --! 転送するバイト数を示す.
                          --! REQ_ADDR、REQ_SIZE、REQ_BUF_PTRなどは、この信号で示さ
                          --! れるバイト数分を加算/減算すると良い.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Transfer Status Signal.
    -------------------------------------------------------------------------------
        XFER_BUSY       : --! @brief Transfer Busy.
                          --! このモジュールが未だデータの転送中であることを示す.
                          --! * QUEUE_SIZEの設定によっては、XFER_BUSY がアサートさ
                          --!   れていても、次のリクエストを受け付け可能な場合があ
                          --!   る.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_ERROR      : --! @brief Transfer Error.
                          --! データの転送中にエラーが発生した事を示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_DONE       : --! @brief Transfer Done.
                          --! このモジュールが未だデータの転送中かつ、次のクロック
                          --! で XFER_BUSY がネゲートされる事を示す.
                          --! * ただし、XFER_BUSY のネゲート前に 必ずしもこの信号が
                          --!   アサートされるわけでは無い.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
    -------------------------------------------------------------------------------
    -- Flow Control Signals.
    -------------------------------------------------------------------------------
        FLOW_STOP       : --! @brief Flow Stop.
                          --! 転送中止信号.
                          --! * 転送を中止する時はこの信号をアサートする.
                          --! * 一旦アサートしたら、完全に停止するまで(XFER_BUSYが
                          --!   ネゲートされるまで)、アサートしたままにしておかなけ
                          --!   ればならない.
                          --! * ただし、一度 AXI4 に発行したトランザクションは中止
                          --!   出来ない.
                          --! * FLOW_VALID=0の場合、この信号は無視される.
                          in    std_logic := '0';
        FLOW_PAUSE      : --! @brief Flow Pause.
                          --! 転送一時中断信号.
                          --! * 転送を一時中断する時はこの信号をアサートする.
                          --! * 転送を再開したい時はこの信号をネゲートする.
                          --! * ただし、一度 AXI4 に発行したトランザクションは中断
                          --!   出来ない. あくまでも、次に発行する予定のトランザク
                          --!   ションを一時的に停めるだけ.
                          --! * 例えば FIFO の空き容量が一定値未満になった時に、こ
                          --!   の信号をアサートすると、再びネゲートするまで転送を
                          --!   中断する.
                          --! * FLOW_VALID=0の場合、この信号は無視される.
                          in    std_logic := '0';
        FLOW_LAST       : --! @brief Flow Last.
                          --! 最後の転送であることを示す.
                          --! * FLOW_PAUSE='0'の時のみ有効.
                          --! * FLOW_VALID=0の場合、この信号は無視される.
                          in    std_logic := '1';
        FLOW_SIZE       : --! @brief Flow Size.
                          --! 転送するバイト数を指定する.
                          --! * FLOW_PAUSE='0'の時のみ有効.
                          --! * 例えば FIFO の空き容量を入力すると、この容量を越え
                          --!   た転送は行わない.
                          --! * FLOW_VALID=0の場合、この信号は無視される.
                          in    std_logic_vector(XFER_SIZE_BITS   -1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Push Reserve Size Signals.
    -------------------------------------------------------------------------------
        PUSH_RSV_VAL    : --! @brief Push Reserve Valid.
                          --! PUSH_RSV_LAST/PUSH_RSV_ERROR/PUSH_RSV_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS -1 downto 0);
        PUSH_RSV_LAST   : --! @brief Push Reserve Last.
                          --! 最後の転送"する予定"である事を示すフラグ.
                          out   std_logic;
        PUSH_RSV_ERROR  : --! @brief Push Reserve Error.
                          --! 転送"する予定"がエラーだった事を示すフラグ.
                          out   std_logic;
        PUSH_RSV_SIZE   : --! @brief Push Reserve Size.
                          --! 転送"する予定"のバイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Push Final Size Signals.
    -------------------------------------------------------------------------------
        PUSH_FIN_VAL    : --! @brief Push Final Valid.
                          --! PUSH_FIN_LAST/PUSH_FIN_ERROR/PUSH_FIN_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PUSH_FIN_LAST   : --! @brief Push Final Last.
                          --! 最後の転送"した事"を示すフラグ.
                          out   std_logic;
        PUSH_FIN_ERROR  : --! @brief Push Final Error.
                          --! 転送"した事"がエラーだった事を示すフラグ.
                          out   std_logic;
        PUSH_FIN_SIZE   : --! @brief Push Final Size.
                          --! 転送"した"バイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Push Buffer Size Signals.
    -------------------------------------------------------------------------------
        PUSH_BUF_RESET  : --! @brief Push Buffer Counter Reset.
                          --! バッファのカウンタをリセットする信号.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PUSH_BUF_VAL    : --! @brief Push Buffer Valid.
                          --! PUSH_BUF_LAST/PUSH_BUF_ERROR/PUSH_BUF_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PUSH_BUF_LAST   : --! @brief Push Buffer Last.
                          --! 最後の転送"した事"を示すフラグ.
                          out   std_logic;
        PUSH_BUF_ERROR  : --! @brief Push Buffer Error.
                          --! 転送"した事"がエラーだった事を示すフラグ.
                          out   std_logic;
        PUSH_BUF_SIZE   : --! @brief Push Buffer Size.
                          --! 転送"した"バイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
        PUSH_BUF_RDY    : --! @brief Push Buffer Ready.
                          --! バッファにデータを書き込み可能な事をを示す.
                          in    std_logic_vector(VAL_BITS         -1 downto 0);
    -------------------------------------------------------------------------------
    -- Read Buffer Interface Signals.
    -------------------------------------------------------------------------------
        BUF_WEN         : --! @brief Buffer Write Enable.
                          --! バッファにデータをライトすることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        BUF_BEN         : --! @brief Buffer Byte Enable.
                          --! バッファにデータをライトする際のバイトイネーブル信号.
                          --! * BUF_WEN='1'の場合にのみ有効.
                          --! * BUF_WEN='0'の場合のこの信号の値は不定.
                          out   std_logic_vector(BUF_DATA_WIDTH/8 -1 downto 0);
        BUF_DATA        : --! @brief Buffer Data.
                          --! バッファへライトするデータを出力する.
                          out   std_logic_vector(BUF_DATA_WIDTH   -1 downto 0);
        BUF_PTR         : --! @brief Buffer Write Pointer.
                          --! ライト時にデータを書き込むバッファの位置を出力する.
                          out   std_logic_vector(BUF_PTR_BITS     -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_MASTER_WRITE_INTERFACE                                           --
-----------------------------------------------------------------------------------
component AXI4_MASTER_WRITE_INTERFACE
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 ライトアドレスチャネルのAWADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 WRITE DATA CHANNEL DATA WIDTH :
                          --! AXI4 ライトデータチャネルのWDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびライトレスポンスチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        VAL_BITS        : --! @brief VALID BITS :
                          --! REQ_VAL、ACK_VAL のビット数を指定する.
                          integer := 1;
        REQ_SIZE_BITS   : --! @brief REQUEST SIZE BITS:
                          --! REQ_SIZE信号のビット数を指定する.
                          integer := 32;
        REQ_SIZE_VALID  : --! @brief REQUEST SIZE VALID :
                          --! REQ_SIZE信号を有効にするかどうかを指定する.
                          --! * REQ_SIZE_VALID=0で無効.
                          --! * REQ_SIZE_VALID=1で有効.
                          integer range 0 to 1 :=  1;
        FLOW_VALID      : --! @brief FLOW VALID :
                          --! FLOW_PAUSE、FLOW_STOP、FLOW_SIZE、FLOW_LAST信号を有効
                          --! にするかどうかを指定する.
                          --! * FLOW_VALID=0で無効.
                          --! * FLOW_VALID=1で有効.
                          integer range 0 to 1 := 1;
        BUF_DATA_WIDTH  : --! @brief BUFFER DATA WIDTH :
                          --! バッファのビット幅を指定する.
                          integer := 32;
        BUF_PTR_BITS    : --! @brief BUFFER POINTER BITS :
                          --! バッファポインタなどを表す信号のビット数を指定する.
                          integer := 8;
        ALIGNMENT_BITS  : --! @brief ALIGNMENT BITS :
                          --! アライメントサイズのビット数を指定する.
                          integer := 8;
        XFER_SIZE_BITS  : --! @brief Transfer Size Bits :
                          --! １回の転送バイト数入出力信号(ACK_SIZE/FLOW_SIZE/
                          --! PULL_SIZE/PUSH_SIZEなど)のビット幅を指定する.
                          integer := 12;
        XFER_MIN_SIZE   : --! @brief TRANSFER MINIMUM SIZE :
                          --! 一回の転送サイズの最小バイト数を２のべき乗で指定する.
                          integer := 4;
        XFER_MAX_SIZE   : --! @brief TRANSFER MAXIMUM SIZE :
                          --! 一回の転送サイズの最大バイト数を２のべき乗で指定する.
                          integer := 4;
        QUEUE_SIZE      : --! @brief RESPONSE QUEUE SIZE :
                          --! レスンポンスのキューの大きさを指定する.
                          --! レスンポンスのキューの大きさは１以上. 
                          --! QUEUE_SIZE=0を指定した場合は、強制的にキューの大きさ
                          --! は１に設定される.
                          integer := 1;
        REQ_REGS        : --! @brief REQUEST REGISTER USE :
                          --! ライトトランザクションの最初のデータ出力のタイミング
                          --! を指定する.
                          --! * REQ_REGS=0でアドレスの出力と同時にデータを出力する.
                          --! * REQ_REGS=1でアドレスを出力してから１クロック後に
                          --!   データを出力する.
                          --! * REQ_REGS=1にすると動作周波数が向上する可能性がある.
                          integer range 0 to 1 := 0;
        ACK_REGS        : --! @brief COMMAND ACKNOWLEDGE SIGNALS REGSITERED OUT :
                          --! Command Acknowledge Signals の出力をレジスタ出力に
                          --! するか否かを指定する.
                          --! * ACK_REGS=0で組み合わせ出力.
                          --! * ACK_REGS=1でレジスタ出力.
                          integer range 0 to 1 := 0;
        RESP_REGS       : --! @brief RESPONSE REGISTER USE :
                          --! レスポンスの入力側にレジスタを挿入する.
                          integer range 0 to 1 := 0
    );
    port(
    ------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    ------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Write Address Channel Signals.
    ------------------------------------------------------------------------------
        AWID            : --! @brief Write address ID.
                          --! This signal is identification tag for the write
                          --! address group of singals.
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        AWADDR          : --! @brief Write address.  
                          --! The read address gives the address of the first
                          --! transfer in a write burst transaction.
                          out   std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        AWLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          out   std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        AWSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          out   AXI4_ASIZE_TYPE;
        AWBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          out   AXI4_ABURST_TYPE;
        AWLOCK          : --! @brief Lock type.
                          --! This signal provides additional information about
                          --! the atomic characteristics of the transfer.
                          out   std_logic_vector(AXI4_ALOCK_WIDTH -1 downto 0);
        AWCACHE         : --! @brief Memory type.
                          --! This signal indicates how transactions are required
                          --! to progress through a system.
                          out   AXI4_ACACHE_TYPE;
        AWPROT          : --! @brief Protection type.
                          --! This signal indicates the privilege and security
                          --! level of the transaction, and wherther the
                          --! transaction is a data access or an instruction access.
                          out   AXI4_APROT_TYPE;
        AWQOS           : --! @brief Quality of Service, QoS.
                          --! QoS identifier sent for each read transaction.
                          out   AXI4_AQOS_TYPE;
        AWREGION        : --! @brief Region identifier.
                          --! Permits a single physical interface on a slave to be
                          --! used for multiple logical interfaces.
                          out   AXI4_AREGION_TYPE;
        AWVALID         : --! @brief Write address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          out   std_logic;
        AWREADY         : --! @brief Write address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Write Data Channel Signals.
    ------------------------------------------------------------------------------
        WID             : --! @brief Write ID tag.
                          --! This signal is the identification tag for the write
                          --! data transfer. Supported only AXI3.
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        WDATA           : --! @brief Write data.
                          out   std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        WSTRB           : --! @brief Write strobes.
                          --! This signal indicates which byte lanes holdvalid 
                          --! data. There is one write strobe bit for each eight
                          --! bits of the write data bus.
                          out   std_logic_vector(AXI4_DATA_WIDTH/8-1 downto 0);
        WLAST           : --! @brief Write last.
                          --! This signal indicates the last transfer in a write burst.
                          out   std_logic;
        WVALID          : --! @brief Write valid.
                          --! This signal indicates that valid write data and
                          --! strobes are available.
                          out   std_logic;
        WREADY          : --! @brief Write ready.
                          --! This signal indicates that the slave can accept the
                          --! write data.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Write Response Channel Signals.
    ------------------------------------------------------------------------------
        BID             : --! @brief Response ID tag.
                          --! This signal is the identification tag of write
                          --! response .
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        BRESP           : --! @brief Write response.
                          --! This signal indicates the status of the write transaction.
                          in    AXI4_RESP_TYPE;
        BVALID          : --! @brief Write response valid.
                          --! This signal indicates that the channel is signaling
                          --! a valid write response.
                          in    std_logic;
        BREADY          : --! @brief Write response ready.
                          --! This signal indicates that the master can accept a
                          --! write response.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- Command Request Signals.
    -- これらの信号は Command Acknowledge Signal(ACK_VAL)がアサートされるまで変更し
    -- てはならない.
    -------------------------------------------------------------------------------
        XFER_SIZE_SEL   : --! @brief Max Transfer Size Select Signal.
                          --! 一回の転送サイズの最大バイト数を指定する.  
                          --! * XFER_MAX_SIZE=XFER_MIN_SIZEの場合は、この信号は無視
                          --!   される.
                          in    std_logic_vector(XFER_MAX_SIZE downto XFER_MIN_SIZE)
                          := (others => '1');
        REQ_ADDR        : --! @brief Request Address.
                          --! 転送開始アドレスを指定する.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        REQ_SIZE        : --! @brief Request Transfer Size.
                          --! 転送したいバイト数を指定する.
                          --! * REQ_SIZE_VALID=0の場合は、この信号は無視される.
                          --! * この値が後述の XFER_SIZE_SEL 信号で示される最大転送
                          --!   バイト数および FLOW_SIZE 信号で示される転送バイト数
                          --!   を越える場合は、そちらの方が優先される.
                          in    std_logic_vector(REQ_SIZE_BITS    -1 downto 0);
        REQ_ID          : --! @brief Request ID.
                          --! AWID および WID の値を指定する.  
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        REQ_BURST       : --! @brief Request Burst type.
                          --! バーストタイプを指定する.  
                          --! * このモジュールでは AXI4_ABURST_INCR と AXI4_ABURST_FIXED
                          --!   のみをサポートしている.
                          in    AXI4_ABURST_TYPE;
        REQ_LOCK        : --! @brief Request Lock type.
                          --! AWLOCK の値を指定する.
                          in    std_logic_vector(AXI4_ALOCK_WIDTH -1 downto 0);
        REQ_CACHE       : --! @brief Request Memory type.
                          --! AWCACHE の値を指定する.
                          in    AXI4_ACACHE_TYPE;
        REQ_PROT        : --! @brief Request Protection type.
                          --! AWPROT の値を指定する.
                          in    AXI4_APROT_TYPE;
        REQ_QOS         : --! @brief Request Quality of Service.
                          --! AWQOS の値を指定する.
                          in    AXI4_AQOS_TYPE;
        REQ_REGION      : --! @brief Request Region identifier.
                          --! AWREGION の値を指定する.
                          in    AXI4_AREGION_TYPE;
        REQ_BUF_PTR     : --! @brief Request Read Buffer Pointer.
                          --! リードバッファの先頭ポインタの値を指定する.  
                          --! * リードバッファのこのポインタの位置からデータを読み
                          --!   込んで、WDATAに出力する.
                          in    std_logic_vector(BUF_PTR_BITS     -1 downto 0);
        REQ_FIRST       : --! @brief Request First Transaction.
                          --! 最初のトランザクションであることを示す.  
                          --! * REQ_FIRST=1の場合、内部状態を初期化してからトランザ
                          --!   クションを開始する.
                          in    std_logic;
        REQ_LAST        : --! @brief Request Last Transaction.
                          --! 最後のトランザクションであることを示す.
                          --! * REQ_LAST=1の場合、Acknowledge を返す際に、すべての
                          --!   トランザクションが終了していると、ACK_LAST 信号をア
                          --!   サートする.
                          --! * REQ_LAST=0の場合、Acknowledge を返す際に、すべての
                          --!   トランザクションが終了していると、ACK_NEXT 信号をア
                          --!   サートする.
                          in    std_logic;
        REQ_SPECULATIVE : --! @brief Request Speculative Mode.
                          --! Acknowledge を返すタイミングを投機モードで行うかどう
                          --! かを指定する.
                          in    std_logic;
        REQ_SAFETY      : --! @brief Request Safety Mode.
                          --! Acknowledge を返すタイミングを安全モードで行うかどう
                          --! かを指定する.
                          --! * REQ_SAFETY=1の場合、スレーブから Write Response が
                          --!   帰ってきた時点で Acknowledge を返す.
                          --! * REQ_SAFETY=0の場合、スレーブに最後のデータを出力し
                          --!   た時点で Acknowledge を返す. 応答を待たないので、
                          --!   エラーが発生しても分からない.
                          in    std_logic;
        REQ_VAL         : --! @brief Request Valid Signal.
                          --! 上記の各種リクエスト信号が有効であることを示す.
                          --! * この信号のアサートでもってトランザクションを開始する.
                          --! * 一度この信号をアサートすると Acknowledge を返すまで、
                          --!   この信号はアサートされなくてはならない.
                          in    std_logic_vector(VAL_BITS         -1 downto 0);
        REQ_RDY         : --! @brief Request Ready Signal.
                          --! 上記の各種リクエスト信号を受け付け可能かどうかを示す.
                          --! * QUEUE_SIZEの設定によっては、XFER_BUSY がアサートさ
                          --!   れていても、次のリクエストを受け付け可能な場合があ
                          --!   る
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- Command Acknowledge Signals.
    -------------------------------------------------------------------------------
        ACK_VAL         : --! @brief Acknowledge Valid Signal.
                          --! 上記の Command Request の応答信号.
                          --! 下記の 各種 Acknowledge 信号が有効である事を示す.
                          --! * この信号のアサートでもって、Command Request が受け
                          --!   付けられたことを示す. ただし、あくまでも Request が
                          --!   受け付けられただけであって、必ずしもトランザクショ
                          --!   ンが完了したわけではないことに注意.
                          --! * この信号は Request につき１クロックだけアサートされ
                          --!   る.
                          --! * この信号がアサートされたら、アプリケーション側は速
                          --!   やかに REQ_VAL 信号をネゲートして Request を取り下
                          --!   げるか、REQ_VALをアサートしたままで次の Request 情
                          --!   報を用意しておかなければならない.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        ACK_NEXT        : --! @brief Acknowledge with need Next transaction.
                          --! すべてのトランザクションが終了かつ REQ_LAST=0 の場合、
                          --! この信号がアサートされる.
                          out   std_logic;
        ACK_LAST        : --! @brief Acknowledge with Last transaction.
                          --! すべてのトランザクションが終了かつ REQ_LAST=1 の場合、
                          --! この信号がアサートされる.
                          out   std_logic;
        ACK_ERROR       : --! @brief Acknowledge with Error.
                          --! トランザクション中になんらかのエラーが発生した場合、
                          --! この信号がアサートされる.
                          out   std_logic;
        ACK_STOP        : --! @brief Acknowledge with Stop operation.
                          --! トランザクションが中止された場合、この信号がアサート
                          --! される.
                          out   std_logic;
        ACK_NONE        : --! @brief Acknowledge with None Request transfer size.
                          --! REQ_SIZE=0 の Request だった場合、この信号がアサート
                          --! される.
                          out   std_logic;
        ACK_SIZE        : --! @brief Acknowledge transfer size.
                          --! 転送するバイト数を示す.
                          --! REQ_ADDR、REQ_SIZE、REQ_BUF_PTRなどは、この信号で示さ
                          --! れるバイト数分を加算/減算すると良い.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Transfer Status Signal.
    -------------------------------------------------------------------------------
        XFER_BUSY       : --! @brief Transfer Busy.
                          --! このモジュールが未だデータの転送中であることを示す.
                          --! * QUEUE_SIZEの設定によっては、XFER_BUSY がアサートさ
                          --!   れていても、次のリクエストを受け付け可能な場合があ
                          --!   る.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_ERROR      : --! @brief Transfer Error.
                          --! データの転送中にエラーが発生した事を示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_DONE       : --! @brief Transfer Done.
                          --! このモジュールが未だデータの転送中かつ、次のクロック
                          --! で XFER_BUSY がネゲートされる事を示す.
                          --! * ただし、XFER_BUSY のネゲート前に 必ずしもこの信号が
                          --!   アサートされるわけでは無い.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
    -------------------------------------------------------------------------------
    -- Flow Control Signals.
    -------------------------------------------------------------------------------
        FLOW_STOP       : --! @brief Flow Stop.
                          --! 転送中止信号.
                          --! * 転送を中止する時はこの信号をアサートする.
                          --! * 一旦アサートしたら、完全に停止するまで(XFER_BUSYが
                          --!   ネゲートされるまで)、アサートしたままにしておかなけ
                          --!   ればならない.
                          --! * ただし、一度 AXI4 に発行したトランザクションは中止
                          --!   出来ない.
                          --! * FLOW_VALID=0の場合、この信号は無視される.
                          in    std_logic := '0';
        FLOW_PAUSE      : --! @brief Flow Pause.
                          --! 転送一時中断信号.
                          --! * 転送を一時中断する時はこの信号をアサートする.
                          --! * 転送を再開したい時はこの信号をネゲートする.
                          --! * ただし、一度 AXI4 に発行したトランザクションは中断
                          --!   出来ない. あくまでも、次に発行する予定のトランザク
                          --!   ションを一時的に停めるだけ.
                          --! * 例えば FIFO に格納されているデータのバイト数が、あ
                          --!   る一定の値未満の時にこの信号をアサートするようにし
                          --!   ておくと、再びある一定の値以上になってこの信号がネ
                          --!   ゲートされるまで、転送を中断しておける.
                          --! * FLOW_VALID=0の場合、この信号は無視される.
                          in    std_logic := '0';
        FLOW_LAST       : --! 最後の転送であることを示す.
                          --! * FLOW_PAUSE='0'の時のみ有効.
                          --! * 例えば FIFO に残っているデータで最後の時に、この信
                          --!   号をアサートしておけば、最後のデータを出力し終えた
                          --!   時点で、転送をする.
                          --! * FLOW_VALID=0の場合、この信号は無視される.
                          in    std_logic := '1';
        FLOW_SIZE       : --! @brief Flow Size.
                          --! 転送するバイト数を指定する.
                          --! * FLOW_PAUSE='0'の時のみ有効.
                          --! * 例えば FIFO に残っているデータの容量を入力しておく
                          --!   と、そのバイト数を越えた転送は行わない.
                          --! * FLOW_VALID=0の場合、この信号は無視される.
                          in    std_logic_vector(XFER_SIZE_BITS   -1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Pull Reserve Size Signals.
    -------------------------------------------------------------------------------
        PULL_RSV_VAL    : --! @brief Pull Reserve Valid.
                          --! PULL_RSV_LAST/PULL_RSV_ERROR/PULL_RSV_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PULL_RSV_LAST   : --! @brief Pull Reserve Last.
                          --! 最後の転送"する予定"である事を示すフラグ.
                          out   std_logic;
        PULL_RSV_ERROR  : --! @brief Pull Reserve Error.
                          --! 転送"する予定"がエラーだった事を示すフラグ.
                          out   std_logic;
        PULL_RSV_SIZE   : --! @brief Pull Reserve Size.
                          --! 転送"する予定"のバイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Pull Final Size Signals.
    -------------------------------------------------------------------------------
        PULL_FIN_VAL    : --! @brief Pull Final Valid.
                          --! PULL_FIN_LAST/PULL_FIN_ERROR/PULL_FIN_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PULL_FIN_LAST   : --! @brief Pull Final Last.
                          --! 最後の転送"した事"を示すフラグ.
                          out   std_logic;
        PULL_FIN_ERROR  : --! @brief Pull Final Error.
                          --! 転送"した事"がエラーだった事を示すフラグ.
                          out   std_logic;
        PULL_FIN_SIZE   : --! @brief Pull Final Size.
                          --! 転送"した"バイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Pull Buffer Size Signals.
    -------------------------------------------------------------------------------
        PULL_BUF_RESET  : --! @brief Pull Buffer Counter Reset.
                          --! バッファのカウンタをリセットする信号.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PULL_BUF_VAL    : --! @brief Pull Buffer Valid.
                          --! PULL_BUF_LAST/PULL_BUF_ERROR/PULL_BUF_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PULL_BUF_LAST   : --! @brief Pull Buffer Last.
                          --! 最後の転送"した事"を示すフラグ.
                          out   std_logic;
        PULL_BUF_ERROR  : --! @brief Pull Buffer Error.
                          --! 転送"した事"がエラーだった事を示すフラグ.
                          out   std_logic;
        PULL_BUF_SIZE   : --! @brief Pull Buffer Size.
                          --! 転送"した"バイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
        PULL_BUF_RDY    : --! @brief Pull Buffer Valid.
                          --! バッファからデータを読み出し可能な事をを示す.
                          in    std_logic_vector(VAL_BITS         -1 downto 0);
    -------------------------------------------------------------------------------
    -- Read Buffer Interface Signals.
    -------------------------------------------------------------------------------
        BUF_REN         : --! @brief Buffer Read Enable.
                          --! バッファからデータをリードすることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        BUF_DATA        : --! @brief Buffer Data.
                          --! バッファからリードしたデータを入力する.
                          in    std_logic_vector(BUF_DATA_WIDTH   -1 downto 0);
        BUF_PTR         : --! @brief Buffer Read Pointer.
                          --! 次にリードするデータのバッファの位置を出力する.
                          --! * この信号の１クロック後に、バッファからリードした
                          --!   データを BUF_DATA に入力すること.
                          out   std_logic_vector(BUF_PTR_BITS     -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_SLAVE_READ_INTERFACE                                             --
-----------------------------------------------------------------------------------
component AXI4_SLAVE_READ_INTERFACE
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 ライトアドレスチャネルのAWADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 READ DATA CHANNEL DATA WIDTH :
                          --! AXI4 ライトデータチャネルのWDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびライトレスポンスチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        XFER_SIZE_BITS  : --! @brief TRANSFER SIZE BITS :
                          --! 各種サイズカウンタのビット数を指定する.
                          integer := 32;
        VAL_BITS        : --! @brief VALID BITS :
                          --! XFER_BUSY、XFER_DONE、PULL_FIN_VAL、PULL_RSV_VAL信号の
                          --! ビット数を指定する.
                          integer := 1;
        BUF_DATA_WIDTH  : --! @brief BUFFER DATA WIDTH :
                          --! バッファのビット幅を指定する.
                          integer := 32;
        BUF_PTR_BITS    : --! @brief BUFFER POINTER BITS :
                          --! バッファポインタなどを表す信号のビット数を指定する.
                          integer := 8;
        ALIGNMENT_BITS  : --! @brief ALIGNMENT BITS :
                          --! アライメントサイズのビット数を指定する.
                          integer := 8
    );
    port(
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Read Address Channel Signals.
    -------------------------------------------------------------------------------
        ARID            : --! @brief Read address ID.
                          --! This signal is identification tag for the read
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        ARADDR          : --! @brief Read address.  
                          --! The read address gives the address of the first
                          --! transfer in a read burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        ARLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        ARSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        ARBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        ARVALID         : --! @brief Read address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        ARREADY         : --! @brief Read address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Read Data Channel Signals.
    ------------------------------------------------------------------------------
        RID             : --! @brief Read ID tag.
                          --! This signal is the identification tag for the read
                          --! data group of signals generated by the slave.
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        RDATA           : --! @brief Read data.
                          out   std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        RRESP           : --! @brief Read response.
                          --! This signal indicates the status of the read transaction.
                          out   AXI4_RESP_TYPE;
        RLAST           : --! @brief Read last.
                          --! This signal indicates the last transfer in a read burst.
                          out   std_logic;
        RVALID          : --! @brief Read data valid.
                          --! This signal indicates that the channel is signaling
                          --! the required read data.
                          out   std_logic;
        RREADY          : --! @brief Read data ready.
                          --! This signal indicates that the master can accept the
                          --! read data and response information.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- Command Request Signals.
    -------------------------------------------------------------------------------
        REQ_ADDR        : --! @brief Request Address.
                          --! 転送開始アドレスを指定する.  
                          out   std_logic_vector(AXI4_ADDR_WIDTH-1 downto 0);
        REQ_SIZE        : --! @brief Request Size.
                          --! 転送要求バイト数を指定する.  
                          out   std_logic_vector(XFER_SIZE_BITS -1 downto 0);
        REQ_ID          : --! @brief Request ID.
                          --! ARID の値を指定する.
                          out   std_logic_vector(AXI4_ID_WIDTH  -1 downto 0);
        REQ_BURST       : --! @brief Request Burst type.
                          --! バーストタイプを指定する.  
                          --! * このモジュールでは AXI4_ABURST_INCR と AXI4_ABURST_FIXED
                          --!   のみをサポートしている.
                          out   AXI4_ABURST_TYPE;
        REQ_VAL         : --! @brief Request Valid Signal.
                          --! 上記の各種リクエスト信号が有効であることを示す.
                          --! * この信号のアサートでもってトランザクションを開始する.
                          --! * 一度この信号をアサートすると Acknowledge を返すまで、
                          --!   この信号はアサートされなくてはならない.
                          out   std_logic;
        REQ_START       : --! @brief Request Start Signal.
                          --! REQ_VAL信号がアサートされた最初のサイクルだけアサート
                          --! される.
                          out   std_logic;
        REQ_RDY         : --! @brief Request Ready Signal.
                          --! 上記の各種リクエスト信号を受け付け可能かどうかを示す.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- Command Acknowledge Signals.
    -------------------------------------------------------------------------------
        ACK_VAL         : --! @brief Acknowledge Valid Signal.
                          --! 上記の Command Request の応答信号.
                          --! 下記の 各種 Acknowledge 信号が有効である事を示す.
                          --! * この信号のアサートでもって、Command Request が受け
                          --!   付けられたことを示す. ただし、あくまでも Request が
                          --!   受け付けられただけであって、必ずしもトランザクショ
                          --!   ンが完了したわけではないことに注意.
                          --! * この信号は Request につき１クロックだけアサートされ
                          --!   る.
                          --! * この信号がアサートされたら、アプリケーション側は速
                          --!   やかに REQ_VAL 信号をネゲートして Request を取り下
                          --!   げるか、REQ_VALをアサートしたままで次の Request 情
                          --!   報を用意しておかなければならない.
                          in    std_logic;
        ACK_NEXT        : --! @brief Acknowledge with need Next transaction.
                          --! すべてのトランザクションが終了かつ REQ_LAST=0 の場合、
                          --! この信号がアサートされる.
                          in    std_logic;
        ACK_LAST        : --! @brief Acknowledge with Last transaction.
                          --! すべてのトランザクションが終了かつ REQ_LAST=1 の場合、
                          --! この信号がアサートされる.
                          in    std_logic;
        ACK_ERROR       : --! @brief Acknowledge with Error.
                          --! トランザクション中になんらかのエラーが発生した場合、
                          --! この信号がアサートされる.
                          in    std_logic;
        ACK_SIZE        : --! @brief Acknowledge transfer size.
                          --! 転送するバイト数を示す.
                          --! REQ_ADDR、REQ_SIZE、REQ_BUF_PTRなどは、この信号で示さ
                          --! れるバイト数分を加算/減算すると良い.
                          in    std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Transfer Control Signal.
    -------------------------------------------------------------------------------
        XFER_START      : --! @brief Transfer Start.
                          --! データ転送開始を指示する信号.
                          --! * 下記の各種リクエスト信号が有効であることを示す.
                          in    std_logic;
        XFER_LAST       : --! @brief Transfer Last.
                          --! 最後の転送であることを指示する信号.
                          --! * XFER_START 信号がアサートされている時のみ有効.
                          in    std_logic;
        XFER_SEL        : --! @brief Transfer Select.
                          --! XFER_BUSY、XFER_DONE、PULL_FIN_VAL、PULL_RSV_VAL 信号
                          --! の生成パターンを指定する.
                          --! * XFER_START 信号がアサートされている時のみ有効.
                          in    std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_BUF_PTR    : --! @brief Transfer Write Buffer Pointer.
                          --! ライトバッファの先頭ポインタの値を指定する.
                          --! * XFER_START 信号がアサートされている時のみ有効.
                          --! * ライトバッファのこのポインタの位置からRDATAを書き込
                          --!   む.
                          in    std_logic_vector(BUF_PTR_BITS     -1 downto 0);
    -------------------------------------------------------------------------------
    -- Transfer Status Signal.
    -------------------------------------------------------------------------------
        XFER_BUSY       : --! @brief Transfer Busy.
                          --! このモジュールが未だデータの転送中であることを示す.
                          --! * QUEUE_SIZEの設定によっては、XFER_BUSY がアサートさ
                          --!   れていても、次のリクエストを受け付け可能な場合があ
                          --!   る.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_ERROR      : --! @brief Transfer Error.
                          --! データの転送中にエラーが発生した事を示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_DONE       : --! @brief Transfer Done.
                          --! このモジュールが未だデータの転送中かつ、次のクロック
                          --! で XFER_BUSY がネゲートされる事を示す.
                          --! * ただし、XFER_BUSY のネゲート前に 必ずしもこの信号が
                          --!   アサートされるわけでは無い.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
    -------------------------------------------------------------------------------
    -- Pull Reserve Size Signals.
    -------------------------------------------------------------------------------
        PULL_RSV_VAL    : --! @brief Pull Reserve Valid.
                          --! PULL_RSV_LAST/PULL_RSV_ERROR/PULL_RSV_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PULL_RSV_LAST   : --! @brief Pull Reserve Last.
                          --! 最後の転送"する予定"である事を示すフラグ.
                          out   std_logic;
        PULL_RSV_ERROR  : --! @brief Pull Reserve Error.
                          --! 転送"する予定"がエラーだった事を示すフラグ.
                          out   std_logic;
        PULL_RSV_SIZE   : --! @brief Pull Reserve Size.
                          --! 転送"する予定"のバイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Pull Final Size Signals.
    -------------------------------------------------------------------------------
        PULL_FIN_VAL    : --! @brief Pull Final Valid.
                          --! PULL_FIN_LAST/PULL_FIN_ERROR/PULL_FIN_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PULL_FIN_LAST   : --! @brief Pull Final Last.
                          --! 最後の転送"した事"を示すフラグ.
                          out   std_logic;
        PULL_FIN_ERROR  : --! @brief Pull Final Error.
                          --! 転送"した事"がエラーだった事を示すフラグ.
                          out   std_logic;
        PULL_FIN_SIZE   : --! @brief Pull Final Size.
                          --! 転送"した"バイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Pull Buffer Size Signals.
    -------------------------------------------------------------------------------
        PULL_BUF_RESET  : --! @brief Pull Buffer Counter Reset.
                          --! バッファのカウンタをリセットする信号.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PULL_BUF_VAL    : --! @brief Pull Buffer Valid.
                          --! PULL_BUF_LAST/PULL_BUF_ERROR/PULL_BUF_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PULL_BUF_LAST   : --! @brief Pull Buffer Last.
                          --! 最後の転送"した事"を示すフラグ.
                          out   std_logic;
        PULL_BUF_ERROR  : --! @brief Pull Buffer Error.
                          --! 転送"した事"がエラーだった事を示すフラグ.
                          out   std_logic;
        PULL_BUF_SIZE   : --! @brief Pull Buffer Size.
                          --! 転送"した"バイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
        PULL_BUF_RDY    : --! @brief Pull Buffer Valid.
                          --! バッファからデータを読み出し可能な事をを示す.
                          in    std_logic_vector(VAL_BITS         -1 downto 0);
    -------------------------------------------------------------------------------
    -- Read Buffer Interface Signals.
    -------------------------------------------------------------------------------
        BUF_REN         : --! @brief Buffer Write Enable.
                          --! バッファにデータをライトすることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        BUF_DATA        : --! @brief Buffer Data.
                          --! バッファへライトするデータを出力する.
                          in    std_logic_vector(BUF_DATA_WIDTH   -1 downto 0);
        BUF_PTR         : --! @brief Buffer Write Pointer.
                          --! ライト時にデータを書き込むバッファの位置を出力する.
                          out   std_logic_vector(BUF_PTR_BITS     -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_SLAVE_WRITE_INTERFACE                                            --
-----------------------------------------------------------------------------------
component AXI4_SLAVE_WRITE_INTERFACE
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 ライトアドレスチャネルのAWADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 WRITE DATA CHANNEL DATA WIDTH :
                          --! AXI4 ライトデータチャネルのWDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびライトレスポンスチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        XFER_SIZE_BITS  : --! @brief TRANSFER SIZE BITS :
                          --! 各種サイズカウンタのビット数を指定する.
                          integer := 32;
        VAL_BITS        : --! @brief VALID BITS :
                          --! XFER_BUSY、XFER_DONE、PUSH_FIN_VAL、PUSH_RSV_VAL信号の
                          --! ビット数を指定する.
                          integer := 1;
        BUF_DATA_WIDTH  : --! @brief BUFFER DATA WIDTH :
                          --! バッファのビット幅を指定する.
                          integer := 32;
        BUF_PTR_BITS    : --! @brief BUFFER POINTER BITS :
                          --! バッファポインタなどを表す信号のビット数を指定する.
                          integer := 8;
        ALIGNMENT_BITS  : --! @brief ALIGNMENT BITS :
                          --! アライメントサイズのビット数を指定する.
                          integer := 8
    );
    port(
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Write Address Channel Signals.
    -------------------------------------------------------------------------------
        AWID            : --! @brief Write address ID.
                          --! This signal is identification tag for the write
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        AWADDR          : --! @brief Write address.  
                          --! The read address gives the address of the first
                          --! transfer in a write burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        AWLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        AWSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        AWBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        AWVALID         : --! @brief Write address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        AWREADY         : --! @brief Write address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Write Data Channel Signals.
    -------------------------------------------------------------------------------
        WDATA           : --! @brief Write data.
                          in    std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        WSTRB           : --! @brief Write strobes.
                          --! This signal indicates which byte lanes holdvalid 
                          --! data. There is one write strobe bit for each eight
                          --! bits of the write data bus.
                          in    std_logic_vector(AXI4_DATA_WIDTH/8-1 downto 0);
        WLAST           : --! @brief Write last.
                          --! This signal indicates the last transfer in a write burst.
                          in    std_logic;
        WVALID          : --! @brief Write valid.
                          --! This signal indicates that valid write data and
                          --! strobes are available.
                          in    std_logic;
        WREADY          : --! @brief Write ready.
                          --! This signal indicates that the slave can accept the
                          --! write data.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Write Response Channel Signals.
    -------------------------------------------------------------------------------
        BID             : --! @brief Response ID tag.
                          --! This signal is the identification tag of write
                          --! response .
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        BRESP           : --! @brief Write response.
                          --! This signal indicates the status of the write transaction.
                          out   AXI4_RESP_TYPE;
        BVALID          : --! @brief Write response valid.
                          --! This signal indicates that the channel is signaling
                          --! a valid write response.
                          out   std_logic;
        BREADY          : --! @brief Write response ready.
                          --! This signal indicates that the master can accept a
                          --! write response.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- Command Request Signals.
    -------------------------------------------------------------------------------
        REQ_ADDR        : --! @brief Request Address.
                          --! 転送開始アドレスを指定する.  
                          out   std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        REQ_ID          : --! @brief Request ID.
                          --! ARID の値を指定する.
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        REQ_BURST       : --! @brief Request Burst type.
                          --! バーストタイプを指定する.  
                          --! * このモジュールでは AXI4_ABURST_INCR と AXI4_ABURST_FIXED
                          --!   のみをサポートしている.
                          out   AXI4_ABURST_TYPE;
        REQ_VAL         : --! @brief Request Valid Signal.
                          --! 上記の各種リクエスト信号が有効であることを示す.
                          --! * この信号のアサートでもってトランザクションを開始する.
                          --! * 一度この信号をアサートすると Acknowledge を返すまで、
                          --!   この信号はアサートされなくてはならない.
                          out   std_logic;
        REQ_START       : --! @brief Request Start Signal.
                          --! REQ_VAL信号がアサートされた最初のサイクルだけアサート
                          --! される.
                          out   std_logic;
        REQ_RDY         : --! @brief Request Ready Signal.
                          --! 上記の各種リクエスト信号を受け付け可能かどうかを示す.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- Command Acknowledge Signals.
    -------------------------------------------------------------------------------
        ACK_VAL         : --! @brief Acknowledge Valid Signal.
                          --! 上記の Command Request の応答信号.
                          --! 下記の 各種 Acknowledge 信号が有効である事を示す.
                          --! * この信号のアサートでもって、Command Request が受け
                          --!   付けられたことを示す. ただし、あくまでも Request が
                          --!   受け付けられただけであって、必ずしもトランザクショ
                          --!   ンが完了したわけではないことに注意.
                          --! * この信号は Request につき１クロックだけアサートされ
                          --!   る.
                          --! * この信号がアサートされたら、アプリケーション側は速
                          --!   やかに REQ_VAL 信号をネゲートして Request を取り下
                          --!   げるか、REQ_VALをアサートしたままで次の Request 情
                          --!   報を用意しておかなければならない.
                          in    std_logic;
        ACK_NEXT        : --! @brief Acknowledge with need Next transaction.
                          --! すべてのトランザクションが終了かつ REQ_LAST=0 の場合、
                          --! この信号がアサートされる.
                          in    std_logic;
        ACK_LAST        : --! @brief Acknowledge with Last transaction.
                          --! すべてのトランザクションが終了かつ REQ_LAST=1 の場合、
                          --! この信号がアサートされる.
                          in    std_logic;
        ACK_ERROR       : --! @brief Acknowledge with Error.
                          --! トランザクション中になんらかのエラーが発生した場合、
                          --! この信号がアサートされる.
                          in    std_logic;
        ACK_SIZE        : --! @brief Acknowledge transfer size.
                          --! 転送するバイト数を示す.
                          --! REQ_ADDR、REQ_SIZE、REQ_BUF_PTRなどは、この信号で示さ
                          --! れるバイト数分を加算/減算すると良い.
                          in    std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Transfer Control Signal.
    -------------------------------------------------------------------------------
        XFER_START      : --! @brief Transfer Start.
                          --! データ転送開始を指示する信号.
                          --! * 下記の各種リクエスト信号が有効であることを示す.
                          in    std_logic;
        XFER_LAST       : --! @brief Transfer Last.
                          --! 最後の転送であることを指示する信号.
                          --! * XFER_START 信号がアサートされている時のみ有効.
                          in    std_logic;
        XFER_SEL        : --! @brief Transfer Select.
                          --! XFER_BUSY、XFER_DONE、PULL_FIN_VAL、PULL_RSV_VAL 信号
                          --! の生成パターンを指定する.
                          --! * XFER_START 信号がアサートされている時のみ有効.
                          in    std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_BUF_PTR    : --! @brief Transfer Write Buffer Pointer.
                          --! ライトバッファの先頭ポインタの値を指定する.
                          --! * XFER_START 信号がアサートされている時のみ有効.
                          --! * ライトバッファのこのポインタの位置からRDATAを書き込
                          --!   む.
                          in    std_logic_vector(BUF_PTR_BITS     -1 downto 0);
    -------------------------------------------------------------------------------
    -- Transfer Status Signal.
    -------------------------------------------------------------------------------
        XFER_BUSY       : --! @brief Transfer Busy.
                          --! このモジュールが未だデータの転送中であることを示す.
                          --! * QUEUE_SIZEの設定によっては、XFER_BUSY がアサートさ
                          --!   れていても、次のリクエストを受け付け可能な場合があ
                          --!   る.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_ERROR      : --! @brief Transfer Error.
                          --! データの転送中にエラーが発生した事を示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        XFER_DONE       : --! @brief Transfer Done.
                          --! このモジュールが未だデータの転送中かつ、次のクロック
                          --! で XFER_BUSY がネゲートされる事を示す.
                          --! * ただし、XFER_BUSY のネゲート前に 必ずしもこの信号が
                          --!   アサートされるわけでは無い.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
    -------------------------------------------------------------------------------
    -- Push Reserve Size Signals.
    -------------------------------------------------------------------------------
        PUSH_RSV_VAL    : --! @brief Push Reserve Valid.
                          --! PUSH_RSV_LAST/PUSH_RSV_ERROR/PUSH_RSV_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PUSH_RSV_LAST   : --! @brief Push Reserve Last.
                          --! 最後の転送"する予定"である事を示すフラグ.
                          out   std_logic;
        PUSH_RSV_ERROR  : --! @brief Push Reserve Error.
                          --! 転送"する予定"がエラーだった事を示すフラグ.
                          out   std_logic;
        PUSH_RSV_SIZE   : --! @brief Push Reserve Size.
                          --! 転送"する予定"のバイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Push Final Size Signals.
    -------------------------------------------------------------------------------
        PUSH_FIN_VAL    : --! @brief Push Final Valid.
                          --! PUSH_FIN_LAST/PUSH_FIN_ERROR/PUSH_FIN_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PUSH_FIN_LAST   : --! @brief Push Final Last.
                          --! 最後の転送"した事"を示すフラグ.
                          out   std_logic;
        PUSH_FIN_ERROR  : --! @brief Push Final Error.
                          --! 転送"した事"がエラーだった事を示すフラグ.
                          out   std_logic;
        PUSH_FIN_SIZE   : --! @brief Push Final Size.
                          --! 転送"した"バイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- Push Buffer Size Signals.
    -------------------------------------------------------------------------------
        PUSH_BUF_RESET  : --! @brief Push Buffer Counter Reset.
                          --! バッファのカウンタをリセットする信号.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PUSH_BUF_VAL    : --! @brief Push Buffer Valid.
                          --! PUSH_BUF_LAST/PUSH_BUF_ERROR/PUSH_BUF_SIZEが有効で
                          --! あることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        PUSH_BUF_LAST   : --! @brief Push Buffer Last.
                          --! 最後の転送"した事"を示すフラグ.
                          out   std_logic;
        PUSH_BUF_ERROR  : --! @brief Push Buffer Error.
                          --! 転送"した事"がエラーだった事を示すフラグ.
                          out   std_logic;
        PUSH_BUF_SIZE   : --! @brief Push Buffer Size.
                          --! 転送"した"バイト数を出力する.
                          out   std_logic_vector(XFER_SIZE_BITS   -1 downto 0);
        PUSH_BUF_RDY    : --! @brief Push Buffer Ready.
                          --! バッファにデータを書き込み可能な事をを示す.
                          in    std_logic_vector(VAL_BITS         -1 downto 0);
    -------------------------------------------------------------------------------
    -- Read Buffer Interface Signals.
    -------------------------------------------------------------------------------
        BUF_WEN         : --! @brief Buffer Write Enable.
                          --! バッファにデータをライトすることを示す.
                          out   std_logic_vector(VAL_BITS         -1 downto 0);
        BUF_BEN         : --! @brief Buffer Byte Enable.
                          --! バッファにデータをライトする際のバイトイネーブル信号.
                          --! * BUF_WEN='1'の場合にのみ有効.
                          --! * BUF_WEN='0'の場合のこの信号の値は不定.
                          out   std_logic_vector(BUF_DATA_WIDTH/8 -1 downto 0);
        BUF_DATA        : --! @brief Buffer Data.
                          --! バッファへライトするデータを出力する.
                          out   std_logic_vector(BUF_DATA_WIDTH   -1 downto 0);
        BUF_PTR         : --! @brief Buffer Write Pointer.
                          --! ライト時にデータを書き込むバッファの位置を出力する.
                          out   std_logic_vector(BUF_PTR_BITS     -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_REGISTER_WRITE_INTERFACE                                         --
-----------------------------------------------------------------------------------
component AXI4_REGISTER_WRITE_INTERFACE
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 ライトアドレスチャネルのAWADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 WRITE DATA CHANNEL DATA WIDTH :
                          --! AXI4 ライトデータチャネルのWDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびライトレスポンスチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        REGS_ADDR_WIDTH : --! @brief REGISTER ADDRESS WIDTH :
                          --! レジスタアクセスインターフェースのアドレスのビット幅
                          --! を指定する.
                          integer := 32;
        REGS_DATA_WIDTH : --! @brief REGISTER DATA WIDTH :
                          --! レジスタアクセスインターフェースのデータのビット幅を
                          --! 指定する.
                          integer := 32
    );
    port(
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Write Address Channel Signals.
    -------------------------------------------------------------------------------
        AWID            : --! @brief Write address ID.
                          --! This signal is identification tag for the write
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        AWADDR          : --! @brief Write address.  
                          --! The read address gives the address of the first
                          --! transfer in a write burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        AWLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        AWSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        AWBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        AWVALID         : --! @brief Write address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        AWREADY         : --! @brief Write address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Write Data Channel Signals.
    -------------------------------------------------------------------------------
        WDATA           : --! @brief Write data.
                          in    std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        WSTRB           : --! @brief Write strobes.
                          --! This signal indicates which byte lanes holdvalid 
                          --! data. There is one write strobe bit for each eight
                          --! bits of the write data bus.
                          in    std_logic_vector(AXI4_DATA_WIDTH/8-1 downto 0);
        WLAST           : --! @brief Write last.
                          --! This signal indicates the last transfer in a write burst.
                          in    std_logic;
        WVALID          : --! @brief Write valid.
                          --! This signal indicates that valid write data and
                          --! strobes are available.
                          in    std_logic;
        WREADY          : --! @brief Write ready.
                          --! This signal indicates that the slave can accept the
                          --! write data.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Write Response Channel Signals.
    -------------------------------------------------------------------------------
        BID             : --! @brief Response ID tag.
                          --! This signal is the identification tag of write
                          --! response .
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        BRESP           : --! @brief Write response.
                          --! This signal indicates the status of the write transaction.
                          out   AXI4_RESP_TYPE;
        BVALID          : --! @brief Write response valid.
                          --! This signal indicates that the channel is signaling
                          --! a valid write response.
                          out   std_logic;
        BREADY          : --! @brief Write response ready.
                          --! This signal indicates that the master can accept a
                          --! write response.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- Register Write Interface.
    -------------------------------------------------------------------------------
        REGS_REQ        : --! @brief レジスタアクセス要求信号.
                          --! レジスタアクセス要求時にアサートされる.
                          --! REGS_ACK 信号がアサートされるまで、この信号はアサー
                          --! トされたまま.
                          out std_logic;
        REGS_ACK        : --! @brief レジスタアクセス応答信号.
                          in  std_logic;
        REGS_ERR        : --! @brief レジスタアクセスエラー信号.
                          --! エラーが発生した時にREGS_ACK信号と共にアサートする.
                          in  std_logic;
        REGS_ADDR       : --! @brief レジスタアドレス信号.
                          out std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
        REGS_BEN        : --! @brief バイトイネーブル信号.
                          out std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
        REGS_DATA       : --! @brief レジスタライトデータ出力信号.
                          out std_logic_vector(REGS_DATA_WIDTH  -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_REGISTER_READ_INTERFACE                                          --
-----------------------------------------------------------------------------------
component AXI4_REGISTER_READ_INTERFACE
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 リードアドレスチャネルのAWADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 WRITE DATA CHANNEL DATA WIDTH :
                          --! AXI4 リードデータチャネルのRDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびライトレスポンスチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        REGS_ADDR_WIDTH : --! @brief REGISTER ADDRESS WIDTH :
                          --! レジスタアクセスインターフェースのアドレスのビット幅
                          --! を指定する.
                          integer := 32;
        REGS_DATA_WIDTH : --! @brief REGISTER DATA WIDTH :
                          --! レジスタアクセスインターフェースのデータのビット幅を
                          --! 指定する.
                          integer := 32
    );
    port(
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Read Address Channel Signals.
    -------------------------------------------------------------------------------
        ARID            : --! @brief Read address ID.
                          --! This signal is identification tag for the read
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        ARADDR          : --! @brief Read address.  
                          --! The read address gives the address of the first
                          --! transfer in a read burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        ARLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        ARSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        ARBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        ARVALID         : --! @brief Read address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        ARREADY         : --! @brief Read address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Read Data Channel Signals.
    -------------------------------------------------------------------------------
        RID             : --! @brief Read ID tag.
                          --! This signal is the identification tag for the read
                          --! data group of signals generated by the slave.
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        RDATA           : --! @brief Read data.
                          out   std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        RRESP           : --! @brief Read response.
                          --! This signal indicates the status of the read transaction.
                          out   AXI4_RESP_TYPE;
        RLAST           : --! @brief Read last.
                          --! This signal indicates the last transfer in a read burst.
                          out   std_logic;
        RVALID          : --! @brief Read data valid.
                          --! This signal indicates that the channel is signaling
                          --! the required read data.
                          out   std_logic;
        RREADY          : --! @brief Read data ready.
                          --! This signal indicates that the master can accept the
                          --! read data and response information.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- Register Read Interface.
    -------------------------------------------------------------------------------
        REGS_REQ        : --! @brief レジスタアクセス要求信号.
                          --! レジスタアクセス要求時にアサートされる.
                          --! REGS_ACK 信号がアサートされるまで、この信号はアサー
                          --! トされたまま.
                          out std_logic;
        REGS_ACK        : --! @brief レジスタアクセス応答信号.
                          in  std_logic;
        REGS_ERR        : --! @brief レジスタアクセスエラー信号.
                          --! エラーが発生した時にREGS_ACK信号と共にアサートする.
                          in  std_logic;
        REGS_ADDR       : --! @brief レジスタアドレス信号.
                          out std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
        REGS_BEN        : --! @brief バイトイネーブル信号.
                          out std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
        REGS_DATA       : --! @brief レジスタライトデータ出力信号.
                          in  std_logic_vector(REGS_DATA_WIDTH  -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_REGISTER_INTERFACE                                               --
-----------------------------------------------------------------------------------
component AXI4_REGISTER_INTERFACE
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 リードアドレスチャネルのAWADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 WRITE DATA CHANNEL DATA WIDTH :
                          --! AXI4 リードデータチャネルのRDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびライトレスポンスチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        REGS_ADDR_WIDTH : --! @brief REGISTER ADDRESS WIDTH :
                          --! レジスタアクセスインターフェースのアドレスのビット幅
                          --! を指定する.
                          integer := 32;
        REGS_DATA_WIDTH : --! @brief REGISTER DATA WIDTH :
                          --! レジスタアクセスインターフェースのデータのビット幅を
                          --! 指定する.
                          integer := 32
    );
    port(
    ------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    ------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Read Address Channel Signals.
    ------------------------------------------------------------------------------
        ARID            : --! @brief Read address ID.
                          --! This signal is identification tag for the read
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        ARADDR          : --! @brief Read address.  
                          --! The read address gives the address of the first
                          --! transfer in a read burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        ARLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        ARSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        ARBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        ARVALID         : --! @brief Read address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        ARREADY         : --! @brief Read address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Read Data Channel Signals.
    ------------------------------------------------------------------------------
        RID             : --! @brief Read ID tag.
                          --! This signal is the identification tag for the read
                          --! data group of signals generated by the slave.
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        RDATA           : --! @brief Read data.
                          out   std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        RRESP           : --! @brief Read response.
                          --! This signal indicates the status of the read transaction.
                          out   AXI4_RESP_TYPE;
        RLAST           : --! @brief Read last.
                          --! This signal indicates the last transfer in a read burst.
                          out   std_logic;
        RVALID          : --! @brief Read data valid.
                          --! This signal indicates that the channel is signaling
                          --! the required read data.
                          out   std_logic;
        RREADY          : --! @brief Read data ready.
                          --! This signal indicates that the master can accept the
                          --! read data and response information.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Write Address Channel Signals.
    ------------------------------------------------------------------------------
        AWID            : --! @brief Write address ID.
                          --! This signal is identification tag for the write
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        AWADDR          : --! @brief Write address.  
                          --! The read address gives the address of the first
                          --! transfer in a write burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        AWLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        AWSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        AWBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        AWVALID         : --! @brief Write address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        AWREADY         : --! @brief Write address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Write Data Channel Signals.
    ------------------------------------------------------------------------------
        WDATA           : --! @brief Write data.
                          in    std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        WSTRB           : --! @brief Write strobes.
                          --! This signal indicates which byte lanes holdvalid 
                          --! data. There is one write strobe bit for each eight
                          --! bits of the write data bus.
                          in    std_logic_vector(AXI4_DATA_WIDTH/8-1 downto 0);
        WLAST           : --! @brief Write last.
                          --! This signal indicates the last transfer in a write burst.
                          in    std_logic;
        WVALID          : --! @brief Write valid.
                          --! This signal indicates that valid write data and
                          --! strobes are available.
                          in    std_logic;
        WREADY          : --! @brief Write ready.
                          --! This signal indicates that the slave can accept the
                          --! write data.
                          out   std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Write Response Channel Signals.
    ------------------------------------------------------------------------------
        BID             : --! @brief Response ID tag.
                          --! This signal is the identification tag of write
                          --! response .
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        BRESP           : --! @brief Write response.
                          --! This signal indicates the status of the write transaction.
                          out   AXI4_RESP_TYPE;
        BVALID          : --! @brief Write response valid.
                          --! This signal indicates that the channel is signaling
                          --! a valid write response.
                          out   std_logic;
        BREADY          : --! @brief Write response ready.
                          --! This signal indicates that the master can accept a
                          --! write response.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- Register Interface.
    ------------------------------------------------------------------------------
        REGS_REQ        : --! @brief レジスタアクセス要求信号.
                          --! レジスタアクセス要求時にアサートされる.
                          --! REGS_ACK 信号がアサートされるまで、この信号はアサー
                          --! トされたまま.
                          out std_logic;
        REGS_WRITE      : --! @brief レジスタライト信号.
                          --! レジスタ書き込み時にアサートされる.
                          out std_logic;
        REGS_ACK        : --! @brief レジスタアクセス応答信号.
                          in  std_logic;
        REGS_ERR        : --! @brief レジスタアクセスエラー信号.
                          --! エラーが発生した時にREGS_ACK信号と共にアサートする.
                          in  std_logic;
        REGS_ADDR       : --! @brief レジスタアドレス信号.
                          out std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
        REGS_BEN        : --! @brief バイトイネーブル信号.
                          out std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
        REGS_WDATA      : --! @brief レジスタライトデータ出力信号.
                          out std_logic_vector(REGS_DATA_WIDTH  -1 downto 0);
        REGS_RDATA      : --! @brief レジスタリードデータ入力信号.
                          in  std_logic_vector(REGS_DATA_WIDTH  -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_DATA_PORT                                                        --
-----------------------------------------------------------------------------------
component AXI4_DATA_PORT
    generic (
        DATA_BITS       : --! @brief DATA BITS :
                          --! I_DATA/O_DATA のビット数を指定する.
                          --! * DATA_BITSで指定できる値は 8,16,32,64,128,256,512,
                          --!   1024
                          integer := 32;
        ADDR_BITS       : --! @brief ADDRESS BITS :
                          --! ADDR のビット数を指定する.
                          integer := 32;
        SIZE_BITS       : --! @brief SIZE BITS :
                          --! O_SIZE/I_SIZE のビット数を指定する.
                          integer := 12;
        USER_BITS       : --! @brief USER INFOMATION BITS :
                          --! O_USER/I_USER のビット数を指定する.
                          integer := 1;
        ALEN_BITS       : --! @brief BURST LENGTH BITS :
                          --! ALEN のビット数を指定する.
                          integer := 12;
        USE_ASIZE       : --! @brief USE BURST SIZE :
                          --! ASIZE による Narrow transfers をサポートするか否かを
                          --! 指定する.
                          --! * USE_ASIZE=0を指定した場合、Narrow transfers をサポ
                          --!   ートしない.
                          --!   この場合、ASIZE信号は未使用.
                          --! * USE_ASIZE=1を指定した場合、Narrow transfers をサポ
                          --!   ートする. その際の１ワード毎の転送バイト数は
                          --!   ASIZE で指定される.
                          integer range 0 to 1 := 1;
        CHECK_ALEN      : --! @brief CHECK BURST LENGTH :
                          --! ALEN で指定されたバースト数とI_LASTによるバースト転送
                          --! の最後が一致するかどうかチェックするか否かを指定する.
                          --! * CHECK_ALEN=0かつUSE_ASIZE=0を指定した場合、バースト
                          --!   長をチェックしない. 
                          --! * CHECK_ALEN=1またはUSE_ASIZEを指定した場合、バースト
                          --!   長をチェックする.
                          integer range 0 to 1 := 1;
        I_REGS_SIZE     : --! @brief PORT INTAKE REGS SIZE :
                          --! 入力側に挿入するパイプラインレジスタの段数を指定する.
                          --! * I_REGS_SIZE=0を指定した場合、パイプラインレジスタは
                          --!   挿入しない.
                          --! * I_REGS_SIZE=1を指定した場合、パイプラインレジスタを
                          --!   １段挿入するが、この場合バースト転送時に１ワード転送
                          --!   毎に１サイクルのウェイトが発生する.
                          --! * I_REGS_SIZE>1を指定した場合、パイプラインレジスタを
                          --!   指定された段数挿入する. この場合、バースト転送時
                          --!   にウェイトは発生しない.
                          integer := 0;
        O_REGS_SIZE     : --! @brief PORT OUTLET REGS SIZE :
                          --! 出力側に挿入するパイプラインレジスタの段数を指定する.
                          --! * O_REGS_SIZE=0を指定した場合、パイプラインレジスタは
                          --!   挿入しない.
                          --! * O_REGS_SIZE=1を指定した場合、パイプラインレジスタを
                          --!   １段挿入するが、この場合バースト転送時に１ワード
                          --!   転送毎に１サイクルのウェイトが発生する.
                          --! * O_REGS_SIZE>1を指定した場合、パイプラインレジスタを
                          --!   指定された段数挿入する. この場合、バースト転送時
                          --!   にウェイトは発生しない.
                          integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        START           : --! @brief START :
                          --! 開始信号.
                          --! * この信号はSTART_PTR/XFER_LAST/XFER_SELを内部に設定
                          --!   してこのモジュールを初期化しする.
                          --! * 最初にデータ入力と同時にアサートしても構わない.
                          in  std_logic;
        ASIZE           : --! @brief AXI4 BURST SIZE :
                          --! AXI4 によるバーストサイズを指定する.
                          in  AXI4_ASIZE_TYPE;
        ALEN            : --! @brief AXI4 BURST LENGTH :
                          --! AXI4 によるバースト数を指定する.
                          in  std_logic_vector(ALEN_BITS-1 downto 0);
        ADDR            : --! @brief START TRANSFER ADDRESS :
                          --! 出力側のアドレス.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(ADDR_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Intake Port Signals.
    -------------------------------------------------------------------------------
        I_DATA          : --! @brief INTAKE PORT DATA :
                          --! ワードデータ入力.
                          in  std_logic_vector(DATA_BITS  -1 downto 0);
        I_STRB          : --! @brief INTAKE PORT DATA STROBE :
                          --! バイト単位での有効信号.
                          in  std_logic_vector(DATA_BITS/8-1 downto 0);
        I_SIZE          : --! @brief INTAKE PORT DATA SIZE :
                          --! 入力ワードデータのバイト数.
                          in  std_logic_vector(SIZE_BITS  -1 downto 0);
        I_USER          : --! @brief INTAKE PORT USER DATA :
                          --! 入力ユーザー定義信号.
                          in  std_logic_vector(USER_BITS  -1 downto 0);
        I_ERROR         : --! @brief INTAKE PORT ERROR :
                          --! エラー入力.
                          --! * 入力時にエラーが発生した事を示すフラグ.
                          in  std_logic;
        I_LAST          : --! @brief INTAKE PORT DATA LAST :
                          --! 最終ワード信号入力.
                          --! * 最後のワードデータ入力であることを示すフラグ.
                          in  std_logic;
        I_VALID         : --! @brief INTAKE PORT VALID :
                          --! 入力ワード有効信号.
                          --! * I_DATA/I_STRB/I_LAST/I_USER/I_SIZEが有効であること
                          --!   を示す.
                          --! * I_VALID='1'and I_READY='1'で上記信号がキューに取り
                          --!   込まれる.
                          in  std_logic;
        I_READY         : --! @brief INTAKE PORT READY :
                          --! 入力レディ信号.
                          --! * キューが次のワードデータを入力出来ることを示す.
                          --! * I_VALID='1'and I_READY='1'で上記信号がキューから
                          --!   取り出される.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- Outlet Port Signals.
    -------------------------------------------------------------------------------
        O_DATA          : --! @brief OUTLET PORT DATA :
                          --! ワードデータ出力.
                          out std_logic_vector(DATA_BITS  -1 downto 0);
        O_STRB          : --! @brief OUTLET PORT DATA STROBE :
                          --! ポートへデータを出力する際のバイト単位での有効信号.
                          out std_logic_vector(DATA_BITS/8-1 downto 0);
        O_SIZE          : --! @brief OUTLET PORT DATA SIZE :
                          --! ポートへデータを出力する際のバイト数.
                          out std_logic_vector(SIZE_BITS  -1 downto 0);
        O_USER          : --! @brief OUTLET PORT USER DATA :
                          --! ポートへデータを出力する際のユーザー定義信号.
                          out std_logic_vector(USER_BITS  -1 downto 0);
        O_ERROR         : --! @brief OUTLET PORT ERROR :
                          --! エラー出力.
                          --! * エラーが発生した事を示すフラグ.
                          out std_logic;
        O_LAST          : --! @brief OUTLET PORT DATA LAST :
                          --! 最終ワード信号出力.
                          --! * 最後のワードデータ出力であることを示すフラグ.
                          out std_logic;
        O_VALID         : --! @brief OUTLET PORT VALID :
                          --! 出力ワード有効信号.
                          --! * O_DATA/O_STRB/O_LASTが有効であることを示す.
                          --! * O_VALID='1'and O_READY='1'で上記信号がキューから取
                          --!   り出される.
                          out std_logic;
        O_READY         : --! @brief OUTLET PORT READY :
                          --! 出力レディ信号.
                          --! * キューが次のワードデータを入力出来ることを示す.
                          --! * O_VALID='1'and O_READY='1'で上記信号がキューから
                          --!   取り出される.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Status Signals.
    -------------------------------------------------------------------------------
        BUSY            : --! @brief QUEUE BUSY :
                          --! キューが動作中であることを示す信号.
                          --! * 最初にデータが入力されたときにアサートされる.
                          --! * 最後のデータが出力し終えたらネゲートされる.
                          out  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief AXI4_DATA_OUTLET_PORT                                                 --
-----------------------------------------------------------------------------------
component AXI4_DATA_OUTLET_PORT
    generic (
        PORT_DATA_BITS  : --! @brief INTAKE PORT DATA BITS :
                          --! PORT_DATA のビット数を指定する.
                          --! * PORT_DATA_BITSで指定できる値は 8,16,32,64,128,256,
                          --!   512,1024
                          integer := 32;
        POOL_DATA_BITS  : --! @brief POOL BUFFER DATA BITS :
                          --! POOL_DATA のビット数を指定する.
                          integer := 32;
        TRAN_ADDR_BITS  : --! @brief TRANSACTION ADDRESS BITS :
                          --! TRAN_ADDR のビット数を指定する.
                          integer := 32;
        TRAN_SIZE_BITS  : --! @brief TRANSACTION SIZE BITS :
                          --! TRAN_SIZE のビット数を指定する.
                          integer := 32;
        TRAN_SEL_BITS   : --! @brief TRANSACTION SELECT BITS :
                          --! TRAN_SEL、PULL_VAL、POOL_REN のビット数を指定する.
                          integer := 1;
        BURST_LEN_BITS  : --! @brief BURST LENGTH BITS :
                          --! BURST_LEN のビット数を指定する.
                          integer := 12;
        ALIGNMENT_BITS  : --! @brief ALIGNMENT BITS :
                          --! アライメント調整を行うビット数を指定する.
                          --! * ALIGNMENT_BITS=8を指定した場合、バイト単位でアライ
                          --!   メント調整する.
                          integer := 8;
        PULL_SIZE_BITS  : --! @brief PULL_SIZE BITS :
                          --! PULL_SIZE のビット数を指定する.
                          integer := 16;
        EXIT_SIZE_BITS  : --! @brief EXIT_SIZE BITS :
                          --! EXIT_SIZE のビット数を指定する.
                          integer := 16;
        POOL_PTR_BITS   : --! @brief POOL BUFFER POINTER BITS:
                          --! START_PTR、POOL_PTR のビット数を指定する.
                          integer := 16;
        USE_BURST_SIZE  : --! @brief USE BURST SIZE :
                          --! BURST_SIZE による Narrow transfers をサポートするか
                          --! 否かを指定する.
                          --! * USE_BURST_SIZE=0を指定した場合、Narrow transfers を
                          --!   サポートしない.
                          --! * USE_BURST_SIZE=1を指定した場合、Narrow transfers を
                          --!   サポートする. その際の１ワード毎の転送バイト数は
                          --!   BURST_SIZE で指定される.
                          integer range 0 to 1 := 1;
        CHECK_BURST_LEN : --! @brief CHECK BURST LENGTH :
                          --! BURST_LEN で指定されたバースト数とI_LASTによるバースト
                          --! 転送の最後が一致するかどうかチェックするか否かを指定す
                          --! る.
                          --! * CHECK_BURST_LEN=0かつUSE_BURST_SIZE=0を指定した場合、
                          --!   バースト長をチェックしない. 
                          --! * CHECK_BURST_LEN=1またはUSE_BURST_SIZE=0を指定した場
                          --!   合、バースト長をチェックする.
                          integer range 0 to 1 := 1;
        TRAN_MAX_SIZE   : --! @brief TRANSFER MAXIMUM SIZE :
                          --! 一回の転送サイズの最大バイト数を２のべき乗で指定する.
                          integer := 4;
        PORT_REGS_SIZE  : --! @brief PORT REGS SIZE :
                          --! 出力側に挿入するパイプラインレジスタの段数を指定する.
                          --! * PORT_REGS_SIZE=0を指定した場合、パイプラインレジスタ
                          --!   は挿入しない.
                          --! * PORT_REGS_SIZE=1を指定した場合、パイプラインレジスタ
                          --!   を１段挿入するが、この場合バースト転送時に１ワード
                          --!   転送毎に１サイクルのウェイトが発生する.
                          --! * PORT_REGS_SIZE>1を指定した場合、パイプラインレジスタ
                          --!   を指定された段数挿入する. この場合、バースト転送時
                          --!   にウェイトは発生しない.
                          integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        TRAN_START      : --! @brief TRANSACTION START :
                          --! 開始信号.
                          --! * この信号はTRAN_ADDR/TRAN_SIZE/BURST_LEN/BURST_SIZE/
                          --!   START_PTR/XFER_LAST/XFER_SELを内部に設定して
                          --!   このモジュールを初期化した後、転送を開始する.
                          in  std_logic;
        TRAN_ADDR       : --! @brief TRANSACTION ADDRESS :
                          --! 転送開始アドレス.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(TRAN_ADDR_BITS  -1 downto 0);
        TRAN_SIZE       : --! @brief START TRANSFER SIZE :
                          --! 転送バイト数.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(TRAN_SIZE_BITS  -1 downto 0);
        BURST_LEN       : --! @brief Burst length.  
                          --! AXI4 バースト長.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(BURST_LEN_BITS  -1 downto 0);
        BURST_SIZE      : --! @brief Burst size.
                          --! AXI4 バーストサイズ信号.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  AXI4_ASIZE_TYPE;
        START_PTR       : --! @brief START POOL BUFFER POINTER :
                          --! 読み込み開始ポインタ.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(POOL_PTR_BITS   -1 downto 0);
        TRAN_LAST       : --! @brief TRANSACTION LAST :
                          --! 最後のトランザクションであることを示すフラグ.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic;
        TRAN_SEL        : --! @brief TRANSACTION SELECT :
                          --! 選択信号. PUSH_VAL、POOL_WENの生成に使う.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(TRAN_SEL_BITS   -1 downto 0);
        XFER_VAL        : --! @brief TRANSFER VALID :
                          --! 転送応答信号.
                          out std_logic;
        XFER_DVAL       : --! @brief TRANSFER DATA VALID :
                          --! バッファからデータをリードする際のユニット単位での有効
                          --! 信号.
                          out std_logic_vector(POOL_DATA_BITS/8-1 downto 0);
        XFER_LAST       : --! @brief TRANSFER NONE :
                          --! 最終転送信号.
                          --! * 最後の転送であることを出力する.
                          out std_logic;
        XFER_NONE       : --! @brief TRANSFER NONE :
                          --! 転送終了信号.
                          --! * これ以上転送が無いことを出力する.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Outlet Port Signals.
    -------------------------------------------------------------------------------
        PORT_DATA       : --! @brief OUTLET PORT DATA :
                          --! ワードデータ出力.
                          out std_logic_vector(PORT_DATA_BITS-1   downto 0);
        PORT_STRB       : --! @brief OUTLET PORT DATA VALID :
                          --! ポートへデータを出力する際のユニット単位での有効信号.
                          out std_logic_vector(PORT_DATA_BITS/8-1 downto 0);
        PORT_LAST       : --! @brief OUTLET DATA LAST :
                          --! 最終ワード信号出力.
                          --! * 最後のワードデータ出力であることを示すフラグ.
                          out std_logic;
        PORT_ERROR      : --! @brief OUTLET RESPONSE :
                          --! エラーが発生したことを示すフラグ.
                          out std_logic;
        PORT_VAL        : --! @brief OUTLET PORT VALID :
                          --! 出力ワード有効信号.
                          --! * PORT_DATA/PORT_DVAL/PORT_LASTが有効であることを示す.
                          --! * PORT_VAL='1'and PORT_RDY='1'で上記信号がキューから
                          --!   取り出される.
                          out std_logic;
        PORT_RDY        : --! @brief OUTLET PORT READY :
                          --! 出力レディ信号.
                          --! * キューが次のワードデータを入力出来ることを示す.
                          --! * PORT_VAL='1'and PORT_RDY='1'で上記信号がキューから
                          --!   取り出される.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Pull Size/Last/Error Signals.
    -------------------------------------------------------------------------------
        PULL_VAL        : --! @brief PULL VALID: 
                          --! PULL_LAST/PULL_XFER_LAST/PULL_XFER_DONE/PULL_ERROR/
                          --! PULL_SIZEが有効であることを示す.
                          out std_logic_vector(TRAN_SEL_BITS-1 downto 0);
        PULL_LAST       : --! @brief PULL LAST : 
                          --! 最後の転送"する事"を示すフラグ.
                          out std_logic;
        PULL_XFER_LAST  : --! @brief PULL TRANSFER LAST : 
                          --! 最後のトランザクションであることを示すフラグ.
                          out std_logic;
        PULL_XFER_DONE  : --! @brief PULL TRANSFER DONE :
                          --! 最後のトランザクションの最後の転送"した"ワードである
                          --! ことを示すフラグ.
                          out std_logic;
        PULL_ERROR      : --! @brief PULL ERROR : 
                          --! エラーが発生したことを示すフラグ.
                          out std_logic;
        PULL_SIZE       : --! @brief PULL SIZE :
                          --! 転送"する"バイト数を出力する.
                          out std_logic_vector(PULL_SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Outlet Size/Last/Error Signals.
    -------------------------------------------------------------------------------
        EXIT_VAL        : --! @brief EXIT VALID: 
                          --! EXIT_LAST/EXIT_XFER_LAST/EXIT_XFER_DONE/EXIT_ERROR/
                          --! EXIT_SIZEが有効であることを示す.
                          out std_logic_vector(TRAN_SEL_BITS-1 downto 0);
        EXIT_LAST       : --! @brief EXIT LAST : 
                          --! 最後の出力"した事"を示すフラグ.
                          out std_logic;
        EXIT_XFER_LAST  : --! @brief EXIT TRANSFER LAST : 
                          --! 最後のトランザクションであることを示すフラグ.
                          out std_logic;
        EXIT_XFER_DONE  : --! @brief EXIT TRANSFER DONE :
                          --! 最後のトランザクションの最後の転送"した"ワードである
                          --! ことを示すフラグ.
                          out std_logic;
        EXIT_ERROR      : --! @brief EXIT ERROR : 
                          --! エラーが発生したことを示すフラグ.
                          out std_logic;
        EXIT_SIZE       : --! @brief EXIT SIZE :
                          --! 出力"した"バイト数を出力する.
                          out std_logic_vector(EXIT_SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Pool Buffer Interface Signals.
    -------------------------------------------------------------------------------
        POOL_REN        : --! @brief POOL BUFFER READ ENABLE :
                          --! バッファからデータをリードすることを示す.
                          out std_logic_vector(TRAN_SEL_BITS-1 downto 0);
        POOL_PTR        : --! @brief POOL BUFFER WRITE POINTER :
                          --! ライト時にデータを書き込むバッファの位置を出力する.
                          out std_logic_vector(POOL_PTR_BITS-1 downto 0);
        POOL_ERROR      : --! @brief EXIT ERROR : 
                          --! エラーが発生したことを示すフラグ.
                          in  std_logic;
        POOL_DATA       : --! @brief POOL BUFFER READ DATA :
                          --! バッファからのリードデータ入力.
                          in  std_logic_vector(POOL_DATA_BITS  -1 downto 0);
        POOL_VAL        : --! @brief POOL BUFFER WRITE READY :
                          --! バッファにデータを書き込み可能な事をを示す.
                          in  std_logic;
        POOL_RDY        : --! @brief POOL BUFFER WRITE READY :
                          --! バッファにデータを書き込み可能な事をを示す.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- Status Signals.
    -------------------------------------------------------------------------------
        POOL_BUSY       : --! @brief POOL BUFFER BUSY :
                          --! バッファからデータリード中であることを示す信号.
                          --! * START信号がアサートされたときにアサートされる.
                          --! * 最後のデータが入力されたネゲートされる.
                          out std_logic;
        POOL_DONE       : --! @brief POOL BUFFER DONE :
                          --! 次のクロックで POOL_BUSY がネゲートされることを示す.
                          out std_logic;
        BUSY            : --! @brief QUEUE BUSY :
                          --! キューが動作中であることを示す信号.
                          --! * 最初にデータが入力されたときにアサートされる.
                          --! * 最後のデータが出力し終えたらネゲートされる.
                          out  std_logic
    );
end component;
end AXI4_COMPONENTS;
-----------------------------------------------------------------------------------
--!     @file    axi4_data_port.vhd
--!     @brief   AXI4 DATA PORT
--!     @version 1.5.5
--!     @date    2014/3/2
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2014 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
-----------------------------------------------------------------------------------
--! @brief   AXI4 DATA OUTLET PORT
-----------------------------------------------------------------------------------
entity  AXI4_DATA_PORT is
    generic (
        DATA_BITS       : --! @brief DATA BITS :
                          --! I_DATA/O_DATA のビット数を指定する.
                          --! * DATA_BITSで指定できる値は 8,16,32,64,128,256,512,
                          --!   1024
                          integer := 32;
        ADDR_BITS       : --! @brief ADDRESS BITS :
                          --! ADDR のビット数を指定する.
                          integer := 32;
        SIZE_BITS       : --! @brief SIZE BITS :
                          --! O_SIZE/I_SIZE のビット数を指定する.
                          integer := 12;
        USER_BITS       : --! @brief USER INFOMATION BITS :
                          --! O_USER/I_USER のビット数を指定する.
                          integer := 1;
        ALEN_BITS       : --! @brief BURST LENGTH BITS :
                          --! ALEN のビット数を指定する.
                          integer := 12;
        USE_ASIZE       : --! @brief USE BURST SIZE :
                          --! ASIZE による Narrow transfers をサポートするか否かを
                          --! 指定する.
                          --! * USE_ASIZE=0を指定した場合、Narrow transfers をサポ
                          --!   ートしない.
                          --!   この場合、ASIZE信号は未使用.
                          --! * USE_ASIZE=1を指定した場合、Narrow transfers をサポ
                          --!   ートする. その際の１ワード毎の転送バイト数は
                          --!   ASIZE で指定される.
                          integer range 0 to 1 := 1;
        CHECK_ALEN      : --! @brief CHECK BURST LENGTH :
                          --! ALEN で指定されたバースト数とI_LASTによるバースト転送
                          --! の最後が一致するかどうかチェックするか否かを指定する.
                          --! * CHECK_ALEN=0かつUSE_ASIZE=0を指定した場合、バースト
                          --!   長をチェックしない. 
                          --! * CHECK_ALEN=1またはUSE_ASIZEを指定した場合、バースト
                          --!   長をチェックする.
                          integer range 0 to 1 := 1;
        I_REGS_SIZE     : --! @brief PORT INTAKE REGS SIZE :
                          --! 入力側に挿入するパイプラインレジスタの段数を指定する.
                          --! * I_REGS_SIZE=0を指定した場合、パイプラインレジスタは
                          --!   挿入しない.
                          --! * I_REGS_SIZE=1を指定した場合、パイプラインレジスタを
                          --!   １段挿入するが、この場合バースト転送時に１ワード転送
                          --!   毎に１サイクルのウェイトが発生する.
                          --! * I_REGS_SIZE>1を指定した場合、パイプラインレジスタを
                          --!   指定された段数挿入する. この場合、バースト転送時
                          --!   にウェイトは発生しない.
                          integer := 0;
        O_REGS_SIZE     : --! @brief PORT OUTLET REGS SIZE :
                          --! 出力側に挿入するパイプラインレジスタの段数を指定する.
                          --! * O_REGS_SIZE=0を指定した場合、パイプラインレジスタは
                          --!   挿入しない.
                          --! * O_REGS_SIZE=1を指定した場合、パイプラインレジスタを
                          --!   １段挿入するが、この場合バースト転送時に１ワード
                          --!   転送毎に１サイクルのウェイトが発生する.
                          --! * O_REGS_SIZE>1を指定した場合、パイプラインレジスタを
                          --!   指定された段数挿入する. この場合、バースト転送時
                          --!   にウェイトは発生しない.
                          integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        START           : --! @brief START :
                          --! 開始信号.
                          --! * この信号はSTART_PTR/XFER_LAST/XFER_SELを内部に設定
                          --!   してこのモジュールを初期化しする.
                          --! * 最初にデータ入力と同時にアサートしても構わない.
                          in  std_logic;
        ASIZE           : --! @brief AXI4 BURST SIZE :
                          --! AXI4 によるバーストサイズを指定する.
                          in  AXI4_ASIZE_TYPE;
        ALEN            : --! @brief AXI4 BURST LENGTH :
                          --! AXI4 によるバースト数を指定する.
                          in  std_logic_vector(ALEN_BITS-1 downto 0);
        ADDR            : --! @brief START TRANSFER ADDRESS :
                          --! 出力側のアドレス.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(ADDR_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Intake Port Signals.
    -------------------------------------------------------------------------------
        I_DATA          : --! @brief INTAKE PORT DATA :
                          --! ワードデータ入力.
                          in  std_logic_vector(DATA_BITS  -1 downto 0);
        I_STRB          : --! @brief INTAKE PORT DATA STROBE :
                          --! バイト単位での有効信号.
                          in  std_logic_vector(DATA_BITS/8-1 downto 0);
        I_SIZE          : --! @brief INTAKE PORT DATA SIZE :
                          --! 入力ワードデータのバイト数.
                          in  std_logic_vector(SIZE_BITS  -1 downto 0);
        I_USER          : --! @brief INTAKE PORT USER DATA :
                          --! 入力ユーザー定義信号.
                          in  std_logic_vector(USER_BITS  -1 downto 0);
        I_ERROR         : --! @brief INTAKE PORT ERROR :
                          --! エラー入力.
                          --! * 入力時にエラーが発生した事を示すフラグ.
                          in  std_logic;
        I_LAST          : --! @brief INTAKE PORT DATA LAST :
                          --! 最終ワード信号入力.
                          --! * 最後のワードデータ入力であることを示すフラグ.
                          in  std_logic;
        I_VALID         : --! @brief INTAKE PORT VALID :
                          --! 入力ワード有効信号.
                          --! * I_DATA/I_STRB/I_LAST/I_USER/I_SIZEが有効であること
                          --!   を示す.
                          --! * I_VALID='1'and I_READY='1'で上記信号がキューに取り
                          --!   込まれる.
                          in  std_logic;
        I_READY         : --! @brief INTAKE PORT READY :
                          --! 入力レディ信号.
                          --! * キューが次のワードデータを入力出来ることを示す.
                          --! * I_VALID='1'and I_READY='1'で上記信号がキューから
                          --!   取り出される.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- Outlet Port Signals.
    -------------------------------------------------------------------------------
        O_DATA          : --! @brief OUTLET PORT DATA :
                          --! ワードデータ出力.
                          out std_logic_vector(DATA_BITS  -1 downto 0);
        O_STRB          : --! @brief OUTLET PORT DATA STROBE :
                          --! ポートへデータを出力する際のバイト単位での有効信号.
                          out std_logic_vector(DATA_BITS/8-1 downto 0);
        O_SIZE          : --! @brief OUTLET PORT DATA SIZE :
                          --! ポートへデータを出力する際のバイト数.
                          out std_logic_vector(SIZE_BITS  -1 downto 0);
        O_USER          : --! @brief OUTLET PORT USER DATA :
                          --! ポートへデータを出力する際のユーザー定義信号.
                          out std_logic_vector(USER_BITS  -1 downto 0);
        O_ERROR         : --! @brief OUTLET PORT ERROR :
                          --! エラー出力.
                          --! * エラーが発生した事を示すフラグ.
                          out std_logic;
        O_LAST          : --! @brief OUTLET PORT DATA LAST :
                          --! 最終ワード信号出力.
                          --! * 最後のワードデータ出力であることを示すフラグ.
                          out std_logic;
        O_VALID         : --! @brief OUTLET PORT VALID :
                          --! 出力ワード有効信号.
                          --! * O_DATA/O_STRB/O_LASTが有効であることを示す.
                          --! * O_VALID='1'and O_READY='1'で上記信号がキューから取
                          --!   り出される.
                          out std_logic;
        O_READY         : --! @brief OUTLET PORT READY :
                          --! 出力レディ信号.
                          --! * キューが次のワードデータを入力出来ることを示す.
                          --! * O_VALID='1'and O_READY='1'で上記信号がキューから
                          --!   取り出される.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Status Signals.
    -------------------------------------------------------------------------------
        BUSY            : --! @brief QUEUE BUSY :
                          --! キューが動作中であることを示す信号.
                          --! * 最初にデータが入力されたときにアサートされる.
                          --! * 最後のデータが出力し終えたらネゲートされる.
                          out  std_logic
    );
end AXI4_DATA_PORT;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.COMPONENTS.QUEUE_REGISTER;
architecture RTL of AXI4_DATA_PORT is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant STRB_BITS      : integer := DATA_BITS/8;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant REGS_LO        : integer := 0;
    constant REGS_DATA_LO   : integer := REGS_LO;
    constant REGS_DATA_HI   : integer := REGS_DATA_LO  + DATA_BITS   - 1;
    constant REGS_STRB_LO   : integer := REGS_DATA_HI  + 1;
    constant REGS_STRB_HI   : integer := REGS_STRB_LO  + DATA_BITS/8 - 1;
    constant REGS_SIZE_LO   : integer := REGS_STRB_HI  + 1;
    constant REGS_SIZE_HI   : integer := REGS_SIZE_LO  + SIZE_BITS   - 1;
    constant REGS_USER_LO   : integer := REGS_SIZE_HI  + 1;
    constant REGS_USER_HI   : integer := REGS_USER_LO  + USER_BITS   - 1;
    constant REGS_LAST_POS  : integer := REGS_USER_HI  + 1;
    constant REGS_ERROR_POS : integer := REGS_LAST_POS + 1;
    constant REGS_HI        : integer := REGS_ERROR_POS;
    constant REGS_BITS      : integer := REGS_HI       + 1;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    function count_assert_bit(ARG:std_logic_vector) return integer is
        variable n  : integer range 0 to ARG'length;
        variable nL : integer range 0 to ARG'length/2;
        variable nH : integer range 0 to ARG'length-ARG'length/2;
        alias    a  : std_logic_vector(ARG'length-1 downto 0) is ARG;
    begin
        case a'length is
            when 0 =>                   n := 0;
            when 1 =>
                if    (a =    "1") then n := 1;
                else                    n := 0;
                end if;
            when 2 =>
                if    (a =   "11") then n := 2;
                elsif (a =   "10") then n := 1;
                elsif (a =   "01") then n := 1;
                else                    n := 0;
                end if;
            when 4 =>
                if    (a = "1111") then n := 4;
                elsif (a = "1110") then n := 3;
                elsif (a = "1101") then n := 3;
                elsif (a = "1100") then n := 2;
                elsif (a = "1011") then n := 3;
                elsif (a = "1010") then n := 2;
                elsif (a = "1001") then n := 2;
                elsif (a = "1000") then n := 1;
                elsif (a = "0111") then n := 3;
                elsif (a = "0110") then n := 2;
                elsif (a = "0101") then n := 2;
                elsif (a = "0100") then n := 1;
                elsif (a = "0011") then n := 2;
                elsif (a = "0010") then n := 1;
                elsif (a = "0001") then n := 1;
                else                    n := 0;
                end if;
            when others =>
                nL := count_assert_bit(a(a'length/2-1 downto a'low     ));
                nH := count_assert_bit(a(a'high       downto a'length/2));
                n  := nL + nH;
        end case;
        return n;
    end function;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   i_enable   : std_logic;
    signal   o_busy     : std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   l_data     : std_logic_vector(DATA_BITS-1 downto 0);
    signal   l_strb     : std_logic_vector(STRB_BITS-1 downto 0);
    signal   l_size     : std_logic_vector(SIZE_BITS-1 downto 0);
    signal   l_user     : std_logic_vector(USER_BITS-1 downto 0);
    signal   l_error    : std_logic;
    signal   l_last     : std_logic;
    signal   l_valid    : std_logic;
    signal   l_ready    : std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   m_data     : std_logic_vector(DATA_BITS-1 downto 0);
    signal   m_strb     : std_logic_vector(STRB_BITS-1 downto 0);
    signal   m_size     : std_logic_vector(SIZE_BITS-1 downto 0);
    signal   m_user     : std_logic_vector(USER_BITS-1 downto 0);
    signal   m_error    : std_logic;
    signal   m_last     : std_logic;
    signal   m_valid    : std_logic;
    signal   m_ready    : std_logic;
    signal   m_skip     : std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   n_data     : std_logic_vector(DATA_BITS-1 downto 0);
    signal   n_strb     : std_logic_vector(STRB_BITS-1 downto 0);
    signal   n_size     : std_logic_vector(SIZE_BITS-1 downto 0);
    signal   n_user     : std_logic_vector(USER_BITS-1 downto 0);
    signal   n_error    : std_logic;
    signal   n_last     : std_logic;
    signal   n_valid    : std_logic;
    signal   n_ready    : std_logic;
begin
    -------------------------------------------------------------------------------
    -- INTAKE PORT
    -------------------------------------------------------------------------------
    INTAKE_PORT: block
        signal   i_val       : std_logic;
        signal   i_rdy       : std_logic;
        signal   l_val       : std_logic_vector(I_REGS_SIZE downto 0);
        signal   i_word      : std_logic_vector(REGS_HI downto REGS_LO);
        signal   l_word      : std_logic_vector(REGS_HI downto REGS_LO);
    begin
        ---------------------------------------------------------------------------
        -- I_XXXX を i_word にセット
        ---------------------------------------------------------------------------
        i_word(REGS_DATA_HI downto REGS_DATA_LO) <= I_DATA;
        i_word(REGS_STRB_HI downto REGS_STRB_LO) <= I_STRB;
        i_word(REGS_SIZE_HI downto REGS_SIZE_LO) <= I_SIZE;
        i_word(REGS_USER_HI downto REGS_USER_LO) <= I_USER;
        i_word(REGS_LAST_POS)                    <= I_LAST;
        i_word(REGS_ERROR_POS)                   <= I_ERROR;
        i_val   <= '1' when (i_enable = '1' and I_VALID = '1') else '0';
        I_READY <= '1' when (i_enable = '1' and i_rdy   = '1') else '0';
        ---------------------------------------------------------------------------
        -- 出力レジスタ
        ---------------------------------------------------------------------------
        REGS: QUEUE_REGISTER
            generic map (
                QUEUE_SIZE  => I_REGS_SIZE , 
                DATA_BITS   => REGS_BITS   ,
                LOWPOWER    => 0                
            )
            port map (
            -----------------------------------------------------------------------
            -- クロック&リセット信号
            -----------------------------------------------------------------------
                CLK         => CLK         , -- In  :
                RST         => RST         , -- In  :
                CLR         => CLR         , -- In  :
            -----------------------------------------------------------------------
            -- 入力側
            -----------------------------------------------------------------------
                I_DATA      => i_word      , -- In  :
                I_VAL       => i_val       , -- In  :
                I_RDY       => i_rdy       , -- Out :
            -----------------------------------------------------------------------
            -- 出力側
            -----------------------------------------------------------------------
                O_DATA      => open        , -- Out :
                O_VAL       => open        , -- Out :
                Q_DATA      => l_word      , -- Out :
                Q_VAL       => l_val       , -- Out :
                Q_RDY       => l_ready       -- In  :
            );
        l_valid <= l_val(0);
        l_data  <= l_word(REGS_DATA_HI downto REGS_DATA_LO);
        l_strb  <= l_word(REGS_STRB_HI downto REGS_STRB_LO);
        l_size  <= l_word(REGS_SIZE_HI downto REGS_SIZE_LO);
        l_user  <= l_word(REGS_USER_HI downto REGS_USER_LO);
        l_last  <= l_word(REGS_LAST_POS);
        l_error <= l_word(REGS_ERROR_POS);
    end block;
    -------------------------------------------------------------------------------
    -- ASIZE による Narrow transfers を行う場合.
    -------------------------------------------------------------------------------
    NARROW_XFER_T : if (USE_ASIZE /= 0) generate
        ---------------------------------------------------------------------------
        -- データのバイト数の２のべき乗値を計算する関数.
        ---------------------------------------------------------------------------
        function CALC_DATA_WIDTH(WIDTH:integer) return integer is
            variable value : integer;
        begin
            value := 0;
            while (2**(value+3) < WIDTH) loop
                value := value + 1;
            end loop;
            return value;
        end function;
        ---------------------------------------------------------------------------
        -- データのバイト数の２のべき乗値.
        ---------------------------------------------------------------------------
        constant  DATA_WIDTH        : integer := CALC_DATA_WIDTH(DATA_BITS);
        constant  DATA_WIDTH_1BYTE  : integer := 0;
        constant  DATA_WIDTH_2BYTE  : integer := 1;
        constant  DATA_WIDTH_4BYTE  : integer := 2;
        constant  DATA_WIDTH_8BYTE  : integer := 3;
        constant  DATA_WIDTH_16BYTE : integer := 4;
        constant  DATA_WIDTH_32BYTE : integer := 5;
        constant  DATA_WIDTH_64BYTE : integer := 6;
        constant  DATA_WIDTH_128BYTE: integer := 7;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        constant  STRB_ALL0         : std_logic_vector(STRB_BITS-1 downto 0) := (others => '0');
        constant  STRB_ALL1         : std_logic_vector(STRB_BITS-1 downto 0) := (others => '1');
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        type      STRB_MASK_TYPE is record
                  enable            : std_logic_vector(STRB_BITS-1 downto 0);
                  remain            : std_logic_vector(STRB_BITS-1 downto 0);
        end record;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        constant  STRB_MASK_ALL1    : STRB_MASK_TYPE := (
                                        enable => STRB_ALL1,
                                        remain => STRB_ALL0
                                    );
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        function GEN_STRB_MASK(
                      WORD_POS   : unsigned;  -- 現在の出力中のワード位置
            constant  WORD_BITS  : integer    -- ASIZEで指定された1ワードのバイト数
        )             return       STRB_MASK_TYPE
        is
            variable  STRB_MASK  : STRB_MASK_TYPE;
            constant  N          : integer := STRB_BITS/WORD_BITS;
            constant  ALL1       : std_logic_vector(WORD_BITS-1 downto 0) := (others => '1');
            constant  ALL0       : std_logic_vector(WORD_BITS-1 downto 0) := (others => '0');
        begin
            for i in 0 to N-1 loop
                if (i = WORD_POS) then
                    STRB_MASK.enable(WORD_BITS*(i+1)-1 downto WORD_BITS*i) := ALL1;
                else
                    STRB_MASK.enable(WORD_BITS*(i+1)-1 downto WORD_BITS*i) := ALL0;
                end if;
                if (i > WORD_POS) then
                    STRB_MASK.remain(WORD_BITS*(i+1)-1 downto WORD_BITS*i) := ALL1;
                else
                    STRB_MASK.remain(WORD_BITS*(i+1)-1 downto WORD_BITS*i) := ALL0;
                end if;
            end loop;
            return STRB_MASK;
        end function;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        function  GEN_STRB_MASK(
                      BYTE_POS   : unsigned;  -- 現在の出力中のバイト位置
                      WORD_WIDTH : integer ;  -- ASIZEで指定された1ワードのバイト数(2のべき乗値)
            constant  DATA_WIDTH : integer    -- データ入出力信号のバイト数(2のべき乗値)
        )             return       STRB_MASK_TYPE
        is
        begin
            case DATA_WIDTH is
                when DATA_WIDTH_2BYTE   =>
                    case WORD_WIDTH is
                        when DATA_WIDTH_1BYTE  => return GEN_STRB_MASK(BYTE_POS(0 downto 0),  1);
                        when others            => return STRB_MASK_ALL1;
                    end case;
                when DATA_WIDTH_4BYTE   =>
                    case WORD_WIDTH is
                        when DATA_WIDTH_1BYTE  => return GEN_STRB_MASK(BYTE_POS(1 downto 0),  1);
                        when DATA_WIDTH_2BYTE  => return GEN_STRB_MASK(BYTE_POS(1 downto 1),  2);
                        when others            => return STRB_MASK_ALL1;
                    end case;
                when DATA_WIDTH_8BYTE   =>                               
                    case WORD_WIDTH is
                        when DATA_WIDTH_1BYTE  => return GEN_STRB_MASK(BYTE_POS(2 downto 0),  1);
                        when DATA_WIDTH_2BYTE  => return GEN_STRB_MASK(BYTE_POS(2 downto 1),  2);
                        when DATA_WIDTH_4BYTE  => return GEN_STRB_MASK(BYTE_POS(2 downto 2),  4);
                        when others            => return STRB_MASK_ALL1;
                    end case;
                when DATA_WIDTH_16BYTE  =>                               
                    case WORD_WIDTH is
                        when DATA_WIDTH_1BYTE  => return GEN_STRB_MASK(BYTE_POS(3 downto 0),  1);
                        when DATA_WIDTH_2BYTE  => return GEN_STRB_MASK(BYTE_POS(3 downto 1),  2);
                        when DATA_WIDTH_4BYTE  => return GEN_STRB_MASK(BYTE_POS(3 downto 2),  4);
                        when DATA_WIDTH_8BYTE  => return GEN_STRB_MASK(BYTE_POS(3 downto 3),  8);
                        when others            => return STRB_MASK_ALL1;
                    end case;
                when DATA_WIDTH_32BYTE  =>                               
                    case WORD_WIDTH is
                        when DATA_WIDTH_1BYTE  => return GEN_STRB_MASK(BYTE_POS(4 downto 0),  1);
                        when DATA_WIDTH_2BYTE  => return GEN_STRB_MASK(BYTE_POS(4 downto 1),  2);
                        when DATA_WIDTH_4BYTE  => return GEN_STRB_MASK(BYTE_POS(4 downto 2),  4);
                        when DATA_WIDTH_8BYTE  => return GEN_STRB_MASK(BYTE_POS(4 downto 3),  8);
                        when DATA_WIDTH_16BYTE => return GEN_STRB_MASK(BYTE_POS(4 downto 4), 16);
                        when others            => return STRB_MASK_ALL1;
                    end case;
                when DATA_WIDTH_64BYTE  =>                               
                    case WORD_WIDTH is
                        when DATA_WIDTH_1BYTE  => return GEN_STRB_MASK(BYTE_POS(5 downto 0),  1);
                        when DATA_WIDTH_2BYTE  => return GEN_STRB_MASK(BYTE_POS(5 downto 1),  2);
                        when DATA_WIDTH_4BYTE  => return GEN_STRB_MASK(BYTE_POS(5 downto 2),  4);
                        when DATA_WIDTH_8BYTE  => return GEN_STRB_MASK(BYTE_POS(5 downto 3),  8);
                        when DATA_WIDTH_16BYTE => return GEN_STRB_MASK(BYTE_POS(5 downto 4), 16);
                        when DATA_WIDTH_32BYTE => return GEN_STRB_MASK(BYTE_POS(5 downto 5), 32);
                        when others            => return STRB_MASK_ALL1;
                    end case;
                when DATA_WIDTH_128BYTE =>
                    case WORD_WIDTH is
                        when DATA_WIDTH_1BYTE  => return GEN_STRB_MASK(BYTE_POS(6 downto 0),  1);
                        when DATA_WIDTH_2BYTE  => return GEN_STRB_MASK(BYTE_POS(6 downto 1),  2);
                        when DATA_WIDTH_4BYTE  => return GEN_STRB_MASK(BYTE_POS(6 downto 2),  4);
                        when DATA_WIDTH_8BYTE  => return GEN_STRB_MASK(BYTE_POS(6 downto 3),  8);
                        when DATA_WIDTH_16BYTE => return GEN_STRB_MASK(BYTE_POS(6 downto 4), 16);
                        when DATA_WIDTH_32BYTE => return GEN_STRB_MASK(BYTE_POS(6 downto 5), 32);
                        when DATA_WIDTH_64BYTE => return GEN_STRB_MASK(BYTE_POS(6 downto 6), 64);
                        when others            => return STRB_MASK_ALL1;
                    end case;
                when others                    => return STRB_MASK_ALL1;
            end case;
        end function;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        signal    next_word_width : integer range 0 to    DATA_WIDTH;
        signal    curr_word_width : integer range 0 to    DATA_WIDTH;
        signal    next_word_bytes : integer range 0 to 2**DATA_WIDTH;
        signal    curr_word_bytes : integer range 0 to 2**DATA_WIDTH;
        signal    next_pos        : unsigned(DATA_WIDTH downto 0);
        signal    curr_pos        : unsigned(DATA_WIDTH downto 0);
        signal    strb_mask       : STRB_MASK_TYPE;
        signal    word_last       : boolean;
    begin
        ---------------------------------------------------------------------------
        -- next_word_bytes : 1ワードのバイト数
        -- next_word_width : 1ワードのバイト数(2のべき乗値)
        ---------------------------------------------------------------------------
        process (START, ASIZE, curr_word_bytes, curr_word_width) begin
            if (START = '1') then
                case DATA_WIDTH is
                    when DATA_WIDTH_1BYTE   =>
                                                       next_word_bytes <=  1; next_word_width <= DATA_WIDTH_1BYTE;
                    when DATA_WIDTH_2BYTE   =>
                        case ASIZE is
                            when AXI4_ASIZE_1BYTE   => next_word_bytes <=  1; next_word_width <= DATA_WIDTH_1BYTE;
                            when others             => next_word_bytes <=  2; next_word_width <= DATA_WIDTH_2BYTE;
                        end case;
                    when DATA_WIDTH_4BYTE   =>
                        case ASIZE is
                            when AXI4_ASIZE_1BYTE   => next_word_bytes <=  1; next_word_width <= DATA_WIDTH_1BYTE;
                            when AXI4_ASIZE_2BYTE   => next_word_bytes <=  2; next_word_width <= DATA_WIDTH_2BYTE;
                            when others             => next_word_bytes <=  4; next_word_width <= DATA_WIDTH_4BYTE;
                        end case;
                    when DATA_WIDTH_8BYTE   =>
                        case ASIZE is
                            when AXI4_ASIZE_1BYTE   => next_word_bytes <=  1; next_word_width <= DATA_WIDTH_1BYTE;
                            when AXI4_ASIZE_2BYTE   => next_word_bytes <=  2; next_word_width <= DATA_WIDTH_2BYTE;
                            when AXI4_ASIZE_4BYTE   => next_word_bytes <=  4; next_word_width <= DATA_WIDTH_4BYTE;
                            when others             => next_word_bytes <=  8; next_word_width <= DATA_WIDTH_8BYTE;
                        end case;
                    when DATA_WIDTH_16BYTE  =>
                        case ASIZE is
                            when AXI4_ASIZE_1BYTE   => next_word_bytes <=  1; next_word_width <= DATA_WIDTH_1BYTE;
                            when AXI4_ASIZE_2BYTE   => next_word_bytes <=  2; next_word_width <= DATA_WIDTH_2BYTE;
                            when AXI4_ASIZE_4BYTE   => next_word_bytes <=  4; next_word_width <= DATA_WIDTH_4BYTE;
                            when AXI4_ASIZE_8BYTE   => next_word_bytes <=  8; next_word_width <= DATA_WIDTH_8BYTE;
                            when others             => next_word_bytes <= 16; next_word_width <= DATA_WIDTH_16BYTE;
                        end case;
                    when DATA_WIDTH_32BYTE  =>
                        case ASIZE is
                            when AXI4_ASIZE_1BYTE   => next_word_bytes <=  1; next_word_width <= DATA_WIDTH_1BYTE;
                            when AXI4_ASIZE_2BYTE   => next_word_bytes <=  2; next_word_width <= DATA_WIDTH_2BYTE;
                            when AXI4_ASIZE_4BYTE   => next_word_bytes <=  4; next_word_width <= DATA_WIDTH_4BYTE;
                            when AXI4_ASIZE_8BYTE   => next_word_bytes <=  8; next_word_width <= DATA_WIDTH_8BYTE;
                            when AXI4_ASIZE_16BYTE  => next_word_bytes <= 16; next_word_width <= DATA_WIDTH_16BYTE;
                            when others             => next_word_bytes <= 32; next_word_width <= DATA_WIDTH_32BYTE;
                        end case;
                    when DATA_WIDTH_64BYTE  =>
                        case ASIZE is
                            when AXI4_ASIZE_1BYTE   => next_word_bytes <=  1; next_word_width <= DATA_WIDTH_1BYTE;
                            when AXI4_ASIZE_2BYTE   => next_word_bytes <=  2; next_word_width <= DATA_WIDTH_2BYTE;
                            when AXI4_ASIZE_4BYTE   => next_word_bytes <=  4; next_word_width <= DATA_WIDTH_4BYTE;
                            when AXI4_ASIZE_8BYTE   => next_word_bytes <=  8; next_word_width <= DATA_WIDTH_8BYTE;
                            when AXI4_ASIZE_16BYTE  => next_word_bytes <= 16; next_word_width <= DATA_WIDTH_16BYTE;
                            when AXI4_ASIZE_32BYTE  => next_word_bytes <= 32; next_word_width <= DATA_WIDTH_32BYTE;
                            when others             => next_word_bytes <= 64; next_word_width <= DATA_WIDTH_64BYTE;
                        end case;
                    when DATA_WIDTH_128BYTE =>
                        case ASIZE is
                            when AXI4_ASIZE_1BYTE   => next_word_bytes <=  1; next_word_width <= DATA_WIDTH_1BYTE;
                            when AXI4_ASIZE_2BYTE   => next_word_bytes <=  2; next_word_width <= DATA_WIDTH_2BYTE;
                            when AXI4_ASIZE_4BYTE   => next_word_bytes <=  4; next_word_width <= DATA_WIDTH_4BYTE;
                            when AXI4_ASIZE_8BYTE   => next_word_bytes <=  8; next_word_width <= DATA_WIDTH_8BYTE;
                            when AXI4_ASIZE_16BYTE  => next_word_bytes <= 16; next_word_width <= DATA_WIDTH_16BYTE;
                            when AXI4_ASIZE_32BYTE  => next_word_bytes <= 32; next_word_width <= DATA_WIDTH_32BYTE;
                            when AXI4_ASIZE_64BYTE  => next_word_bytes <= 64; next_word_width <= DATA_WIDTH_64BYTE;
                            when others             => next_word_bytes <=128; next_word_width <= DATA_WIDTH_128BYTE;
                        end case;
                    when others                     => next_word_bytes <=  1; next_word_width <= DATA_WIDTH_1BYTE;
                end case;
            else
                next_word_bytes <= curr_word_bytes;
                next_word_width <= curr_word_width;
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- next_pos  :
        -- word_last : 
        ---------------------------------------------------------------------------
        process (ADDR, START, n_valid, n_ready, curr_pos, curr_word_bytes)
            variable temp_pos  : unsigned(DATA_WIDTH downto 0);
            variable temp_size : AXI4_ASIZE_TYPE;
        begin 
            if (START = '1') then
                for i in next_pos'range loop
                    if (i < DATA_WIDTH and ADDR(i) = '1') then
                        next_pos(i) <= '1';
                    else
                        next_pos(i) <= '0';
                    end if;
                end loop;
                word_last <= FALSE;
            elsif (n_valid = '1' and n_ready = '1') then
                temp_pos  := curr_pos + curr_word_bytes;
                if (to_01(temp_pos) >= 2**DATA_WIDTH) then
                    next_pos  <= (others => '0');
                    word_last <= TRUE;
                else
                    next_pos  <= temp_pos;
                    word_last <= FALSE;
                end if;
            else
                next_pos  <= curr_pos;
                word_last <= FALSE;
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- curr_pos  :
        -- strb_mask : 
        ---------------------------------------------------------------------------
        process (CLK, RST) begin
            if (RST = '1') then
                    curr_word_bytes <= 0;
                    curr_word_width <= 0;
                    curr_pos        <= (others => '0');
                    strb_mask       <= STRB_MASK_ALL1;
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    curr_word_bytes <= 0;
                    curr_word_width <= 0;
                    curr_pos        <= (others => '0');
                    strb_mask       <= STRB_MASK_ALL1;
                else
                    curr_word_bytes <= next_word_bytes;
                    curr_word_width <= next_word_width;
                    curr_pos        <= next_pos;
                    strb_mask       <= GEN_STRB_MASK(
                                           BYTE_POS   => next_pos,
                                           WORD_WIDTH => next_word_width,
                                           DATA_WIDTH => DATA_WIDTH
                                       );
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        m_valid <= l_valid;
        m_data  <= l_data;
        m_user  <= l_user;
        m_error <= l_error;
        m_strb  <= l_strb and strb_mask.enable;
        m_size  <= std_logic_vector(to_unsigned(count_assert_bit(l_strb),m_size'length));
        m_last  <= '1' when (l_last = '1') and
                            ((l_strb and strb_mask.remain) = STRB_ALL0) else '0';
        l_ready <= '1' when (m_ready = '1' and word_last   ) or
                            (m_ready = '1' and m_last = '1') or
                            (m_skip  = '1') else '0';
    end generate;
    -------------------------------------------------------------------------------
    -- ASIZE による Narrow transfers 行わない場合.
    -------------------------------------------------------------------------------
    NARROW_XFER_F : if (USE_ASIZE = 0) generate
        m_valid <= l_valid;
        m_data  <= l_data;
        m_strb  <= l_strb;
        m_size  <= l_size;
        m_user  <= l_user;
        m_last  <= l_last;
        m_error <= l_error;
        l_ready <= '1' when (m_ready = '1' or m_skip = '1') else '0';
    end generate;
    -------------------------------------------------------------------------------
    -- CHECK_ALEN によるバースト長のチェックを行う場合の制御部
    -------------------------------------------------------------------------------
    CHECK_ALEN_T: if (CHECK_ALEN /= 0 or USE_ASIZE /= 0) generate
        type     STATE_TYPE  is (IDLE_STATE, XFER_STATE, DUMMY_STATE, SKIP_STATE);
        signal   curr_state  : STATE_TYPE;
        signal   curr_length : std_logic_vector(ALEN'range);
    begin
        process (CLK, RST)
            variable temp_length : unsigned(curr_length'high downto 0);
            variable next_length : unsigned(curr_length'high downto 0);
            variable m_done      : boolean;
        begin
            if (RST = '1') then
                    curr_state  <= IDLE_STATE;
                    curr_length <= (others => '0');
                    n_last      <= '1';
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    curr_state  <= IDLE_STATE;
                    curr_length <= (others => '0');
                    n_last      <= '1';
                else
                    m_done := (m_last = '1' or m_error = '1');
                    case curr_state is
                        when IDLE_STATE =>
                            if (START = '1') then
                                curr_state <= XFER_STATE;
                            else
                                curr_state <= IDLE_STATE;
                            end if;
                        when XFER_STATE =>
                            if (n_valid = '1' and n_ready = '1') then
                                if    (n_last = '1' and m_done = TRUE ) then
                                    curr_state <= IDLE_STATE;
                                elsif (n_last = '0' and m_done = TRUE ) then
                                    curr_state <= DUMMY_STATE;
                                elsif (n_last = '1' and m_done = FALSE) then
                                    curr_state <= SKIP_STATE;
                                else
                                    curr_state <= XFER_STATE;
                                end if;
                            else
                                    curr_state <= XFER_STATE;
                            end if;
                        when DUMMY_STATE =>
                            if (n_valid = '1' and n_ready = '1') then
                                if (n_last = '1') then
                                    curr_state <= IDLE_STATE;
                                else
                                    curr_state <= DUMMY_STATE;
                                end if;
                            else
                                    curr_state <= DUMMY_STATE;
                            end if;
                        when SKIP_STATE =>
                            if (m_valid = '1' and m_done = TRUE) then
                                    curr_state <= IDLE_STATE;
                            else
                                    curr_state <= SKIP_STATE;
                            end if;
                        when others  =>
                            curr_state <= IDLE_STATE;
                    end case;
                end if;
                if (curr_state = IDLE_STATE and START = '1') then
                    temp_length := unsigned(ALEN);
                else
                    temp_length := unsigned(curr_length);
                end if;
                if (n_valid = '1' and n_ready = '1' and temp_length > 0) then
                    next_length := temp_length - 1;
                else
                    next_length := temp_length;
                end if;
                if (next_length = 0) then
                    n_last <= '1';
                else
                    n_last <= '0';
                end if;
                curr_length <= std_logic_vector(next_length);
            end if;
        end process;
        n_data   <= m_data;
        n_user   <= m_user;
        n_error  <= m_error;
        n_strb   <= m_strb when (curr_state = XFER_STATE ) else (others => '0');
        n_size   <= m_size when (curr_state = XFER_STATE ) else (others => '0');
        n_valid  <= '1'    when (curr_state = XFER_STATE and m_valid = '1') or
                                (curr_state = DUMMY_STATE) else '0';
        m_ready  <= '1'    when (curr_state = XFER_STATE and n_ready = '1') else '0';
        m_skip   <= '1'    when (curr_state = SKIP_STATE ) else '0';
        i_enable <= '1'    when (curr_state = XFER_STATE ) or
                                (curr_state = SKIP_STATE ) else '0';
        BUSY     <= '1'    when (curr_state = XFER_STATE ) or
                                (curr_state = DUMMY_STATE) or
                                (curr_state = SKIP_STATE ) or
                                (o_busy     = '1'        ) else '0';
    end generate;
    -------------------------------------------------------------------------------
    -- CHECK_ALEN によるバースト長のチェックを行わない場合の制御部
    -------------------------------------------------------------------------------
    CHECK_ALEN_F: if (CHECK_ALEN = 0 and USE_ASIZE = 0) generate
        type     STATE_TYPE  is (IDLE_STATE, XFER_STATE);
        signal   curr_state  : STATE_TYPE;
    begin
        process (CLK, RST)
            variable m_done : boolean;
        begin
            if (RST = '1') then
                    curr_state  <= IDLE_STATE;
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    curr_state  <= IDLE_STATE;
                else
                    m_done := (m_last = '1' or m_error = '1');
                    case curr_state is
                        when IDLE_STATE =>
                            if (START = '1') then
                                curr_state <= XFER_STATE;
                            else
                                curr_state <= IDLE_STATE;
                            end if;
                        when XFER_STATE =>
                            if (m_valid = '1' and m_ready = '1' and m_done = TRUE) then
                                curr_state <= IDLE_STATE;
                            else
                                curr_state <= XFER_STATE;
                            end if;
                        when others =>
                                curr_state <= IDLE_STATE;
                    end case;
                end if;
            end if;
        end process;
        n_data   <= m_data;
        n_user   <= m_user;
        n_last   <= m_last;
        n_error  <= m_error;
        n_strb   <= m_strb;
        n_size   <= m_size;
        n_valid  <= m_valid;
        m_ready  <= n_ready;
        m_skip   <= '0';
        i_enable <= '1' when (curr_state = XFER_STATE ) else '0';
        BUSY     <= '1' when (curr_state = XFER_STATE ) or
                             (o_busy     = '1'        ) else '0';
    end generate;
    -------------------------------------------------------------------------------
    -- OUTLET PORT
    -------------------------------------------------------------------------------
    OUTLET_PORT: block
        signal   n_word      : std_logic_vector(REGS_HI downto REGS_LO);
        signal   o_word      : std_logic_vector(REGS_HI downto REGS_LO);
        signal   o_val       : std_logic_vector(O_REGS_SIZE downto 0);
    begin
        ---------------------------------------------------------------------------
        -- n_xxxx を n_word にセット
        ---------------------------------------------------------------------------
        n_word(REGS_DATA_HI downto REGS_DATA_LO) <= n_data;
        n_word(REGS_STRB_HI downto REGS_STRB_LO) <= n_strb;
        n_word(REGS_SIZE_HI downto REGS_SIZE_LO) <= n_size;
        n_word(REGS_USER_HI downto REGS_USER_LO) <= n_user;
        n_word(REGS_LAST_POS)                    <= n_last;
        n_word(REGS_ERROR_POS)                   <= n_error;
        ---------------------------------------------------------------------------
        -- 出力レジスタ
        ---------------------------------------------------------------------------
        REGS: QUEUE_REGISTER
            generic map (
                QUEUE_SIZE  => O_REGS_SIZE , 
                DATA_BITS   => REGS_BITS   ,
                LOWPOWER    => 0                
            )
            port map (
            -----------------------------------------------------------------------
            -- クロック&リセット信号
            -----------------------------------------------------------------------
                CLK         => CLK         , -- In  :
                RST         => RST         , -- In  :
                CLR         => CLR         , -- In  :
            -----------------------------------------------------------------------
            -- 入力側
            -----------------------------------------------------------------------
                I_DATA      => n_word      , -- In  :
                I_VAL       => n_valid     , -- In  :
                I_RDY       => n_ready     , -- Out :
            -----------------------------------------------------------------------
            -- 出力側
            -----------------------------------------------------------------------
                O_DATA      => open        , -- Out :
                O_VAL       => open        , -- Out :
                Q_DATA      => o_word      , -- Out :
                Q_VAL       => o_val       , -- Out :
                Q_RDY       => O_READY       -- In  :
            );
        o_busy  <= o_val(0);
        o_valid <= o_val(0);
        O_DATA  <= o_word(REGS_DATA_HI downto REGS_DATA_LO);
        O_STRB  <= o_word(REGS_STRB_HI downto REGS_STRB_LO);
        O_SIZE  <= o_word(REGS_SIZE_HI downto REGS_SIZE_LO);
        O_USER  <= o_word(REGS_USER_HI downto REGS_USER_LO);
        O_LAST  <= o_word(REGS_LAST_POS);
        O_ERROR <= o_word(REGS_ERROR_POS);
    end block;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    chopper.vhd
--!     @brief   CHOPPER MODULE :
--!              先頭アドレス(ADDR信号)と容量(SIZE信号)で表されたブロックを、
--!              指定された単位(SEL信号およびMIN_PIECE変数、MAX_PIECE変数)のピース
--!              に分割するモジュール.
--!     @version 1.5.8
--!     @date    2015/5/19
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2015 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   CHOPPER :
--!          先頭アドレス(ADDR信号)と容量(SIZE信号)で表されたブロックを、
--!          指定された単位(SEL信号およびMIN_PIECE変数、MAX_PIECE変数)のピースに
--!          分割するモジュール.
--!        * 例1) ADDR=0x0002、SIZE=11、１ピースのサイズ=4の場合、
--!          2、4、4、1のサイズのピースに分割します.
--!        * 例2) ADDR=0x0048、SIZE=0x400、１ピースのサイズ=0x100の場合、
--!          0x0B8、0x100、0x100、0x100、0x048のサイズのピースに分割します.
--!        * ついでにピース有効信号(１ピースのうちどの部分が有効かを示す信号)も出力
--!          します.
--!          例えば、ADDR=0x0002、SIZE=11、１ピースのサイズ=4の場合、
--!          "1100"、"1111"、"1111"、"0001" を生成します.
--!          機能的には別モジュールでも良かったのですが、このモジュールで生成する
--!          ことにより回路が削減できるため、一緒にしました.
-----------------------------------------------------------------------------------
entity  CHOPPER is
    -------------------------------------------------------------------------------
    -- ジェネリック変数
    -------------------------------------------------------------------------------
    generic (
        BURST       : --! @brief BURST MODE : 
                      --! バースト転送に対応するかを指定する.
                      --! * 1:バースト転送に対応する.
                      --!   0:バースト転送に対応しない.
                      --! * バースト転送に対応する場合は、CHOP信号をアサートする度に 
                      --!   PIECE_COUNT や各種出力信号が更新される.
                      --! * バースト転送に対応しない場合は、カウンタの初期値は１に設
                      --!   定され、CHOP信号が一回アサートされた時点でカウンタは停止
                      --!   する. つまり、最初のピースのサイズしか生成されない.
                      --! * 当然 BURST=0 の方が回路規模は小さくなる.
                      integer range 0 to 1 := 1;
        MIN_PIECE   : --! @brief MINIMUM PIECE SIZE :
                      --! １ピースの大きさの最小値を2のべき乗値で指定する.
                      --! * 例えば、大きさの単位がバイトの場合次のようになる.
                      --!   0=1バイト、1=2バイト、2=4バイト、3=8バイト
                      integer := 6;
        MAX_PIECE   : --! @brief MAXIMUM PIECE SIZE :
                      --! １ピースの大きさの最大値を2のべき乗値で指定する.
                      --! * 例えば、大きさの単位がバイトの場合次のようになる.
                      --!   0=1バイト、1=2バイト、2=4バイト、3=8バイト
                      --! * MAX_PIECE > MIN_PIECE の場合、１ピースの大きさを 
                      --!   SEL 信号によって選択することができる.
                      --!   SEL信号の対応するビットを'1'に設定して他のビットを'0'に
                      --!   設定することによって１ピースの大きさを指定する.
                      --! * MAX_PIECE = MIN_PIECE の場合、１ピースの大きさは 
                      --!   MIN_PIECEの値になる.
                      --!   この場合は SEL 信号は使用されない.
                      --! * MAX_PIECE と MIN_PIECE の差が大きいほど、回路規模は
                      --!   大きくなる。
                      integer := 6;
        MAX_SIZE    : --! @brief MAXIMUM SIZE :
                      --! 想定している最大の大きさを2のべき乗値で指定する.
                      --! * この回路内で、MAX_SIZE-MIN_PIECEのビット幅のカウンタを
                      --!   生成する。
                      integer := 9;
        ADDR_BITS   : --! @brief BLOCK ADDRESS BITS :
                      --! ブロックの先頭アドレスを指定する信号(ADDR信号)の
                      --! ビット幅を指定する.
                      integer := 9;
        SIZE_BITS   : --! @brief BLOCK SIZE BITS :
                      --! ブロックの大きさを指定する信号(SIZE信号)のビット幅を
                      --! 指定する.
                      integer := 9;
        COUNT_BITS  : --! @brief OUTPUT COUNT BITS :
                      --! 出力するカウンタ信号(COUNT)のビット幅を指定する.
                      --! * 出力するカウンタのビット幅は、想定している最大の大きさ
                      --!   (MAX_SIZE)-１ピースの大きさの最小値(MIN_PIECE)以上で
                      --!   なければならない.
                      --! * カウンタ信号(COUNT)を使わない場合は、エラボレーション時
                      --!   にエラーが発生しないように1以上の値を指定しておく.
                      integer := 9;
        PSIZE_BITS  : --! @brief OUTPUT PIECE SIZE BITS :
                      --! 出力するピースサイズ(PSIZE,NEXT_PSIZE)のビット幅を指定する.
                      --! * ピースサイズのビット幅は、MAX_PIECE(１ピースのサイズを
                      --!   表現できるビット数)以上でなければならない.
                      integer := 9;
        GEN_VALID   : --! @brief GENERATE VALID FLAG :
                      --! ピース有効信号(VALID/NEXT_VALID)を生成するかどうかを指定する.
                      --! * GEN_VALIDが０以外の場合は、ピース有効信号を生成する.
                      --! * GEN_VALIDが０の場合は、ピース有効信号はALL'1'になる.
                      --! * GEN_VALIDが０以外でも、この回路の上位階層で
                      --!   ピース有効をopenにしても論理上は問題ないが、
                      --!   論理合成ツールによっては、コンパイルに膨大な時間を
                      --!   要することがある.
                      --!   その場合はこの変数を０にすることで解決出来る場合がある.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 各種初期値
    -------------------------------------------------------------------------------
        ADDR        : --! @brief BLOCK ADDRESS :
                      --! ブロックの先頭アドレス.
                      --! * LOAD信号のアサート時に内部に保存される.
                      --! * 入力はADDR_BITSで示されるビット数あるが、実際に使用され
                      --!   るのは、1ピース分の下位ビットだけ.
                      in  std_logic_vector(ADDR_BITS-1 downto 0);
        SIZE        : --! @brief BLOCK SIZE :
                      --! ブロックの大きさ.
                      --! * LOAD信号のアサート時に内部に保存される.
                      in  std_logic_vector(SIZE_BITS-1 downto 0);
        SEL         : --! @brief PIECE SIZE SELECT :
                      --! １ピースの大きさを選択するための信号.
                      --! * LOAD信号のアサート時に内部に保存される.
                      --! * １ピースの大きさに対応するビットのみ'1'をセットし、他の
                      --!   ビットは'0'をセットすることで１ピースの大きさを選択する.
                      --! * もしSEL信号のうち複数のビットに'1'が設定されていた場合は
                      --!   もっとも最小値に近い値(MIN_PIECEの値)が選ばれる。
                      --! * この信号は MAX_PIECE > MIN_PIECE の場合にのみ使用される.
                      --! * この信号は MAX_PIECE = MIN_PIECE の場合は無視される.
                      in  std_logic_vector(MAX_PIECE downto MIN_PIECE);
        LOAD        : --! @brief LOAD :
                      --! ADDR,SIZE,SELを内部にロードするための信号.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 制御信号
    -------------------------------------------------------------------------------
        CHOP        : --! @brief CHOP ENABLE :
                      --! ブロックをピースに分割する信号.
                      --! * この信号のアサートによって、ピースカウンタ、各種フラグ、
                      --!   ピースサイズを更新され、次のクロックでこれらの信号が
                      --!   出力される.
                      --! * LOAD信号と同時にアサートされた場合はLOADの方が優先され、
                      --!   CHOP信号は無視される.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- ピースカウンタ/フラグ出力
    -------------------------------------------------------------------------------
        COUNT       : --! @brief PIECE COUNT :
                      --! 残りのピースの数-1を示す.
                      --! * CHOP信号のアサートによりカウントダウンする.
                      out std_logic_vector(COUNT_BITS-1 downto 0);
        NONE        : --! @brief NONE PIECE FLAG :
                      --! 残りのピースの数が０になったことを示すフラグ.
                      --! * COUNT = (others => '1') で'1'が出力される.
                      out std_logic;
        LAST        : --! @brief LAST PIECE FLAG :
                      --! 残りのピースの数が１になったことを示すフラグ.
                      --! * COUNT = (others => '0') で'1'が出力される.
                      --! * 最後のピースであることを示す.
                      out std_logic;
        NEXT_NONE   : --! @brief NONE PIECE FLAG(NEXT CYCLE) :
                      --! 次のクロックで残りのピースの数が０になることを示すフラグ.
                      out std_logic;
        NEXT_LAST   : --! @brief LAST PIECE FLAG(NEXT CYCYE) :
                      --! 次のクロックで残りのピースの数が１になることを示すフラグ.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- ピースサイズ(1ピースの容量)出力
    -------------------------------------------------------------------------------
        PSIZE       : --! @brief PIECE SIZE :
                      --! 現在のピースの大きさを示す.
                      out std_logic_vector(PSIZE_BITS-1 downto 0);
        NEXT_PSIZE  : --! @brief PIECE SIZE(NEXT CYCLE)
                      --! 次のクロックでのピースの大きさを示す.
                      out std_logic_vector(PSIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- ピース有効出力
    -------------------------------------------------------------------------------
        VALID       : --! @brief PIECE VALID FLAG :
                      --! ピース有効信号.
                      --! * 例えば、ADDR=0x0002、SIZE=11、１ピースのサイズ=4の場合、
                      --!   "1100"、"1111"、"1111"、"0001" を生成する.
                      --! * GEN_VALIDが０以外の場合にのみ有効な値を生成する.
                      --! * GEN_VALIDが０の場合は常に ALL'1' を生成する.
                      out std_logic_vector(2**(MAX_PIECE)-1 downto 0);
        NEXT_VALID  : --! @brief PIECE VALID FALG(NEXT CYCLE)
                      --! 次のクロックでのピース有効信号
                      out std_logic_vector(2**(MAX_PIECE)-1 downto 0)
    );
end CHOPPER;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
architecture RTL of CHOPPER is
    -------------------------------------------------------------------------------
    -- ブロックの先頭アドレス(ADDR)/ブロックのサイズ(SIZE)を扱い易いように内部形式に
    -- 変換した信号
    -------------------------------------------------------------------------------
    signal    block_size        : unsigned(MAX_SIZE downto 0);
    signal    block_size_dec    : unsigned(MAX_SIZE downto 0);
    signal    block_addr_top    : unsigned(MAX_SIZE downto 0);
    signal    block_addr_last   : unsigned(MAX_SIZE downto 0);
    -------------------------------------------------------------------------------
    -- 残りピース数をカウントしているカウンタおよび各種フラグ関連の信号
    -------------------------------------------------------------------------------
    constant  PIECE_COUNT_BITS  : integer := MAX_SIZE - MIN_PIECE;
    signal    curr_piece_count  : unsigned(PIECE_COUNT_BITS downto 0);
    signal    init_piece_count  : unsigned(PIECE_COUNT_BITS downto 0);
    signal    next_piece_count  : unsigned(PIECE_COUNT_BITS downto 0);
    signal    curr_piece_last   : boolean;
    signal    curr_piece_none   : boolean;
    signal    next_piece_last   : boolean;
    signal    next_piece_none   : boolean;
    signal    init_piece_last   : boolean;
    signal    init_piece_none   : boolean;
    -------------------------------------------------------------------------------
    -- 分割された１ピースのサイズを生成するための信号
    -------------------------------------------------------------------------------
    signal    curr_piece_size   : unsigned(MAX_PIECE downto 0);
    signal    next_piece_size   : unsigned(MAX_PIECE downto 0);
    signal    last_piece_size   : unsigned(MAX_PIECE downto 0);
    signal    max_piece_size    : unsigned(MAX_PIECE downto 0);
    signal    max_piece_size_q  : unsigned(MAX_PIECE downto 0);
    -------------------------------------------------------------------------------
    -- SEL信号から１ピースのサイズを整数値に変換した信号
    -------------------------------------------------------------------------------
    signal    sel_piece         : integer range MIN_PIECE to MAX_PIECE;
begin
    -------------------------------------------------------------------------------
    -- LOAD = '1' の時に ADDR または SIZE に不定があった場合は警告を出力するための
    -- プロセス。
    -------------------------------------------------------------------------------
    process (CLK) 
        variable  u_addr :  unsigned(ADDR_BITS-1 downto 0);
        variable  u_size :  unsigned(SIZE_BITS-1 downto 0);
    begin
        if (CLK'event and CLK = '1') then
            if (LOAD = '1') then
                u_addr := 0 + unsigned(ADDR);
                u_size := 0 + unsigned(SIZE);
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- sel_piece : SEL信号から１ピースのバイト数を整数値に変換したした信号.
    --             もしSEL信号のうち複数のビットに'1'が設定されていた場合は、
    --             もっとも最小値に近い値(MIN_PIECEの値)が選ばれる.
    -------------------------------------------------------------------------------
    process (SEL) 
        variable n : integer range MIN_PIECE to MAX_PIECE;
    begin
        n := MIN_PIECE;            
        if (MIN_PIECE < MAX_PIECE) then
            for i in MIN_PIECE to MAX_PIECE loop
                if (SEL(i) = '1') then
                    n := i;
                    exit;
                end if;
            end loop;
        end if;
        sel_piece <= n;
    end process;
    -------------------------------------------------------------------------------
    -- block_size     : 入力サイズ信号(SIZE)を、後々使い易いように unsigned 形式に
    --                  変換して、ビット長を MAX_SIZE で指定されている長さまで
    --                  ０拡張しておく.
    -- block_size_dec : block_size から、さらに1を引いておく.
    -------------------------------------------------------------------------------
    process (SIZE) 
        variable u_size : unsigned(block_size'range);
    begin
        u_size := RESIZE(TO_01(unsigned(SIZE),'0'),u_size'length);
        block_size     <= u_size;
        block_size_dec <= u_size - 1;
    end process;
    -------------------------------------------------------------------------------
    -- block_addr_top : 入力アドレス信号(ADDR)のうち、１ピース分のアドレスだけ抽出
    --                  して unsigned 形式に変換して、ビット長を MAX_SIZE で指定さ
    --                  れている長さまで０拡張しておく.
    -------------------------------------------------------------------------------
    process (ADDR, sel_piece)
        variable u_addr : unsigned(block_addr_top'range);
    begin
        for i in block_addr_top'range loop
            if (i < ADDR_BITS and i < sel_piece and MIN_PIECE < MAX_PIECE) or
               (i < ADDR_BITS and i < MIN_PIECE and MIN_PIECE = MAX_PIECE) then
                u_addr(i) := ADDR(i);
            else
                u_addr(i) := '0';
            end if;
        end loop;
        block_addr_top <= TO_01(u_addr,'0');
    end process;
    -------------------------------------------------------------------------------
    -- block_addr_last : block_addr_top に block_size_dec を加算して
    --                   ブロックの最終アドレスを計算する.
    -------------------------------------------------------------------------------
    block_addr_last <= block_addr_top + ('0' & block_size_dec(block_size_dec'left-1 downto 0));
    -------------------------------------------------------------------------------
    -- init_piece_count : piece_count の初期値.
    --                    block_addr_last を sel_piece 分だけ右にシフトすることに
    --                    よって計算される.
    -- init_piece_last  : init_piece_count = 0 であることを示すフラグ.
    -- init_piece_none  : block_size       = 0 であることを示すフラグ.
    -------------------------------------------------------------------------------
    process (block_addr_last, SEL)
        type     COUNT_VECTOR is array (INTEGER range <>) 
                              of unsigned(PIECE_COUNT_BITS downto 0);
        variable count_vec     : COUNT_VECTOR(MIN_PIECE to MAX_PIECE);
        variable count_val     : unsigned(PIECE_COUNT_BITS downto 0);
        variable non_0_vec     : std_logic_vector(MIN_PIECE to MAX_PIECE);
        variable non_0_val     : std_logic;
    begin
        for i in MIN_PIECE to MAX_PIECE loop
            non_0_vec(i) := '0';
            for j in 0 to PIECE_COUNT_BITS loop
                if (i+j <= block_addr_last'left) then 
                    count_vec(i)(j) := block_addr_last(i+j);
                    non_0_vec(i)    := block_addr_last(i+j) or non_0_vec(i);
                else
                    count_vec(i)(j) := '0';
                end if;
            end loop;
        end loop;
        count_val := count_vec(MIN_PIECE);
        non_0_val := non_0_vec(MIN_PIECE);
        if (MIN_PIECE < MAX_PIECE) then
            for i in MIN_PIECE to MAX_PIECE loop
                if (SEL(i) = '1') then
                    count_val := count_vec(i);
                    non_0_val := non_0_vec(i);
                    exit;
                end if;
            end loop;
        end if;
        init_piece_count <= count_val;
        init_piece_last  <= (non_0_val = '0');
    end process;
    init_piece_none <= (block_size_dec(block_size_dec'left) = '1');
    -------------------------------------------------------------------------------
    -- next_piece_count : 次のクロックでのピースカウンタの値
    -- next_piece_none  : 次のクロックでのカウンタ終了信号
    -- next_piece_last  : 次のクロックでのカウンタ最終信号
    -------------------------------------------------------------------------------
    PCOUNT_NEXT: process (init_piece_count, init_piece_none, init_piece_last, LOAD,  
                          curr_piece_count, curr_piece_none, curr_piece_last, CHOP)
        variable piece_count_dec : unsigned(curr_piece_count'left+1 downto curr_piece_count'right);
    begin
        if    (LOAD = '1') then
            if    (init_piece_none) then
                next_piece_count <= (others => '1');
                next_piece_none  <= TRUE;
                next_piece_last  <= FALSE;
            elsif (BURST = 1) then
                next_piece_count <= init_piece_count;
                next_piece_none  <= FALSE;
                next_piece_last  <= init_piece_last;
            else
                next_piece_count <= (others => '0');
                next_piece_none  <= FALSE;
                next_piece_last  <= TRUE;
            end if;
        elsif (CHOP = '1' and curr_piece_none = FALSE) then
            if (BURST = 1) then
                piece_count_dec  := RESIZE(curr_piece_count, piece_count_dec'length) - 1;
                next_piece_count <= piece_count_dec(next_piece_count'range);
                next_piece_none  <= (piece_count_dec(piece_count_dec'left) = '1');
                next_piece_last  <= (piece_count_dec = 0);
            else
                next_piece_count <= (others => '1');
                next_piece_none  <= TRUE;
                next_piece_last  <= FALSE;
            end if;
        else
                next_piece_count <= curr_piece_count;
                next_piece_none  <= curr_piece_none;
                next_piece_last  <= curr_piece_last;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- curr_piece_count : ピースカウンタ
    -- curr_piece_none  : ピースカウンタ終了信号(curr_piece_count = 0)
    -- curr_piece_last  : ピースカウンタ最終信号(curr_piece_count = 1)
    -------------------------------------------------------------------------------
    PCOUNT_REGS: process (CLK, RST) begin
        if (RST = '1') then
                curr_piece_count <= (others => '1');
                curr_piece_none  <= TRUE;
                curr_piece_last  <= FALSE;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_piece_count <= (others => '1');
                curr_piece_none  <= TRUE;
                curr_piece_last  <= FALSE;
            else
                curr_piece_count <= next_piece_count;
                curr_piece_none  <= next_piece_none;
                curr_piece_last  <= next_piece_last;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- max_piece_size   : ピース毎に転送するバイト数の最大値
    --                    MIN_PIECE=MAX_PIECEの場合は、2**MIN_PIECE の固定値とな
    --                    り、回路規模は少ない。
    --                    MIN_PIECE<MAX_PIECEの場合は、SEL信号により指定された１
    --                    ピース毎のバイト数となる。
    -------------------------------------------------------------------------------
    process (SEL, LOAD, max_piece_size_q) 
        variable max : unsigned(max_piece_size'range);
    begin
        if (MIN_PIECE < MAX_PIECE) then
            if (LOAD = '1') then
                max := TO_UNSIGNED(2**MIN_PIECE, max_piece_size'length);
                for i in MIN_PIECE to MAX_PIECE loop
                    if (SEL(i) = '1') then
                        max := TO_UNSIGNED(2**i, max_piece_size'length);
                        exit;
                    end if;
                end loop;
                max_piece_size <= max;
            else
                max_piece_size <= TO_01(max_piece_size_q,'0');
            end if;
        else
                max_piece_size <= TO_UNSIGNED(2**MIN_PIECE, max_piece_size'length);
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- max_piece_size_q : ピース毎に転送するバイト数の最大値を LOAD 信号ネゲート
    --                    後も保持しておく信号
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                max_piece_size_q <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                max_piece_size_q <= (others => '0');
            else
                max_piece_size_q <= max_piece_size;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- next_piece_size : 次のクロックでのピース毎に転送するサイズ
    -------------------------------------------------------------------------------
    PSIZE_NEXT: process (curr_piece_size, max_piece_size , last_piece_size,
                         init_piece_none, init_piece_last, block_addr_top , LOAD,
                         next_piece_none, next_piece_last, block_size     , CHOP) begin
        if    (LOAD = '1') then
            if    (init_piece_none) then
                next_piece_size <= (others => '0');
            elsif (init_piece_last) then
                next_piece_size <= block_size(next_piece_size'range);
            else
                next_piece_size <= max_piece_size - block_addr_top(next_piece_size'range);
            end if;
        elsif (CHOP = '1') then
            if    (next_piece_none or BURST = 0) then
                next_piece_size <= (others => '0');
            elsif (next_piece_last) then
                next_piece_size <= last_piece_size;
            else
                next_piece_size <= max_piece_size;
            end if;
        else
                next_piece_size <= curr_piece_size;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- curr_piece_size : ピース毎に転送するサイズ
    -------------------------------------------------------------------------------
    PSIZE_REGS: process (CLK, RST) begin
        if (RST = '1') then
                curr_piece_size <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_piece_size <= (others => '0');
            else
                curr_piece_size <= next_piece_size;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- last_piece_size : 最終ピースでのバイト数
    -------------------------------------------------------------------------------
    PSIZE_LAST: process (CLK, RST) 
        variable lo_block_addr_last : unsigned(MAX_PIECE downto 0);
    begin
        if (RST = '1') then
            last_piece_size <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                last_piece_size <= (others => '0');
            elsif (LOAD = '1') then
                for i in 0 to MAX_PIECE loop
                    if (i < sel_piece and MIN_PIECE < MAX_PIECE) or
                       (i < MIN_PIECE and MIN_PIECE = MAX_PIECE) then
                        lo_block_addr_last(i) := block_addr_last(i);
                    else
                        lo_block_addr_last(i) := '0';
                    end if;
                end loop;
                last_piece_size <= lo_block_addr_last + 1;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- ピース有効信号の生成
    -------------------------------------------------------------------------------
    VALID_GEN_T: if (GEN_VALID /= 0) generate
        signal    curr_piece_valid   : std_logic_vector(VALID'range);
        signal    next_piece_valid   : std_logic_vector(VALID'range);
        signal    piece_valid_1st    : std_logic_vector(VALID'range);
        signal    piece_valid_last   : std_logic_vector(VALID'range);
        signal    piece_valid_last_q : std_logic_vector(VALID'range);
        signal    piece_valid_mask   : std_logic_vector(VALID'range);
    begin
        ---------------------------------------------------------------------------
        -- next_piece_valid : 次のクロックでのピース有効信号
        ---------------------------------------------------------------------------
        VALID_NEXT: process (curr_piece_valid,
                             piece_valid_1st, piece_valid_last, piece_valid_mask,
                             init_piece_none, init_piece_last, LOAD,
                             next_piece_none, next_piece_last, CHOP) begin
            if    (LOAD = '1') then
                if    (init_piece_none) then
                    next_piece_valid <= (others => '0');
                elsif (init_piece_last) then
                    next_piece_valid <= piece_valid_1st and piece_valid_last;
                else
                    next_piece_valid <= piece_valid_1st and piece_valid_mask;
                end if;
            elsif (CHOP = '1') then
                if    (next_piece_none or BURST = 0) then
                    next_piece_valid <= (others => '0');
                elsif (next_piece_last) then
                    next_piece_valid <= piece_valid_last;
                else
                    next_piece_valid <= piece_valid_mask;
                end if;
            else
                    next_piece_valid <= curr_piece_valid;
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- curr_piece_valid : ピース有効信号
        ---------------------------------------------------------------------------
        VALID_REGS: process (CLK, RST) begin
            if (RST = '1') then
                    curr_piece_valid <= (others => '0');
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    curr_piece_valid <= (others => '0');
                else
                    curr_piece_valid <= next_piece_valid;
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- piece_valid_mask : 指定された１ピース毎のバイト数分だけピース有効信号を
        --                    マスクするための信号
        ---------------------------------------------------------------------------
        VALID_MSK_COMB: process (max_piece_size)
            variable max : unsigned(MAX_PIECE downto 0);
        begin
            if (MAX_PIECE > MIN_PIECE) then
                max := TO_01(max_piece_size, '0');
                for i in piece_valid_mask'range loop
                    if (i < max) then
                        piece_valid_mask(i) <= '1';
                    else
                        piece_valid_mask(i) <= '0';
                    end if;
                end loop;
            else
                piece_valid_mask <= (others => '1');
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- piece_valid_1st  : 開始ピースでのピース有効信号
        ---------------------------------------------------------------------------
        VALID_1ST_COMB: process (block_addr_top, sel_piece) 
            variable lo_block_addr_top : unsigned(MAX_PIECE downto 0);
        begin
            for i in 0 to MAX_PIECE loop
                if (i < sel_piece and MIN_PIECE < MAX_PIECE) or
                   (i < MIN_PIECE and MIN_PIECE = MAX_PIECE) then
                    lo_block_addr_top(i) := block_addr_top(i);
                else
                    lo_block_addr_top(i) := '0';
                end if;
            end loop;
            lo_block_addr_top := TO_01(lo_block_addr_top,'0');
            for i in piece_valid_1st'range loop
                if (i >= lo_block_addr_top) then
                    piece_valid_1st(i) <= '1';
                else
                    piece_valid_1st(i) <= '0';
                end if;
            end loop;
        end process;
        ---------------------------------------------------------------------------
        -- piece_valid_last : 最終ピースでのピース有効信号
        ---------------------------------------------------------------------------
        VALID_LAST_COMB: process (piece_valid_last_q, block_addr_last, sel_piece, LOAD) 
            variable lo_block_addr_last   : unsigned(MAX_PIECE downto 0);
        begin
            if (LOAD = '1') then
                for i in 0 to MAX_PIECE loop
                    if (i < sel_piece and MIN_PIECE < MAX_PIECE) or
                       (i < MIN_PIECE and MIN_PIECE = MAX_PIECE) then
                        lo_block_addr_last(i) := block_addr_last(i);
                    else
                        lo_block_addr_last(i) := '0';
                    end if;
                end loop;
                lo_block_addr_last := TO_01(lo_block_addr_last,'0');
                for i in piece_valid_last'range loop
                    if (i <= lo_block_addr_last) then
                        piece_valid_last(i) <= '1';
                    else
                        piece_valid_last(i) <= '0';
                    end if;
                end loop;
            else
                piece_valid_last <= piece_valid_last_q;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --  piece_valid_last_q : 最終ピースでのピース有効の値を LOAD 信号ネゲート後
        --                       も保持しておく信号
        ---------------------------------------------------------------------------
        VALID_LAST_REGS: process (CLK, RST) begin
            if (RST = '1') then
                    piece_valid_last_q <= (others => '0');
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    piece_valid_last_q <= (others => '0');
                else
                    piece_valid_last_q <= piece_valid_last;
                end if;
            end if;
        end process;
        VALID      <= curr_piece_valid;
        NEXT_VALID <= next_piece_valid;
    end generate;
    VALID_GEN_F: if (GEN_VALID = 0) generate
        VALID      <= (others => '1');
        NEXT_VALID <= (others => '1');
    end generate;
    -------------------------------------------------------------------------------
    -- 各種出力信号の生成
    -------------------------------------------------------------------------------
    process (curr_piece_count, curr_piece_none) begin
        for i in COUNT'range loop
            if (i > curr_piece_count'high) then
                if (curr_piece_none) then
                    COUNT(i) <= '1';
                else
                    COUNT(i) <= '0';
                end if;
            else
                COUNT(i) <= curr_piece_count(i);
            end if;
        end loop;
    end process;
    NONE       <= '1' when (curr_piece_none) else '0';
    LAST       <= '1' when (curr_piece_last) else '0';
    NEXT_NONE  <= '1' when (next_piece_none) else '0';
    NEXT_LAST  <= '1' when (next_piece_last) else '0';
    PSIZE      <= std_logic_vector(RESIZE(curr_piece_size, PSIZE'length));
    NEXT_PSIZE <= std_logic_vector(RESIZE(next_piece_size, PSIZE'length));
end RTL;
-----------------------------------------------------------------------------------
--!     @file    pool_outlet_port.vhd
--!     @brief   POOL OUTLET PORT
--!     @version 1.5.8
--!     @date    2015/9/20
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2015 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   POOL OUTLET PORT
-----------------------------------------------------------------------------------
entity  POOL_OUTLET_PORT is
    generic (
        UNIT_BITS       : --! @brief UNIT BITS :
                          --! イネーブル信号(PORT_DVAL,POOL_DVAL)、
                          --! ポインタ(POOL_PTR)のサイズカウンタ(PUSH_SIZE)の
                          --! 基本単位をビット数で指定する.
                          --! 普通はUNIT_BITS=8(８ビット単位)にしておく.
                          integer := 8;
        WORD_BITS       : --! @brief WORD BITS :
                          --! １ワードのデータのビット数を指定する.
                          integer := 8;
        PORT_DATA_BITS  : --! @brief OUTLET PORT DATA BITS :
                          --! PORT_DATA のビット数を指定する.
                          integer := 32;
        POOL_DATA_BITS  : --! @brief POOL BUFFER DATA BITS :
                          --! POOL_DATA のビット数を指定する.
                          integer := 32;
        PORT_PTR_BITS   : --! @brief PORT POINTER BITS:
                          --! START_PORT_PTR のビット数を指定する.
                          integer := 16;
        POOL_PTR_BITS   : --! @brief POOL BUFFER POINTER BITS:
                          --! START_POOL_PTR、POOL_PTR のビット数を指定する.
                          integer := 16;
        SEL_BITS        : --! @brief SELECT BITS :
                          --! XFER_SEL、PUSH_VAL、POOL_WEN のビット数を指定する.
                          integer := 1;
        SIZE_BITS       : --! @brief PORT_SIZE BITS :
                          --! PORT_SIZE のビット数を指定する.
                          integer := 16;
        POOL_SIZE_VALID : --! @brief POOL_SIZE VALID :
                          --! POOL_SIZE が有効が有効かどうかを指定する.
                          --! * POOL_SIZE_VALID=0の場合、POOL_SIZE 信号は無効。
                          --!   この場合、入力ユニット数は POOL_DVAL 信号から生成さ
                          --!   れる.
                          integer := 1;
        QUEUE_SIZE      : --! @brief QUEUE SIZE :
                          --! キューの大きさをワード数で指定する.
                          --! * QUEUE_SIZE<0 かつ PORT_DATA_BITS=WORD_BITS かつ
                          --!   POOL_DATA_BITS=WORD_BITS の場合、キューは生成しない.
                          --! * QUEUE_SIZE=0を指定した場合は、キューの深さは自動的に
                          --!   (PORT_DATA_BITS/WORD_BITS)+(POOL_DATA_BITS/WORD_BITS)
                          --!   に設定される.
                          integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        START           : --! @brief START :
                          --! 開始信号.
                          --! * この信号はSTART_PTR/XFER_LAST/XFER_SELを内部に設定
                          --!   してこのモジュールを初期化しする.
                          --! * 最初にデータ入力と同時にアサートしても構わない.
                          in  std_logic;
        START_POOL_PTR  : --! @brief START POOL BUFFER POINTER :
                          --! 書き込み開始ポインタ.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(POOL_PTR_BITS-1 downto 0);
        START_PORT_PTR  : --! @brief START PORT POINTER :
                          --! 書き込み開始ポインタ.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(PORT_PTR_BITS-1 downto 0);
        XFER_LAST       : --! @brief TRANSFER LAST :
                          --! 最後のトランザクションであることを示すフラグ.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic;
        XFER_SEL        : --! @brief TRANSFER SELECT :
                          --! 選択信号. PUSH_VAL、POOL_WENの生成に使う.
                          --! START 信号により内部に取り込まれる.
                          in  std_logic_vector(SEL_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Outlet Port Signals.
    -------------------------------------------------------------------------------
        PORT_DATA       : --! @brief OUTLET PORT DATA :
                          --! ワードデータ出力.
                          out std_logic_vector(PORT_DATA_BITS-1 downto 0);
        PORT_DVAL       : --! @brief OUTLET PORT DATA VALID :
                          --! ポートからデータを出力する際のユニット単位での有効信号.
                          out std_logic_vector(PORT_DATA_BITS/UNIT_BITS-1 downto 0);
        PORT_LAST       : --! @brief OUTLET DATA LAST :
                          --! 最終ワード信号出力.
                          --! * 最後のワードデータ出力であることを示すフラグ.
                          out std_logic;
        PORT_ERROR      : --! @brief OUTLET ERROR :
                          --! エラー出力
                          --! * エラーが発生したことをし示すフラグ.
                          out std_logic;
        PORT_SIZE       : --! @brief OUTLET DATA SIZE :
                          --! 出力バイト数
                          --! * ポートからのデータの出力ユニット数.
                          out std_logic_vector(SIZE_BITS-1 downto 0);
        PORT_VAL        : --! @brief OUTLET PORT VALID :
                          --! 出力ワード有効信号.
                          --! * PORT_DATA/PORT_DVAL/PORT_LAST/PORT_SIZEが有効である
                          --!   ことを示す.
                          out std_logic;
        PORT_RDY        : --! @brief OUTLET PORT READY :
                          --! 出力レディ信号.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Pull Size Signals.
    -------------------------------------------------------------------------------
        PULL_VAL        : --! @brief PULL VALID: 
                          --! PULL_LAST/PULL_ERR/PULL_SIZEが有効であることを示す.
                          out std_logic_vector(SEL_BITS-1 downto 0);
        PULL_LAST       : --! @brief PULL LAST : 
                          --! 最後の入力"した事"を示すフラグ.
                          out std_logic;
        PULL_XFER_LAST  : --! @brief PULL TRANSFER LAST :
                          --! 最後のトランザクションであることを示すフラグ.
                          out std_logic;
        PULL_XFER_DONE  : --! @brief PULL TRANSFER DONE :
                          --! 最後のトランザクションの最後の転送"した"ワードである
                          --! ことを示すフラグ.
                          out std_logic;
        PULL_ERROR      : --! @brief PULL ERROR : 
                          --! エラーが発生したことをし示すフラグ.
                          out std_logic;
        PULL_SIZE       : --! @brief PUSH SIZE :
                          --! 入力"した"バイト数を出力する.
                          out std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Pool Buffer Interface Signals.
    -------------------------------------------------------------------------------
        POOL_REN        : --! @brief POOL BUFFER READ ENABLE :
                          --! バッファからデータをリードすることを示す.
                          out std_logic_vector(SEL_BITS-1 downto 0);
        POOL_PTR        : --! @brief POOL BUFFER WRITE POINTER :
                          --! リード時にデータをリードするバッファの位置を出力する.
                          out std_logic_vector(POOL_PTR_BITS-1 downto 0);
        POOL_DATA       : --! @brief POOL BUFFER WRITE DATA :
                          --! バッファからリードされたデータを入力する.
                          in  std_logic_vector(POOL_DATA_BITS-1 downto 0);
        POOL_DVAL       : --! @brief POOL BUFFER DATA VALID :
                          --! バッファからデータをリードする際のユニット単位での
                          --! 有効信号.
                          in  std_logic_vector(POOL_DATA_BITS/UNIT_BITS-1 downto 0);
        POOL_SIZE       : --! @brief POOL BUFFER DATA SIZE :
                          --! 入力バイト数
                          --! * バッファからのデータの入力ユニット数.
                          in  std_logic_vector(SIZE_BITS-1 downto 0);
        POOL_ERROR      : --! @brief POOL BUFFER ERROR :
                          --! データ転送中にエラーが発生したことを示すフラグ.
                          in  std_logic;
        POOL_LAST       : --! @brief POOL BUFFER DATA LAST :
                          --! 最後の入力データであることを示す.
                          in  std_logic;
        POOL_VAL        : --! @brief POOL BUFFER DATA VALID :
                          --! バッファからリードしたデータが有効である事を示す信号.
                          in  std_logic;
        POOL_RDY        : --! @brief POOL BUFFER WRITE READY :
                          --! バッファからデータを読み込み可能な事をを示す.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- Status Signals.
    -------------------------------------------------------------------------------
        POOL_BUSY       : --! @brief POOL BUFFER BUSY :
                          --! バッファからデータリード中であることを示す信号.
                          --! * START信号がアサートされたときにアサートされる.
                          --! * 最後のデータが入力されたネゲートされる.
                          out std_logic;
        POOL_DONE       : --! @brief POOL BUFFER DONE :
                          --! 次のクロックで POOL_BUSY がネゲートされることを示す.
                          out std_logic;
        BUSY            : --! @brief QUEUE BUSY :
                          --! キューが動作中であることを示す信号.
                          --! * START信号がアサートされたときにアサートされる.
                          --! * 最後のデータが出力し終えたらネゲートされる.
                          out std_logic
    );
end POOL_OUTLET_PORT;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.COMPONENTS.REDUCER;
architecture RTL of POOL_OUTLET_PORT is
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    function count_assert_bit(ARG:std_logic_vector) return integer is
        variable n  : integer range 0 to ARG'length;
        variable nL : integer range 0 to ARG'length/2;
        variable nH : integer range 0 to ARG'length-ARG'length/2;
        alias    a  : std_logic_vector(ARG'length-1 downto 0) is ARG;
    begin
        case a'length is
            when 0 =>                   n := 0;
            when 1 =>
                if    (a =    "1") then n := 1;
                else                    n := 0;
                end if;
            when 2 =>
                if    (a =   "11") then n := 2;
                elsif (a =   "10") then n := 1;
                elsif (a =   "01") then n := 1;
                else                    n := 0;
                end if;
            when 4 =>
                if    (a = "1111") then n := 4;
                elsif (a = "1110") then n := 3;
                elsif (a = "1101") then n := 3;
                elsif (a = "1100") then n := 2;
                elsif (a = "1011") then n := 3;
                elsif (a = "1010") then n := 2;
                elsif (a = "1001") then n := 2;
                elsif (a = "1000") then n := 1;
                elsif (a = "0111") then n := 3;
                elsif (a = "0110") then n := 2;
                elsif (a = "0101") then n := 2;
                elsif (a = "0100") then n := 1;
                elsif (a = "0011") then n := 2;
                elsif (a = "0010") then n := 1;
                elsif (a = "0001") then n := 1;
                else                    n := 0;
                end if;
            when others =>
                nL := count_assert_bit(a(a'length/2-1 downto a'low     ));
                nH := count_assert_bit(a(a'high       downto a'length/2));
                n  := nL + nH;
        end case;
        return n;
    end function;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    signal    regs_busy     : std_logic;
    signal    intake_running: boolean;
    signal    intake_enable : std_logic;
    signal    intake_valid  : std_logic;
    signal    intake_ready  : std_logic;
    signal    intake_last   : std_logic;
    signal    intake_select : std_logic_vector( SEL_BITS-1 downto 0);
    signal    intake_strobe : std_logic_vector(POOL_DATA_BITS/UNIT_BITS-1 downto 0);
    signal    intake_size   : std_logic_vector(SIZE_BITS-1 downto 0);
    constant  outlet_enable : std_logic := '1';
    signal    outlet_valid  : std_logic;
    signal    outlet_ready  : std_logic;
    signal    outlet_last   : std_logic;
    signal    outlet_error  : std_logic;
    signal    outlet_size   : std_logic_vector(SIZE_BITS-1 downto 0);
    signal    outlet_strobe : std_logic_vector(PORT_DATA_BITS/UNIT_BITS-1 downto 0);
    constant  SEL_ALL0      : std_logic_vector(SEL_BITS -1 downto 0) := (others => '0');
    constant  SEL_ALL1      : std_logic_vector(SEL_BITS -1 downto 0) := (others => '1');
begin
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    INTAKE_CTRL: block
        signal   next_read_ptr    : std_logic_vector(POOL_PTR_BITS-1 downto 0);
        signal   curr_read_ptr    : std_logic_vector(POOL_PTR_BITS-1 downto 0);
        signal   curr_select      : std_logic_vector(SEL_BITS -1 downto 0);
        signal   curr_xfer_last   : boolean;
        signal   intake_done      : boolean;
        signal   intake_continue  : boolean;
        signal   intake_chop      : std_logic;
        signal   strb_size        : std_logic_vector(SIZE_BITS-1 downto 0);
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        strb_size       <= std_logic_vector(to_unsigned(count_assert_bit(intake_strobe), SIZE_BITS));
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        intake_valid    <= POOL_VAL;
        intake_strobe   <= POOL_DVAL when (POOL_ERROR = '0') else (others => '0');
        intake_size     <= strb_size when (POOL_SIZE_VALID = 0) else
                           POOL_SIZE when (POOL_ERROR = '0') else
                           (others => '0');
        intake_last     <= '1' when (POOL_LAST = '1' or  POOL_ERROR   = '1') else '0';
        intake_enable   <= '1' when (START     = '1' or  intake_continue   ) else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        intake_chop     <= '1' when (intake_valid = '1' and intake_ready = '1') else '0';
        intake_done     <= (intake_running = TRUE  and intake_chop = '1' and intake_last = '1');
        intake_continue <= (intake_running = TRUE  and not intake_done);
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (curr_read_ptr, intake_size)
            variable u_intake_size   : unsigned(  intake_size'range);
            variable u_add_ptr       : unsigned(next_read_ptr'range);
            variable u_curr_read_ptr : unsigned(next_read_ptr'range);
        begin
            u_curr_read_ptr := to_01(unsigned(curr_read_ptr));
            u_intake_size   := to_01(unsigned(intake_size  ));
            u_add_ptr       := resize(u_intake_size, u_add_ptr'length);
            next_read_ptr   <= std_logic_vector(u_curr_read_ptr + u_add_ptr);
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process(CLK, RST) begin
            if (RST = '1') then
                    intake_running <= FALSE;
                    curr_xfer_last <= FALSE;
                    curr_select    <= (others => '0');
                    curr_read_ptr  <= (others => '0');
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then 
                    intake_running <= FALSE;
                    curr_xfer_last <= FALSE;
                    curr_select    <= (others => '0');
                    curr_read_ptr  <= (others => '0');
                elsif (START = '1') then
                    intake_running <= TRUE;
                    curr_xfer_last <= (XFER_LAST = '1');
                    curr_select    <= XFER_SEL;
                    curr_read_ptr  <= START_POOL_PTR;
                else
                    intake_running <= intake_continue;
                    if (intake_chop = '1' ) then
                        curr_read_ptr <= next_read_ptr;
                    end if;
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        intake_select <= curr_select when (SEL_BITS > 1) else SEL_ALL1;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        POOL_BUSY <= '1' when (intake_running = TRUE) else '0';
        POOL_DONE <= '1' when (intake_done    = TRUE) else '0';
        POOL_PTR  <= START_POOL_PTR when (START       = '1') else
                     next_read_ptr  when (intake_chop = '1') else
                     curr_read_ptr;
        POOL_REN  <= XFER_SEL       when (START = '1' and SEL_BITS > 1) else
                     SEL_ALL1       when (START = '1' and SEL_BITS = 1) else
                     intake_select  when (intake_continue             ) else
                     SEL_ALL0;
        BUSY      <= '1' when (intake_running = TRUE or regs_busy = '1') else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        PULL_VAL       <= intake_select when (intake_chop = '1') else SEL_ALL0;
        PULL_LAST      <= '1' when (POOL_LAST = '1') else '0';
        PULL_XFER_LAST <= '1' when (curr_xfer_last ) else '0';
        PULL_XFER_DONE <= '1' when (POOL_LAST = '1') and
                                   (curr_xfer_last ) else '0';
        PULL_ERROR     <= POOL_ERROR;
        PULL_SIZE      <= intake_size;
    end block;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    ADJ_ALIGN: if (QUEUE_SIZE >= 0) or
                  (POOL_DATA_BITS /= WORD_BITS) or
                  (PORT_DATA_BITS /= WORD_BITS) generate
        function  Q_SIZE return integer is begin
            if (QUEUE_SIZE >= 0) then
                return QUEUE_SIZE;
            else
                return 0;
            end if;
        end function;
        constant  STRB_BITS     : integer   := WORD_BITS/UNIT_BITS;
        constant  I_WORDS       : integer   := POOL_DATA_BITS/WORD_BITS;
        constant  O_WORDS       : integer   := PORT_DATA_BITS/WORD_BITS;
        constant  flush         : std_logic := '0';
        constant  done          : std_logic := '0';
        constant  o_shift       : std_logic_vector(O_WORDS   downto O_WORDS) := "0";
        signal    offset        : std_logic_vector(O_WORDS-1 downto 0);
        signal    error_flag    : boolean;
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (START_PORT_PTR)
            function CALC_WIDTH(BITS:integer) return integer is
                variable value : integer;
            begin
                value := 0;
                while (2**value < (BITS/UNIT_BITS)) loop
                    value := value + 1;
                end loop;
                return value;
            end function;
            constant O_DATA_WIDTH : integer := CALC_WIDTH(O_WORDS*WORD_BITS);
            constant WORD_WIDTH   : integer := CALC_WIDTH(WORD_BITS);
            variable u_offset     : unsigned(O_DATA_WIDTH-WORD_WIDTH downto 0);
        begin
            for i in u_offset'range loop
                if (i+WORD_WIDTH <  O_DATA_WIDTH       ) and
                   (i+WORD_WIDTH <= START_PORT_PTR'high) and
                   (i+WORD_WIDTH >= START_PORT_PTR'low ) then
                    if (START_PORT_PTR(i+WORD_WIDTH) = '1') then
                        u_offset(i) := '1';
                    else
                        u_offset(i) := '0';
                    end if;
                else
                        u_offset(i) := '0';
                end if;
            end loop;
            for i in offset'range loop
                if (i < u_offset) then
                    offset(i) <= '1';
                else
                    offset(i) <= '0';
                end if;
            end loop;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process(CLK, RST) begin
            if (RST = '1') then
                    error_flag <= FALSE;
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then 
                    error_flag <= FALSE;
                elsif (intake_valid = '1' and intake_ready = '1' and POOL_ERROR  = '1') then
                    error_flag <= TRUE;
                elsif (outlet_valid = '1' and outlet_ready = '1' and outlet_last = '1') then
                    error_flag <= FALSE;
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        QUEUE: REDUCER                              -- 
            generic map (                           -- 
                WORD_BITS       => WORD_BITS      , -- 
                STRB_BITS       => STRB_BITS      , -- 
                I_WIDTH         => I_WORDS        , -- 
                O_WIDTH         => O_WORDS        , -- 
                QUEUE_SIZE      => Q_SIZE         , -- 
                VALID_MIN       => 0              , -- 
                VALID_MAX       => 0              , -- 
                O_VAL_SIZE      => O_WORDS        , -- 
                O_SHIFT_MIN     => o_shift'low    , --
                O_SHIFT_MAX     => o_shift'high   , --
                I_JUSTIFIED     => 0              , -- 
                FLUSH_ENABLE    => 0                -- 
            )                                       -- 
            port map (                              -- 
            -----------------------------------------------------------------------
            -- クロック&リセット信号
            -----------------------------------------------------------------------
                CLK             => CLK            , -- In  :
                RST             => RST            , -- In  :
                CLR             => CLR            , -- In  :
            -----------------------------------------------------------------------
            -- 各種制御信号
            -----------------------------------------------------------------------
                START           => START          , -- In  :
                OFFSET          => offset         , -- In  :
                DONE            => done           , -- In  :
                FLUSH           => flush          , -- In  :
                BUSY            => regs_busy      , -- Out :
                VALID           => open           , -- Out :
            -----------------------------------------------------------------------
            -- 入力側 I/F
            -----------------------------------------------------------------------
                I_ENABLE        => intake_enable  , -- In  :
                I_STRB          => intake_strobe  , -- In  :
                I_DATA          => POOL_DATA      , -- In  :
                I_DONE          => intake_last    , -- In  :
                I_FLUSH         => flush          , -- In  :
                I_VAL           => intake_valid   , -- In  :
                I_RDY           => intake_ready   , -- Out :
            -----------------------------------------------------------------------
            -- 出力側 I/F
            -----------------------------------------------------------------------
                O_ENABLE        => outlet_enable  , -- In  :
                O_DATA          => PORT_DATA      , -- Out :
                O_STRB          => outlet_strobe  , -- Out :
                O_DONE          => outlet_last    , -- Out :
                O_FLUSH         => open           , -- Out :
                O_VAL           => outlet_valid   , -- Out :
                O_RDY           => outlet_ready   , -- In  :
                O_SHIFT         => o_shift          -- In  :
        );
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        outlet_error <= '1' when (error_flag and outlet_last = '1') else '0';
        outlet_size  <= std_logic_vector(to_unsigned(count_assert_bit(outlet_strobe), outlet_size'length));
    end generate;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    NON_ALIGN: if (QUEUE_SIZE < 0) and 
                  (POOL_DATA_BITS = WORD_BITS) and
                  (PORT_DATA_BITS = WORD_BITS) generate
    begin
        PORT_DATA    <= POOL_DATA;
        outlet_error <= POOL_ERROR;
        outlet_strobe<= intake_strobe;
        outlet_last  <= intake_last;
        outlet_valid <= intake_valid;
        outlet_size  <= intake_size;
        intake_ready <= '1' when (intake_running and outlet_ready = '1') else '0';
        regs_busy    <= '0';
    end generate;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    POOL_RDY     <= intake_ready;
    PORT_SIZE    <= outlet_size;
    PORT_DVAL    <= outlet_strobe;
    PORT_LAST    <= outlet_last;
    PORT_ERROR   <= outlet_error;
    PORT_VAL     <= outlet_valid;
    outlet_ready <= PORT_RDY;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    axi4_data_outlet_port.vhd
--!     @brief   AXI4 DATA OUTLET PORT
--!     @version 1.5.5
--!     @date    2014/3/8
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2014 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
-----------------------------------------------------------------------------------
--! @brief   AXI4 DATA OUTLET PORT
-----------------------------------------------------------------------------------
entity  AXI4_DATA_OUTLET_PORT is
    generic (
        PORT_DATA_BITS  : --! @brief INTAKE PORT DATA BITS :
                          --! PORT_DATA のビット数を指定する.
                          --! * PORT_DATA_BITSで指定できる値は 8,16,32,64,128,256,
                          --!   512,1024
                          integer := 32;
        POOL_DATA_BITS  : --! @brief POOL BUFFER DATA BITS :
                          --! POOL_DATA のビット数を指定する.
                          integer := 32;
        TRAN_ADDR_BITS  : --! @brief TRANSACTION ADDRESS BITS :
                          --! TRAN_ADDR のビット数を指定する.
                          integer := 32;
        TRAN_SIZE_BITS  : --! @brief TRANSACTION SIZE BITS :
                          --! TRAN_SIZE のビット数を指定する.
                          integer := 32;
        TRAN_SEL_BITS   : --! @brief TRANSACTION SELECT BITS :
                          --! TRAN_SEL、PULL_VAL、POOL_REN のビット数を指定する.
                          integer := 1;
        BURST_LEN_BITS  : --! @brief BURST LENGTH BITS :
                          --! BURST_LEN のビット数を指定する.
                          integer := 12;
        ALIGNMENT_BITS  : --! @brief ALIGNMENT BITS :
                          --! アライメント調整を行うビット数を指定する.
                          --! * ALIGNMENT_BITS=8を指定した場合、バイト単位でアライ
                          --!   メント調整する.
                          integer := 8;
        PULL_SIZE_BITS  : --! @brief PULL_SIZE BITS :
                          --! PULL_SIZE のビット数を指定する.
                          integer := 16;
        EXIT_SIZE_BITS  : --! @brief EXIT_SIZE BITS :
                          --! EXIT_SIZE のビット数を指定する.
                          integer := 16;
        POOL_PTR_BITS   : --! @brief POOL BUFFER POINTER BITS:
                          --! START_PTR、POOL_PTR のビット数を指定する.
                          integer := 16;
        USE_BURST_SIZE  : --! @brief USE BURST SIZE :
                          --! BURST_SIZE による Narrow transfers をサポートするか
                          --! 否かを指定する.
                          --! * USE_BURST_SIZE=0を指定した場合、Narrow transfers を
                          --!   サポートしない.
                          --! * USE_BURST_SIZE=1を指定した場合、Narrow transfers を
                          --!   サポートする. その際の１ワード毎の転送バイト数は
                          --!   BURST_SIZE で指定される.
                          integer range 0 to 1 := 1;
        CHECK_BURST_LEN : --! @brief CHECK BURST LENGTH :
                          --! BURST_LEN で指定されたバースト数とI_LASTによるバースト
                          --! 転送の最後が一致するかどうかチェックするか否かを指定す
                          --! る.
                          --! * CHECK_BURST_LEN=0かつUSE_BURST_SIZE=0を指定した場合、
                          --!   バースト長をチェックしない. 
                          --! * CHECK_BURST_LEN=1またはUSE_BURST_SIZE=0を指定した場
                          --!   合、バースト長をチェックする.
                          integer range 0 to 1 := 1;
        TRAN_MAX_SIZE   : --! @brief TRANSFER MAXIMUM SIZE :
                          --! 一回の転送サイズの最大バイト数を２のべき乗で指定する.
                          integer := 4;
        PORT_REGS_SIZE  : --! @brief PORT REGS SIZE :
                          --! 出力側に挿入するパイプラインレジスタの段数を指定する.
                          --! * PORT_REGS_SIZE=0を指定した場合、パイプラインレジスタ
                          --!   は挿入しない.
                          --! * PORT_REGS_SIZE=1を指定した場合、パイプラインレジスタ
                          --!   を１段挿入するが、この場合バースト転送時に１ワード
                          --!   転送毎に１サイクルのウェイトが発生する.
                          --! * PORT_REGS_SIZE>1を指定した場合、パイプラインレジスタ
                          --!   を指定された段数挿入する. この場合、バースト転送時
                          --!   にウェイトは発生しない.
                          integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK             : --! @brief CLOCK :
                          --! クロック信号
                          in  std_logic; 
        RST             : --! @brief ASYNCRONOUSE RESET :
                          --! 非同期リセット信号.アクティブハイ.
                          in  std_logic;
        CLR             : --! @brief SYNCRONOUSE RESET :
                          --! 同期リセット信号.アクティブハイ.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Signals.
    -------------------------------------------------------------------------------
        TRAN_START      : --! @brief TRANSACTION START :
                          --! 開始信号.
                          --! * この信号はTRAN_ADDR/TRAN_SIZE/BURST_LEN/BURST_SIZE/
                          --!   START_PTR/XFER_LAST/XFER_SELを内部に設定して
                          --!   このモジュールを初期化した後、転送を開始する.
                          in  std_logic;
        TRAN_ADDR       : --! @brief TRANSACTION ADDRESS :
                          --! 転送開始アドレス.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(TRAN_ADDR_BITS  -1 downto 0);
        TRAN_SIZE       : --! @brief START TRANSFER SIZE :
                          --! 転送バイト数.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(TRAN_SIZE_BITS  -1 downto 0);
        BURST_LEN       : --! @brief Burst length.  
                          --! AXI4 バースト長.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(BURST_LEN_BITS  -1 downto 0);
        BURST_SIZE      : --! @brief Burst size.
                          --! AXI4 バーストサイズ信号.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  AXI4_ASIZE_TYPE;
        START_PTR       : --! @brief START POOL BUFFER POINTER :
                          --! 読み込み開始ポインタ.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(POOL_PTR_BITS   -1 downto 0);
        TRAN_LAST       : --! @brief TRANSACTION LAST :
                          --! 最後のトランザクションであることを示すフラグ.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic;
        TRAN_SEL        : --! @brief TRANSACTION SELECT :
                          --! 選択信号. PUSH_VAL、POOL_WENの生成に使う.
                          --! * TRAN_START 信号により内部に取り込まれる.
                          in  std_logic_vector(TRAN_SEL_BITS   -1 downto 0);
        XFER_VAL        : --! @brief TRANSFER VALID :
                          --! 転送応答信号.
                          out std_logic;
        XFER_DVAL       : --! @brief TRANSFER DATA VALID :
                          --! バッファからデータをリードする際のユニット単位での有効
                          --! 信号.
                          out std_logic_vector(POOL_DATA_BITS/8-1 downto 0);
        XFER_LAST       : --! @brief TRANSFER NONE :
                          --! 最終転送信号.
                          --! * 最後の転送であることを出力する.
                          out std_logic;
        XFER_NONE       : --! @brief TRANSFER NONE :
                          --! 転送終了信号.
                          --! * これ以上転送が無いことを出力する.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Outlet Port Signals.
    -------------------------------------------------------------------------------
        PORT_DATA       : --! @brief OUTLET PORT DATA :
                          --! ワードデータ出力.
                          out std_logic_vector(PORT_DATA_BITS-1   downto 0);
        PORT_STRB       : --! @brief OUTLET PORT DATA VALID :
                          --! ポートへデータを出力する際のユニット単位での有効信号.
                          out std_logic_vector(PORT_DATA_BITS/8-1 downto 0);
        PORT_LAST       : --! @brief OUTLET DATA LAST :
                          --! 最終ワード信号出力.
                          --! * 最後のワードデータ出力であることを示すフラグ.
                          out std_logic;
        PORT_ERROR      : --! @brief OUTLET RESPONSE :
                          --! エラーが発生したことを示すフラグ.
                          out std_logic;
        PORT_VAL        : --! @brief OUTLET PORT VALID :
                          --! 出力ワード有効信号.
                          --! * PORT_DATA/PORT_DVAL/PORT_LASTが有効であることを示す.
                          --! * PORT_VAL='1'and PORT_RDY='1'で上記信号がキューから
                          --!   取り出される.
                          out std_logic;
        PORT_RDY        : --! @brief OUTLET PORT READY :
                          --! 出力レディ信号.
                          --! * キューが次のワードデータを入力出来ることを示す.
                          --! * PORT_VAL='1'and PORT_RDY='1'で上記信号がキューから
                          --!   取り出される.
                          in  std_logic;
    -------------------------------------------------------------------------------
    -- Pull Size/Last/Error Signals.
    -------------------------------------------------------------------------------
        PULL_VAL        : --! @brief PULL VALID: 
                          --! PULL_LAST/PULL_XFER_LAST/PULL_XFER_DONE/PULL_ERROR/
                          --! PULL_SIZEが有効であることを示す.
                          out std_logic_vector(TRAN_SEL_BITS-1 downto 0);
        PULL_LAST       : --! @brief PULL LAST : 
                          --! 最後の転送"する事"を示すフラグ.
                          out std_logic;
        PULL_XFER_LAST  : --! @brief PULL TRANSFER LAST : 
                          --! 最後のトランザクションであることを示すフラグ.
                          out std_logic;
        PULL_XFER_DONE  : --! @brief PULL TRANSFER DONE :
                          --! 最後のトランザクションの最後の転送"した"ワードである
                          --! ことを示すフラグ.
                          out std_logic;
        PULL_ERROR      : --! @brief PULL ERROR : 
                          --! エラーが発生したことを示すフラグ.
                          out std_logic;
        PULL_SIZE       : --! @brief PULL SIZE :
                          --! 転送"する"バイト数を出力する.
                          out std_logic_vector(PULL_SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Outlet Size/Last/Error Signals.
    -------------------------------------------------------------------------------
        EXIT_VAL        : --! @brief EXIT VALID: 
                          --! EXIT_LAST/EXIT_XFER_LAST/EXIT_XFER_DONE/EXIT_ERROR/
                          --! EXIT_SIZEが有効であることを示す.
                          out std_logic_vector(TRAN_SEL_BITS-1 downto 0);
        EXIT_LAST       : --! @brief EXIT LAST : 
                          --! 最後の出力"した事"を示すフラグ.
                          out std_logic;
        EXIT_XFER_LAST  : --! @brief EXIT TRANSFER LAST : 
                          --! 最後のトランザクションであることを示すフラグ.
                          out std_logic;
        EXIT_XFER_DONE  : --! @brief EXIT TRANSFER DONE :
                          --! 最後のトランザクションの最後の転送"した"ワードである
                          --! ことを示すフラグ.
                          out std_logic;
        EXIT_ERROR      : --! @brief EXIT ERROR : 
                          --! エラーが発生したことを示すフラグ.
                          out std_logic;
        EXIT_SIZE       : --! @brief EXIT SIZE :
                          --! 出力"した"バイト数を出力する.
                          out std_logic_vector(EXIT_SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- Pool Buffer Interface Signals.
    -------------------------------------------------------------------------------
        POOL_REN        : --! @brief POOL BUFFER READ ENABLE :
                          --! バッファからデータをリードすることを示す.
                          out std_logic_vector(TRAN_SEL_BITS-1 downto 0);
        POOL_PTR        : --! @brief POOL BUFFER WRITE POINTER :
                          --! ライト時にデータを書き込むバッファの位置を出力する.
                          out std_logic_vector(POOL_PTR_BITS-1 downto 0);
        POOL_ERROR      : --! @brief EXIT ERROR : 
                          --! エラーが発生したことを示すフラグ.
                          in  std_logic;
        POOL_DATA       : --! @brief POOL BUFFER READ DATA :
                          --! バッファからのリードデータ入力.
                          in  std_logic_vector(POOL_DATA_BITS  -1 downto 0);
        POOL_VAL        : --! @brief POOL BUFFER WRITE READY :
                          --! バッファにデータを書き込み可能な事をを示す.
                          in  std_logic;
        POOL_RDY        : --! @brief POOL BUFFER WRITE READY :
                          --! バッファにデータを書き込み可能な事をを示す.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- Status Signals.
    -------------------------------------------------------------------------------
        POOL_BUSY       : --! @brief POOL BUFFER BUSY :
                          --! バッファからデータリード中であることを示す信号.
                          --! * START信号がアサートされたときにアサートされる.
                          --! * 最後のデータが入力されたネゲートされる.
                          out std_logic;
        POOL_DONE       : --! @brief POOL BUFFER DONE :
                          --! 次のクロックで POOL_BUSY がネゲートされることを示す.
                          out std_logic;
        BUSY            : --! @brief QUEUE BUSY :
                          --! キューが動作中であることを示す信号.
                          --! * 最初にデータが入力されたときにアサートされる.
                          --! * 最後のデータが出力し終えたらネゲートされる.
                          out  std_logic
    );
end AXI4_DATA_OUTLET_PORT;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.COMPONENTS.CHOPPER;
use     PIPEWORK.COMPONENTS.POOL_OUTLET_PORT;
use     PIPEWORK.AXI4_COMPONENTS.AXI4_DATA_PORT;
architecture RTL of AXI4_DATA_OUTLET_PORT is
    -------------------------------------------------------------------------------
    -- データバスのバイト数の２のべき乗値を計算する関数.
    -------------------------------------------------------------------------------
    function CALC_DATA_SIZE(WIDTH:integer) return integer is
        variable value : integer;
    begin
        value := 0;
        while (2**(value+3) < WIDTH) loop
            value := value + 1;
        end loop;
        return value;
    end function;
    -------------------------------------------------------------------------------
    -- データバスのバイト数の２のべき乗値.
    -------------------------------------------------------------------------------
    constant POOL_DATA_SIZE : integer := CALC_DATA_SIZE(POOL_DATA_BITS);
    -------------------------------------------------------------------------------
    -- データバスのバイト数選択定数.
    -------------------------------------------------------------------------------
    constant POOL_DATA_SEL  : std_logic_vector(POOL_DATA_SIZE downto POOL_DATA_SIZE) := "1";
    -------------------------------------------------------------------------------
    -- 内部サイズビット数
    -------------------------------------------------------------------------------
    function CALC_SIZE_BITS return integer is begin
        if (POOL_DATA_BITS >= PORT_DATA_BITS) then
            return CALC_DATA_SIZE(POOL_DATA_BITS) + 1;
        else
            return CALC_DATA_SIZE(PORT_DATA_BITS) + 1;
        end if;
    end function;
    constant SIZE_BITS      : integer := CALC_SIZE_BITS;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type     SETTING_TYPE   is record
             Q_Q_SIZE       : integer;  -- Q:POOL_OUTLET_PORT の QUEUE_SIZE
             O_I_SIZE       : integer;  -- O:AXI4_DATA_PORT の I_REGS_SIZE
             O_O_SIZE       : integer;  -- O:AXI4_DATA_PORT の O_REGS_SIZE
    end record;
    function SET_SETTING return SETTING_TYPE is
        variable setting : SETTING_TYPE;
    begin
        setting.O_O_SIZE := PORT_REGS_SIZE;
        if (USE_BURST_SIZE /= 0) and 
           (PORT_DATA_BITS = ALIGNMENT_BITS) and
           (POOL_DATA_BITS = ALIGNMENT_BITS) then
            setting.Q_Q_SIZE := -1;
            setting.O_I_SIZE :=  2;
        else
            setting.Q_Q_SIZE :=  0;
            setting.O_I_SIZE :=  0;
        end if;
        return setting;
    end function;
    constant SET            : SETTING_TYPE := SET_SETTING;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant USER_LO        : integer := 0;
    constant USER_SEL_LO    : integer := USER_LO;
    constant USER_SEL_HI    : integer := USER_SEL_LO + TRAN_SEL_BITS-1;
    constant USER_DONE_POS  : integer := USER_SEL_HI + 1;
    constant USER_HI        : integer := USER_DONE_POS;
    constant USER_BITS      : integer := USER_HI - USER_LO + 1;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   i_busy         : std_logic;
    signal   i_chop         : std_logic;
    signal   i_valid        : std_logic;
    signal   i_ready        : std_logic;
    signal   i_last         : std_logic;
    signal   i_size         : std_logic_vector(SIZE_BITS-1 downto 0);
    signal   i_ben          : std_logic_vector(POOL_DATA_BITS/8-1 downto 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   o_pull_size    : std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   q_data         : std_logic_vector(PORT_DATA_BITS  -1 downto 0);
    signal   q_strb         : std_logic_vector(PORT_DATA_BITS/8-1 downto 0);
    signal   q_size         : std_logic_vector(SIZE_BITS-1 downto 0);
    signal   q_user         : std_logic_vector(USER_HI downto USER_LO);
    signal   q_last         : std_logic;
    signal   q_error        : std_logic;
    signal   q_valid        : std_logic;
    signal   q_ready        : std_logic;
    signal   q_busy         : std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   o_size         : std_logic_vector(SIZE_BITS-1 downto 0);
    signal   o_sel          : std_logic_vector(TRAN_SEL_BITS -1 downto 0);
    signal   o_user         : std_logic_vector(USER_HI downto USER_LO);
    signal   o_xfer_last    : std_logic;
    signal   o_error        : std_logic;
    signal   o_last         : std_logic;
    signal   o_valid        : std_logic;
    signal   o_ready        : std_logic;
    signal   o_busy         : std_logic;
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    i_valid   <= POOL_VAL;
    i_chop    <= '1' when (i_valid = '1' and i_ready = '1') else '0';
    POOL_RDY  <= i_ready;
    XFER_VAL  <= i_chop;
    XFER_DVAL <= i_ben;
    XFER_LAST <= i_last;
    -------------------------------------------------------------------------------
    -- i_ben  : バイトイネーブル信号.
    -- i_size : １ワード毎のリードバイト数.
    -- i_last : 最後のワードであることを示すフラグ.
    -------------------------------------------------------------------------------
    BEN: CHOPPER                                 -- 
        generic map (                            -- 
            BURST           => 1               , -- 
            MIN_PIECE       => POOL_DATA_SIZE  , -- 
            MAX_PIECE       => POOL_DATA_SIZE  , -- 
            MAX_SIZE        => TRAN_MAX_SIZE   , -- 
            ADDR_BITS       => START_PTR'length, -- 
            SIZE_BITS       => TRAN_SIZE'length, -- 
            COUNT_BITS      => 1               , -- 
            PSIZE_BITS      => SIZE_BITS       , -- 
            GEN_VALID       => 1                 -- 
        )                                        -- 
        port map (                               -- 
        ---------------------------------------------------------------------------
        -- Clock and Reset Signals.
        ---------------------------------------------------------------------------
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
        ---------------------------------------------------------------------------
        -- 各種初期値
        ---------------------------------------------------------------------------
            ADDR            => START_PTR       , -- In  :
            SIZE            => TRAN_SIZE       , -- In  :
            SEL             => POOL_DATA_SEL   , -- In  :
            LOAD            => TRAN_START      , -- In  :
        ---------------------------------------------------------------------------
        -- 制御信号
        ---------------------------------------------------------------------------
            CHOP            => i_chop          , -- In  :
        ---------------------------------------------------------------------------
        -- ピースカウンタ/フラグ出力
        ---------------------------------------------------------------------------
            COUNT           => open            , -- Out :
            NONE            => open            , -- Out :
            LAST            => i_last          , -- Out :
            NEXT_NONE       => XFER_NONE       , -- Out :
            NEXT_LAST       => open            , -- Out :
        ---------------------------------------------------------------------------
        -- １ワードのバイト数
        ---------------------------------------------------------------------------
            PSIZE           => i_size          , -- Out :
            NEXT_PSIZE      => open            , -- Out :
        ---------------------------------------------------------------------------
        -- バイトイネーブル信号
        ---------------------------------------------------------------------------
            VALID           => i_ben           , -- Out :
            NEXT_VALID      => open              -- Out :
        );                                       -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    Q: POOL_OUTLET_PORT                          -- 
        generic map (                            -- 
            UNIT_BITS       => 8               , --
            WORD_BITS       => ALIGNMENT_BITS  , --
            PORT_DATA_BITS  => PORT_DATA_BITS  , --
            POOL_DATA_BITS  => POOL_DATA_BITS  , --
            PORT_PTR_BITS   => TRAN_ADDR_BITS  , --
            POOL_PTR_BITS   => POOL_PTR_BITS   , --
            SEL_BITS        => TRAN_SEL_BITS   , --
            SIZE_BITS       => SIZE_BITS       , --
            POOL_SIZE_VALID => 1               , --
            QUEUE_SIZE      => SET.Q_Q_SIZE      -- 
        )                                        -- 
        port map (                               -- 
        ---------------------------------------------------------------------------
        -- クロック&リセット信号
        ---------------------------------------------------------------------------
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
        ---------------------------------------------------------------------------
        -- Control Signals.
        ---------------------------------------------------------------------------
            START           => TRAN_START      , -- In  :
            START_POOL_PTR  => START_PTR       , -- In  :
            START_PORT_PTR  => TRAN_ADDR       , -- In  :
            XFER_LAST       => TRAN_LAST       , -- In  :
            XFER_SEL        => TRAN_SEL        , -- In  :
        ---------------------------------------------------------------------------
        -- Outlet Port Signals.
        ---------------------------------------------------------------------------
            PORT_DATA       => q_data          , -- Out :
            PORT_DVAL       => q_strb          , -- Out :
            PORT_ERROR      => q_error         , -- Out :
            PORT_LAST       => q_last          , -- Out :
            PORT_SIZE       => q_size          , -- Out :
            PORT_VAL        => q_valid         , -- Out :
            PORT_RDY        => q_ready         , -- In  :
        ---------------------------------------------------------------------------
        -- Pull Size Signals.
        ---------------------------------------------------------------------------
            PULL_VAL        => PULL_VAL        , -- Out :
            PULL_LAST       => PULL_LAST       , -- Out :
            PULL_XFER_LAST  => PULL_XFER_LAST  , -- Out :
            PULL_XFER_DONE  => PULL_XFER_DONE  , -- Out :
            PULL_ERROR      => PULL_ERROR      , -- Out :
            PULL_SIZE       => o_pull_size     , -- Out :
        ---------------------------------------------------------------------------
        -- Pool Buffer Interface Signals.
        ---------------------------------------------------------------------------
            POOL_REN        => POOL_REN        , -- Out :
            POOL_PTR        => POOL_PTR        , -- Out :
            POOL_DATA       => POOL_DATA       , -- In  :
            POOL_ERROR      => POOL_ERROR      , -- In  :
            POOL_DVAL       => i_ben           , -- In  :
            POOL_SIZE       => i_size          , -- In  :
            POOL_LAST       => i_last          , -- In  :
            POOL_VAL        => i_valid         , -- In  :
            POOL_RDY        => i_ready         , -- Out :
        ---------------------------------------------------------------------------
        -- Status Signals.
        ---------------------------------------------------------------------------
            POOL_BUSY       => POOL_BUSY       , -- Out :
            POOL_DONE       => POOL_DONE       , -- Out :
            BUSY            => q_busy            -- Out :
        );                                       -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                q_user <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                q_user <= (others => '0');
            elsif (TRAN_START = '1') then
                q_user(USER_SEL_HI downto USER_SEL_LO) <= TRAN_SEL;
                q_user(USER_DONE_POS)                  <= TRAN_LAST;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    O: AXI4_DATA_PORT                            -- 
        generic map (                            -- 
            DATA_BITS       => PORT_DATA_BITS  , --
            ADDR_BITS       => TRAN_ADDR_BITS  , --
            SIZE_BITS       => SIZE_BITS       , --
            USER_BITS       => USER_BITS       , --
            ALEN_BITS       => BURST_LEN_BITS  , --
            USE_ASIZE       => USE_BURST_SIZE  , --
            CHECK_ALEN      => CHECK_BURST_LEN , -- 
            I_REGS_SIZE     => SET.O_I_SIZE    , --
            O_REGS_SIZE     => SET.O_O_SIZE      --
        )                                        -- 
        port map (                               -- 
        ---------------------------------------------------------------------------
        -- クロック&リセット信号
        ---------------------------------------------------------------------------
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
        ---------------------------------------------------------------------------
        -- Control Signals.
        ---------------------------------------------------------------------------
            START           => TRAN_START      , -- In  :
            ASIZE           => BURST_SIZE      , -- In  :
            ALEN            => BURST_LEN       , -- In  :
            ADDR            => TRAN_ADDR       , -- In  :
        ---------------------------------------------------------------------------
        -- Intake Port Signals.
        ---------------------------------------------------------------------------
            I_DATA          => q_data          , -- In  :
            I_STRB          => q_strb          , -- In  :
            I_SIZE          => q_size          , -- In  :
            I_USER          => q_user          , -- In  :
            I_LAST          => q_last          , -- In  :
            I_ERROR         => q_error         , -- In  :
            I_VALID         => q_valid         , -- In  :
            I_READY         => q_ready         , -- Out :
        ---------------------------------------------------------------------------
        -- Outlet Port Signals.
        ---------------------------------------------------------------------------
            O_DATA          => PORT_DATA       , -- Out :
            O_STRB          => PORT_STRB       , -- Out :
            O_SIZE          => o_size          , -- Out :
            O_USER          => o_user          , -- Out :
            O_ERROR         => o_error         , -- Out :
            O_LAST          => o_last          , -- Out :
            O_VALID         => o_valid         , -- Out :
            O_READY         => o_ready         , -- In  :
        ---------------------------------------------------------------------------
        -- Status Signals.
        ---------------------------------------------------------------------------
            BUSY            => o_busy            -- Out :
        );
    PORT_VAL   <= o_valid;
    PORT_LAST  <= o_last;
    PORT_ERROR <= o_error;
    o_ready    <= PORT_RDY;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    o_sel          <= o_user(USER_SEL_HI downto USER_SEL_LO) when (TRAN_SEL_BITS > 1) else (others => '1');
    o_xfer_last    <= o_user(USER_DONE_POS);
    EXIT_VAL       <= o_sel when (o_valid = '1' and o_ready = '1') else (others => '0');
    EXIT_ERROR     <= o_error;
    EXIT_LAST      <= '1' when (o_last      = '1') else '0';
    EXIT_XFER_LAST <= '1' when (o_xfer_last = '1') else '0';
    EXIT_XFER_DONE <= '1' when (o_last      = '1') and
                               (o_xfer_last = '1') else '0';
    EXIT_SIZE      <= std_logic_vector(resize(unsigned(o_size     ), EXIT_SIZE_BITS));
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    PULL_SIZE      <= std_logic_vector(resize(unsigned(o_pull_size), PULL_SIZE_BITS));
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    BUSY <= '1' when (o_busy = '1' or q_busy = '1') else '0';
end RTL;
-----------------------------------------------------------------------------------
--!     @file    syncronizer.vhd
--!     @brief   SYNCRONIZER MODULE :
--!              異なるクロックで動作するパスを継ぐアダプタのクロック同期化モジュール.
--!     @version 1.5.9
--!     @date    2015/12/22
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2015 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   SYNCRONIZER
--!          異なるクロックで動作するパスを継ぐアダプタのクロック同期化部分.
--!        * 入力側のクロック(I_CLK)に同期化された入力データを 
--!          出力側クロック(O_CLK)に同期化して出力する.
--!        * 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)との関係は、
--!          ジェネリック変数I_CLK_RATEとO_CLK_RATEで指示する.
--!          詳細は O_CLK_RATE を参照.
-----------------------------------------------------------------------------------
entity  SYNCRONIZER is
    generic (
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(IDATA/ODATA)のビット幅を指定する.
                      integer :=  8;
        VAL_BITS    : --! @brief VALID BITS :
                      --! データ有効信号(IVAL/OVAL)のビット幅を指定する.
                      integer :=  1;
        I_CLK_RATE  : --! @brief INPUT CLOCK RATE :
                      --! O_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する. 詳細は O_CLK_RATE を参照.
                      integer :=  1;
        O_CLK_RATE  : --! @brief OUTPUT CLOCK RATE :
                      --! I_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する.
                      --! * I_CLK_RATE = 0 かつ O_CLK_RATE = 0 の場合は I_CLK と 
                      --!   O_CLK は非同期.
                      --! * I_CLK_RATE = 1 かつ O_CLK_RATE = 1 の場合は I_CLK と 
                      --!   O_CLK は完全に同期している.
                      --! * I_CLK_RATE > 1 かつ O_CLK_RATE = 1 の場合は I_CLK は 
                      --!   O_CLK のI_CLK_RATE倍の周波数.
                      --!   ただし I_CLK の立上りは O_CLK の立上りと一致している.
                      --! * I_CLK_RATE = 1 かつ O_CLK_RATE > 1 の場合は O_CLK は 
                      --!   I_CLK の O_CLK_RATE倍の周波数.
                      --!   ただし I_CLK の立上りは O_CLK の立上りと一致している.
                      --! * 例1)I_CLK_RATE=1 & O_CLK_RATE=1          \n
                      --!       I_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --!       O_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --! * 例2)I_CLK_RATE=2 & O_CLK_RATE=1          \n
                      --!       I_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --!       O_CLK _|~~~|___|~~~|___|~~~|___|~~~  \n
                      --!       I_CKE ~~~|___|~~~|___|~~~|___|~~~|_  \n
                      --! * 例3)I_CLK_RATE=3 & O_CLK_RATE=1          \n
                      --!       I_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --!       O_CLK _|~~~~~|_____|~~~~~|_____|~~~  \n
                      --!       I_CKE ~~~|_______|~~~|_______|~~~|_  \n
                      --! * 例4)I_CLK_RATE=1 & O_CLK_RATE=2          \n
                      --!       I_CLK _|~~~|___|~~~|___|~~~|___|~~~  \n
                      --!       O_CLK _|~|_|~|_|~|_|~|_|~|_|~|_|~|_  \n
                      --!       O_CKE ~~~|___|~~~|___|~~~|___|~~~|_  \n
                      integer :=  1;
        I_CLK_FLOP  : --! @brief INPUT CLOCK FLOPPING :
                      --! 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)が非同期
                      --! の場合に、出力側のFFからの制御信号を入力側のFFで叩く段数
                      --! を指定する.
                      --! * FFで叩くのはメタステーブルの発生による誤動作を防ぐため.
                      --!   メタステーブルの意味が分からない人は、この変数を変更す
                      --!   るのはやめたほうがよい。
                      integer range 0 to 2 := 2;
        O_CLK_FLOP  : --! @brief OUTPUT CLOCK FLOPPING :
                      --! 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)が非同期
                      --! の場合に、入力側のFFからの制御信号を出力側のFFで叩く段数
                      --! を指定する.
                      --! * FFで叩くのはメタステーブルの発生による誤動作を防ぐため.
                      --!   メタステーブルの意味が分からない人は、この変数を変更す
                      --!   るのはやめたほうがよい.
                      integer range 0 to 2 := 2;
        I_CLK_FALL  : --! @brief USE INPUT CLOCK FALL :
                      --! 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)が非同期
                      --! の場合に、入力側のクロック(I_CLK)の立ち下がりを使うかどう
                      --! かを指定する.
                      --! * この変数は後方互換性のために存在する. 現在は未使用.
                      --! * I_CLK_FALL = 0 の場合は使わない.
                      --! * I_CLK_FALL = 1 の場合は使う.
                      integer range 0 to 1 :=  0;
        O_CLK_FALL  : --! @brief USE OUTPUT CLOCK FALL :
                      --! 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)が非同期
                      --! の場合に、出力側のクロック(OCLK)の立ち下がりを使うかどう
                      --! かを指定する.
                      --! * O_CLK_FALL = 0 の場合は使わない.
                      --! * O_CLK_FALL = 1 の場合は使う.
                      integer range 0 to 1 :=  0;
        O_CLK_REGS  : --! @brief REGISTERD OUTPUT :
                      --! 出力側の各種信号(O_VAL/O_DATA)をレジスタ出力するかどうか
                      --! を指定する.
                      --! * この変数は I_CLK_RATE > 0 の場合のみ有効. 
                      --!   I_CLK_RATE = 0 の場合は、常にレジスタ出力になる.
                      --! * O_CLK_REGS = 0 の場合はレジスタ出力しない.
                      --! * O_CLK_REGS = 1 の場合はレジスタ出力する.
                      integer range 0 to 1 :=  0
    );
    port (
    -------------------------------------------------------------------------------
    -- リセット信号
    -------------------------------------------------------------------------------
        RST         : --! @brief RESET :
                      --! 非同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        I_CLK       : --! @brief INPUT CLOCK :
                      --! 入力側のクロック信号.
                      in  std_logic;
        I_CLR       : --! @brief INPUT CLEAR :
                      --! 入力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側の制御信号
    -------------------------------------------------------------------------------
        I_CKE       : --! @brief INPUT CLOCK ENABLE :
                      --! 入力側のクロック(I_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とOCLKの立上り時が同じ時にアサートするよ
                      --!   うに入力されなければならない.
                      --! * この信号は I_CLK_RATE > 1 かつ O_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側のデータ信号/有効信号/可能信号
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT DATA :
                      --! 入力データ.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT VALID :
                      --! 入力有効信号.
                      --! * この信号がアサートされている時はI_DATAに有効なデータが
                      --!   入力されていなければならない。
                      in  std_logic_vector(VAL_BITS -1 downto 0);
        I_RDY       : --! @brief INPUT READY :
                      --! 入力可能信号.
                      --! * この信号がアサートされている場合にのみ、I_VAL,I_DATAを
                      --!   受け付けて、出力側に転送する.
                      --! * この信号がネゲートされている場合は、I_VAL,I_DATAは無視
                      --!   される.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側のクロック
    -------------------------------------------------------------------------------
        O_CLK       : --! @brief OUTPUT CLK :
                      --! 出力側のクロック信号.
                      in  std_logic;
        O_CLR       : --! @brief OUTPUT CLEAR :
                      --! 出力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 出力側の制御信号
    -------------------------------------------------------------------------------
        O_CKE       : --! @brief OUTPUT CLOCK ENABLE :
                      --! 出力側のクロック(O_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とO_CLKの立上り時が同じ時にアサートする
                      --!   ように入力されなければならない.
                      --! * この信号は O_CLK_RATE > 1 かつ I_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 出力側のデータ信号/有効信号
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT DATA :
                      --! 出力データ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT VALID :
                      --! 出力有効信号.
                      --! * この信号がアサートされている時はODATAに有効なデータが出
                      --!   力されていることを示す.
                      out std_logic_vector(VAL_BITS -1 downto 0)
    );
end SYNCRONIZER;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
architecture RTL of SYNCRONIZER is
    signal    sync_req  : std_logic;
    signal    sync_ack  : std_logic;
    signal    sync_load : std_logic;
    signal    sync_valid: std_logic_vector(VAL_BITS -1 downto 0);
    signal    sync_data : std_logic_vector(DATA_BITS-1 downto 0);
    constant  VAL_ALL_0 : std_logic_vector(VAL_BITS -1 downto 0) := (others => '0');
begin
    -------------------------------------------------------------------------------
    -- 同期化ブロック(I_CLKとO_CLKが非同期の場合)
    -------------------------------------------------------------------------------
    --    I_CLKとO_CLKが非同期の場合は、入力ブロックと出力ブロックの間に同期化のた
    --    めのしくみが必要になる。
    -------------------------------------------------------------------------------
    ASYNC:if (I_CLK_RATE = 0 or O_CLK_RATE = 0) generate
        ---------------------------------------------------------------------------
        -- 入力側の回路
        ---------------------------------------------------------------------------
        I_BLK: block
            signal   curr_state     : std_logic_vector(1 downto 0);
            signal   next_state     : std_logic_vector(1 downto 0);
            signal   sync_start     : std_logic;
            signal   sync_ready     : std_logic;
            signal   sync_ack_i     : std_logic;
            signal   sync_ack_1     : std_logic;
            signal   sync_ack_2     : std_logic;
        begin
            -----------------------------------------------------------------------
            -- curr_state : 出力側と同期をとるためのステートマシーン
            -----------------------------------------------------------------------
            next_state(0) <= '1' when (curr_state = "00" and sync_start = '1') or
                                      (curr_state = "01") or
                                      (curr_state = "11" and sync_start = '0') else '0';
            next_state(1) <= '1' when (curr_state = "01" and sync_ack_i = '1') or
                                      (curr_state = "11") or
                                      (curr_state = "10" and sync_ack_i = '1') else '0';
            process (I_CLK, RST) begin
                if     (RST   = '1') then  curr_state <= (others => '0');
                elsif  (I_CLK'event and I_CLK = '1') then
                    if (I_CLR = '1') then curr_state <= (others => '0');
                    else                  curr_state <= next_state;
                    end if;
                end if;
            end process;
            -----------------------------------------------------------------------
            -- sync_ack_i : 出力側からの sync_ack 信号を FF で叩く
            -----------------------------------------------------------------------
            sync_ack_i <= sync_ack   when (I_CLK_FLOP = 0) else
                          sync_ack_1 when (I_CLK_FLOP = 1) else
                          sync_ack_2;
            process (I_CLK, RST) begin
                if (RST = '1') then
                        sync_ack_1 <= '0';
                        sync_ack_2 <= '0';
                elsif  (I_CLK'event and I_CLK = '1') then
                    if (I_CLR = '1') then
                        sync_ack_1 <= '0';
                        sync_ack_2 <= '0';
                    else
                        sync_ack_1 <= sync_ack;
                        sync_ack_2 <= sync_ack_1;
                    end if;
                end if;
            end process;
            -----------------------------------------------------------------------
            -- sync_req   : 出力側に送る同期信号
            -----------------------------------------------------------------------
            sync_req   <= curr_state(0);
            -----------------------------------------------------------------------
            -- sync_ready : curr_state が起動可能であることを示す信号
            -----------------------------------------------------------------------
            sync_ready <= '1' when (curr_state = "00") or (curr_state = "11") else '0';
            -----------------------------------------------------------------------
            -- sync_start : curr_state を起動する信号
            -----------------------------------------------------------------------
            sync_start <= '1' when (I_VAL /= VAL_ALL_0) else '0';
            -----------------------------------------------------------------------
            -- sync_valid : 出力側に転送する有効信号.
            -- sync_data  : 出力側に転送するデータ.
            -----------------------------------------------------------------------
            process (I_CLK, RST) begin
                if (RST = '1') then 
                        sync_valid <= (others => '0');
                        sync_data  <= (others => '0');
                elsif  (I_CLK'event and I_CLK = '1') then
                    if (I_CLR = '1') then 
                        sync_valid <= (others => '0');
                        sync_data  <= (others => '0');
                    elsif (sync_ready = '1') then
                        sync_valid <= I_VAL;
                        sync_data  <= I_DATA;
                    end if;
                end if;
            end process;
            -----------------------------------------------------------------------
            -- I_RDY      : 入力可能であることを示す信号.
            -----------------------------------------------------------------------
            I_RDY <= sync_ready;
        end block;
        ---------------------------------------------------------------------------
        -- 出力側の回路
        ---------------------------------------------------------------------------
        O_BLK: block
            signal   curr_state     : std_logic_vector(1 downto 0);
            signal   next_state     : std_logic_vector(1 downto 0);
            signal   sync_req_i     : std_logic;
            signal   sync_req_1     : std_logic;
            signal   sync_req_2     : std_logic;
        begin
            -----------------------------------------------------------------------
            -- sync_req_i : 入力側からの sync_req 信号を FF で叩く
            -----------------------------------------------------------------------
            sync_req_i <= sync_req   when (O_CLK_FLOP = 0) else
                          sync_req_1 when (O_CLK_FLOP = 1) else
                          sync_req_2;
            REQ1F: if (O_CLK_FALL > 0 and O_CLK_FLOP = 1) generate
                process (O_CLK, RST) begin
                    if     (RST   = '1') then sync_req_1 <= '0';
                    elsif  (O_CLK'event and O_CLK = '0') then
                        if (O_CLR = '1') then sync_req_1 <= '0';
                        else                  sync_req_1 <= sync_req;
                        end if;
                    end if;
                end process;
            end generate;
            REQ1R: if (O_CLK_FALL = 0 or O_CLK_FLOP /= 1) generate
                process (O_CLK, RST) begin
                    if     (RST   = '1') then sync_req_1 <= '0';
                    elsif  (O_CLK'event and O_CLK = '1') then
                        if (O_CLR = '1') then sync_req_1 <= '0';
                        else                  sync_req_1 <= sync_req;
                        end if;
                    end if;
                end process;
            end generate;
            REQ2F: if (O_CLK_FALL > 0) generate
                process (O_CLK, RST) begin
                    if     (RST   = '1') then sync_req_2 <= '0';
                    elsif  (O_CLK'event and O_CLK = '0') then
                        if (O_CLR = '1') then sync_req_2 <= '0';
                        else                  sync_req_2 <= sync_req_1;
                        end if;
                    end if;
                end process;
            end generate;
            REQ2R: if (O_CLK_FALL = 0) generate
                process (O_CLK, RST) begin
                    if     (RST   = '1') then sync_req_2 <= '0';
                    elsif  (O_CLK'event and O_CLK = '1') then
                        if (O_CLR = '1') then sync_req_2 <= '0';
                        else                  sync_req_2 <= sync_req_1;
                        end if;
                    end if;
                end process;
            end generate;
            -----------------------------------------------------------------------
            -- curr_state : 送り側と同期をとるためのステートマシーン
            -----------------------------------------------------------------------
            next_state(0) <= '1' when (curr_state = "00" and sync_req_i = '1') or
                                      (curr_state = "01") or
                                      (curr_state = "11" and sync_req_i = '1') else '0';
            next_state(1) <= '1' when (curr_state = "01") or
                                      (curr_state = "11") else '0';
            OCF:if (O_CLK_FALL > 0 and O_CLK_FLOP = 0) generate
                process (O_CLK, RST) begin
                    if     (RST   = '1') then curr_state <= (others => '0');
                    elsif  (O_CLK'event and O_CLK = '0') then
                        if (O_CLR = '1') then curr_state <= (others => '0');
                        else                  curr_state <= next_state;
                        end if;
                    end if;
                end process;
            end generate;
            OCR:if (O_CLK_FALL = 0 or O_CLK_FLOP > 0) generate
                process (O_CLK, RST) begin
                    if     (RST   = '1') then curr_state <= (others => '0');
                    elsif  (O_CLK'event and O_CLK = '1') then
                        if (O_CLR = '1') then curr_state <= (others => '0');
                        else                  curr_state <= next_state;
                        end if;
                    end if;
                end process;
            end generate;
            -----------------------------------------------------------------------
            -- sync_ack  : 入力側に送る同期信号
            -----------------------------------------------------------------------
            sync_ack  <= curr_state(1);
            -----------------------------------------------------------------------
            -- sync_load : 出力側のロード信号
            -----------------------------------------------------------------------
            sync_load <= '1' when (curr_state = "01" or curr_state = "10") else '0';
        end block;
    end generate; -- ASYNC: if (I_CLK_RATE = 0 or O_CLK_RATE = 0) generate
    -------------------------------------------------------------------------------
    -- 同期化ブロック(I_CLKとO_CLKが同期している場合)
    -------------------------------------------------------------------------------
    --    I_CLKとO_CLKが同期している場合はほとんどの信号はスルーで出力側に転送される
    -------------------------------------------------------------------------------
    SYNC:if (I_CLK_RATE > 0 and O_CLK_RATE > 0) generate
        I_RDY      <= '1' when (I_CKE = '1' or I_CLK_RATE = 1) else '0';
        sync_valid <= I_VAL;
        sync_data  <= I_DATA;
        sync_req   <= '0';
        sync_ack   <= '0';
        sync_load  <= '1' when (O_CKE = '1' or O_CLK_RATE = 1) else '0';
    end generate; -- SYNC: if (I_CLK_RATE > 0 and O_CLK_RATE > 0) generate
    -------------------------------------------------------------------------------
    -- 出力側ブロック(レジスタ出力の場合)
    -------------------------------------------------------------------------------
    O_REG:if (I_CLK_RATE = 0 or O_CLK_RATE = 0 or O_CLK_REGS /= 0) generate
        process (O_CLK, RST) begin
            if (RST = '1') then 
                    O_VAL  <= (others => '0');
                    O_DATA <= (others => '0');
            elsif (O_CLK'event and O_CLK = '1') then
                if (O_CLR = '1') then
                    O_VAL  <= (others => '0');
                    O_DATA <= (others => '0');
                elsif (sync_load = '1') then
                    O_VAL  <= sync_valid;
                    O_DATA <= sync_data;
                else
                    O_VAL  <= (others => '0');
                end if;
            end if;
        end process;
    end generate; 
    -------------------------------------------------------------------------------
    -- 出力側ブロック(レジスタ出力でない場合)
    -------------------------------------------------------------------------------
    O_CMB:if (I_CLK_RATE > 0 and O_CLK_RATE > 0 and O_CLK_REGS = 0) generate
        O_VAL  <= sync_valid when (sync_load = '1') else (others => '0');
        O_DATA <= sync_data;
    end generate; 
end RTL;
-----------------------------------------------------------------------------------
--!     @file    syncronizer_input_pending_register.vhd
--!     @brief   SYNCRONIZER INPUT PENDING REGISTER : 
--!     @version 0.1.2
--!     @date    2012/9/10
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   SYNCRONIZER INPUT PENDING_REGSISTER
--!          異なるクロックで動作するパスを継ぐアダプタ(SYNCRONIZER)の入力側レジスタ.
--!        * SYNCRONIZER の入力側(I_DATA,I_VAL)に接続し、
--!          SYNCRONIZERが入力不可の際(I_RDY='0')に
--!          一時的に入力データを保存(ペンディング)しておくためレジスタ.
--!        * ペンディングする際の方法はジェネリック変数OPERATIONで指示する.
--!          OPERATION = 0 の場合は常に新しい入力データで上書きされる.  
--!          OPERATION = 1 の場合は入力データとペンディングデータとをビット単位で 
--!          論理和して新しいペンディングデータとする.   
--!          OPERATION = 2 の場合は入力データとペンディングデータとを加算して 
--!          新しいペンディングデータとする.  
-----------------------------------------------------------------------------------
entity  SYNCRONIZER_INPUT_PENDING_REGISTER is
    generic (
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(IDATA/ODATA)のビット幅を指定する.
                      integer :=  8;
        OPERATION   : --! @brief PENDING OPERATION :
                      --! ペンディング(出力待ち)時に次のIVALがアサートされた時に
                      --! データをどう扱うを指定する.
                      --! * OPERATION = 0 の場合は常に新しい入力データで上書きされる. 
                      --! * OPERATION = 1 の場合は入力データ(IDATA)と
                      --!   ペンディングデータとをビット単位で論理和して
                      --!   新しいペンディングデータとする.
                      --!   主に入力データがフラグ等の場合に使用する.
                      --! * OPERATION = 2 の場合は入力データ(IDATA)と
                      --!   ペンディングデータとを加算して
                      --!   新しいペンディングデータとする.
                      --!   主に入力データがカウンタ等の場合に使用する.
                      integer range 0 to 2 := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側 I/F
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT DATA :
                      --! 入力データ.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT VALID :
                      --! 入力有効信号.
                      --! * この信号がアサートされている時はI_DATAに有効なデータが
                      --!   入力されていなければならない。
                      in  std_logic;
        I_PAUSE     : --! @brief INPUT PAUSE :
                      --! * 入力側の情報(I_VAL,I_DATA)を、出力側(O_VAL,O_DATA)に
                      --!   出力するのを一時的に中断する。
                      --! * この信号がアサートされている間に入力された入力側の情報(
                      --!   I_VAL,I_DATA)は、出力側(O_VAL,O_DATA)には出力されず、
                      --!   ペンディングレジスタに保持される。
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側(PENDING) I/F
    -------------------------------------------------------------------------------
        P_DATA      : --! @brief PENDING DATA :
                      --! 現在ペンディング中のデータ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        P_VAL       : --! @brief PENDING VALID :
                      --! 現在ペンディング中のデータがあることを示すフラグ.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側 I/F
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT DATA :
                      --! 出力データ.
                      --! * SYNCRONIZERのI_DATAに接続する.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT VALID :
                      --! 出力有効信号.
                      --! * SYNCRONIZERのI_VALに接続する.
                      --! * この信号がアサートされている時はO_DATAに有効なデータが
                      --!   出力されていることを示す.
                      out std_logic;
        O_RDY       : --! @brief OUTPUT READY :
                      --! 出力許可信号.
                      --! * SYNCRONIZERのI_RDYに接続する.
                      in  std_logic
    );
end SYNCRONIZER_INPUT_PENDING_REGISTER;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
architecture RTL of SYNCRONIZER_INPUT_PENDING_REGISTER is
    -------------------------------------------------------------------------------
    --! @brief 出力側に出力するデータ有効信号.
    -------------------------------------------------------------------------------
    signal   out_valid       : std_logic;
    -------------------------------------------------------------------------------
    --! @brief 出力側に出力するデータ.
    -------------------------------------------------------------------------------
    signal   out_data        : std_logic_vector(DATA_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    --! @brief データが出力側に出力されていないことを示すフラグ.
    -------------------------------------------------------------------------------
    signal   pend_valid      : std_logic;
    -------------------------------------------------------------------------------
    --! @brief 出力側に出力できない時にデータを保持しておくレジスタ.
    -------------------------------------------------------------------------------
    signal   pend_data       : std_logic_vector(DATA_BITS-1 downto 0);
begin
    -------------------------------------------------------------------------------
    -- 常に I_PAUSE=0 かつ O_RDY=1 が成立するような場合は pend_valid, pend_data
    -- はすべて0になり、その場合は out_valid, out_data は次のように簡略化されるよ
    -- うに記述している.
    -- out_valid <= I_VAL; out_data  <= I_DATA
    -------------------------------------------------------------------------------
    out_valid <= '1' when (I_PAUSE = '0' and (I_VAL = '1' or pend_valid = '1')) else '0';
    process (I_VAL, I_DATA, pend_valid, pend_data) begin
        if    (I_VAL = '1') then
            case OPERATION is
                when 2      => out_data <= std_logic_vector(unsigned(I_DATA) + unsigned(pend_data));
                when 1      => out_data <= I_DATA or pend_data;
                when others => out_data <= I_DATA;
            end case;
        elsif (pend_valid = '1') then
            out_data <= pend_data;
        else
            out_data <= I_DATA;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- 少し変則的で判りにくい記述だが、out_data を再利用することで回路がなるべく
    -- 簡単になるようにしている.
    -- 常に I_PAUSE=0 かつ O_RDY=1 が成立するような場合は pend_valid, pend_data
    -- はすべて0になるようにしている.
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then 
                pend_valid <= '0';
                pend_data  <= (others => '0');
        elsif  (CLK'event and CLK = '1') then
            if (CLR = '1') or 
               (O_RDY       = '1' and I_PAUSE = '0') or
               (pend_valid  = '0' and I_VAL   = '0') then
                pend_valid <= '0';
                pend_data  <= (others => '0');
            else
                pend_valid <= '1';
                pend_data  <= out_data;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- 出力情報をモジュール外部に出力する.
    -------------------------------------------------------------------------------
    O_VAL  <= out_valid;
    O_DATA <= out_data;
    -------------------------------------------------------------------------------
    -- ペンディング情報をモジュール外部に出力する.
    -------------------------------------------------------------------------------
    P_VAL  <= pend_valid;
    P_DATA <= pend_data;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    axi4_register_read_interface.vhd
--!     @brief   AXI4 Register Read Interface
--!     @version 1.5.9
--!     @date    2016/1/7
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2016 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
-----------------------------------------------------------------------------------
--! @brief   AXI4 Register Read Interface.
-----------------------------------------------------------------------------------
entity  AXI4_REGISTER_READ_INTERFACE is
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 リードアドレスチャネルのAWADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 WRITE DATA CHANNEL DATA WIDTH :
                          --! AXI4 リードデータチャネルのRDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびライトレスポンスチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        REGS_ADDR_WIDTH : --! @brief REGISTER ADDRESS WIDTH :
                          --! レジスタアクセスインターフェースのアドレスのビット幅
                          --! を指定する.
                          integer := 32;
        REGS_DATA_WIDTH : --! @brief REGISTER DATA WIDTH :
                          --! レジスタアクセスインターフェースのデータのビット幅を
                          --! 指定する.
                          integer := 32
    );
    port(
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Read Address Channel Signals.
    -------------------------------------------------------------------------------
        ARID            : --! @brief Read address ID.
                          --! This signal is identification tag for the read
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        ARADDR          : --! @brief Read address.  
                          --! The read address gives the address of the first
                          --! transfer in a read burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        ARLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        ARSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        ARBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        ARVALID         : --! @brief Read address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        ARREADY         : --! @brief Read address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Read Data Channel Signals.
    -------------------------------------------------------------------------------
        RID             : --! @brief Read ID tag.
                          --! This signal is the identification tag for the read
                          --! data group of signals generated by the slave.
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        RDATA           : --! @brief Read data.
                          out   std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        RRESP           : --! @brief Read response.
                          --! This signal indicates the status of the read transaction.
                          out   AXI4_RESP_TYPE;
        RLAST           : --! @brief Read last.
                          --! This signal indicates the last transfer in a read burst.
                          out   std_logic;
        RVALID          : --! @brief Read data valid.
                          --! This signal indicates that the channel is signaling
                          --! the required read data.
                          out   std_logic;
        RREADY          : --! @brief Read data ready.
                          --! This signal indicates that the master can accept the
                          --! read data and response information.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- Register Read Interface.
    -------------------------------------------------------------------------------
        REGS_REQ        : --! @brief レジスタアクセス要求信号.
                          --! レジスタアクセス要求時にアサートされる.
                          --! REGS_ACK 信号がアサートされるまで、この信号はアサー
                          --! トされたまま.
                          out std_logic;
        REGS_ACK        : --! @brief レジスタアクセス応答信号.
                          in  std_logic;
        REGS_ERR        : --! @brief レジスタアクセスエラー信号.
                          --! エラーが発生した時にREGS_ACK信号と共にアサートする.
                          in  std_logic;
        REGS_ADDR       : --! @brief レジスタアドレス信号.
                          out std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
        REGS_BEN        : --! @brief バイトイネーブル信号.
                          out std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
        REGS_DATA       : --! @brief レジスタライトデータ出力信号.
                          in  std_logic_vector(REGS_DATA_WIDTH  -1 downto 0)
    );
end AXI4_REGISTER_READ_INTERFACE;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
use     PIPEWORK.AXI4_COMPONENTS.AXI4_DATA_OUTLET_PORT;
architecture RTL of AXI4_REGISTER_READ_INTERFACE is
    -------------------------------------------------------------------------------
    -- データバスのバイト数の２のべき乗値を計算する関数.
    -------------------------------------------------------------------------------
    function CALC_DATA_SIZE(WIDTH:integer) return integer is
        variable value : integer;
    begin
        value := 0;
        while (2**(value+3) < WIDTH) loop
            value := value + 1;
        end loop;
        return value;
    end function;
    -------------------------------------------------------------------------------
    -- AXI4 データバスのバイト数の２のべき乗値.
    -------------------------------------------------------------------------------
    constant AXI4_DATA_SIZE     : integer := CALC_DATA_SIZE(AXI4_DATA_WIDTH);
    -------------------------------------------------------------------------------
    -- レジスタインターフェース側のデータバスのバイト数の２のべき乗値.
    -------------------------------------------------------------------------------
    constant REGS_DATA_SIZE     : integer := CALC_DATA_SIZE(REGS_DATA_WIDTH);
    -------------------------------------------------------------------------------
    -- 最大転送バイト数
    -------------------------------------------------------------------------------
    constant XFER_MAX_SIZE      : integer := AXI4_ALEN_WIDTH + AXI4_DATA_SIZE;
    -------------------------------------------------------------------------------
    -- アライメントのビット数
    -------------------------------------------------------------------------------
    function CALC_ALIGNMENT_BITS return integer is begin
        if (AXI4_DATA_WIDTH <= REGS_DATA_WIDTH) then
            return AXI4_DATA_WIDTH;
        else
            return REGS_DATA_WIDTH;
        end if;
    end function;
    constant ALIGNMENT_BITS     : integer := CALC_ALIGNMENT_BITS;
    -------------------------------------------------------------------------------
    -- 内部信号
    -------------------------------------------------------------------------------
    signal   xfer_start         : std_logic;
    signal   xfer_error         : std_logic;
    signal   xfer_prepare       : std_logic;
    signal   xfer_req_addr      : std_logic_vector(REGS_ADDR_WIDTH-1 downto 0);
    signal   xfer_req_size      : std_logic_vector(XFER_MAX_SIZE     downto 0);
    signal   identifier         : std_logic_vector(AXI4_ID_WIDTH  -1 downto 0);
    signal   burst_type         : AXI4_ABURST_TYPE;
    signal   burst_length       : std_logic_vector(AXI4_ALEN_WIDTH-1 downto 0);
    signal   word_size          : AXI4_ASIZE_TYPE;
    signal   xfer_beat_load     : std_logic;
    signal   xfer_beat_chop     : std_logic;
    signal   xfer_beat_valid    : std_logic;
    signal   xfer_beat_ready    : std_logic;
    signal   xfer_beat_last     : std_logic;
    signal   xfer_beat_error    : std_logic;
    signal   xfer_beat_done     : std_logic;
    signal   xfer_beat_none     : std_logic;
    signal   xfer_beat_ben      : std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
    signal   xfer_beat_size     : std_logic_vector(REGS_DATA_SIZE downto 0);
    signal   rbuf_busy          : std_logic;
    signal   outlet_error       : std_logic;
    signal   size_error         : boolean;
    type     STATE_TYPE        is (IDLE, PREPARE, XFER_DATA, TURN_AR);
    signal   curr_state         : STATE_TYPE;
begin
    -------------------------------------------------------------------------------
    -- ステートマシン
    -------------------------------------------------------------------------------
    process (CLK, RST)
        variable next_state : STATE_TYPE;
    begin
        if (RST = '1') then
                curr_state <= IDLE;
                ARREADY    <= '0';
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then 
                curr_state <= IDLE;
                ARREADY    <= '0';
            else
                case curr_state is
                    when IDLE =>
                        if (ARVALID = '1') then
                            next_state := PREPARE;
                        else
                            next_state := IDLE;
                        end if;
                    when PREPARE =>
                            next_state := XFER_DATA;
                    when XFER_DATA =>
                        if (xfer_beat_chop = '1' and xfer_beat_done = '1') then
                            next_state := TURN_AR;
                        else
                            next_state := XFER_DATA;
                        end if;
                    when TURN_AR =>
                        if (rbuf_busy = '0') then
                            next_state := IDLE;
                        else
                            next_state := TURN_AR;
                        end if;
                    when others =>
                            next_state := IDLE;
                end case;
                curr_state <= next_state;
                if (next_state = IDLE) then
                    ARREADY <= '1';
                else
                    ARREADY <= '0';
                end if;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- xfer_start    : この信号がトリガーとなっていろいろと処理を開始する.
    -------------------------------------------------------------------------------
    xfer_prepare <= '1' when (curr_state = PREPARE) else '0';
    xfer_start   <= '1' when (curr_state = PREPARE and size_error = FALSE) else '0';
    xfer_error   <= '1' when (curr_state = PREPARE and size_error = TRUE ) else '0';
    -------------------------------------------------------------------------------
    -- ARVALID='1' and ARREADY='1'の時に、各種情報をレジスタに保存しておく.
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                identifier    <= (others => '0');
                burst_length  <= (others => '0');
                burst_type    <= AXI4_ABURST_FIXED;
                word_size     <= AXI4_ASIZE_1BYTE;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then 
                identifier    <= (others => '0');
                burst_length  <= (others => '0');
                burst_type    <= AXI4_ABURST_FIXED;
                word_size     <= AXI4_ASIZE_1BYTE;
            elsif (curr_state = IDLE and ARVALID = '1') then
                burst_length  <= ARLEN;
                burst_type    <= ARBURST;
                word_size     <= ARSIZE;
                identifier    <= ARID;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- xfer_req_addr : 転送要求アドレス.
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                xfer_req_addr <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then 
                xfer_req_addr <= (others => '0');
            elsif (curr_state = IDLE and ARVALID = '1') then
                for i in xfer_req_addr'range loop
                    if (ARADDR'low <= i and i <= ARADDR'high) then
                        xfer_req_addr(i) <= ARADDR(i);
                    else
                        xfer_req_addr(i) <= '0';
                    end if;
                end loop;
            elsif (burst_type = AXI4_ABURST_INCR and xfer_beat_chop = '1') then
                xfer_req_addr <= std_logic_vector(unsigned(xfer_req_addr) + unsigned(xfer_beat_size));
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- xfer_req_size : リードするバイト数.
    -------------------------------------------------------------------------------
    process (xfer_req_addr, burst_length, word_size)
        constant u_zero      : unsigned(              6 downto 0) := (6 downto 0 => '0');
        variable u_addr      : unsigned(              6 downto 0);
        variable dt_len      : unsigned(AXI4_ALEN_WIDTH downto 0);
        variable others_size : unsigned(XFER_MAX_SIZE   downto 0);
        variable first_size  : unsigned(              6 downto 0);
    begin
        dt_len := RESIZE(to_01(unsigned(burst_length )), dt_len'length);
        u_addr := RESIZE(to_01(unsigned(xfer_req_addr)), u_addr'length);
        if    (word_size = AXI4_ASIZE_128BYTE and AXI4_DATA_WIDTH >= 128*8) then
            first_size  := RESIZE(     not u_addr(6 downto 0),  first_size'length);
            others_size := RESIZE(dt_len & u_zero(6 downto 0), others_size'length);
        elsif (word_size = AXI4_ASIZE_64BYTE  and AXI4_DATA_WIDTH >=  64*8) then
            first_size  := RESIZE(     not u_addr(5 downto 0),  first_size'length);
            others_size := RESIZE(dt_len & u_zero(5 downto 0), others_size'length);
        elsif (word_size = AXI4_ASIZE_32BYTE  and AXI4_DATA_WIDTH >=  32*8) then
            first_size  := RESIZE(     not u_addr(4 downto 0),  first_size'length);
            others_size := RESIZE(dt_len & u_zero(4 downto 0), others_size'length);
        elsif (word_size = AXI4_ASIZE_16BYTE  and AXI4_DATA_WIDTH >=  16*8) then
            first_size  := RESIZE(     not u_addr(3 downto 0),  first_size'length);
            others_size := RESIZE(dt_len & u_zero(3 downto 0), others_size'length);
        elsif (word_size = AXI4_ASIZE_8BYTE   and AXI4_DATA_WIDTH >=   8*8) then
            first_size  := RESIZE(     not u_addr(2 downto 0),  first_size'length);
            others_size := RESIZE(dt_len & u_zero(2 downto 0), others_size'length);
        elsif (word_size = AXI4_ASIZE_4BYTE   and AXI4_DATA_WIDTH >=   4*8) then
            first_size  := RESIZE(     not u_addr(1 downto 0),  first_size'length);
            others_size := RESIZE(dt_len & u_zero(1 downto 0), others_size'length);
        elsif (word_size = AXI4_ASIZE_2BYTE   and AXI4_DATA_WIDTH >=   2*8) then
            first_size  := RESIZE(     not u_addr(0 downto 0),  first_size'length);
            others_size := RESIZE(dt_len & u_zero(0 downto 0), others_size'length);
        else
            first_size  := (others => '0');
            others_size := RESIZE(dt_len                     , others_size'length);
        end if;
        xfer_req_size <= std_logic_vector(others_size + first_size + 1);
    end process;
    -------------------------------------------------------------------------------
    -- 不正なサイズを指定された事を示すフラグ.
    -------------------------------------------------------------------------------
    size_error <= (word_size = AXI4_ASIZE_128BYTE and AXI4_DATA_WIDTH < 128*8) or
                  (word_size = AXI4_ASIZE_64BYTE  and AXI4_DATA_WIDTH <  64*8) or
                  (word_size = AXI4_ASIZE_32BYTE  and AXI4_DATA_WIDTH <  32*8) or
                  (word_size = AXI4_ASIZE_16BYTE  and AXI4_DATA_WIDTH <  16*8) or
                  (word_size = AXI4_ASIZE_8BYTE   and AXI4_DATA_WIDTH <   8*8) or
                  (word_size = AXI4_ASIZE_4BYTE   and AXI4_DATA_WIDTH <   4*8) or
                  (word_size = AXI4_ASIZE_2BYTE   and AXI4_DATA_WIDTH <   2*8);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    REGS_ADDR       <= xfer_req_addr;
    REGS_BEN        <= xfer_beat_ben;
    REGS_REQ        <= '1' when (curr_state = XFER_DATA and xfer_beat_ready = '1') else '0';
    xfer_beat_valid <= '1' when (curr_state = XFER_DATA and REGS_ACK        = '1') else '0';
    xfer_beat_done  <= '1' when (xfer_beat_last = '1' or xfer_beat_error = '1') else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    OUTLET_PORT: AXI4_DATA_OUTLET_PORT           -- 
        generic map (                            -- 
            PORT_DATA_BITS  => AXI4_DATA_WIDTH , -- 
            POOL_DATA_BITS  => REGS_DATA_WIDTH , -- 
            TRAN_ADDR_BITS  => REGS_ADDR_WIDTH , -- 
            TRAN_SIZE_BITS  => XFER_MAX_SIZE+1 , --
            TRAN_SEL_BITS   => 1               , -- 
            BURST_LEN_BITS  => AXI4_ALEN_WIDTH , -- 
            ALIGNMENT_BITS  => ALIGNMENT_BITS  , --
            PULL_SIZE_BITS  => REGS_DATA_SIZE+1, --
            EXIT_SIZE_BITS  => REGS_DATA_SIZE+1, --
            POOL_PTR_BITS   => REGS_ADDR_WIDTH , --
            TRAN_MAX_SIZE   => XFER_MAX_SIZE   , --
            USE_BURST_SIZE  => 1               , --
            CHECK_BURST_LEN => 1               , -- 
            PORT_REGS_SIZE  => 0                 --
        )                                        -- 
        port map (                               -- 
        ---------------------------------------------------------------------------
        -- クロック&リセット信号
        ---------------------------------------------------------------------------
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
        ---------------------------------------------------------------------------
        -- Control Signals.
        ---------------------------------------------------------------------------
            TRAN_START      => xfer_start      , -- In  :
            TRAN_ADDR       => xfer_req_addr   , -- In  :
            TRAN_SIZE       => xfer_req_size   , -- In  :
            BURST_LEN       => burst_length    , -- In  :
            BURST_SIZE      => word_size       , -- In  :
            START_PTR       => xfer_req_addr   , -- In  :
            TRAN_LAST       => '1'             , -- In  :
            TRAN_SEL        => "1"             , -- In  :
            XFER_VAL        => open            , -- Out :
            XFER_DVAL       => xfer_beat_ben   , -- Out :
            XFER_LAST       => open            , -- Out :
            XFER_NONE       => xfer_beat_none  , -- Out :
        ---------------------------------------------------------------------------
        -- AXI4 Outlet Port Signals.
        ---------------------------------------------------------------------------
            PORT_DATA       => RDATA           , -- Out :
            PORT_STRB       => open            , -- Out :
            PORT_LAST       => RLAST           , -- Out :
            PORT_ERROR      => outlet_error    , -- Out :
            PORT_VAL        => RVALID          , -- Out :
            PORT_RDY        => RREADY          , -- In  :
        ---------------------------------------------------------------------------
        -- Pull Size Signals.
        ---------------------------------------------------------------------------
            PULL_VAL(0)     => xfer_beat_chop  , -- Out :
            PULL_LAST       => xfer_beat_last  , -- Out :
            PULL_XFER_LAST  => open            , -- Out :
            PULL_XFER_DONE  => open            , -- Out :
            PULL_ERROR      => xfer_beat_error , -- Out :
            PULL_SIZE       => xfer_beat_size  , -- Out :
        ---------------------------------------------------------------------------
        -- Outlet Size Signals.
        ---------------------------------------------------------------------------
            EXIT_VAL        => open            , -- Out :
            EXIT_LAST       => open            , -- Out :
            EXIT_XFER_LAST  => open            , -- Out :
            EXIT_XFER_DONE  => open            , -- Out :
            EXIT_ERROR      => open            , -- Out :
            EXIT_SIZE       => open            , -- Out :
        ---------------------------------------------------------------------------
        -- Pool Buffer Interface Signals.
        ---------------------------------------------------------------------------
            POOL_REN        => open            , -- Out :
            POOL_PTR        => open            , -- Out :
            POOL_ERROR      => REGS_ERR        , -- In  :
            POOL_DATA       => REGS_DATA       , -- In  :
            POOL_VAL        => xfer_beat_valid , -- In  :
            POOL_RDY        => xfer_beat_ready , -- Out :
        ---------------------------------------------------------------------------
        -- Status Signals.
        ---------------------------------------------------------------------------
            BUSY            => rbuf_busy         -- Out :
        );
    RID   <= identifier;
    RRESP <= AXI4_RESP_SLVERR when (outlet_error = '1') else AXI4_RESP_OKAY;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    axi4_register_write_interface.vhd
--!     @brief   AXI4 Register Write Interface
--!     @version 1.5.8
--!     @date    2015/9/20
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2015 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
-----------------------------------------------------------------------------------
--! @brief   AXI4 Register Write Interface.
-----------------------------------------------------------------------------------
entity  AXI4_REGISTER_WRITE_INTERFACE is
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 ライトアドレスチャネルのAWADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 WRITE DATA CHANNEL DATA WIDTH :
                          --! AXI4 ライトデータチャネルのWDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびライトレスポンスチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        REGS_ADDR_WIDTH : --! @brief REGISTER ADDRESS WIDTH :
                          --! レジスタアクセスインターフェースのアドレスのビット幅
                          --! を指定する.
                          integer := 32;
        REGS_DATA_WIDTH : --! @brief REGISTER DATA WIDTH :
                          --! レジスタアクセスインターフェースのデータのビット幅を
                          --! 指定する.
                          integer := 32
    );
    port(
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Write Address Channel Signals.
    -------------------------------------------------------------------------------
        AWID            : --! @brief Write address ID.
                          --! This signal is identification tag for the write
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        AWADDR          : --! @brief Write address.  
                          --! The read address gives the address of the first
                          --! transfer in a write burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        AWLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        AWSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        AWBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        AWVALID         : --! @brief Write address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        AWREADY         : --! @brief Write address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Write Data Channel Signals.
    -------------------------------------------------------------------------------
        WDATA           : --! @brief Write data.
                          in    std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        WSTRB           : --! @brief Write strobes.
                          --! This signal indicates which byte lanes holdvalid 
                          --! data. There is one write strobe bit for each eight
                          --! bits of the write data bus.
                          in    std_logic_vector(AXI4_DATA_WIDTH/8-1 downto 0);
        WLAST           : --! @brief Write last.
                          --! This signal indicates the last transfer in a write burst.
                          in    std_logic;
        WVALID          : --! @brief Write valid.
                          --! This signal indicates that valid write data and
                          --! strobes are available.
                          in    std_logic;
        WREADY          : --! @brief Write ready.
                          --! This signal indicates that the slave can accept the
                          --! write data.
                          out   std_logic;
    -------------------------------------------------------------------------------
    -- AXI4 Write Response Channel Signals.
    -------------------------------------------------------------------------------
        BID             : --! @brief Response ID tag.
                          --! This signal is the identification tag of write
                          --! response .
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        BRESP           : --! @brief Write response.
                          --! This signal indicates the status of the write transaction.
                          out   AXI4_RESP_TYPE;
        BVALID          : --! @brief Write response valid.
                          --! This signal indicates that the channel is signaling
                          --! a valid write response.
                          out   std_logic;
        BREADY          : --! @brief Write response ready.
                          --! This signal indicates that the master can accept a
                          --! write response.
                          in    std_logic;
    -------------------------------------------------------------------------------
    -- Register Write Interface.
    -------------------------------------------------------------------------------
        REGS_REQ        : --! @brief レジスタアクセス要求信号.
                          --! レジスタアクセス要求時にアサートされる.
                          --! REGS_ACK 信号がアサートされるまで、この信号はアサー
                          --! トされたまま.
                          out std_logic;
        REGS_ACK        : --! @brief レジスタアクセス応答信号.
                          in  std_logic;
        REGS_ERR        : --! @brief レジスタアクセスエラー信号.
                          --! エラーが発生した時にREGS_ACK信号と共にアサートする.
                          in  std_logic;
        REGS_ADDR       : --! @brief レジスタアドレス信号.
                          out std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
        REGS_BEN        : --! @brief バイトイネーブル信号.
                          out std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
        REGS_DATA       : --! @brief レジスタライトデータ出力信号.
                          out std_logic_vector(REGS_DATA_WIDTH  -1 downto 0)
    );
end AXI4_REGISTER_WRITE_INTERFACE;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
use     PIPEWORK.COMPONENTS.REDUCER;
architecture RTL of AXI4_REGISTER_WRITE_INTERFACE is
    -------------------------------------------------------------------------------
    -- データバスのバイト数の２のべき乗値を計算する関数.
    -------------------------------------------------------------------------------
    function CALC_DATA_SIZE(WIDTH:integer) return integer is
        variable value : integer;
    begin
        value := 0;
        while (2**(value+3) < WIDTH) loop
            value := value + 1;
        end loop;
        return value;
    end function;
    -------------------------------------------------------------------------------
    -- AXI4 データバスのバイト数の２のべき乗値.
    -------------------------------------------------------------------------------
    constant AXI4_DATA_SIZE     : integer := CALC_DATA_SIZE(AXI4_DATA_WIDTH);
    -------------------------------------------------------------------------------
    -- レジスタインターフェース側のデータバスのバイト数の２のべき乗値.
    -------------------------------------------------------------------------------
    constant REGS_DATA_SIZE     : integer := CALC_DATA_SIZE(REGS_DATA_WIDTH);
    -------------------------------------------------------------------------------
    -- 内部信号
    -------------------------------------------------------------------------------
    signal   xfer_req_addr      : std_logic_vector(REGS_ADDR_WIDTH-1 downto 0);
    signal   wbuf_enable        : std_logic;
    signal   wbuf_intake        : std_logic;
    signal   wbuf_busy          : std_logic;
    signal   wbuf_valid         : std_logic;
    signal   wbuf_ready         : std_logic;
    signal   wbuf_start         : std_logic;
    signal   wbuf_offset        : std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
    constant wbuf_shift         : std_logic_vector(REGS_DATA_WIDTH/8   downto REGS_DATA_WIDTH/8) := "0";
    constant wbuf_flush         : std_logic := '0';
    constant wbuf_done          : std_logic := '0';
    constant regs_enable        : std_logic := '1';
    signal   regs_valid         : std_logic;
    signal   regs_ready         : std_logic;
    signal   regs_last          : std_logic;
    signal   burst_type         : AXI4_ABURST_TYPE;
    type     STATE_TYPE        is (IDLE, XFER_DATA, SKIP_ERR, RESP_ERR, RESP_OK);
    signal   curr_state         : STATE_TYPE;
begin
    -------------------------------------------------------------------------------
    -- ステートマシン
    -------------------------------------------------------------------------------
    process (CLK, RST)
        variable next_state : STATE_TYPE;
    begin
        if (RST = '1') then
                curr_state  <= IDLE;
                AWREADY     <= '0';
                BVALID      <= '0';
                BRESP       <= AXI4_RESP_OKAY;
                BID         <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then 
                curr_state  <= IDLE;
                AWREADY     <= '0';
                BVALID      <= '0';
                BRESP       <= AXI4_RESP_OKAY;
                BID         <= (others => '0');
            else
                case curr_state is
                    when IDLE =>
                        if (AWVALID = '1') then
                            next_state := XFER_DATA;
                        else
                            next_state := IDLE;
                        end if;
                    when XFER_DATA =>
                        if (regs_valid = '1' and REGS_ACK = '1') then
                            if    (regs_last = '1' and REGS_ERR = '1') then
                                next_state := RESP_ERR;
                            elsif (regs_last = '1' and REGS_ERR = '0') then
                                next_state := RESP_OK;
                            elsif (regs_last = '0' and REGS_ERR = '1') then
                                next_state := SKIP_ERR;
                            else
                                next_state := XFER_DATA;
                            end if;
                        else
                                next_state := XFER_DATA;
                        end if;
                    when SKIP_ERR =>
                        if (regs_valid = '1' and regs_last = '1') then
                            next_state := RESP_ERR;
                        else
                            next_state := SKIP_ERR;
                        end if;
                    when RESP_ERR =>
                        if (BREADY = '1') then
                            next_state := IDLE;
                        else
                            next_state := RESP_ERR;
                        end if;
                    when RESP_OK  =>
                        if (BREADY = '1') then
                            next_state := IDLE;
                        else
                            next_state := RESP_OK;
                        end if;
                    when others =>
                            next_state := IDLE;
                end case;
                curr_state <= next_state;
                if (next_state = IDLE) then
                    AWREADY <= '1';
                else
                    AWREADY <= '0';
                end if;
                if (next_state = RESP_OK or next_state = RESP_ERR) then
                    BVALID  <= '1';
                else
                    BVALID  <= '0';
                end if;
                if (next_state = RESP_ERR) then
                    BRESP   <= AXI4_RESP_SLVERR;
                else
                    BRESP   <= AXI4_RESP_OKAY;
                end if;
                if (curr_state = IDLE and AWVALID = '1') then
                    BID     <= AWID;
                end if;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- アドレスカウンタ
    -------------------------------------------------------------------------------
    process (CLK, RST)
        variable temp_addr : unsigned(xfer_req_addr'range);
    begin
        if (RST = '1') then
                xfer_req_addr  <= (others => '0');
                burst_type <= AXI4_ABURST_FIXED;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then 
                xfer_req_addr  <= (others => '0');
                burst_type <= AXI4_ABURST_FIXED;
            elsif (curr_state = IDLE and AWVALID = '1') then
                for i in xfer_req_addr'range loop
                    if (AWADDR'low <= i and i <= AWADDR'high) then
                        xfer_req_addr(i) <= AWADDR(i);
                    else
                        xfer_req_addr(i) <= '0';
                    end if;
                end loop;
                burst_type <= AWBURST;
            elsif (burst_type = AXI4_ABURST_INCR and
                   regs_valid = '1' and regs_ready = '1') then
                for i in xfer_req_addr'range loop
                    if (i >= REGS_DATA_SIZE) then
                        temp_addr(i) := xfer_req_addr(i);
                    else
                        temp_addr(i) := '0';
                    end if;
                end loop;
                xfer_req_addr <= std_logic_vector(temp_addr + 2**REGS_DATA_SIZE);
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    REGS_ADDR   <= xfer_req_addr;
    REGS_REQ    <= '1' when (curr_state = XFER_DATA and regs_valid = '1') else '0';
    regs_ready  <= '1' when (curr_state = XFER_DATA and REGS_ACK   = '1') or
                            (curr_state = SKIP_ERR                      ) else '0';
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                wbuf_intake <= '0';
        elsif (CLK'event and CLK = '1') then
            if    (CLR = '1') then
                wbuf_intake <= '0';
            elsif (wbuf_start = '1') then
                wbuf_intake <= '1';
            elsif (curr_state = IDLE) or
                  (WVALID = '1' and WLAST = '1' and wbuf_ready = '1') then
                wbuf_intake <= '0';
            end if;
        end if;
    end process;
    wbuf_start  <= '1' when (curr_state = IDLE and AWVALID = '1' ) else '0';
    wbuf_enable <= '1' when (wbuf_start = '1' or wbuf_intake ='1') else '0';
    -------------------------------------------------------------------------------
    -- wbuf_offset : 
    -------------------------------------------------------------------------------
    process (AWADDR)
        variable addr : unsigned(REGS_DATA_SIZE downto 0);
    begin
        for i in addr'range loop
            if (i < REGS_DATA_SIZE and AWADDR(i) = '1') then
                addr(i) := '1';
            else
                addr(i) := '0';
            end if;
        end loop;
        for i in wbuf_offset'range loop
            if (i < addr) then
                wbuf_offset(i) <= '1';
            else
                wbuf_offset(i) <= '0';
            end if;
        end loop;
    end process;
    -------------------------------------------------------------------------------
    -- ライトデータバッファ
    -------------------------------------------------------------------------------
    WBUF: REDUCER                                  -- 
        generic map (                              -- 
            WORD_BITS       => 8                 , -- 
            STRB_BITS       => 1                 , -- 
            I_WIDTH         => AXI4_DATA_WIDTH/8 , -- 
            O_WIDTH         => REGS_DATA_WIDTH/8 , -- 
            QUEUE_SIZE      => 0                 , -- 
            VALID_MIN       => 0                 , -- 
            VALID_MAX       => 0                 , -- 
            O_VAL_SIZE      => REGS_DATA_WIDTH/8 , -- 
            O_SHIFT_MIN     => wbuf_shift'low    , -- 
            O_SHIFT_MAX     => wbuf_shift'high   , -- 
            I_JUSTIFIED     => 0                 , -- 
            FLUSH_ENABLE    => 0                   -- 
        )                                          -- 
        port map (                                 -- 
        ---------------------------------------------------------------------------
        -- クロック&リセット信号
        ---------------------------------------------------------------------------
            CLK             => CLK               , -- In  :
            RST             => RST               , -- In  :
            CLR             => CLR               , -- In  :
        ---------------------------------------------------------------------------
        -- 各種制御信号
        ---------------------------------------------------------------------------
            START           => wbuf_start        , -- In  :
            OFFSET          => wbuf_offset       , -- In  :
            DONE            => wbuf_done         , -- In  :
            FLUSH           => wbuf_flush        , -- In  :
            BUSY            => wbuf_busy         , -- Out :
            VALID           => open              , -- Out :
        ---------------------------------------------------------------------------
        -- 入力側 I/F
        ---------------------------------------------------------------------------
            I_ENABLE        => wbuf_enable       , -- In  :
            I_DATA          => WDATA             , -- In  :
            I_STRB          => WSTRB             , -- In  :
            I_DONE          => WLAST             , -- In  :
            I_FLUSH         => wbuf_flush        , -- In  :
            I_VAL           => WVALID            , -- In  :
            I_RDY           => wbuf_ready        , -- Out :
        ---------------------------------------------------------------------------
        -- 出力側 I/F
        ---------------------------------------------------------------------------
            O_ENABLE        => regs_enable       , -- In  :
            O_DATA          => REGS_DATA         , -- Out :
            O_STRB          => REGS_BEN          , -- Out :
            O_DONE          => regs_last         , -- Out :
            O_FLUSH         => open              , -- Out :
            O_VAL           => regs_valid        , -- Out :
            O_RDY           => regs_ready        , -- In  :
            O_SHIFT         => wbuf_shift          -- In  :
    );
    WREADY <= wbuf_ready;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    queue_arbiter.vhd
--!     @brief   QUEUE ARBITER MODULE :
--!              キュータイプの調停回路
--!     @version 1.0.0
--!     @date    2012/8/11
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   QUEUE ARBITER :
--!          キュー(ファーストインファーストアウト)方式の調停回路.
--!        * 要求を到着順に許可することを特徴とする調停回路.
--!        * キュー方式が他の一般的な固定優先順位方式やラウンドロビン方式に比べて
--!          有利な点は次の二つ.
--!          * 必ず要求はいつかは許可されることが保証されている.
--!            固定優先順位方式の場合、場合によっては永久に要求が許可されることが
--!            ないことが起り得るが、キュー方式はそれがない.
--!          * 要求された順番が変わることがない.
--!            用途によっては順番が変わることで誤動作する場合があるが、
--!            キュー方式ではそれに対応できる.
--!        * 一般的な固定優先順位方式やラウンドロビン方式の調停回路と異なり、
--!          要求が到着した順番を記録しているため、
--!          回路規模は他の方式に比べて大きい傾向がある.
-----------------------------------------------------------------------------------
entity  QUEUE_ARBITER is
    generic (
        MIN_NUM     : --! @brief REQUEST MINIMUM NUMBER :
                      --! リクエストの最小番号を指定する.
                      integer := 0;
        MAX_NUM     : --! @brief REQUEST MAXIMUM NUMBER :
                      --! リクエストの最大番号を指定する.
                      integer := 7
    );
    port (
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
        ENABLE      : --! @brief ARBITORATION ENABLE :
                      --! この調停回路を有効にするかどうかを指定する.
                      --! * 幾つかの調停回路を組み合わせて使う場合、設定によっては
                      --!  この調停回路の出力を無効にしたいことがある.
                      --!  その時はこの信号を'0'にすることで簡単に出来る.
                      --! * ENABLE='1'でこの回路は調停を行う.
                      --! * ENABLE='0'でこの回路は調停を行わない.
                      --!   この場合REQUEST信号に関係なREQUEST_OおよびGRANTは'0'になる.
                      --!   リクエストキューの中身は破棄される.
                      in  std_logic := '1';
        REQUEST     : --! @brief REQUEST INPUT :
                      --! リクエスト入力.
                      in  std_logic_vector(MIN_NUM to MAX_NUM);
        GRANT       : --! @brief GRANT OUTPUT :
                      --! 調停結果出力.
                      out std_logic_vector(MIN_NUM to MAX_NUM);
        GRANT_NUM   : --! @brief GRANT NUMBER :
                      --! 許可番号.
                      --! * ただしリクエストキューに次の要求が無い場合でも、
                      --!   なんらかの番号を出力してしまう.
                      out integer   range  MIN_NUM to MAX_NUM;
        REQUEST_O   : --! @brief REQUEST OUTOUT :
                      --! リクエストキューに次の要求があることを示す信号.
                      --! * VALIDと異なり、リクエストキューに次の要求があっても、
                      --!   対応するREQUEST信号が'0'の場合はアサートされない.
                      out std_logic;
        VALID       : --! @brief REQUEST QUEUE VALID :
                      --! リクエストキューに次の要求があることを示す信号.
                      --! * REQUEST_Oと異なり、リスエストキューに次の要求があると
                      --!   対応するREQUEST信号の状態に関わらずアサートされる.
                      out std_logic;
        SHIFT       : --! @brief REQUEST QUEUE SHIFT :
                      --! リクエストキューの先頭からリクエストを取り除く信号.
                      in  std_logic
    );
end     QUEUE_ARBITER;
-----------------------------------------------------------------------------------
--!     @file    register_access_decoder.vhd
--!     @brief   REGISTER ACCESS DECODER MODULE :
--!              レジスタアクセスデコーダ.
--!     @version 1.5.5
--!     @date    2014/3/13
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2014 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   REGISTER ACCESS DECODER MODULE 
-----------------------------------------------------------------------------------
entity  REGISTER_ACCESS_DECODER is
    generic (
        ADDR_WIDTH  : --! @brief REGISTER ADDRESS WIDTH :
                      --! レジスタアクセスインターフェースのアドレスのビット幅を指
                      --! 定する.
                      integer := 8;
        DATA_WIDTH  : --! @brief REGISTER DATA WIDTH :
                      --! レジスタアクセスインターフェースのデータのビット幅を指定
                      --! する.
                      integer := 32;
        WBIT_MIN    : --! @brief REGISTER WRITE BIT MIN INDEX :
                      integer := 0;
        WBIT_MAX    : --! @brief REGISTER WRITE BIT MAX INDEX :
                      integer := (2**8)*8-1;
        RBIT_MIN    : --! @brief REGISTER READ  BIT MIN INDEX :
                      integer := 0;
        RBIT_MAX    : --! @brief REGISTER READ  BIT MAX INDEX :
                      integer := (2**8)*8-1
    );
    port (
    -------------------------------------------------------------------------------
    -- 入力側のレジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        REGS_REQ    : --! @brief REGISTER ACCESS REQUEST :
                      --! レジスタアクセス要求信号.
                      in  std_logic;
        REGS_WRITE  : --! @brief REGISTER WRITE ACCESS :
                      --! レジスタライトアクセス信号.
                      --! * この信号が'1'の時はライトアクセスを行う.
                      --! * この信号が'0'の時はリードアクセスを行う.
                      in  std_logic;
        REGS_ADDR   : --! @brief REGISTER ACCESS ADDRESS :
                      --! レジスタアクセスアドレス信号.
                      in  std_logic_vector(ADDR_WIDTH  -1 downto 0);
        REGS_BEN    : --! @brief REGISTER BYTE ENABLE :
                      --! レジスタアクセスバイトイネーブル信号.
                      in  std_logic_vector(DATA_WIDTH/8-1 downto 0);
        REGS_WDATA  : --! @brief REGISTER ACCESS WRITE DATA :
                      --! レジスタアクセスライトデータ.
                      in  std_logic_vector(DATA_WIDTH  -1 downto 0);
        REGS_RDATA  : --! @brief REGISTER ACCESS READ DATA :
                      --! レジスタアクセスリードデータ.
                      out std_logic_vector(DATA_WIDTH  -1 downto 0);
        REGS_ACK    : --! @brief REGISTER ACCESS ACKNOWLEDGE :
                      --! レジスタアクセス応答信号.
                      out std_logic;
        REGS_ERR    : --! @brief REGISTER ACCESS ERROR ACKNOWLEDGE :
                      --! レジスタアクセスエラー応答信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- レジスタライトデータ/ロード出力
    -------------------------------------------------------------------------------
        W_DATA      : out std_logic_vector(WBIT_MAX downto WBIT_MIN);
        W_LOAD      : out std_logic_vector(WBIT_MAX downto WBIT_MIN);
    -------------------------------------------------------------------------------
    -- レジスタリードデータ入力
    -------------------------------------------------------------------------------
        R_DATA      : in  std_logic_vector(RBIT_MAX downto RBIT_MIN)
    );
end REGISTER_ACCESS_DECODER;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
architecture RTL of REGISTER_ACCESS_DECODER is
    constant BYTE_BITS  : natural := 8;
    constant WORD_BYTES : natural := DATA_WIDTH/BYTE_BITS;
    function min(L,R:integer) return integer is begin
        if (L > R) then return R;
        else            return L;
        end if;
    end function;
    function max(L,R:integer) return integer is begin
        if (L > R) then return L;
        else            return R;
        end if;
    end function;
    constant W_POS_LO   : natural := (WBIT_MIN)/DATA_WIDTH;
    constant W_POS_HI   : natural := (WBIT_MAX)/DATA_WIDTH;
    constant R_POS_LO   : natural := (RBIT_MIN)/DATA_WIDTH;
    constant R_POS_HI   : natural := (RBIT_MAX)/DATA_WIDTH;
    constant A_POS_LO   : natural := min(R_POS_LO,W_POS_LO);
    constant A_POS_HI   : natural := max(R_POS_HI,W_POS_HI);
    signal   addr_hit   : std_logic_vector(A_POS_HI downto A_POS_LO);
    signal   word_wen   : std_logic_vector(DATA_WIDTH-1 downto 0);
begin
    -------------------------------------------------------------------------------
    -- addr_hit   : 
    -------------------------------------------------------------------------------
    process (REGS_ADDR)
        variable byte_addr : unsigned(ADDR_WIDTH-1 downto 0);
    begin
        byte_addr := to_01(unsigned(REGS_ADDR));
        for word_pos in addr_hit'range loop
            if (word_pos = byte_addr/WORD_BYTES) then
                addr_hit(word_pos) <= '1';
            else
                addr_hit(word_pos) <= '0';
            end if;
        end loop;
    end process;
    -------------------------------------------------------------------------------
    -- word_wen   : 
    -------------------------------------------------------------------------------
    process (REGS_REQ, REGS_WRITE, REGS_BEN) begin
        if (REGS_REQ = '1' and REGS_WRITE = '1') then
            for i in 0 to DATA_WIDTH/8-1 loop
                if (REGS_BEN(i) = '1') then
                    word_wen(8*(i+1)-1 downto 8*i) <= (8*(i+1)-1 downto 8*i => '1');
                else
                    word_wen(8*(i+1)-1 downto 8*i) <= (8*(i+1)-1 downto 8*i => '0');
                end if;
            end loop;
        else
            word_wen <= (others => '0');
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- W_DATA     :
    -------------------------------------------------------------------------------
    process (REGS_WDATA) begin
        for i in W_POS_LO to W_POS_HI loop
            for n in 0 to DATA_WIDTH-1 loop
                if (W_DATA'low <= DATA_WIDTH*i+n and DATA_WIDTH*i+n <= W_DATA'high) then
                    W_DATA(DATA_WIDTH*i+n) <= REGS_WDATA(n);
                end if;
            end loop;
        end loop;
    end process;
    -------------------------------------------------------------------------------
    -- W_LOAD     :
    -------------------------------------------------------------------------------
    process (addr_hit, word_wen) begin
        for i in W_POS_LO to W_POS_HI loop
            if (addr_hit(i) = '1') then
                for n in 0 to DATA_WIDTH-1 loop
                    if (W_LOAD'low <= DATA_WIDTH*i+n and DATA_WIDTH*i+n <= W_LOAD'high) then
                        W_LOAD(DATA_WIDTH*i+n) <= word_wen(n);
                    end if;
                end loop;
            else
                for n in 0 to DATA_WIDTH-1 loop
                    if (W_LOAD'low <= DATA_WIDTH*i+n and DATA_WIDTH*i+n <= W_LOAD'high) then
                        W_LOAD(DATA_WIDTH*i+n) <= '0';
                    end if;
                end loop;
            end if;
        end loop;
    end process;
    -------------------------------------------------------------------------------
    -- REGS_RDATA :
    -------------------------------------------------------------------------------
    process (R_DATA, addr_hit)
        type     WORD_VEC_TYPE is array(DATA_WIDTH-1 downto 0)
                               of std_logic_vector(R_POS_HI downto R_POS_LO);
        variable word_vec      :  WORD_VEC_TYPE;
        function or_reduce_tree(A:std_logic_vector) return std_logic is
            alias V : std_logic_vector(A'length-1 downto 0) is A;
        begin
            if    (V'length < 1) then
                return '0';
            elsif (V'length = 1) then
                return V(0);
            elsif (V'length = 2) then
                return V(0) or V(1);
            elsif (V'length = 3) then
                return V(0) or V(1) or V(2);
            else
                return or_reduce_tree(V(V'length/2-1 downto V'low     ))
                    or or_reduce_tree(V(V'high       downto V'length/2));
            end if;
        end function;
    begin
        for i in R_POS_LO to R_POS_HI loop
            for n in DATA_WIDTH-1 downto 0 loop
                if (addr_hit(i) = '1') and 
                   (R_DATA'low <= DATA_WIDTH*i+n and DATA_WIDTH*i+n <= R_DATA'high) then
                    word_vec(n)(i) := R_DATA(DATA_WIDTH*i+n);
                else
                    word_vec(n)(i) := '0';
                end if;
            end loop;
        end loop;
        for n in DATA_WIDTH-1 downto 0 loop
            REGS_RDATA(n) <= or_reduce_tree(word_vec(n));
        end loop;
    end process;
    -------------------------------------------------------------------------------
    -- REGS_ACK   :
    -- REGS_ERR   :
    -------------------------------------------------------------------------------
    REGS_ACK <= REGS_REQ;
    REGS_ERR <= '0';
end RTL;
-----------------------------------------------------------------------------------
--!     @file    register_access_syncronizer.vhd
--!     @brief   REGISTER ACCESS SYNCRONIZER MODULE :
--!              異なるクロックドメイン間でレジスタアクセスを中継するモジュール.
--!     @version 1.5.5
--!     @date    2014/3/20
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2014 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   REGISTER ACCESS SYNCRONIZER MODULE 
--!          異なるクロックドメイン間でレジスタアクセスを中継するモジュール.
--!        * 入力側のクロック(I_CLK)に同期化された入力データを 
--!          出力側クロック(O_CLK)に同期化して出力する.
--!        * 入力側のクロック(I_CLK)と出力側のクロック(O_CLK)との関係は、
--!          ジェネリック変数I_CLK_RATEとO_CLK_RATEで指示する.
--!          詳細は O_CLK_RATE を参照.
-----------------------------------------------------------------------------------
entity  REGISTER_ACCESS_SYNCRONIZER is
    generic (
        ADDR_WIDTH  : --! @brief REGISTER ADDRESS WIDTH :
                      --! レジスタアクセスインターフェースのアドレスのビット幅を指
                      --! 定する.
                      integer := 32;
        DATA_WIDTH  : --! @brief REGISTER DATA WIDTH :
                      --! レジスタアクセスインターフェースのデータのビット幅を指定
                      --! する.
                      integer := 32;
        I_CLK_RATE  : --! @brief INPUT CLOCK RATE :
                      --! O_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する. 
                      --! 詳細は PipeWork.Components の SYNCRONIZER を参照.
                      integer :=  1;
        O_CLK_RATE  : --! @brief OUTPUT CLOCK RATE :
                      --! I_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する.
                      --! 詳細は PipeWork.Components の SYNCRONIZER を参照.
                      integer :=  1;
        O_CLK_REGS  : --! @brief REGISTERD OUTPUT :
                      --! 出力側の各種信号(O_REQ/O_WRITE/O_WDATA/O_BEN)をレジスタ
                      --! 出力するかどうかを指定する.
                      --! * この変数は I_CLK_RATE > 0 の場合のみ有効. 
                      --!   I_CLK_RATE = 0 の場合は、常にレジスタ出力になる.
                      --! * O_CLK_REGS = 0 の場合はレジスタ出力しない.
                      --! * O_CLK_REGS = 1 の場合はレジスタ出力する.
                      integer range 0 to 1 :=  0
    );
    port (
    -------------------------------------------------------------------------------
    -- リセット信号
    -------------------------------------------------------------------------------
        RST         : --! @brief RESET :
                      --! 非同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        I_CLK       : --! @brief INPUT CLOCK :
                      --! 入力側のクロック信号.
                      in  std_logic;
        I_CLR       : --! @brief INPUT CLEAR :
                      --! 入力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
        I_CKE       : --! @brief INPUT CLOCK ENABLE :
                      --! 入力側のクロック(I_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とOCLKの立上り時が同じ時にアサートするよ
                      --!   うに入力されなければならない.
                      --! * この信号は I_CLK_RATE > 1 かつ O_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- 入力側のレジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        I_REQ       : --! @brief INPUT REGISTER ACCESS REQUEST :
                      --! レジスタアクセス要求信号.
                      in  std_logic;
        I_SEL       : --! @brief INPUT REGISTER ACCESS SELECT :
                      --! レジスタアクセス選択信号.
                      --! * I_REQ='1'の際、この信号が'1'の時にのみレジスタアクセス
                      --!   を開始する.
                      in  std_logic := '1';
        I_WRITE     : --! @brief INPUT REGISTER WRITE ACCESS :
                      --! レジスタライトアクセス信号.
                      --! * この信号が'1'の時はライトアクセスを行う.
                      --! * この信号が'0'の時はリードアクセスを行う.
                      in  std_logic;
        I_ADDR      : --! @brief INPUT REGISTER ACCESS ADDRESS :
                      --! レジスタアクセスアドレス信号.
                      in  std_logic_vector(ADDR_WIDTH  -1 downto 0);
        I_BEN       : --! @brief INPUT REGISTER BYTE ENABLE :
                      --! レジスタアクセスバイトイネーブル信号.
                      in  std_logic_vector(DATA_WIDTH/8-1 downto 0);
        I_WDATA     : --! @brief INPUT REGISTER ACCESS WRITE DATA :
                      --! レジスタアクセスライトデータ.
                      in  std_logic_vector(DATA_WIDTH  -1 downto 0);
        I_RDATA     : --! @brief INPUT REGISTER ACCESS READ DATA :
                      --! レジスタアクセスリードデータ.
                      out std_logic_vector(DATA_WIDTH  -1 downto 0);
        I_ACK       : --! @brief INPUT REGISTER ACCESS ACKNOWLEDGE :
                      --! レジスタアクセス応答信号.
                      out std_logic;
        I_ERR       : --! @brief INPUT REGISTER ACCESS ERROR ACKNOWLEDGE :
                      --! レジスタアクセスエラー応答信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        O_CLK       : --! @brief OUTPUT CLK :
                      --! 出力側のクロック信号.
                      in  std_logic;
        O_CLR       : --! @brief OUTPUT CLEAR :
                      --! 出力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
        O_CKE       : --! @brief OUTPUT CLOCK ENABLE :
                      --! 出力側のクロック(O_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とO_CLKの立上り時が同じ時にアサートする
                      --!   ように入力されなければならない.
                      --! * この信号は O_CLK_RATE > 1 かつ I_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- 出力側のレジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        O_REQ       : --! @brief OUTNPUT REGISTER ACCESS REQUEST :
                      --! レジスタアクセス要求信号.
                      out std_logic;
        O_WRITE     : --! @brief OUTPUT REGISTER WRITE ACCESS :
                      --! レジスタライトアクセス信号.
                      --! * この信号が'1'の時はライトアクセスを行う.
                      --! * この信号が'0'の時はリードアクセスを行う.
                      out std_logic;
        O_ADDR      : --! @brief OUTPUT REGISTER ACCESS ADDRESS :
                      --! レジスタアクセスアドレス信号.
                      out std_logic_vector(ADDR_WIDTH  -1 downto 0);
        O_BEN       : --! @brief OUTPUT REGISTER BYTE ENABLE :
                      --! レジスタアクセスバイトイネーブル信号.
                      out std_logic_vector(DATA_WIDTH/8-1 downto 0);
        O_WDATA     : --! @brief OUTPUT REGISTER ACCESS WRITE DATA :
                      --! レジスタアクセスライトデータ.
                      out std_logic_vector(DATA_WIDTH  -1 downto 0);
        O_RDATA     : --! @brief OUTPUT REGISTER ACCESS READ DATA :
                      --! レジスタアクセスリードデータ.
                      in  std_logic_vector(DATA_WIDTH  -1 downto 0);
        O_ACK       : --! @brief OUTPUT REGISTER ACCESS ACKNOWLEDGE :
                      --! レジスタアクセス応答信号.
                      in  std_logic;
        O_ERR       : --! @brief OUTPUT REGISTER ACCESS ERROR ACKNOWLEDGE :
                      --! レジスタアクセスエラー応答信号.
                      in  std_logic
    );
end REGISTER_ACCESS_SYNCRONIZER;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library PIPEWORK;
use     PIPEWORK.COMPONENTS.SYNCRONIZER;
use     PIPEWORK.COMPONENTS.SYNCRONIZER_INPUT_PENDING_REGISTER;
architecture RTL of REGISTER_ACCESS_SYNCRONIZER is
    constant  I2O_WDATA_LO  :  integer := 0;
    constant  I2O_WDATA_HI  :  integer := I2O_WDATA_LO  + DATA_WIDTH   - 1;
    constant  I2O_BEN_LO    :  integer := I2O_WDATA_HI  + 1;
    constant  I2O_BEN_HI    :  integer := I2O_BEN_LO    + DATA_WIDTH/8 - 1;
    constant  I2O_ADDR_LO   :  integer := I2O_BEN_HI    + 1;
    constant  I2O_ADDR_HI   :  integer := I2O_ADDR_LO   + ADDR_WIDTH   - 1;
    constant  I2O_WRITE_POS :  integer := I2O_ADDR_HI   + 1;
    constant  I2O_BITS      :  integer := I2O_WRITE_POS - I2O_WDATA_LO + 1;
    signal    i2o_i_data    :  std_logic_vector(I2O_BITS-1 downto 0);
    signal    i2o_i_valid   :  std_logic;
    signal    i2o_i_ready   :  std_logic;
    signal    i2o_o_data    :  std_logic_vector(I2O_BITS-1 downto 0);
    signal    i2o_o_valid   :  std_logic;
    signal    o2i_i_rdata   :  std_logic_vector(DATA_WIDTH-1 downto 0);
    signal    o2i_i_valid   :  std_logic_vector(1 downto 0);
    signal    o2i_i_ready   :  std_logic;
    signal    o2i_o_rdata   :  std_logic_vector(DATA_WIDTH-1 downto 0);
    signal    o2i_o_valid   :  std_logic_vector(1 downto 0);
begin
    -------------------------------------------------------------------------------
    -- 入力側の制御回路
    -------------------------------------------------------------------------------
    I: block
        type     STATE_TYPE  is (IDLE_STATE, REQ_STATE, RUN_STATE);
        signal   curr_state  :  STATE_TYPE;
        signal   next_state  :  STATE_TYPE;
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (curr_state, I_REQ, I_SEL, i2o_i_ready, o2i_o_valid)
            variable request     : boolean;
            variable acknowledge : boolean;
        begin
            request     := (I_REQ = '1' and I_SEL = '1');
            acknowledge := (o2i_o_valid(0) = '1' or o2i_o_valid(1) = '1');
            case curr_state is
                when IDLE_STATE =>
                    if (request = TRUE) then
                        if    (acknowledge = TRUE) then
                            next_state <= IDLE_STATE;
                        elsif (i2o_i_ready = '1') then
                            next_state <= RUN_STATE;
                        else
                            next_state <= REQ_STATE;
                        end if;
                        i2o_i_valid <= '1';
                    else
                        next_state  <= IDLE_STATE;
                        i2o_i_valid <= '0';
                    end if;
                when REQ_STATE =>
                        if    (acknowledge = TRUE) then
                            next_state <= IDLE_STATE;
                        elsif (i2o_i_ready = '1' ) then
                            next_state <= RUN_STATE;
                        else
                            next_state <= REQ_STATE;
                        end if;
                        i2o_i_valid <= '1';
                when RUN_STATE =>
                        if    (acknowledge = TRUE) then
                            next_state <= IDLE_STATE;
                        else
                            next_state <= RUN_STATE;
                        end if;
                        i2o_i_valid <= '0';
                when others  =>
                        next_state  <= IDLE_STATE;
                        i2o_i_valid <= '0';
            end case;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (I_CLK, RST) begin
            if (RST = '1') then
                    curr_state <= IDLE_STATE;
            elsif (I_CLK'event and I_CLK = '1') then
                if (I_CLR = '1') then
                    curr_state <= IDLE_STATE;
                else
                    curr_state <= next_state;
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        i2o_i_data(I2O_WDATA_HI downto I2O_WDATA_LO) <= I_WDATA;
        i2o_i_data(I2O_BEN_HI   downto I2O_BEN_LO  ) <= I_BEN;
        i2o_i_data(I2O_ADDR_HI  downto I2O_ADDR_LO ) <= I_ADDR;
        i2o_i_data(I2O_WRITE_POS                   ) <= I_WRITE;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        I_RDATA <= o2i_o_rdata    when (I_SEL = '1') else (others => '0');
        I_ACK   <= o2i_o_valid(0) when (I_SEL = '1') else '0';
        I_ERR   <= o2i_o_valid(1) when (I_SEL = '1') else '0';
    end block;
    -------------------------------------------------------------------------------
    -- 入力側から出力側への同期回路
    -------------------------------------------------------------------------------
    I2O: SYNCRONIZER                     -- 
        generic map (                    -- 
            DATA_BITS   => I2O_BITS    , -- 
            VAL_BITS    => 1           , -- 
            I_CLK_RATE  => I_CLK_RATE  , -- 
            O_CLK_RATE  => O_CLK_RATE  , -- 
            I_CLK_FLOP  => 1           , -- 
            O_CLK_FLOP  => 1           , -- 
            I_CLK_FALL  => 0           , -- 
            O_CLK_FALL  => 0           , -- 
            O_CLK_REGS  => O_CLK_REGS    -- 
        )                                -- 
        port map (                       -- 
            RST         => RST         , -- In  :
            I_CLK       => I_CLK       , -- In  :
            I_CLR       => I_CLR       , -- In  :
            I_CKE       => I_CKE       , -- In  :
            I_DATA      => i2o_i_data  , -- In  :
            I_VAL(0)    => i2o_i_valid , -- In  :
            I_RDY       => i2o_i_ready , -- Out :
            O_CLK       => O_CLK       , -- In  :
            O_CLR       => O_CLR       , -- In  :
            O_CKE       => O_CKE       , -- In  :
            O_DATA      => i2o_o_data  , -- Out :
            O_VAL(0)    => i2o_o_valid   -- Out :
        );
    -------------------------------------------------------------------------------
    -- 出力側から入力側への同期回路
    -------------------------------------------------------------------------------
    O2I: SYNCRONIZER                     -- 
        generic map (                    -- 
            DATA_BITS   => DATA_WIDTH  , -- 
            VAL_BITS    => 2           , -- 
            I_CLK_RATE  => O_CLK_RATE  , -- 
            O_CLK_RATE  => I_CLK_RATE  , -- 
            I_CLK_FLOP  => 1           , -- 
            O_CLK_FLOP  => 1           , -- 
            I_CLK_FALL  => 0           , -- 
            O_CLK_FALL  => 0           , -- 
            O_CLK_REGS  => 0             -- 
        )                                -- 
        port map (                       -- 
            RST         => RST         , -- In  :
            I_CLK       => O_CLK       , -- In  :
            I_CLR       => O_CLR       , -- In  :
            I_CKE       => O_CKE       , -- In  :
            I_DATA      => o2i_i_rdata , -- In  :
            I_VAL       => o2i_i_valid , -- In  :
            I_RDY       => o2i_i_ready , -- Out :
            O_CLK       => I_CLK       , -- In  :
            O_CLR       => I_CLR       , -- In  :
            O_CKE       => I_CKE       , -- In  :
            O_DATA      => o2i_o_rdata , -- Out :
            O_VAL       => o2i_o_valid   -- Out :
        );
    -------------------------------------------------------------------------------
    -- 出力側の制御回路
    -------------------------------------------------------------------------------
    O: block
        constant pause       :  std_logic := '0';
        signal   req_pending :  boolean;
        signal   req_valid   :  boolean;
        signal   req_ready   :  boolean;
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        req_valid <= (req_pending = FALSE and i2o_o_valid = '1') or
                     (req_pending = TRUE                       );
        req_ready <= (O_ACK = '1' or O_ERR = '1');
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (O_CLK, RST) begin
            if (RST = '1') then
                    req_pending <= FALSE;
            elsif (O_CLK'event and O_CLK = '1') then
                if (O_CLR = '1') then
                    req_pending <= FALSE;
                else
                    req_pending <= (req_valid and not req_ready);
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        O_REQ   <= '1' when (req_valid) else '0';
        O_WDATA <= i2o_o_data(I2O_WDATA_HI downto I2O_WDATA_LO);
        O_BEN   <= i2o_o_data(I2O_BEN_HI   downto I2O_BEN_LO  );
        O_ADDR  <= i2o_o_data(I2O_ADDR_HI  downto I2O_ADDR_LO );
        O_WRITE <= i2o_o_data(I2O_WRITE_POS                   );
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        ACK_REGS: SYNCRONIZER_INPUT_PENDING_REGISTER
            generic map (                      --
                DATA_BITS   => DATA_WIDTH    , -- 
                OPERATION   => 0               -- 
            )                                  -- 
            port map (                         -- 
                CLK         => O_CLK         , -- In  :
                RST         => RST           , -- In  :
                CLR         => O_CLR         , -- In  :
                I_DATA      => O_RDATA       , -- In  :
                I_VAL       => O_ACK         , -- In  :
                I_PAUSE     => pause         , -- In  :
                P_DATA      => open          , -- Out :
                P_VAL       => open          , -- Out :
                O_DATA      => o2i_i_rdata   , -- Out :
                O_VAL       => o2i_i_valid(0), -- Out :
                O_RDY       => o2i_i_ready     -- In  :
            );                                 -- 
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        ERR_REGS: SYNCRONIZER_INPUT_PENDING_REGISTER
            generic map (                      --
                DATA_BITS   => 1             , -- 
                OPERATION   => 1               -- 
            )                                  -- 
            port map (                         -- 
                CLK         => O_CLK         , -- In  :
                RST         => RST           , -- In  :
                CLR         => O_CLR         , -- In  :
                I_DATA(0)   => O_ERR         , -- In  :
                I_VAL       => O_ERR         , -- In  :
                I_PAUSE     => pause         , -- In  :
                P_DATA      => open          , -- Out :
                P_VAL       => open          , -- Out :
                O_DATA      => open          , -- Out :
                O_VAL       => o2i_i_valid(1), -- Out :
                O_RDY       => o2i_i_ready     -- In  :
            );                                 -- 
    end block;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    sdpram.vhd
--!     @brief   Synchronous Dual Port RAM Entity.
--!     @version 1.0.0
--!     @date    2012/8/11
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   SDPRAM :
--!          1W1Rの同期メモリ.
--!        * ライトとリードでは別クロック.
--!        * ライトとリードで別々にビット幅を指定できる.
-----------------------------------------------------------------------------------
entity  SDPRAM is
    generic (
        DEPTH   : --! @brief SDPRAM DEPTH :
                  --! メモリの深さ(ビット単位)を2のべき乗値で指定する.
                  --! 例 DEPTH=10 => 2**10=1024bit
                  integer := 10;
        RWIDTH  : --! @brief SDPRAM READ DATA PORT WIDTH :
                  --! リードデータ(RDATA)の幅(ビット数)を2のべき乗値で指定する.
                  --! 例 RWIDTH=5 => 2**5=32bit
                  integer := 5;   
        WWIDTH  : --! @brief SDPRAM WRITE DATA PORT WIDTH :
                  --! ライトデータ(WDATA)の幅(ビット数)を2のべき乗値で指定する.
                  integer := 6;   
        WEBIT   : --! @brief SDPRAM WRITE ENABLE WIDTH :
                  --! ライトイネーブル信号(WE)の幅(ビット数)を2のべき乗値で指定する.
                  --! 例 WEBIT=0 => 2**0=1bit
                  --!    WEBIT=2 => 2**2=4bit
                  integer := 0;
        ID      : --! @brief SDPRAM IDENTIFIER :
                  --! どのモジュールで使われているかを示す識別番号.
                  integer := 0 
    );
    port (
        WCLK    : --! @brief WRITE CLOCK :
                  --! ライトクロック信号
                  in  std_logic;
        WE      : --! @brief WRITE ENABLE :
                  --! ライトイネーブル信号
                  in  std_logic_vector(2**WEBIT-1 downto 0);
        WADDR   : --! @brief WRITE ADDRESS :
                  --! ライトアドレス信号
                  in  std_logic_vector(DEPTH-1 downto WWIDTH);
        WDATA   : --! @brief WRITE DATA :
                  --! ライトデータ信号
                  in  std_logic_vector(2**WWIDTH-1 downto 0);
        RCLK    : --! @brief READ CLOCK :
                  --! リードクロック信号
                  in  std_logic;
        RADDR   : --! @brief READ ADDRESS :
                  --! リードアドレス信号
                  in  std_logic_vector(DEPTH-1 downto RWIDTH);
        RDATA   : --! @brief READ DATA :
                  --! リードデータ信号
                  out std_logic_vector(2**RWIDTH-1 downto 0)
    );
end     SDPRAM;
-----------------------------------------------------------------------------------
--!     @file    axi4_register_interface.vhd
--!     @brief   AXI4 Register Interface
--!     @version 1.5.5
--!     @date    2014/3/2
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2014 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
-----------------------------------------------------------------------------------
--! @brief   AXI4 Register Interface.
-----------------------------------------------------------------------------------
entity  AXI4_REGISTER_INTERFACE is
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        AXI4_ADDR_WIDTH : --! @brief AIX4 ADDRESS CHANNEL ADDR WIDTH :
                          --! AXI4 リードアドレスチャネルのAWADDR信号のビット幅.
                          integer range 1 to AXI4_ADDR_MAX_WIDTH := 32;
        AXI4_DATA_WIDTH : --! @brief AXI4 WRITE DATA CHANNEL DATA WIDTH :
                          --! AXI4 リードデータチャネルのRDATA信号のビット幅.
                          integer range 8 to AXI4_DATA_MAX_WIDTH := 32;
        AXI4_ID_WIDTH   : --! @brief AXI4 ID WIDTH :
                          --! AXI4 アドレスチャネルおよびライトレスポンスチャネルの
                          --! ID信号のビット幅.
                          integer := 4;
        REGS_ADDR_WIDTH : --! @brief REGISTER ADDRESS WIDTH :
                          --! レジスタアクセスインターフェースのアドレスのビット幅
                          --! を指定する.
                          integer := 32;
        REGS_DATA_WIDTH : --! @brief REGISTER DATA WIDTH :
                          --! レジスタアクセスインターフェースのデータのビット幅を
                          --! 指定する.
                          integer := 32
    );
    port(
    ------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    ------------------------------------------------------------------------------
        CLK             : --! @brief Global clock signal.  
                          in    std_logic;
        RST             : --! @brief Global asyncrounos reset signal, active HIGH.
                          in    std_logic;
        CLR             : --! @brief Global syncrounos reset signal, active HIGH.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Read Address Channel Signals.
    ------------------------------------------------------------------------------
        ARID            : --! @brief Read address ID.
                          --! This signal is identification tag for the read
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        ARADDR          : --! @brief Read address.  
                          --! The read address gives the address of the first
                          --! transfer in a read burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        ARLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        ARSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        ARBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        ARVALID         : --! @brief Read address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        ARREADY         : --! @brief Read address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Read Data Channel Signals.
    ------------------------------------------------------------------------------
        RID             : --! @brief Read ID tag.
                          --! This signal is the identification tag for the read
                          --! data group of signals generated by the slave.
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        RDATA           : --! @brief Read data.
                          out   std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        RRESP           : --! @brief Read response.
                          --! This signal indicates the status of the read transaction.
                          out   AXI4_RESP_TYPE;
        RLAST           : --! @brief Read last.
                          --! This signal indicates the last transfer in a read burst.
                          out   std_logic;
        RVALID          : --! @brief Read data valid.
                          --! This signal indicates that the channel is signaling
                          --! the required read data.
                          out   std_logic;
        RREADY          : --! @brief Read data ready.
                          --! This signal indicates that the master can accept the
                          --! read data and response information.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Write Address Channel Signals.
    ------------------------------------------------------------------------------
        AWID            : --! @brief Write address ID.
                          --! This signal is identification tag for the write
                          --! address group of singals.
                          in    std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        AWADDR          : --! @brief Write address.  
                          --! The read address gives the address of the first
                          --! transfer in a write burst transaction.
                          in    std_logic_vector(AXI4_ADDR_WIDTH  -1 downto 0);
        AWLEN           : --! @brief Burst length.  
                          --! This signal indicates the exact number of transfer
                          --! in a burst.
                          in    std_logic_vector(AXI4_ALEN_WIDTH  -1 downto 0);
        AWSIZE          : --! @brief Burst size.
                          --! This signal indicates the size of each transfer in
                          --! the burst.
                          in    AXI4_ASIZE_TYPE;
        AWBURST         : --! @brief Burst type.
                          --! The burst type and size infomation determine how
                          --! the address for each transfer within the burst is
                          --! calculated.
                          in    AXI4_ABURST_TYPE;
        AWVALID         : --! @brief Write address valid.
                          --! This signal indicates that the channel is signaling
                          --! valid read address and control infomation.
                          in    std_logic;
        AWREADY         : --! @brief Write address ready.
                          --! This signal indicates that the slave is ready to
                          --! accept and associated control signals.
                          out   std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Write Data Channel Signals.
    ------------------------------------------------------------------------------
        WDATA           : --! @brief Write data.
                          in    std_logic_vector(AXI4_DATA_WIDTH  -1 downto 0);
        WSTRB           : --! @brief Write strobes.
                          --! This signal indicates which byte lanes holdvalid 
                          --! data. There is one write strobe bit for each eight
                          --! bits of the write data bus.
                          in    std_logic_vector(AXI4_DATA_WIDTH/8-1 downto 0);
        WLAST           : --! @brief Write last.
                          --! This signal indicates the last transfer in a write burst.
                          in    std_logic;
        WVALID          : --! @brief Write valid.
                          --! This signal indicates that valid write data and
                          --! strobes are available.
                          in    std_logic;
        WREADY          : --! @brief Write ready.
                          --! This signal indicates that the slave can accept the
                          --! write data.
                          out   std_logic;
    ------------------------------------------------------------------------------
    -- AXI4 Write Response Channel Signals.
    ------------------------------------------------------------------------------
        BID             : --! @brief Response ID tag.
                          --! This signal is the identification tag of write
                          --! response .
                          out   std_logic_vector(AXI4_ID_WIDTH    -1 downto 0);
        BRESP           : --! @brief Write response.
                          --! This signal indicates the status of the write transaction.
                          out   AXI4_RESP_TYPE;
        BVALID          : --! @brief Write response valid.
                          --! This signal indicates that the channel is signaling
                          --! a valid write response.
                          out   std_logic;
        BREADY          : --! @brief Write response ready.
                          --! This signal indicates that the master can accept a
                          --! write response.
                          in    std_logic;
    ------------------------------------------------------------------------------
    -- Register Interface.
    ------------------------------------------------------------------------------
        REGS_REQ        : --! @brief レジスタアクセス要求信号.
                          --! レジスタアクセス要求時にアサートされる.
                          --! REGS_ACK 信号がアサートされるまで、この信号はアサー
                          --! トされたまま.
                          out std_logic;
        REGS_WRITE      : --! @brief レジスタライト信号.
                          --! レジスタ書き込み時にアサートされる.
                          out std_logic;
        REGS_ACK        : --! @brief レジスタアクセス応答信号.
                          in  std_logic;
        REGS_ERR        : --! @brief レジスタアクセスエラー信号.
                          --! エラーが発生した時にREGS_ACK信号と共にアサートする.
                          in  std_logic;
        REGS_ADDR       : --! @brief レジスタアドレス信号.
                          out std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
        REGS_BEN        : --! @brief バイトイネーブル信号.
                          out std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
        REGS_WDATA      : --! @brief レジスタライトデータ出力信号.
                          out std_logic_vector(REGS_DATA_WIDTH  -1 downto 0);
        REGS_RDATA      : --! @brief レジスタリードデータ入力信号.
                          in  std_logic_vector(REGS_DATA_WIDTH  -1 downto 0)
    );
end AXI4_REGISTER_INTERFACE;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
use     PIPEWORK.COMPONENTS.QUEUE_ARBITER;
use     PIPEWORK.AXI4_COMPONENTS.AXI4_REGISTER_READ_INTERFACE;
use     PIPEWORK.AXI4_COMPONENTS.AXI4_REGISTER_WRITE_INTERFACE;
architecture RTL of AXI4_REGISTER_INTERFACE is
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    constant R_NUM      : integer := 1;
    constant W_NUM      : integer := 0;
    constant arb_enable : std_logic := '1';
    signal   arb_req    : std_logic_vector(1 downto 0);
    signal   arb_gnt    : std_logic_vector(1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    signal   w_ack      : std_logic;
    signal   w_err      : std_logic;
    signal   w_addr     : std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
    signal   w_ben      : std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    signal   r_ack      : std_logic;
    signal   r_err      : std_logic;
    signal   r_addr     : std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
    signal   r_ben      : std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
begin
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    R: AXI4_REGISTER_READ_INTERFACE
        generic map (
            AXI4_ADDR_WIDTH => AXI4_ADDR_WIDTH ,
            AXI4_DATA_WIDTH => AXI4_DATA_WIDTH ,
            AXI4_ID_WIDTH   => AXI4_ID_WIDTH   ,
            REGS_ADDR_WIDTH => REGS_ADDR_WIDTH ,
            REGS_DATA_WIDTH => REGS_DATA_WIDTH
        )
        port map (
        ---------------------------------------------------------------------------
        -- Clock and Reset Signals.
        ---------------------------------------------------------------------------
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
        ---------------------------------------------------------------------------
        -- AXI4 Read Address Channel Signals.
        ---------------------------------------------------------------------------
            ARID            => ARID            , -- In  :
            ARADDR          => ARADDR          , -- In  :
            ARLEN           => ARLEN           , -- In  :
            ARSIZE          => ARSIZE          , -- In  :
            ARBURST         => ARBURST         , -- In  :
            ARVALID         => ARVALID         , -- In  :
            ARREADY         => ARREADY         , -- Out :
        ---------------------------------------------------------------------------
        -- AXI4 Read Data Channel Signals.
        ---------------------------------------------------------------------------
            RID             => RID             , -- In  :
            RDATA           => RDATA           , -- In  :
            RRESP           => RRESP           , -- In  :
            RLAST           => RLAST           , -- In  :
            RVALID          => RVALID          , -- In  :
            RREADY          => RREADY          , -- Out :
        ---------------------------------------------------------------------------
        -- Register Write Interface.
        ---------------------------------------------------------------------------
            REGS_REQ        => arb_req(R_NUM)  , -- Out :
            REGS_ACK        => r_ack           , -- In  :
            REGS_ERR        => r_err           , -- In  :
            REGS_ADDR       => r_addr          , -- Out :
            REGS_BEN        => r_ben           , -- Out :
            REGS_DATA       => REGS_RDATA        -- In  :
        );
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    W: AXI4_REGISTER_WRITE_INTERFACE 
        generic map (
            AXI4_ADDR_WIDTH => AXI4_ADDR_WIDTH ,
            AXI4_DATA_WIDTH => AXI4_DATA_WIDTH ,
            AXI4_ID_WIDTH   => AXI4_ID_WIDTH   ,
            REGS_ADDR_WIDTH => REGS_ADDR_WIDTH ,
            REGS_DATA_WIDTH => REGS_DATA_WIDTH 
        )
        port map (
        ---------------------------------------------------------------------------
        -- Clock and Reset Signals.
        ---------------------------------------------------------------------------
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
        ---------------------------------------------------------------------------
        -- AXI4 Write Address Channel Signals.
        ---------------------------------------------------------------------------
            AWID            => AWID            , -- In  :
            AWADDR          => AWADDR          , -- In  :
            AWLEN           => AWLEN           , -- In  :
            AWSIZE          => AWSIZE          , -- In  :
            AWBURST         => AWBURST         , -- In  :
            AWVALID         => AWVALID         , -- In  :
            AWREADY         => AWREADY         , -- Out :
        ---------------------------------------------------------------------------
        -- AXI4 Write Data Channel Signals.
        ---------------------------------------------------------------------------
            WDATA           => WDATA           , -- Out :
            WSTRB           => WSTRB           , -- Out :
            WLAST           => WLAST           , -- Out :
            WVALID          => WVALID          , -- Out :
            WREADY          => WREADY          , -- In  :
        ---------------------------------------------------------------------------
        -- AXI4 Write Response Channel Signals.
        ---------------------------------------------------------------------------
            BID             => BID             , -- In  :
            BRESP           => BRESP           , -- In  :
            BVALID          => BVALID          , -- In  :
            BREADY          => BREADY          , -- Out :
        ---------------------------------------------------------------------------
        -- Register Write Interface.
        ---------------------------------------------------------------------------
            REGS_REQ        => arb_req(W_NUM)  , -- Out :
            REGS_ACK        => w_ack           , -- In  :
            REGS_ERR        => w_err           , -- In  :
            REGS_ADDR       => w_addr          , -- Out :
            REGS_BEN        => w_ben           , -- Out :
            REGS_DATA       => REGS_WDATA        -- Out :
        );
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    ARB: QUEUE_ARBITER 
        generic map (
            MIN_NUM         => arb_req'low     ,
            MAX_NUM         => arb_req'high
        )
        port map (
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
            ENABLE          => arb_enable      , -- In  :
            REQUEST         => arb_req         , -- In  :
            GRANT           => arb_gnt         , -- Out :
            GRANT_NUM       => open            , -- Out :
            REQUEST_O       => REGS_REQ        , -- Out :
            VALID           => open            , -- Out :
            SHIFT           => REGS_ACK          -- In  :
        );
    REGS_ADDR  <= w_addr   when (arb_gnt(W_NUM) = '1') else r_addr;
    REGS_BEN   <= w_ben    when (arb_gnt(W_NUM) = '1') else r_ben;
    REGS_WRITE <= '1'      when (arb_gnt(W_NUM) = '1') else '0';
    w_ack      <= REGS_ACK when (arb_gnt(W_NUM) = '1') else '0';
    w_err      <= REGS_ERR when (arb_gnt(W_NUM) = '1') else '0';
    r_ack      <= REGS_ACK when (arb_gnt(R_NUM) = '1') else '0';
    r_err      <= REGS_ERR when (arb_gnt(R_NUM) = '1') else '0';
end RTL;
-----------------------------------------------------------------------------------
--!     @file    queue_arbiter_integer_arch.vhd
--!     @brief   QUEUE ARBITER INTEGER ARCHITECTURE :
--!              キュータイプの調停回路のアーキテクチャ(整数デコード)
--!     @version 1.0.0
--!     @date    2012/8/11
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------
architecture INTEGER_ARCH of QUEUE_ARBITER is
    type     REQUEST_VECTOR is array(integer range <>) of integer range MIN_NUM to MAX_NUM;
    constant QUEUE_TOP      :  integer := MIN_NUM;
    constant QUEUE_END      :  integer := MAX_NUM;
    signal   curr_queue     :  REQUEST_VECTOR  (QUEUE_TOP to QUEUE_END);
    signal   next_queue     :  REQUEST_VECTOR  (QUEUE_TOP to QUEUE_END);
    signal   curr_valid     :  std_logic_vector(QUEUE_TOP to QUEUE_END);
    signal   next_valid     :  std_logic_vector(QUEUE_TOP to QUEUE_END);
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (ENABLE, REQUEST, curr_queue, curr_valid)
        variable req_enable :  std_logic_vector(MIN_NUM to MAX_NUM);
        variable req_num    :  integer   range  MIN_NUM to MAX_NUM ;
        variable req_new    :  boolean;
        variable temp_queue :  REQUEST_VECTOR  (QUEUE_TOP to QUEUE_END);
        variable temp_valid :  std_logic_vector(QUEUE_TOP to QUEUE_END);
        variable temp_num   :  integer   range  MIN_NUM to MAX_NUM ;
    begin
        --------------------------------------------------------------------------
        -- ENABLE信号がネゲートされている場合.
        --------------------------------------------------------------------------
        if    (ENABLE /= '1') then
                next_valid <= (others => '0');
                next_queue <= (others => MIN_NUM);
                VALID      <= '0';
                REQUEST_O  <= '0';
                GRANT_NUM  <= MIN_NUM;
                GRANT      <= (others => '0');
        --------------------------------------------------------------------------
        -- リクエスト信号が一つしかない場合は話は簡単だ.
        --------------------------------------------------------------------------
        elsif (MIN_NUM >= MAX_NUM) then
            if (REQUEST(MIN_NUM) = '1') then 
                next_valid <= (others => '0');
                next_queue <= (others => MIN_NUM);
                VALID      <= '1';
                REQUEST_O  <= '1';
                GRANT_NUM  <= MIN_NUM;
                GRANT      <= (others => '1');
            else
                next_valid <= (others => '0');
                next_queue <= (others => MIN_NUM);
                VALID      <= '0';
                REQUEST_O  <= '0';
                GRANT_NUM  <= MIN_NUM;
                GRANT      <= (others => '0');
            end if;
        --------------------------------------------------------------------------
        -- 複数のリクエスト信号がある場合は調停しなければならない.
        -- あたりまえだ. それがこの回路の本来の仕事だ.
        --------------------------------------------------------------------------
        else
            req_enable := (others => '1');
            for i in QUEUE_TOP to QUEUE_END loop
                if (curr_valid(i) = '1') then
                    for n in MIN_NUM to MAX_NUM loop
                        if (n = curr_queue(i)) then
                            req_enable(n) := '0';
                        end if;
                    end loop;
                    temp_valid(i) := '1';
                    temp_queue(i) := curr_queue(i);
                else
                    req_new := FALSE;
                    req_num := MIN_NUM;
                    for n in MIN_NUM to MAX_NUM loop
                        if (REQUEST(n) = '1' and req_enable(n) = '1') then
                            req_new       := TRUE;
                            req_num       := n;
                            req_enable(n) := '0';
                            exit;
                        end if;
                    end loop;
                    if (req_new) then
                        temp_valid(i) := '1';
                        temp_queue(i) := req_num;
                    else
                        temp_valid(i) := '0';
                        temp_queue(i) := MIN_NUM;
                    end if;
                end if;
            end loop;
            VALID      <= temp_valid(QUEUE_TOP);
            next_valid <= temp_valid;
            next_queue <= temp_queue;
            temp_num   := temp_queue(QUEUE_TOP);
            if (temp_valid(QUEUE_TOP) = '1' and REQUEST(temp_num) = '1') then
                REQUEST_O <= '1';
                GRANT_NUM <= temp_num;
                for i in GRANT'range loop
                    if (i = temp_num) then
                        GRANT(i) <= '1';
                    else
                        GRANT(i) <= '0';
                    end if;
                end loop;
            else
                REQUEST_O <= '0';
                GRANT_NUM <= temp_num;
                GRANT     <= (others => '0');
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if     (RST = '1') then
                curr_queue <= (others => MIN_NUM);
                curr_valid <= (others => '0');
        elsif  (CLK'event and CLK = '1') then
            if (CLR     = '1') or
               (ENABLE /= '1') then
                curr_queue <= (others => MIN_NUM);
                curr_valid <= (others => '0');
            elsif (SHIFT = '1') then
                for i in QUEUE_TOP to QUEUE_END loop
                    if (i < QUEUE_END) then
                        curr_queue(i) <= next_queue(i+1);
                        curr_valid(i) <= next_valid(i+1);
                    else
                        curr_queue(i) <= MIN_NUM;
                        curr_valid(i) <= '0';
                    end if;
                end loop;
            else
                curr_queue <= next_queue;
                curr_valid <= next_valid;
            end if;
        end if;
    end process;
end INTEGER_ARCH;
-----------------------------------------------------------------------------------
--!     @file    register_access_adapter.vhd
--!     @brief   REGISTER ACCESS ADAPTER MODULE :
--!              レジスタアクセスアダプタ.
--!     @version 1.5.4
--!     @date    2014/2/16
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2014 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief   REGISTER ACCESS ADAPTER MODULE 
-----------------------------------------------------------------------------------
entity  REGISTER_ACCESS_ADAPTER is
    generic (
        ADDR_WIDTH  : --! @brief REGISTER ADDRESS WIDTH :
                      --! レジスタアクセスインターフェースのアドレスのビット幅を指
                      --! 定する.
                      integer := 8;
        DATA_WIDTH  : --! @brief REGISTER DATA WIDTH :
                      --! レジスタアクセスインターフェースのデータのビット幅を指定
                      --! する.
                      integer := 32;
        WBIT_MIN    : --! @brief REGISTER WRITE BIT MIN INDEX :
                      integer := 0;
        WBIT_MAX    : --! @brief REGISTER WRITE BIT MAX INDEX :
                      integer := (2**8)*8-1;
        RBIT_MIN    : --! @brief REGISTER READ  BIT MIN INDEX :
                      integer := 0;
        RBIT_MAX    : --! @brief REGISTER READ  BIT MAX INDEX :
                      integer := (2**8)*8-1;
        I_CLK_RATE  : --! @brief INPUT CLOCK RATE :
                      --! O_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する. 
                      --! 詳細は PipeWork.Components の SYNCRONIZER を参照.
                      integer :=  1;
        O_CLK_RATE  : --! @brief OUTPUT CLOCK RATE :
                      --! I_CLK_RATEとペアで入力側のクロック(I_CLK)と出力側のクロッ
                      --! ク(O_CLK)との関係を指定する.
                      --! 詳細は PipeWork.Components の SYNCRONIZER を参照.
                      integer :=  1;
        O_CLK_REGS  : --! @brief REGISTERD OUTPUT :
                      --! 出力側の各種信号(O_REQ/O_WRITE/O_WDATA/O_BEN)をレジスタ
                      --! 出力するかどうかを指定する.
                      --! * この変数は I_CLK_RATE > 0 の場合のみ有効. 
                      --!   I_CLK_RATE = 0 の場合は、常にレジスタ出力になる.
                      --! * O_CLK_REGS = 0 の場合はレジスタ出力しない.
                      --! * O_CLK_REGS = 1 の場合はレジスタ出力する.
                      integer range 0 to 1 :=  0
    );
    port (
    -------------------------------------------------------------------------------
    -- リセット信号
    -------------------------------------------------------------------------------
        RST         : --! @brief RESET :
                      --! 非同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        I_CLK       : --! @brief INPUT CLOCK :
                      --! 入力側のクロック信号.
                      in  std_logic;
        I_CLR       : --! @brief INPUT CLEAR :
                      --! 入力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
        I_CKE       : --! @brief INPUT CLOCK ENABLE :
                      --! 入力側のクロック(I_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とOCLKの立上り時が同じ時にアサートするよ
                      --!   うに入力されなければならない.
                      --! * この信号は I_CLK_RATE > 1 かつ O_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- 入力側のレジスタアクセスインターフェース
    -------------------------------------------------------------------------------
        I_REQ       : --! @brief REGISTER ACCESS REQUEST :
                      --! レジスタアクセス要求信号.
                      in  std_logic;
        I_SEL       : --! @brief INPUT REGISTER ACCESS SELECT :
                      --! レジスタアクセス選択信号.
                      --! * I_REQ='1'の際、この信号が'1'の時にのみレジスタアクセス
                      --!   を開始する.
                      in  std_logic := '1';
        I_WRITE     : --! @brief REGISTER WRITE ACCESS :
                      --! レジスタライトアクセス信号.
                      --! * この信号が'1'の時はライトアクセスを行う.
                      --! * この信号が'0'の時はリードアクセスを行う.
                      in  std_logic;
        I_ADDR      : --! @brief REGISTER ACCESS ADDRESS :
                      --! レジスタアクセスアドレス信号.
                      in  std_logic_vector(ADDR_WIDTH  -1 downto 0);
        I_BEN       : --! @brief REGISTER BYTE ENABLE :
                      --! レジスタアクセスバイトイネーブル信号.
                      in  std_logic_vector(DATA_WIDTH/8-1 downto 0);
        I_WDATA     : --! @brief REGISTER ACCESS WRITE DATA :
                      --! レジスタアクセスライトデータ.
                      in  std_logic_vector(DATA_WIDTH  -1 downto 0);
        I_RDATA     : --! @brief REGISTER ACCESS READ DATA :
                      --! レジスタアクセスリードデータ.
                      out std_logic_vector(DATA_WIDTH  -1 downto 0);
        I_ACK       : --! @brief REGISTER ACCESS ACKNOWLEDGE :
                      --! レジスタアクセス応答信号.
                      out std_logic;
        I_ERR       : --! @brief REGISTER ACCESS ERROR ACKNOWLEDGE :
                      --! レジスタアクセスエラー応答信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側のクロック信号/同期リセット信号
    -------------------------------------------------------------------------------
        O_CLK       : --! @brief OUTPUT CLK :
                      --! 出力側のクロック信号.
                      in  std_logic;
        O_CLR       : --! @brief OUTPUT CLEAR :
                      --! 出力側の同期リセット信号(ハイ・アクティブ).
                      in  std_logic;
        O_CKE       : --! @brief OUTPUT CLOCK ENABLE :
                      --! 出力側のクロック(O_CLK)の立上りが有効であることを示す信号.
                      --! * この信号は I_CLK_RATE > 1 の時に、I_CLK と O_CLK の位相
                      --!   関係を示す時に使用する.
                      --! * I_CLKの立上り時とO_CLKの立上り時が同じ時にアサートする
                      --!   ように入力されなければならない.
                      --! * この信号は O_CLK_RATE > 1 かつ I_CLK_RATE = 1の時のみ有
                      --!   効. それ以外は未使用.
                      in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- レジスタライトデータ/ロード出力
    -------------------------------------------------------------------------------
        O_WDATA     : out std_logic_vector(WBIT_MAX downto WBIT_MIN);
        O_WLOAD     : out std_logic_vector(WBIT_MAX downto WBIT_MIN);
    -------------------------------------------------------------------------------
    -- レジスタリードデータ入力
    -------------------------------------------------------------------------------
        O_RDATA     : in  std_logic_vector(RBIT_MAX downto RBIT_MIN)
    );
end REGISTER_ACCESS_ADAPTER;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library PIPEWORK;
use     PIPEWORK.COMPONENTS.REGISTER_ACCESS_SYNCRONIZER;
use     PIPEWORK.COMPONENTS.REGISTER_ACCESS_DECODER;
architecture RTL of REGISTER_ACCESS_ADAPTER is
    signal   regs_req   : std_logic;
    signal   regs_write : std_logic;
    signal   regs_addr  : std_logic_vector(I_ADDR 'range);
    signal   regs_ben   : std_logic_vector(I_BEN  'range);
    signal   regs_wdata : std_logic_vector(I_WDATA'range);
    signal   regs_rdata : std_logic_vector(I_RDATA'range);
    signal   regs_ack   : std_logic;
    signal   regs_err   : std_logic;
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    SYNC: REGISTER_ACCESS_SYNCRONIZER    -- 
        generic map (                    -- 
            ADDR_WIDTH  => ADDR_WIDTH  , -- 
            DATA_WIDTH  => DATA_WIDTH  , -- 
            I_CLK_RATE  => I_CLK_RATE  , -- 
            O_CLK_RATE  => O_CLK_RATE  , -- 
            O_CLK_REGS  => O_CLK_REGS    -- 
        )                                -- 
        port map (                       -- 
            RST         => RST         , -- In  :
            I_CLK       => I_CLK       , -- In  :
            I_CLR       => I_CLR       , -- In  :
            I_CKE       => I_CKE       , -- In  :
            I_REQ       => I_REQ       , -- In  :
            I_SEL       => I_SEL       , -- In  :
            I_WRITE     => I_WRITE     , -- In  :
            I_ADDR      => I_ADDR      , -- In  :
            I_BEN       => I_BEN       , -- In  :
            I_WDATA     => I_WDATA     , -- In  :
            I_RDATA     => I_RDATA     , -- Out :
            I_ACK       => I_ACK       , -- Out :
            I_ERR       => I_ERR       , -- Out :
            O_CLK       => O_CLK       , -- In  :
            O_CLR       => O_CLR       , -- In  :
            O_CKE       => O_CKE       , -- In  :
            O_REQ       => regs_req    , -- Out :
            O_WRITE     => regs_write  , -- Out :
            O_ADDR      => regs_addr   , -- Out :
            O_BEN       => regs_ben    , -- Out :
            O_WDATA     => regs_wdata  , -- Out :
            O_RDATA     => regs_rdata  , -- In  :
            O_ACK       => regs_ack    , -- In  :
            O_ERR       => regs_err      -- In  :
        );
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    DEC: REGISTER_ACCESS_DECODER         -- 
        generic map (                    -- 
            ADDR_WIDTH  => ADDR_WIDTH  , --
            DATA_WIDTH  => DATA_WIDTH  , --
            WBIT_MIN    => WBIT_MIN    , --
            WBIT_MAX    => WBIT_MAX    , --
            RBIT_MIN    => RBIT_MIN    , --
            RBIT_MAX    => RBIT_MAX      --
        )                                -- 
        port map (                       -- 
            REGS_REQ    => regs_req    , -- In  :
            REGS_WRITE  => regs_write  , -- In  :
            REGS_ADDR   => regs_addr   , -- In  :
            REGS_BEN    => regs_ben    , -- In  :
            REGS_WDATA  => regs_wdata  , -- In  :
            REGS_RDATA  => regs_rdata  , -- Out :
            REGS_ACK    => regs_ack    , -- Out :
            REGS_ERR    => regs_err    , -- Out :
            W_DATA      => O_WDATA     , -- Out :
            W_LOAD      => O_WLOAD     , -- Out :
            R_DATA      => O_RDATA       -- In  :
        );
end RTL;
-----------------------------------------------------------------------------------
--!     @file    sdpram_altera_auto_select.vhd
--!     @brief   Synchronous Dual Port RAM Model for Altera FPGA.
--!     @version 1.5.9
--!     @date    2016/3/13
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2016 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
architecture ALTERA_AUTO_SELECT of SDPRAM is
    component altsyncram 
        generic (
            width_a                                :  integer;
            widthad_a                              :  integer;
            numwords_a                             :  integer;
            outdata_reg_a                          :  string ;
            address_aclr_a                         :  string ;
            outdata_aclr_a                         :  string ;
            indata_aclr_a                          :  string ;
            wrcontrol_aclr_a                       :  string ;
            byteena_aclr_a                         :  string ;
            width_byteena_a                        :  integer;
            clock_enable_input_a                   :  string ;
            clock_enable_output_a                  :  string ;
            clock_enable_core_a                    :  string ;
            read_during_write_mode_port_a          :  string ;
            width_b                                :  integer;
            widthad_b                              :  integer;
            numwords_b                             :  integer;
            rdcontrol_reg_b                        :  string ;
            address_reg_b                          :  string ;
            outdata_reg_b                          :  string ;
            outdata_aclr_b                         :  string ;
            rdcontrol_aclr_b                       :  string ;
            indata_reg_b                           :  string ;
            wrcontrol_wraddress_reg_b              :  string ;
            byteena_reg_b                          :  string ;
            indata_aclr_b                          :  string ;
            wrcontrol_aclr_b                       :  string ;
            address_aclr_b                         :  string ;
            byteena_aclr_b                         :  string ;
            width_byteena_b                        :  integer;
            clock_enable_input_b                   :  string ;
            clock_enable_output_b                  :  string ;
            clock_enable_core_b                    :  string ;
            read_during_write_mode_port_b          :  string ;
            enable_ecc                             :  string ;
            width_eccstatus                        :  integer;
            ecc_pipeline_stage_enabled             :  string ;
            operation_mode                         :  string ;
            byte_size                              :  integer;
            read_during_write_mode_mixed_ports     :  string ;
            ram_block_type                         :  string ;
            init_file                              :  string ;
            init_file_layout                       :  string ;
            maximum_depth                          :  integer;
            intended_device_family                 :  string ;
            power_up_uninitialized                 :  string ;
            implement_in_les                       :  string ;
            sim_show_memory_data_in_port_b_layout  :  string ;
            lpm_hint                               :  string ;
            lpm_type                               :  string 
        );
        port (
            wren_a            : in  std_logic;
            wren_b            : in  std_logic;
            rden_a            : in  std_logic;
            rden_b            : in  std_logic;
            data_a            : in  std_logic_vector(width_a   - 1 downto 0);
            data_b            : in  std_logic_vector(width_b   - 1 downto 0);
            address_a         : in  std_logic_vector(widthad_a - 1 downto 0);
            address_b         : in  std_logic_vector(widthad_b - 1 downto 0);
            clock0            : in  std_logic;
            clock1            : in  std_logic;
            clocken0          : in  std_logic;
            clocken1          : in  std_logic;
            clocken2          : in  std_logic;
            clocken3          : in  std_logic;
            aclr0             : in  std_logic;
            aclr1             : in  std_logic;
            addressstall_a    : in  std_logic;
            addressstall_b    : in  std_logic;
            byteena_a         : in  std_logic_vector(width_byteena_a-1 downto 0);
            byteena_b         : in  std_logic_vector(width_byteena_b-1 downto 0);
            q_a               : out std_logic_vector(width_a - 1       downto 0);
            q_b               : out std_logic_vector(width_b - 1       downto 0);
            eccstatus         : out std_logic_vector(width_eccstatus-1 downto 0)
        );
    end component;
    constant sig0       : std_logic := '0';
    constant sig1       : std_logic := '1';
    constant data_b     : std_logic_vector(2**(RWIDTH  )-1 downto 0) := (others => '0');
    constant byteena_b  : std_logic_vector(2**(RWIDTH-3)-1 downto 0) := (others => '1');
    signal   wren       : std_logic;
    signal   byteena    : std_logic_vector(2**(WWIDTH-3)-1 downto 0);
begin
    process (WE)
        constant BE_LEN  : integer := 2**(WWIDTH-WEBIT-3);
        constant BE_ALL1 : std_logic_vector(BE_LEN-1 downto 0) := (others => '1');
        constant BE_ALL0 : std_logic_vector(BE_LEN-1 downto 0) := (others => '0');
        constant WE_ALL0 : std_logic_vector(WE'range) := (others => '0');
    begin
        if (WE /= WE_ALL0) then
            wren <= '1';
        else
            wren <= '0';
        end if;
        for i in WE'range loop
            if (WE(i) = '1') then
                byteena(BE_LEN*(i+1)-1 downto BE_LEN*i) <= BE_ALL1;
            else
                byteena(BE_LEN*(i+1)-1 downto BE_LEN*i) <= BE_ALL0;
            end if;
        end loop;
    end process;

    RAM:altsyncram
        generic map(
            width_a                                => 2**WWIDTH,
            widthad_a                              => (DEPTH-WWIDTH),
            numwords_a                             => 2**(DEPTH-WWIDTH),
            outdata_reg_a                          => "UNREGISTERED",
            address_aclr_a                         => "NONE",
            outdata_aclr_a                         => "NONE",
            indata_aclr_a                          => "NONE",
            wrcontrol_aclr_a                       => "NONE",
            byteena_aclr_a                         => "NONE",
            width_byteena_a                        => byteena'length,
            clock_enable_input_a                   => "NORMAL",
            clock_enable_output_a                  => "NORMAL",
            clock_enable_core_a                    => "USE_INPUT_CLKEN",
            read_during_write_mode_port_a          => "NEW_DATA_NO_NBE_READ",
            width_b                                => 2**RWIDTH,
            widthad_b                              => (DEPTH-RWIDTH),
            numwords_b                             => 2**(DEPTH-RWIDTH),
            rdcontrol_reg_b                        => "CLOCK1",
            address_reg_b                          => "CLOCK1",
            outdata_reg_b                          => "UNREGISTERED",
            outdata_aclr_b                         => "NONE",
            rdcontrol_aclr_b                       => "NONE",
            indata_reg_b                           => "CLOCK1",
            wrcontrol_wraddress_reg_b              => "CLOCK1",
            byteena_reg_b                          => "CLOCK1",
            indata_aclr_b                          => "NONE",
            wrcontrol_aclr_b                       => "NONE",
            address_aclr_b                         => "NONE",
            byteena_aclr_b                         => "NONE",
            width_byteena_b                        => byteena_b'length,
            clock_enable_input_b                   => "NORMAL",
            clock_enable_output_b                  => "NORMAL",
            clock_enable_core_b                    => "USE_INPUT_CLKEN",
            read_during_write_mode_port_b          => "NEW_DATA_NO_NBE_READ",
            enable_ecc                             => "FALSE",
            width_eccstatus                        => 3,
            ecc_pipeline_stage_enabled             => "FALSE",
            operation_mode                         => "DUAL_PORT",
            byte_size                              => 8,
            read_during_write_mode_mixed_ports     => "DONT_CARE",
            ram_block_type                         => "AUTO",
            init_file                              => "UNUSED",
            init_file_layout                       => "UNUSED",
            maximum_depth                          => 0,
            intended_device_family                 => "stratix v",
            power_up_uninitialized                 => "FALSE",
            implement_in_les                       => "OFF",
            sim_show_memory_data_in_port_b_layout  => "OFF",
            lpm_hint                               => "UNUSED",
            lpm_type                               => "altsyncram"
        )
        port map (
            wren_a            => wren,
            wren_b            => sig0,
            rden_a            => sig1,
            rden_b            => sig1,
            data_a            => WDATA,
            data_b            => data_b,
            address_a         => WADDR,
            address_b         => RADDR,
            clock0            => WCLK,
            clock1            => RCLK,
            clocken0          => sig1,
            clocken1          => sig1,
            clocken2          => sig1,
            clocken3          => sig1,
            aclr0             => sig0,
            aclr1             => sig0,
            addressstall_a    => sig0,
            addressstall_b    => sig0,
            byteena_a         => byteena,
            byteena_b         => byteena_b,
            q_a               => open,
            q_b               => RDATA,
            eccstatus         => open
        );
end ALTERA_AUTO_SELECT;
