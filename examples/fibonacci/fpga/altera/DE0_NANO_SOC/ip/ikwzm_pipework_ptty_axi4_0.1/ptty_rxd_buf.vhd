-----------------------------------------------------------------------------------
--!     @file    ptty_rxd_buf.vhd
--!     @brief   Receive Data Buffer for PTTY_AXI4
--!     @version 0.2.0
--!     @date    2015/11/3
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
--! @brief 受信バッファ
-----------------------------------------------------------------------------------
entity  PTTY_RXD_BUF is
    generic (
        BUF_DEPTH   : --! @brief BUFFER DEPTH :
                      --! バッファの容量(バイト数)を２のべき乗値で指定する.
                      integer := 8;
        BUF_WIDTH   : --! @brief BUFFER DATA WIDTH :
                      --! バッファのデータ幅(バイト数)を２のべき乗値で指定する.
                      integer := 2;
        I_BYTES     : --! @brief INTAKE DATA WIDTH :
                      --! 入力側のデータ幅(バイト数)を指定する.
                      integer := 1;
        I_CLK_RATE  : --! @brief INTAKE CLOCK RATE :
                      --! S_CLK_RATEとペアで入力側のクロック(I_CLK)とバッファアクセ
                      --! ス側のクロック(S_CLK)との関係を指定する.
                      integer :=  1;
        S_CLK_RATE  : --! @brief BUFFER ACCESS CLOCK RATE :
                      --! I_CLK_RATEとペアで入力側のクロック(I_CLK)とバッファアクセ
                      --! ス側のクロック(S_CLK)との関係を指定する.
                      integer :=  1
    );
    port (
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側の信号
    -------------------------------------------------------------------------------
        I_CLK       : --! @brief INTAKE CLOCK :
                      --! 入力側のクロック信号.
                      in  std_logic;
        I_CKE       : --! @brief INTAKE CLOCK ENABLE :
                      --! 入力側のクロック(I_CLK)の立上りが有効であることを示す信号.
                      in  std_logic;
        I_DATA      : --! @brief INTAKE DATA :
                      --! 入力側データ
                      in  std_logic_vector(8*I_BYTES-1 downto 0);
        I_STRB      : --! @brief INTAKE STROBE :
                      --! 入力側データ
                      in  std_logic_vector(  I_BYTES-1 downto 0) := (others => '1');
        I_LAST      : --! @brief INTAKE LAST :
                      --! 入力側データ
                      in  std_logic;
        I_VALID     : --! @brief INTAKE ENABLE :
                      --! 入力有効信号.
                      in  std_logic;
        I_READY     : --! @brief INTAKE READY :
                      --! 入力許可信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- バッファリード I/F
    -------------------------------------------------------------------------------
        S_CLK       : --! @brief BUFFER READ CLOCK :
                      --! バッファ側のクロック信号.
                      in  std_logic;
        S_CKE       : --! @brief BUFFER READ CLOCK ENABLE :
                      --! バッファ側のクロック(S_CLK)の立上りが有効であることを示す信号.
                      in  std_logic;
        BUF_RDATA   : --! @brief BUFFER READ DATA :
                      --! バッファから読み出したデータ.
                      --! BUF_RADDR で指定されたアドレスの１クロック後に対応するデー
                      --! タを出力する.
                      out std_logic_vector(2**(BUF_WIDTH+3)-1 downto 0);
        BUF_RADDR   : --! @brief BUFFER READ ADDRESS :
                      --! バッファから読み出すアドレス.
                      in  std_logic_vector(BUF_DEPTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- バッファ制御
    -------------------------------------------------------------------------------
        BUF_COUNT   : --! @brief BUFFER COUNT :
                      --! バッファに格納されているデータのバイト数を出力する.
                      out std_logic_vector(BUF_DEPTH   downto 0);
        BUF_CADDR   : --! @brief BUFFER CURRENT ADDRESS :
                      --! データが格納されているバッファの先頭アドレスを出力する.
                      out std_logic_vector(BUF_DEPTH-1 downto 0);
        BUF_LAST    : --! @brief BUFFER LAST :
                      --! 入力側から I_LAST がアサートされたことを示す.
                      out std_logic;
        PULL_SIZE   : --! @brief BUFFER PULL SIZE :
                      --! バッファから読み出したデータのバイト数を入力する.
                      in  std_logic_vector(BUF_DEPTH   downto 0);
        PULL_LOAD   : --! @brief BUFFER PULL LOAD :
                      --! バッファから読み出したデータのバイト数(PULL_COUNT)を
                      --! 入力してBUF_COUNTおよびBUF_CADDRを更新する信号.
                      in  std_logic;
        ABORT_START : --! @brief ABORT START :
                      --! 受信中止開始.
                      in  std_logic;
        ABORT_BUSY  : --! @brief ABORT BUSY :
                      --! 受信中止中であることを示す信号.
                      out std_logic;
        PAUSE_DATA  : --! @brief PAUSE LOAD :
                      --! 受信中断入力信号.
                      in  std_logic;
        PAUSE_LOAD  : --! @brief PAUSE LOAD :
                      --! 受信中断ロード信号.
                      in  std_logic;
        RESET_DATA  : --! @brief RESET DATA :
                      --! リセット入力信号.
                      in  std_logic;
        RESET_LOAD  : --! @brief RESET LOAD :
                      --! リセットロード信号.
                      in  std_logic
    );
end PTTY_RXD_BUF;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.COMPONENTS.SDPRAM;
use     PIPEWORK.COMPONENTS.REDUCER;
use     PIPEWORK.COMPONENTS.SYNCRONIZER;
use     PIPEWORK.COMPONENTS.SYNCRONIZER_INPUT_PENDING_REGISTER;
architecture RTL of PTTY_RXD_BUF is
    -------------------------------------------------------------------------------
    -- バッファ書き込み制御信号
    -------------------------------------------------------------------------------
    signal    buf_waddr         :  std_logic_vector(    BUF_DEPTH   -1 downto 0);
    signal    buf_wdata         :  std_logic_vector(2**(BUF_WIDTH+3)-1 downto 0);
    signal    buf_we            :  std_logic_vector(2**(BUF_WIDTH  )-1 downto 0);
    -------------------------------------------------------------------------------
    -- 入力側の各種信号
    -------------------------------------------------------------------------------
    signal    i_reset           :  std_logic;
    signal    i_reset_data      :  std_logic;
    signal    i_reset_load      :  std_logic;
    signal    i_pull_size       :  std_logic_vector(BUF_DEPTH   downto 0);
    signal    i_pull_valid      :  std_logic;
    signal    i_push_size       :  std_logic_vector(BUF_DEPTH   downto 0);
    signal    i_push_last       :  std_logic;
    signal    i_push_valid      :  std_logic;
    signal    i_abort           :  std_logic;
    signal    i_abort_start     :  std_logic;
    signal    i_pause           :  std_logic;
    signal    i_pause_data      :  std_logic;
    signal    i_pause_load      :  std_logic;
    -------------------------------------------------------------------------------
    -- バッファ読み出し側の各種信号
    -------------------------------------------------------------------------------
    signal    s_push_size       :  std_logic_vector(BUF_DEPTH   downto 0);
    signal    s_push_last       :  std_logic;
    signal    s_push_valid      :  std_logic;
    signal    s_abort_done      :  std_logic;
    signal    s_abort_busy      :  std_logic;
begin
    -------------------------------------------------------------------------------
    -- 入力側ブロック
    -------------------------------------------------------------------------------
    I_SIDE: block
        signal   buf_counter    :  unsigned(BUF_DEPTH downto 0);
        signal   buf_ready      :  boolean;
        signal   intake_ready   :  boolean;
    begin
        ---------------------------------------------------------------------------
        -- 入力側のデータ幅が１バイトの場合...
        ---------------------------------------------------------------------------
        I1: if (I_BYTES = 1) generate
            -----------------------------------------------------------------------
            -- i_push_size  : 書き込みバイト数
            -- i_push_last  : 最後の書き込みであることを示す信号
            -- i_push_valid : 書き込み信号
            -----------------------------------------------------------------------
            i_push_size  <= std_logic_vector(to_unsigned(1, i_push_size'length)) when I_STRB(0) = '1' else
                            std_logic_vector(to_unsigned(0, i_push_size'length));
            i_push_last  <= I_LAST;
            i_push_valid <= '1' when (I_VALID = '1' and buf_ready) else '0';
            I_READY      <= '1' when (intake_ready) else '0';
            -----------------------------------------------------------------------
            -- buf_wdata    : バッファ書き込みデータ
            -----------------------------------------------------------------------
            process (I_DATA) begin
                for i in buf_we'range loop
                    buf_wdata(8*(i+1)-1 downto 8*i) <= I_DATA;
                end loop;
            end process;
            -----------------------------------------------------------------------
            -- buf_we       : バッファ書き込みイネーブル信号(バイト単位)
            -----------------------------------------------------------------------
            process (buf_waddr, i_push_valid, I_STRB) begin
                for i in buf_we'range loop
                    if (BUF_WIDTH > 0) then
                        if (i_push_valid = '1') and
                           (I_STRB(0)    = '1') and
                           (i = to_01(unsigned(buf_waddr(BUF_WIDTH-1 downto 0)))) then
                            buf_we(i) <= '1';
                        else
                            buf_we(i) <= '0';
                        end if;
                    else
                        if (i_push_valid = '1') and
                           (I_STRB(0)    = '1') then
                            buf_we(i) <= '1';
                        else
                            buf_we(i) <= '0';
                        end if;
                    end if;
                end loop;
            end process;
        end generate;
        ---------------------------------------------------------------------------
        -- 入力側のデータ幅が２バイト以上の場合...
        ---------------------------------------------------------------------------
        I2: if (I_BYTES > 1) generate
            signal    queue_valid    :  std_logic;
            signal    queue_ready    :  std_logic;
            signal    queue_last     :  std_logic;
            signal    queue_strb     :  std_logic_vector(2**(BUF_WIDTH  )-1 downto 0);
        begin
            -----------------------------------------------------------------------
            -- 入力キュー兼バイトシフタ
            -----------------------------------------------------------------------
            QUEUE: REDUCER                                -- 
                generic map (                             --
                    WORD_BITS   => 8                    , --
                    STRB_BITS   => 1                    , --
                    I_WIDTH     => I_BYTES              , --
                    O_WIDTH     => 2**BUF_WIDTH         , --
                    QUEUE_SIZE  => 0                    , --
                    VALID_MIN   => 0                    , --
                    VALID_MAX   => 0                    , --
                    O_SHIFT_MIN => 2**BUF_WIDTH         , --
                    O_SHIFT_MAX => 2**BUF_WIDTH         , --
                    I_JUSTIFIED => 1                    , --
                    FLUSH_ENABLE=> 1                      -- DONEの替わりにFLUSHを使う.
                )                                         --
                port map (                                --
                    CLK         => I_CLK                , -- In  :
                    RST         => RST                  , -- In  :
                    CLR         => i_reset              , -- In  :
                    BUSY        => open                 , -- Out :
                    VALID       => open                 , -- Out :
                    I_DATA      => I_DATA               , -- In  :
                    I_STRB      => I_STRB               , -- In  :
                    I_DONE      => '0'                  , -- In  :
                    I_FLUSH     => I_LAST               , -- In  :
                    I_VAL       => I_VALID              , -- In  :
                    I_RDY       => I_READY              , -- Out :
                    O_DATA      => buf_wdata            , -- Out :
                    O_STRB      => queue_strb           , -- Out :
                    O_DONE      => open                 , -- Out :
                    O_FLUSH     => queue_last           , -- Out :
                    O_VAL       => queue_valid          , -- Out :
                    O_RDY       => queue_ready            -- In  :
                );                                        --
            queue_ready  <= '1' when (intake_ready = TRUE) else '0';
            -----------------------------------------------------------------------
            -- buf_we       : バッファ書き込みイネーブル信号(バイト単位)
            -----------------------------------------------------------------------
            buf_we       <= queue_strb when (i_push_valid = '1') else (others => '0');
            -----------------------------------------------------------------------
            -- i_push_last  : 最後の書き込みであることを示す信号
            -- i_push_valid : 書き込み信号
            -----------------------------------------------------------------------
            i_push_valid <= '1' when (queue_valid = '1' and buf_ready) else '0';
            i_push_last  <= '1' when (queue_last  = '1') else '0';
            -----------------------------------------------------------------------
            -- i_push_size  : 書き込みバイト数
            -----------------------------------------------------------------------
            process (queue_strb)
                variable i_size  : integer range 0 to I_BYTES;
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
                i_size := count_bits(queue_strb);
                i_push_size <= std_logic_vector(to_unsigned(i_size, i_push_size'length));
            end process;
        end generate;
        ---------------------------------------------------------------------------
        -- buf_waddr    : バッファ書き込みアドレス
        -- buf_counter  : バッファに格納されているバイト数
        -- buf_ready    : バッファに空きがあることを示すフラグ
        -- intake_ready : 入力許可信号. buf_ready とリセット時の値が違うことに注意.
        ---------------------------------------------------------------------------
        process (I_CLK, RST)
            variable next_counter :  unsigned(BUF_DEPTH+1 downto 0);
            variable next_addr    :  unsigned(BUF_DEPTH+1 downto 0);
        begin
            if    (RST = '1') then
                    buf_waddr    <= (others => '0');
                    buf_counter  <= (others => '0');
                    buf_ready    <= FALSE;
                    intake_ready <= TRUE;
            elsif (I_CLK'event and I_CLK = '1') then
                if (i_reset = '1' or i_abort = '1') then
                    buf_waddr    <= (others => '0');
                    buf_counter  <= (others => '0');
                    buf_ready    <= FALSE;
                    intake_ready <= TRUE;
                else
                    next_counter := "0" & buf_counter;
                    if (i_push_valid = '1') then
                        next_counter := next_counter + resize(unsigned(i_push_size),next_counter'length);
                    end if;
                    if (i_pull_valid = '1') then
                        next_counter := next_counter - resize(unsigned(i_pull_size),next_counter'length);
                    end if;
                    buf_counter <= next_counter(buf_counter'range);
                    if (next_counter <= 2**BUF_DEPTH - I_BYTES) and (i_pause = '0') then
                        buf_ready    <= TRUE;
                        intake_ready <= TRUE;
                    else
                        buf_ready    <= FALSE;
                        intake_ready <= FALSE;
                    end if;
                    if (i_push_valid = '1') then
                        next_addr := "00" & unsigned(buf_waddr);
                        next_addr := next_addr + resize(unsigned(i_push_size), next_addr'length);
                        buf_waddr <= std_logic_vector(next_addr(buf_waddr'range));
                    end if;
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (I_CLK, RST) begin
            if    (RST = '1') then
                    i_reset <= '1';
                    i_abort <= '0';
                    i_pause <= '0';
            elsif (I_CLK'event and I_CLK = '1') then
                if (i_reset_load = '1') then
                    i_reset <= i_reset_data;
                end if;
                if (i_abort_start = '1') then
                    i_abort <= '1';
                else
                    i_abort <= '0';
                end if;
                if (i_reset = '1') then
                    i_pause <= '0';
                elsif (i_pause_load = '1') then
                    i_pause <= i_pause_data;
                end if;
            end if;
        end process;
    end block;
    -------------------------------------------------------------------------------
    -- 入力側からバッファ読み出し側への信号の伝搬
    -------------------------------------------------------------------------------
    I2S: block
        constant sync_i_pause   :  std_logic := '0';
        constant sync_i_clear   :  std_logic := '0';
        constant sync_o_clear   :  std_logic := '0';
        constant SYNC_DATA_LOW  :  integer := 0;
        constant SYNC_SIZE_LOW  :  integer := SYNC_DATA_LOW;
        constant SYNC_SIZE_HIGH :  integer := SYNC_DATA_LOW  + i_push_size'length-1;
        constant SYNC_LAST_POS  :  integer := SYNC_SIZE_HIGH + 1;
        constant SYNC_PUSH_POS  :  integer := SYNC_LAST_POS;
        constant SYNC_ABORT_POS :  integer := SYNC_PUSH_POS  + 1;
        constant SYNC_DATA_HIGH :  integer := SYNC_ABORT_POS;
        constant SYNC_SIZE      :  std_logic_vector(SYNC_SIZE_HIGH downto SYNC_SIZE_LOW) := (others => '0');
        constant SYNC_DATA      :  std_logic_vector(SYNC_DATA_HIGH downto SYNC_DATA_LOW) := (others => '0');
        constant SYNC_VALID     :  std_logic_vector(SYNC_ABORT_POS downto SYNC_PUSH_POS) := (others => '0');
        signal   sync_i_data    :  std_logic_vector(SYNC_DATA'range);
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
                CLK         => I_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => i_reset          , -- In  :
                I_DATA      => i_push_size      , -- In  :
                I_VAL       => i_push_valid     , -- In  :
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
                CLK         => I_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => i_reset          , -- In  :
                I_DATA(0)   => i_push_last      , -- In  :
                I_VAL       => i_push_valid     , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA(0)   => sync_i_data (SYNC_LAST_POS), -- Out :
                O_VAL       => sync_i_valid(SYNC_PUSH_POS), -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    -- 
        ABORT: SYNCRONIZER_INPUT_PENDING_REGISTER -- 
            generic map(                          -- 
                DATA_BITS   => 1                , -- 
                OPERATION   => 0                  -- 
            )                                     -- 
            port map (                            -- 
                CLK         => I_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => i_reset          , -- In  :
                I_DATA(0)   => '1'              , -- In  :
                I_VAL       => i_abort          , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA(0)   => sync_i_data (SYNC_ABORT_POS), -- Out :
                O_VAL       => sync_i_valid(SYNC_ABORT_POS), -- Out :
                O_RDY       => sync_i_ready       -- In  :
            );                                    -- 
        SYNC: SYNCRONIZER                         -- 
            generic map(                          -- 
                DATA_BITS   => SYNC_DATA'length , -- 
                VAL_BITS    => SYNC_VALID'length, -- 
                I_CLK_RATE  => I_CLK_RATE       , -- 
                O_CLK_RATE  => S_CLK_RATE       , -- 
                O_CLK_REGS  => 1                  -- 
            )                                     -- 
            port map (                            -- 
                RST         => RST              , -- In  :
                I_CLK       => I_CLK            , -- In  : 
                I_CLR       => sync_i_clear     , -- In  :
                I_CKE       => I_CKE            , -- In  :
                I_DATA      => sync_i_data      , -- In  :
                I_VAL       => sync_i_valid     , -- In  :
                I_RDY       => sync_i_ready     , -- Out :
                O_CLK       => S_CLK            , -- In  :
                O_CLR       => sync_o_clear     , -- In  :
                O_CKE       => S_CKE            , -- In  :
                O_DATA      => sync_o_data      , -- Out :
                O_VAL       => sync_o_valid       -- Out :
            );
        s_push_size  <= sync_o_data (SYNC_SIZE'range);
        s_push_last  <= sync_o_data (SYNC_LAST_POS);
        s_push_valid <= sync_o_valid(SYNC_PUSH_POS);
        s_abort_done <= sync_o_valid(SYNC_ABORT_POS);
    end block;
    -------------------------------------------------------------------------------
    -- バッファ読み出し側から入力側への信号の伝搬
    -------------------------------------------------------------------------------
    S2I: block
        constant sync_i_pause   :  std_logic := '0';
        constant sync_i_clear   :  std_logic := '0';
        constant sync_o_clear   :  std_logic := '0';
        constant SYNC_DATA_LOW  :  integer := 0;
        constant SYNC_SIZE_LOW  :  integer := SYNC_DATA_LOW;
        constant SYNC_SIZE_HIGH :  integer := SYNC_DATA_LOW  + i_push_size'length-1;
        constant SYNC_PULL_POS  :  integer := SYNC_SIZE_HIGH;
        constant SYNC_ABORT_POS :  integer := SYNC_PULL_POS  + 1;
        constant SYNC_PAUSE_POS :  integer := SYNC_ABORT_POS + 1;
        constant SYNC_RESET_POS :  integer := SYNC_PAUSE_POS + 1;
        constant SYNC_DATA_HIGH :  integer := SYNC_RESET_POS;
        constant SYNC_SIZE      :  std_logic_vector(SYNC_SIZE_HIGH downto SYNC_SIZE_LOW) := (others => '0');
        constant SYNC_DATA      :  std_logic_vector(SYNC_DATA_HIGH downto SYNC_DATA_LOW) := (others => '0');
        constant SYNC_VALID     :  std_logic_vector(SYNC_RESET_POS downto SYNC_PULL_POS) := (others => '0');
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
                CLK         => S_CLK            , -- In  : 
                RST         => RST              , -- In  : 
                CLR         => sync_i_clear     , -- In  :
                I_DATA      => PULL_SIZE        , -- In  :
                I_VAL       => PULL_LOAD        , -- In  :
                I_PAUSE     => sync_i_pause     , -- In  :
                O_DATA      => sync_i_data (SYNC_SIZE'range), -- Out :
                O_VAL       => sync_i_valid(SYNC_PULL_POS  ), -- Out :
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
                O_CLK_RATE  => I_CLK_RATE       , -- 
                O_CLK_REGS  => 0                  -- 
            )                                     -- 
            port map (                            -- 
                RST         => RST              , -- In  :
                I_CLK       => S_CLK            , -- In  : 
                I_CLR       => sync_i_clear     , -- In  :
                I_CKE       => S_CKE            , -- In  :
                I_DATA      => sync_i_data      , -- In  :
                I_VAL       => sync_i_valid     , -- In  :
                I_RDY       => sync_i_ready     , -- Out :
                O_CLK       => I_CLK            , -- In  :
                O_CLR       => sync_o_clear     , -- In  :
                O_CKE       => I_CKE            , -- In  :
                O_DATA      => sync_o_data      , -- Out :
                O_VAL       => sync_o_valid       -- Out :
            );
        i_pull_size   <= sync_o_data (SYNC_SIZE'range);
        i_pull_valid  <= sync_o_valid(SYNC_PULL_POS );
        i_abort_start <= sync_o_valid(SYNC_ABORT_POS);
        i_pause_data  <= sync_o_data (SYNC_PAUSE_POS);
        i_pause_load  <= sync_o_valid(SYNC_PAUSE_POS);
        i_reset_data  <= sync_o_data (SYNC_RESET_POS);
        i_reset_load  <= sync_o_valid(SYNC_RESET_POS);
    end block;
    -------------------------------------------------------------------------------
    -- バッファ読み出し側
    -------------------------------------------------------------------------------
    S_SIDE: block
        signal   buf_counter    :  unsigned(BUF_DEPTH   downto 0);
        signal   buf_curr_addr  :  unsigned(BUF_DEPTH-1 downto 0);
    begin
        ---------------------------------------------------------------------------
        -- buf_counter   : バッファに格納されているバイト数
        -- buf_curr_addr : データが格納されているバッファの先頭アドレス
        ---------------------------------------------------------------------------
        process (S_CLK, RST)
            variable next_counter  : unsigned(BUF_DEPTH+1 downto 0);
            variable buf_next_addr : unsigned(BUF_DEPTH   downto 0);
        begin
            if    (RST = '1') then
                    buf_counter   <= (others => '0');
                    buf_curr_addr <= (others => '0');
                    BUF_LAST      <= '0';
            elsif (S_CLK'event and S_CLK = '1') then
                if (RESET_LOAD   = '1' and RESET_DATA = '1') or
                   (ABORT_START  = '1') or
                   (s_abort_busy = '1') then
                    buf_counter   <= (others => '0');
                    buf_curr_addr <= (others => '0');
                    BUF_LAST      <= '0';
                else
                    next_counter := "0" & buf_counter;
                    if (s_push_valid = '1') then
                        next_counter := next_counter   + resize(unsigned(s_push_size), next_counter'length);
                    end if;
                    if (PULL_LOAD    = '1') then
                        next_counter := next_counter   - resize(unsigned(  PULL_SIZE), next_counter'length);
                    end if;
                    buf_counter   <= next_counter(buf_counter'range);
                    buf_next_addr := "0" & buf_curr_addr;
                    if (PULL_LOAD    = '1') then
                        buf_next_addr := buf_next_addr + resize(unsigned(  PULL_SIZE),buf_next_addr'length);
                    end if;
                    buf_curr_addr <= buf_next_addr(buf_curr_addr'range);
                    if    (s_push_valid = '1') then
                        BUF_LAST <= s_push_last;
                    elsif (PULL_LOAD    = '1') then
                        BUF_LAST <= '0';
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
        BUF_COUNT  <= std_logic_vector(buf_counter);
        BUF_CADDR  <= std_logic_vector(buf_curr_addr);
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
            ID          => 1                     -- 
        )                                        -- 
        port map (                               -- 
            WCLK        => I_CLK               , -- In  :
            WE          => buf_we              , -- In  :
            WADDR       => buf_waddr(BUF_DEPTH-1 downto BUF_WIDTH), -- In  :
            WDATA       => buf_wdata           , -- In  :
            RCLK        => S_CLK               , -- In  :
            RADDR       => BUF_RADDR(BUF_DEPTH-1 downto BUF_WIDTH), -- In  :
            RDATA       => BUF_RDATA             -- Out :
        );
end RTL;
