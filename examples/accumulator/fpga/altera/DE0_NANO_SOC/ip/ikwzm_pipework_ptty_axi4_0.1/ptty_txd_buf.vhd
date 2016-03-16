-----------------------------------------------------------------------------------
--!     @file    ptty_txd_buf.vhd
--!     @brief   Transimit Data Buffer for PTTY_AXI4
--!     @version 0.2.0
--!     @date    2015/11/2
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2015 Ichiro Kawazome
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
--! @brief 送信バッファ
-----------------------------------------------------------------------------------
entity  PTTY_TXD_BUF is
    generic (
        BUF_DEPTH   : --! @brief BUFFER DEPTH :
                      --! バッファの容量(バイト数)を２のべき乗値で指定する.
                      integer := 8;
        BUF_WIDTH   : --! @brief BUFFER DATA WIDTH :
                      --! バッファのデータ幅(バイト数)を２のべき乗値で指定する.
                      integer := 2;
        O_BYTES     : --! @brief OUTLET DATA WIDTH :
                      --! 出力側のデータ幅(バイト数)を指定する.
                      integer := 1;
        O_CLK_RATE  : --! @brief OUTLET CLOCK RATE :
                      --! S_CLK_RATEとペアで出力側のクロック(O_CLK)とバッファアクセ
                      --! ス側のクロック(S_CLK)との関係を指定する.
                      integer := 1;
        S_CLK_RATE  : --! @brief BUFFER ACCESS CLOCK RATE :
                      --! O_CLK_RATEとペアで出力側のクロック(O_CLK)とバッファアクセ
                      --! ス側のクロック(S_CLK)との関係を指定する.
                      integer := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 出力側の信号
    -------------------------------------------------------------------------------
        O_CLK       : --! @brief OUTLET CLOCK :
                      --! 出力側のクロック信号.
                      in  std_logic;
        O_CKE       : --! @brief OUTLET CLOCK ENABLE :
                      --! 出力側のクロック(I_CLK)の立上りが有効であることを示す信号.
                      in  std_logic;
        O_DATA      : --! @brief OUTLET DATA :
                      --! 出力側データ
                      out std_logic_vector(8*O_BYTES-1 downto 0);
        O_STRB      : --! @brief OUTLET STROBE :
                      --! 出力側データ
                      out std_logic_vector(  O_BYTES-1 downto 0);
        O_LAST      : --! @brief OUTLET LAST :
                      --! 出力側データ
                      out std_logic;
        O_VALID     : --! @brief OUTLET ENABLE :
                      --! 出力有効信号.
                      out std_logic;
        O_READY     : --! @brief OUTLET READY :
                      --! 出力許可信号.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- バッファライト I/F
    -------------------------------------------------------------------------------
        S_CLK       : --! @brief BUFFER WRITE CLOCK :
                      --! バッファ側のクロック信号.
                      in  std_logic;
        S_CKE       : --! @brief BUFFER WRITE CLOCK ENABLE :
                      --! バッファ側のクロック(S_CLK)の立上りが有効であることを示す信号.
                      in  std_logic;
        BUF_WDATA   : --! @brief BUFFER WRITE DATA :
                      --! バッファに書き込むデータ.
                      in  std_logic_vector(2**(BUF_WIDTH+3)-1 downto 0);
        BUF_WE      : --! @brief BUFFER WRITE ENABLE :
                      --! バッファ書き込みバイトイネーブル信号.
                      in  std_logic_vector(2**(BUF_WIDTH  )-1 downto 0);
        BUF_WADDR   : --! @brief BUFFER WRITE ADDRESS :
                      --! バッファ書き込みアドレス.
                      in  std_logic_vector(BUF_DEPTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- バッファ制御
    -------------------------------------------------------------------------------
        BUF_COUNT   : --! @brief BUFFER COUNT :
                      --! バッファに格納されているデータのバイト数を出力する.
                      out std_logic_vector(BUF_DEPTH   downto 0);
        BUF_CADDR   : --! @brief BUFFER CURRENT ADDRESS :
                      --! バッファの空いている先頭アドレスを出力する.
                      out std_logic_vector(BUF_DEPTH-1 downto 0);
        BUF_LAST    : --! @brief BUFFER LAST :
                      out std_logic;
        PUSH_SIZE   : --! @brief BUFFER PUSH SIZE :
                      --! バッファに書き込んだデータのバイト数を入力する.
                      in  std_logic_vector(BUF_DEPTH   downto 0);
        PUSH_LAST   : --! @brief BUFFER PUSH LAST :
                      in  std_logic;
        PUSH_LOAD   : --! @brief BUFFER PUSH LOAD :
                      --! バッファに書き込んだデータのバイト数(PUSH_COUNT)を
                      --! 入力してBUF_COUNTおよびBUF_CADDRを更新する信号.
                      in  std_logic;
        ABORT_START : --! @brief ABORT START :
                      --! 送信中止開始.
                      in  std_logic;
        ABORT_BUSY  : --! @brief ABORT BUSY :
                      --! 送信中止中であることを示す信号.
                      out std_logic;
        PAUSE_DATA  : --! @brief PAUSE LOAD :
                      --! 送信中断入力信号.
                      in  std_logic;
        PAUSE_LOAD  : --! @brief PAUSE LOAD :
                      --! 送信中断ロード信号.
                      in  std_logic;
        RESET_DATA  : --! @brief RESET DATA :
                      --! リセット入力信号.
                      in  std_logic;
        RESET_LOAD  : --! @brief RESET LOAD :
                      --! リセットロード信号.
                      in  std_logic
    );
end PTTY_TXD_BUF;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.COMPONENTS.SDPRAM;
use     PIPEWORK.COMPONENTS.REDUCER;
use     PIPEWORK.COMPONENTS.CHOPPER;
use     PIPEWORK.COMPONENTS.SYNCRONIZER;
use     PIPEWORK.COMPONENTS.SYNCRONIZER_INPUT_PENDING_REGISTER;
architecture RTL of PTTY_TXD_BUF is
    -------------------------------------------------------------------------------
    -- バッファ読み出し制御信号
    -------------------------------------------------------------------------------
    signal    buf_raddr         :  std_logic_vector(    BUF_DEPTH   -1 downto 0);
    signal    buf_rdata         :  std_logic_vector(2**(BUF_WIDTH+3)-1 downto 0);
    -------------------------------------------------------------------------------
    -- 出力側の各種信号
    -------------------------------------------------------------------------------
    signal    o_clear           :  std_logic;
    signal    o_reset           :  std_logic;
    signal    o_reset_data      :  std_logic;
    signal    o_reset_load      :  std_logic;
    signal    o_abort           :  std_logic;
    signal    o_abort_start     :  std_logic;
    signal    o_pause           :  std_logic;
    signal    o_pause_data      :  std_logic;
    signal    o_pause_load      :  std_logic;
    signal    o_push_size       :  std_logic_vector(BUF_DEPTH downto 0);
    signal    o_push_last       :  std_logic;
    signal    o_push_valid      :  std_logic;
    signal    o_pull_valid      :  std_logic;
    signal    o_pull_last       :  std_logic;
    signal    o_pull_size       :  std_logic_vector(BUF_DEPTH downto 0);
    -------------------------------------------------------------------------------
    -- バッファ書き込み側の各種信号
    -------------------------------------------------------------------------------
    signal    s_pull_size       :  std_logic_vector(BUF_DEPTH downto 0);
    signal    s_pull_last       :  std_logic;
    signal    s_pull_valid      :  std_logic;
    signal    s_abort_done      :  std_logic;
    signal    s_abort_busy      :  std_logic;
begin
    -------------------------------------------------------------------------------
    -- 出力側(O_BYTES > 1)
    -------------------------------------------------------------------------------
    O_SIDE: block
        signal    out_valid     :  std_logic;
        signal    out_ready     :  std_logic;
        signal    out_last      :  std_logic;
        signal    out_strb      :  std_logic_vector(O_BYTES-1 downto 0);
        signal    buf_valid     :  std_logic;
        signal    buf_ready     :  std_logic;
        signal    buf_last      :  std_logic;
        signal    buf_strb      :  std_logic_vector(2**BUF_WIDTH-1 downto 0);
    begin
        ---------------------------------------------------------------------------
        -- 出力 I/F
        ---------------------------------------------------------------------------
        O_STRB    <= out_strb;
        O_LAST    <= out_last;
        O_VALID   <= '1' when (out_valid = '1' and o_pause = '0') else '0';
        out_ready <= '1' when (O_READY   = '1' and o_pause = '0') else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        QUEUE: REDUCER                                --
            generic map (                             --
                WORD_BITS   => 8                    , --
                STRB_BITS   => 1                    , --
                I_WIDTH     => 2**BUF_WIDTH         , --
                O_WIDTH     => O_BYTES              , --
                QUEUE_SIZE  => 0                    , --
                VALID_MIN   => 0                    , --
                VALID_MAX   => 0                    , --
                O_SHIFT_MIN => O_BYTES              , --
                O_SHIFT_MAX => O_BYTES              , --
                I_JUSTIFIED => 0                    , --
                FLUSH_ENABLE=> 0                      --
            )                                         --
            port map (                                --
                CLK         => O_CLK                , -- In  :
                RST         => RST                  , -- In  :
                CLR         => o_clear              , -- In  :
                BUSY        => open                 , -- Out :
                VALID       => open                 , -- Out :
                I_DATA      => buf_rdata            , -- In  :
                I_STRB      => buf_strb             , -- In  :
                I_DONE      => buf_last             , -- In  :
                I_VAL       => buf_valid            , -- In  :
                I_RDY       => buf_ready            , -- Out :
                O_DATA      => O_DATA               , -- Out :
                O_STRB      => out_strb             , -- Out :
                O_DONE      => out_last             , -- Out :
                O_VAL       => out_valid            , -- Out :
                O_RDY       => out_ready              -- In  :
            );                                        -- 
        ---------------------------------------------------------------------------
        -- o_pull_valid : データの出力があったことを示す.
        -- o_pull_last  : 最後のデータの出力があったことを示すフラグ.
        -- o_pull_size  : データの出力バイト数(=バッファから読み出したバイト数)
        ---------------------------------------------------------------------------
        o_pull_valid <= '1' when (out_valid = '1' and out_ready = '1') else '0';
        o_pull_last  <= out_last;
        process (out_strb)
            variable o_size  : integer range 0 to O_BYTES;
            function count_bits(I: std_logic_vector) return integer is
                alias    vec : std_logic_vector(I'length-1 downto 0) is I;
                variable num : integer range 0 to vec'length;
            begin
                if (vec'length = 1) then
                    if vec(0) = '1' then
                        num := 1;
                    else
                        num := 0;
                    end if;
                else
                    num := count_bits(vec(vec'length/2-1 downto 0))
                         + count_bits(vec(vec'length  -1 downto vec'length/2));
                end if;
                return num;
            end function;
        begin
            if (O_BYTES > 1) then
                o_size := count_bits(out_strb);
            else
                o_size := 1;
            end if;
            o_pull_size <= std_logic_vector(to_unsigned(o_size, o_pull_size'length));
        end process;
        ---------------------------------------------------------------------------
        -- バッファ制御部
        ---------------------------------------------------------------------------
        CTRL: block
            signal    next_addr     :  std_logic_vector(BUF_DEPTH-1 downto 0);
            signal    curr_addr     :  std_logic_vector(BUF_DEPTH-1 downto 0);
            signal    next_count    :  std_logic_vector(BUF_DEPTH   downto 0);
            signal    curr_count    :  std_logic_vector(BUF_DEPTH   downto 0);
            signal    word_size     :  std_logic_vector(BUF_WIDTH   downto 0);
            signal    buf_empty     :  std_logic;
            signal    chop_last     :  std_logic;
            signal    push_last     :  std_logic;
        begin
            -----------------------------------------------------------------------
            -- next_count : 次のクロックでのバッファに格納されているバイト数
            -----------------------------------------------------------------------
            process (curr_count, buf_valid, buf_ready, word_size, o_push_valid, o_push_size, o_clear)
                variable temp_count : unsigned(BUF_DEPTH+1 downto 0);
            begin
                temp_count := to_01("0" & unsigned(curr_count));
                if (o_push_valid = '1') then
                    temp_count := temp_count + resize(to_01(unsigned(o_push_size)), temp_count'length);
                end if;
                if (buf_valid = '1' and buf_ready = '1') then
                    temp_count := temp_count - resize(to_01(unsigned(word_size  )), temp_count'length);
                end if;
                if (o_clear = '1') then
                    next_count <= (others => '0');
                else
                    next_count <= std_logic_vector(temp_count(next_count'range));
                end if;
            end process;
            -----------------------------------------------------------------------
            -- next_addr  : 次のクロックでのバッファから読み出すアドレス
            -----------------------------------------------------------------------
            process (curr_addr, buf_valid, buf_ready, word_size)
                variable temp_addr : unsigned(BUF_DEPTH-1 downto 0);
            begin
                temp_addr := to_01(unsigned(curr_addr));
                if (buf_valid = '1' and buf_ready = '1') then
                    temp_addr := temp_addr + to_01(unsigned(word_size));
                end if;
                next_addr <= std_logic_vector(temp_addr);
            end process;
            -----------------------------------------------------------------------
            -- curr_count : バッファに格納されているバイト数
            -- curr_addr  : バッファから読み出すアドレス
            -----------------------------------------------------------------------
            process (O_CLK, RST) begin
                if    (RST = '1') then
                        curr_addr  <= (others => '0');
                        curr_count <= (others => '0');
                elsif (O_CLK'event and O_CLK = '1') then
                    if (o_clear = '1') then
                        curr_addr  <= (others => '0');
                        curr_count <= (others => '0');
                    else
                        curr_addr  <= next_addr;
                        curr_count <= next_count;
                    end if;
                end if;
            end process;
            -----------------------------------------------------------------------
            -- word_size  : バッファから読み出すバイト数
            -- buf_strb   : バッファから QUEUE に転送する時のバイトネーブル信号
            -- buf_empty  : バッファが空であることを示すフラグ.
            -----------------------------------------------------------------------
            CHOP: CHOPPER                                 -- 
                generic map (                             -- 
                    BURST       => 1                    , --
                    MIN_PIECE   => BUF_WIDTH            , --
                    MAX_PIECE   => BUF_WIDTH            , --
                    MAX_SIZE    => BUF_DEPTH            , --
                    ADDR_BITS   => next_addr'length     , --
                    SIZE_BITS   => next_count'length    , --
                    COUNT_BITS  => next_count'length    , --
                    PSIZE_BITS  => word_size'length     , --
                    GEN_VALID   => 1                      -- 
                )                                         -- 
                port map (                                -- 
                    CLK         => O_CLK                , -- In  :
                    RST         => RST                  , -- In  :
                    CLR         => o_clear              , -- In  : 
                    ADDR        => next_addr            , -- In  :
                    SIZE        => next_count           , -- In  :
                    SEL         => "0"                  , -- In  :
                    LOAD        => '1'                  , -- In  :
                    CHOP        => '0'                  , -- In  :
                    COUNT       => open                 , -- Out :
                    NONE        => buf_empty            , -- Out :
                    LAST        => chop_last            , -- Out :
                    NEXT_NONE   => open                 , -- Out :
                    NEXT_LAST   => open                 , -- Out :
                    PSIZE       => word_size            , -- Out :
                    VALID       => buf_strb             , -- Out :
                    NEXT_VALID  => open                   -- Out :
                );                                        --
            -----------------------------------------------------------------------
            -- push_last :
            -----------------------------------------------------------------------
            process (O_CLK, RST) begin
                if    (RST = '1') then
                        push_last <= '0';
                elsif (O_CLK'event and O_CLK = '1') then
                    if (o_clear = '1') then
                        push_last <= '0';
                    elsif (o_push_valid = '1' and o_push_last = '1') then
                        push_last <= '1';
                    elsif (buf_valid = '1' and buf_ready = '1' and buf_last = '1') then
                        push_last <= '0';
                    end if;
                end if;
            end process;
            -----------------------------------------------------------------------
            -- buf_valid : バッファにデータがあることを示すフラグ.
            -- buf_last  : バッファの最後のデータであることを示すフラグ.
            -- buf_raddr : バッファ読み出しアドレス.
            -----------------------------------------------------------------------
            buf_valid <= '1' when (buf_empty = '0') else '0';
            buf_last  <= '1' when (push_last = '1' and chop_last = '1') else '0';
            buf_raddr <= next_addr;
            -----------------------------------------------------------------------
            -- o_reset   : 出力側をリセットする信号
            -- o_clear   : 出力側をリセットする信号
            -- o_pause   : 出力側を中断する信号
            -----------------------------------------------------------------------
            process (O_CLK, RST) begin
                if    (RST = '1') then
                        o_reset <= '1';
                        o_clear <= '1';
                        o_pause <= '1';
                elsif (O_CLK'event and O_CLK = '1') then
                    if (o_reset_load = '1') then
                        o_reset <= o_reset_data;
                    end if;
                    if (o_reset_load = '1' and o_reset_data = '1') or
                       (o_reset_load = '0' and o_reset      = '1') or
                       (o_abort_start = '1') then
                        o_clear <= '1';
                    else
                        o_clear <= '0';
                    end if;
                    if (o_pause_load = '1') then
                        o_pause <= o_pause_data;
                    end if;
                    o_abort <= o_abort_start;
                end if;
            end process;
        end block;
    end block;
    -------------------------------------------------------------------------------
    -- 出力側からバッファ書き込み側への信号の伝搬
    -------------------------------------------------------------------------------
    O2S: block
        constant sync_i_pause   :  std_logic := '0';
        constant sync_i_clear   :  std_logic := '0';
        constant sync_o_clear   :  std_logic := '0';
        constant SYNC_DATA_LOW  :  integer := 0;
        constant SYNC_SIZE_LOW  :  integer := SYNC_DATA_LOW;
        constant SYNC_SIZE_HIGH :  integer := SYNC_DATA_LOW  + o_pull_size'length-1;
        constant SYNC_LAST_POS  :  integer := SYNC_SIZE_HIGH + 1;
        constant SYNC_PULL_POS  :  integer := SYNC_LAST_POS;
        constant SYNC_ABORT_POS :  integer := SYNC_PULL_POS  + 1;
        constant SYNC_DATA_HIGH :  integer := SYNC_ABORT_POS;
        constant SYNC_SIZE      :  std_logic_vector(SYNC_SIZE_HIGH downto SYNC_SIZE_LOW) := (others => '0');
        constant SYNC_DATA      :  std_logic_vector(SYNC_DATA_HIGH downto SYNC_DATA_LOW) := (others => '0');
        constant SYNC_VALID     :  std_logic_vector(SYNC_ABORT_POS downto SYNC_PULL_POS) := (others => '0');
        signal   sync_i_data    :  std_logic_vector(SYNC_DATA 'range);
        signal   sync_i_valid   :  std_logic_vector(SYNC_VALID'range);
        signal   sync_i_ready   :  std_logic;
        signal   sync_o_data    :  std_logic_vector(SYNC_DATA 'range);
        signal   sync_o_valid   :  std_logic_vector(SYNC_VALID'range);
    begin
        SIZE: SYNCRONIZER_INPUT_PENDING_REGISTER  -- 
            generic map(                          -- 
                DATA_BITS   => SYNC_SIZE'length , -- 
                OPERATION   => 2                  -- 
            )                                     -- 
            port map (                            -- 
                CLK         => O_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => o_reset          , -- In  :
                I_DATA      => o_pull_size      , -- In  :
                I_VAL       => o_pull_valid     , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA      => sync_i_data(SYNC_SIZE'range),  -- Out :
                O_VAL       => open             , -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    -- 
        LAST: SYNCRONIZER_INPUT_PENDING_REGISTER  -- 
            generic map(                          -- 
                DATA_BITS   => 1                , -- 
                OPERATION   => 1                  -- 
            )                                     -- 
            port map (                            -- 
                CLK         => O_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => o_reset          , -- In  :
                I_DATA(0)   => o_pull_last      , -- In  :
                I_VAL       => o_pull_valid     , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA(0)   => sync_i_data (SYNC_LAST_POS), -- Out :
                O_VAL       => sync_i_valid(SYNC_PULL_POS), -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    -- 
        ABORT: SYNCRONIZER_INPUT_PENDING_REGISTER -- 
            generic map(                          -- 
                DATA_BITS   => 1                , -- 
                OPERATION   => 0                  -- 
            )                                     -- 
            port map (                            -- 
                CLK         => O_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => o_reset          , -- In  :
                I_DATA(0)   => '1'              , -- In  :
                I_VAL       => o_abort          , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA(0)   => sync_i_data (SYNC_ABORT_POS), -- Out :
                O_VAL       => sync_i_valid(SYNC_ABORT_POS), -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    -- 
        SYNC: SYNCRONIZER                         -- 
            generic map(                          -- 
                DATA_BITS   => SYNC_DATA'length , -- 
                VAL_BITS    => SYNC_VALID'length, -- 
                I_CLK_RATE  => O_CLK_RATE       , -- 
                O_CLK_RATE  => S_CLK_RATE       , -- 
                O_CLK_REGS  => 0                  -- 
            )                                     -- 
            port map (                            -- 
                RST         => RST              , -- In  :
                I_CLK       => O_CLK            , -- In  : 
                I_CLR       => sync_i_clear     , -- In  :
                I_CKE       => O_CKE            , -- In  :
                I_DATA      => sync_i_data      , -- In  :
                I_VAL       => sync_i_valid     , -- In  :
                I_RDY       => sync_i_ready     , -- Out :
                O_CLK       => S_CLK            , -- In  :
                O_CLR       => sync_o_clear     , -- In  :
                O_CKE       => S_CKE            , -- In  :
                O_DATA      => sync_o_data      , -- Out :
                O_VAL       => sync_o_valid       -- Out :
            );
        s_pull_size  <= sync_o_data (SYNC_SIZE'range);
        s_pull_last  <= sync_o_data (SYNC_LAST_POS);
        s_pull_valid <= sync_o_valid(SYNC_PULL_POS);
        s_abort_done <= sync_o_valid(SYNC_ABORT_POS);
    end block;
    -------------------------------------------------------------------------------
    -- バッファ書き込み側から出力側への信号の伝搬
    -------------------------------------------------------------------------------
    S2O: block
        constant sync_i_pause   :  std_logic := '0';
        constant sync_i_clear   :  std_logic := '0';
        constant sync_o_clear   :  std_logic := '0';
        constant SYNC_DATA_LOW  :  integer := 0;
        constant SYNC_SIZE_LOW  :  integer := SYNC_DATA_LOW;
        constant SYNC_SIZE_HIGH :  integer := SYNC_DATA_LOW  + PUSH_SIZE'length-1;
        constant SYNC_LAST_POS  :  integer := SYNC_SIZE_HIGH + 1;
        constant SYNC_PUSH_POS  :  integer := SYNC_LAST_POS;
        constant SYNC_ABORT_POS :  integer := SYNC_PUSH_POS  + 1;
        constant SYNC_PAUSE_POS :  integer := SYNC_ABORT_POS + 1;
        constant SYNC_RESET_POS :  integer := SYNC_PAUSE_POS + 1;
        constant SYNC_DATA_HIGH :  integer := SYNC_RESET_POS;
        constant SYNC_SIZE      :  std_logic_vector(SYNC_SIZE_HIGH  downto SYNC_SIZE_LOW) := (others => '0');
        constant SYNC_DATA      :  std_logic_vector(SYNC_DATA_HIGH  downto SYNC_DATA_LOW) := (others => '0');
        constant SYNC_VALID     :  std_logic_vector(SYNC_RESET_POS  downto SYNC_PUSH_POS) := (others => '0');
        signal   sync_i_data    :  std_logic_vector(SYNC_DATA 'range);
        signal   sync_i_valid   :  std_logic_vector(SYNC_VALID'range);
        signal   sync_i_ready   :  std_logic;
        signal   sync_o_data    :  std_logic_vector(SYNC_DATA'range);
        signal   sync_o_valid   :  std_logic_vector(SYNC_VALID'range);
    begin
        SIZE: SYNCRONIZER_INPUT_PENDING_REGISTER  -- 
            generic map(                          -- 
                DATA_BITS   => SYNC_SIZE'length , -- 
                OPERATION   => 2                  -- 
            )                                     -- 
            port map (                            -- 
                CLK         => S_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => sync_i_clear     , -- In  :
                I_DATA      => PUSH_SIZE        , -- In  :
                I_VAL       => PUSH_LOAD        , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA      => sync_i_data (SYNC_SIZE'range),  -- Out :
                O_VAL       => open             , -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    -- 
        LAST: SYNCRONIZER_INPUT_PENDING_REGISTER  -- 
            generic map(                          -- 
                DATA_BITS   => 1                , -- 
                OPERATION   => 1                  -- 
            )                                     -- 
            port map (                            -- 
                CLK         => S_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => sync_i_clear     , -- In  :
                I_DATA(0)   => PUSH_LAST        , -- In  :
                I_VAL       => PUSH_LOAD        , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA(0)   => sync_i_data (SYNC_LAST_POS), -- Out :
                O_VAL       => sync_i_valid(SYNC_PUSH_POS), -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    -- 
        ABORT:SYNCRONIZER_INPUT_PENDING_REGISTER  -- 
            generic map(                          -- 
                DATA_BITS   => 1                , -- 
                OPERATION   => 0                  -- 
            )                                     -- 
            port map (                            -- 
                CLK         => S_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => sync_i_clear     , -- In  :
                I_DATA(0)   => '1'              , -- In  :
                I_VAL       => ABORT_START      , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA(0)   => sync_i_data (SYNC_ABORT_POS), -- Out :
                O_VAL       => sync_i_valid(SYNC_ABORT_POS), -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    --
        PAUSE:SYNCRONIZER_INPUT_PENDING_REGISTER  -- 
            generic map(                          -- 
                DATA_BITS   => 1                , -- 
                OPERATION   => 0                  -- 
            )                                     -- 
            port map (                            -- 
                CLK         => S_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => sync_i_clear     , -- In  :
                I_DATA(0)   => PAUSE_DATA       , -- In  :
                I_VAL       => PAUSE_LOAD       , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA(0)   => sync_i_data (SYNC_PAUSE_POS), -- Out :
                O_VAL       => sync_i_valid(SYNC_PAUSE_POS), -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    -- 
        RESET:SYNCRONIZER_INPUT_PENDING_REGISTER  -- 
            generic map(                          -- 
                DATA_BITS   => 1                , -- 
                OPERATION   => 0                  -- 
            )                                     -- 
            port map (                            -- 
                CLK         => S_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => sync_i_clear     , -- In  :
                I_DATA(0)   => RESET_DATA       , -- In  :
                I_VAL       => RESET_LOAD       , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA(0)   => sync_i_data (SYNC_RESET_POS), -- Out :
                O_VAL       => sync_i_valid(SYNC_RESET_POS), -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    -- 
        SYNC: SYNCRONIZER                         -- 
            generic map(                          -- 
                DATA_BITS   => SYNC_DATA'length , -- 
                VAL_BITS    => SYNC_VALID'length, -- 
                I_CLK_RATE  => S_CLK_RATE       , -- 
                O_CLK_RATE  => O_CLK_RATE       , --
                O_CLK_REGS  => 1                  -- 
            )                                     -- 
            port map (                            -- 
                RST         => RST              , -- In  :
                I_CLK       => S_CLK            , -- In  : 
                I_CLR       => sync_i_clear     , -- In  :
                I_CKE       => S_CKE            , -- In  :
                I_DATA      => sync_i_data      , -- In  :
                I_VAL       => sync_i_valid     , -- In  :
                I_RDY       => sync_i_ready     , -- Out :
                O_CLK       => O_CLK            , -- In  :
                O_CLR       => sync_o_clear     , -- In  :
                O_CKE       => O_CKE            , -- In  :
                O_DATA      => sync_o_data      , -- Out :
                O_VAL       => sync_o_valid       -- Out :
            );
        o_push_size   <= sync_o_data (SYNC_SIZE'range);
        o_push_last   <= sync_o_data (SYNC_LAST_POS);
        o_push_valid  <= sync_o_valid(SYNC_PUSH_POS);
        o_abort_start <= sync_o_valid(SYNC_ABORT_POS);
        o_pause_data  <= sync_o_data (SYNC_PAUSE_POS);
        o_pause_load  <= sync_o_valid(SYNC_PAUSE_POS);
        o_reset_data  <= sync_o_data (SYNC_RESET_POS);
        o_reset_load  <= sync_o_valid(SYNC_RESET_POS);
    end block;
    -------------------------------------------------------------------------------
    -- バッファ書き込み側
    -------------------------------------------------------------------------------
    S_SIDE: block
        signal   curr_count :  unsigned(BUF_DEPTH   downto 0);
        signal   curr_addr  :  unsigned(BUF_DEPTH-1 downto 0);
    begin
        ---------------------------------------------------------------------------
        -- curr_count : バッファに格納されているバイト数
        -- curr_addr  : データが格納されているバッファの先頭アドレス
        ---------------------------------------------------------------------------
        process (S_CLK, RST)
            variable next_count : unsigned(BUF_DEPTH+1 downto 0);
            variable next_addr  : unsigned(BUF_DEPTH   downto 0);
        begin
            if    (RST = '1') then
                    curr_count <= (others => '0');
                    curr_addr  <= (others => '0');
            elsif (S_CLK'event and S_CLK = '1') then
                if (RESET_LOAD   = '1' and RESET_DATA = '1') or
                   (ABORT_START  = '1') or
                   (s_abort_busy = '1') then
                    curr_count <= (others => '0');
                    curr_addr  <= (others => '0');
                else
                    next_count := "0" & curr_count;
                    if (PUSH_LOAD    = '1') then
                        next_count := next_count + resize(unsigned(  PUSH_SIZE),next_count'length);
                    end if;
                    if (s_pull_valid = '1') then
                        next_count := next_count - resize(unsigned(s_pull_size),next_count'length);
                    end if;
                    curr_count <= next_count(curr_count'range);
                    if (PUSH_LOAD    = '1') then
                        next_addr := "0" & curr_addr;
                        next_addr := next_addr   + resize(unsigned(  PUSH_SIZE), next_addr'length);
                        curr_addr <= next_addr(curr_addr'range);
                    end if;
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- s_abort_busy : 転送中止中であることを示す.
        ---------------------------------------------------------------------------
        process (S_CLK, RST) begin
            if    (RST = '1') then
                    s_abort_busy <= '0';
            elsif (S_CLK'event and S_CLK = '1') then
                if    (RESET_LOAD = '1' and RESET_DATA = '1') then
                    s_abort_busy <= '0';
                elsif (s_abort_done = '1') then
                    s_abort_busy <= '0';
                elsif (ABORT_START  = '1') then
                    s_abort_busy <= '1';
                end if;
            end if;
        end process;
        ABORT_BUSY <= s_abort_busy;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        BUF_COUNT  <= std_logic_vector(curr_count);
        BUF_CADDR  <= std_logic_vector(curr_addr );
    end block;
    -------------------------------------------------------------------------------
    -- バッファメモリ
    -------------------------------------------------------------------------------
    RAM: SDPRAM                                  -- 
        generic map(                             -- 
            DEPTH       => BUF_DEPTH+3         , --
            RWIDTH      => BUF_WIDTH+3         , --
            WWIDTH      => BUF_WIDTH+3         , --
            WEBIT       => BUF_WIDTH           , --
            ID          => 0                     -- 
        )                                        -- 
        port map (                               -- 
            WCLK        => S_CLK               , -- In  :
            WE          => BUF_WE              , -- In  :
            WADDR       => BUF_WADDR(BUF_DEPTH-1 downto BUF_WIDTH), -- In  :
            WDATA       => BUF_WDATA           , -- In  :
            RCLK        => O_CLK               , -- In  :
            RADDR       => buf_raddr(BUF_DEPTH-1 downto BUF_WIDTH), -- In  :
            RDATA       => buf_rdata             -- Out :
        );
end RTL;
