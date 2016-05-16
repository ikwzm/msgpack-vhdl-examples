-----------------------------------------------------------------------------------
--!     @file    ptty_rx
--!     @brief   PTTY Receive Data Core
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
--
-----------------------------------------------------------------------------------
entity  PTTY_RX is
    generic (
        PORT_NUM        : --! @brief TRANSMIT PORT NUMBER :
                          --! ポート番号を指定する.
                          --! ヘッダレジスタの値に反映される.
                          integer range 0 to 99   :=  0;
        RXD_BUF_DEPTH   : --! @brief RECEIVE DATA BUFFER DEPTH :
                          --! バッファの容量(バイト数)を２のべき乗値で指定する.
                          integer range 4 to   15 :=  7;
        RXD_BUF_BASE    : --! @brief RECEIVE DATA BUFFER BASE ADDRESS :
                          --! バッファのベースアドレスを指定する.
                          integer := 16#0000#;
        CSR_ADDR_WIDTH  : --! @brief REGISTER INTERFACE ADDRESS WIDTH :
                          --! レジスタアクセスのアドレスのビット幅を指定する.
                          integer range 1 to   64 := 32;
        CSR_DATA_WIDTH  : --! @brief REGISTER INTERFACE DATA WIDTH :
                          --! レジスタアクセスのデータのビット幅を指定する.
                          integer range 8 to 1024 := 32;
        RXD_BYTES       : --! @brief RECEIVE DATA DATA WIDTH :
                          --! 入力側のデータ幅(バイト数)を指定する.
                          integer := 1;
        RXD_CLK_RATE    : --! @brief RECEIVE DATA CLOCK RATE :
                          --! CSR_CLK_RATEとペアで入力側のクロック(RXD_CLK)とレジス
                          --! タアクセス側のクロック(C_CLK)との関係を指定する.
                          integer := 1;
        CSR_CLK_RATE      : --! @brief REGISTER INTERFACE CLOCK RATE :
                          --! RXD_CLK_RATEとペアで入力側のクロック(RXD_CLK)とレジス
                          --! タアクセス側のクロック(C_CLK)との関係を指定する.
                          integer := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Reset Signals.
    -------------------------------------------------------------------------------
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register Access Interface
    -------------------------------------------------------------------------------
        CSR_CLK         : --! @breif REGISTER INTERFACE CLOCK :
                          in  std_logic;
        CSR_CKE         : --! @breif REGISTER INTERFACE CLOCK ENABLE:
                          in  std_logic;
        CSR_ADDR        : --! @breif REGISTER ADDRESS :
                          in  std_logic_vector(CSR_ADDR_WIDTH  -1 downto 0);
        CSR_BEN         : --! @breif REGISTER BYTE ENABLE :
                          in  std_logic_vector(CSR_DATA_WIDTH/8-1 downto 0);
        CSR_WDATA       : --! @breif REGISTER WRITE DATA :
                          in  std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
        CSR_RDATA       : --! @breif REGISTER READ DATA :
                          out std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
        CSR_REG_REQ     : --! @breif REGISTER ACCESS REQUEST :
                          in  std_logic;
        CSR_BUF_REQ     : --! @breif REGISTER ACCESS REQUEST :
                          in  std_logic;
        CSR_WRITE       : --! @breif REGISTER ACCESS WRITE  :
                          in  std_logic;
        CSR_ACK         : --! @breif REGISTER ACCESS ACKNOWLEDGE :
                          out std_logic;
        CSR_ERR         : --! @breif REGISTER ACCESS ERROR ACKNOWLEDGE :
                          out std_logic;
        CSR_IRQ         : --! @breif INTERRUPT
                          out std_logic;
    -------------------------------------------------------------------------------
    -- 入力側の信号
    -------------------------------------------------------------------------------
        RXD_CLK         : --! @brief RECEIVE DATA CLOCK :
                          --! 入力側のクロック信号.
                          in  std_logic;
        RXD_CKE         : --! @brief RECEIVE DATA CLOCK ENABLE :
                          --! 入力側のクロック(RXD_CLK)の立上りが有効であることを示す信号.
                          in  std_logic;
        RXD_DATA        : --! @brief RECEIVE DATA DATA :
                          --! 入力側データ
                          in  std_logic_vector(8*RXD_BYTES-1 downto 0);
        RXD_STRB        : --! @brief RECEIVE DATA STROBE :
                          --! 入力側データ
                          in  std_logic_vector(  RXD_BYTES-1 downto 0);
        RXD_LAST        : --! @brief RECEIVE DATA LAST :
                          --! 入力側データ
                          in  std_logic;
        RXD_VALID       : --! @brief RECEIVE DATA ENABLE :
                          --! 入力有効信号.
                          in  std_logic;
        RXD_READY       : --! @brief RECEIVE DATA READY :
                          --! 入力許可信号.
                          out std_logic
    );
end PTTY_RX;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.COMPONENTS.REGISTER_ACCESS_ADAPTER;
architecture RTL of PTTY_RX is
    -------------------------------------------------------------------------------
    -- RXD_BUF_WIDTH : 受信バッファのデータ幅のバイト数を２のべき乗で示した値.
    -------------------------------------------------------------------------------
    function   CALC_RXD_BUF_WIDTH return integer is
        variable width : integer;
    begin
        width := 0;
        while (2**(width+3) < CSR_DATA_WIDTH) loop
            width := width + 1;
        end loop;
        return width;
    end function;
    constant   RXD_BUF_WIDTH         :  integer := CALC_RXD_BUF_WIDTH;
    -------------------------------------------------------------------------------
    -- レジスタアクセスインターフェースのアドレスのビット数.
    -------------------------------------------------------------------------------
    constant   REGS_ADDR_WIDTH    :  integer := 4;
    -------------------------------------------------------------------------------
    -- 全レジスタのビット数.
    -------------------------------------------------------------------------------
    constant   REGS_DATA_BITS     :  integer := (2**REGS_ADDR_WIDTH)*8;
    -------------------------------------------------------------------------------
    -- レジスタアクセス用の信号群.
    -------------------------------------------------------------------------------
    signal     regs_addr          :  std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
    signal     regs_rdata         :  std_logic_vector(CSR_DATA_WIDTH   -1 downto 0);
    signal     regs_ack           :  std_logic;
    signal     regs_err           :  std_logic;
    signal     regs_load          :  std_logic_vector(REGS_DATA_BITS   -1 downto 0);
    signal     regs_wbit          :  std_logic_vector(REGS_DATA_BITS   -1 downto 0);
    signal     regs_rbit          :  std_logic_vector(REGS_DATA_BITS   -1 downto 0);
    -------------------------------------------------------------------------------
    -- バッファアクセス用の信号群.
    -------------------------------------------------------------------------------
    signal     rbuf_addr          :  std_logic_vector(RXD_BUF_DEPTH    -1 downto 0);
    signal     rbuf_ack           :  std_logic;
    signal     rbuf_err           :  std_logic;
    signal     rbuf_rdata         :  std_logic_vector(CSR_DATA_WIDTH   -1 downto 0);
    -------------------------------------------------------------------------------
    -- レジスタのアドレスマップ.
    -------------------------------------------------------------------------------
    --           31            24              16               8               0
    --           +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    -- Addr=0x00 |                      Header[31:00]                            |
    --           +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    -- Addr=0x04 |                   Configuration[31:00]                        |
    --           +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    -- Addr=0x08 |          BufPtr[15:0]         |       BufCount[15:00]         |
    --           +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    -- Addr=0x0C | Control[7:0]  |  Status[7:0]  |       PullSize[15:00]         |
    --           +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    -------------------------------------------------------------------------------
    constant   REGS_BASE_ADDR     :  integer := 16#00#;
    -------------------------------------------------------------------------------
    -- Header[31:0]
    -------------------------------------------------------------------------------
    constant   REGS_HEADER_ADDR   :  integer := REGS_BASE_ADDR        + 16#00#;
    constant   REGS_HEADER_BITS   :  integer := 32;
    constant   REGS_HEADER_LO     :  integer := 8*REGS_HEADER_ADDR    + 0;
    constant   REGS_HEADER_HI     :  integer := REGS_HEADER_LO        + REGS_HEADER_BITS-1;
    constant   REGS_HEADER_0      :  std_logic_vector(7 downto 0) := "01010010"; -- 'R'
    constant   REGS_HEADER_1      :  std_logic_vector(7 downto 0) := "01011000"; -- 'X'
    constant   REGS_HEADER_2      :  std_logic_vector(7 downto 0)
                                  := "0011" & std_logic_vector(to_unsigned((PORT_NUM mod 10), 4));
    constant   REGS_HEADER_3      :  std_logic_vector(7 downto 0)
                                  := "0011" & std_logic_vector(to_unsigned((PORT_NUM  /  10), 4));
    constant   REGS_HEADER_VALUE  :  std_logic_vector(REGS_HEADER_BITS-1 downto 0)
                                  := REGS_HEADER_3 & REGS_HEADER_2 & REGS_HEADER_1 & REGS_HEADER_0;
    -------------------------------------------------------------------------------
    -- Configuration[31:0]
    -------------------------------------------------------------------------------
    -- Configuration[15:00] = バッファの容量
    -- Configuration[31:16] = 予約
    -------------------------------------------------------------------------------
    constant   REGS_CONFIG_ADDR   :  integer := REGS_BASE_ADDR        + 16#04#;
    constant   REGS_BUF_SIZE_BITS :  integer := 16;
    constant   REGS_BUF_SIZE_LO   :  integer := 8*REGS_CONFIG_ADDR    +  0;
    constant   REGS_BUF_SIZE_HI   :  integer := REGS_BUF_SIZE_LO      + REGS_BUF_SIZE_BITS - 1;
    constant   REGS_CONFIG_RSV_LO :  integer := 8*REGS_CONFIG_ADDR    + 16;
    constant   REGS_CONFIG_RSV_HI :  integer := REGS_CONFIG_RSV_LO    + 15;
    constant   REGS_BUF_SIZE      :  std_logic_vector(REGS_BUF_SIZE_BITS-1 downto 0)
                                  := std_logic_vector(to_unsigned(2**RXD_BUF_DEPTH, REGS_BUF_SIZE_BITS));
    constant   REGS_CONFIG_RSV    :  std_logic_vector(REGS_CONFIG_RSV_HI downto REGS_CONFIG_RSV_LO)
                                  := (others => '0');
    -------------------------------------------------------------------------------
    -- BufCount[15:0]
    -------------------------------------------------------------------------------
    constant   REGS_BUF_COUNT_ADDR:  integer := REGS_BASE_ADDR        + 16#08#;
    constant   REGS_BUF_COUNT_BITS:  integer := 16;
    constant   REGS_BUF_COUNT_LO  :  integer := 8*REGS_BUF_COUNT_ADDR + 0;
    constant   REGS_BUF_COUNT_HI  :  integer := REGS_BUF_COUNT_LO     + REGS_BUF_COUNT_BITS-1;
    signal     rbuf_count         :  std_logic_vector(RXD_BUF_DEPTH downto 0);
    -------------------------------------------------------------------------------
    -- BufPtr[15:0]
    -------------------------------------------------------------------------------
    constant   REGS_BUF_PTR_ADDR  :  integer := REGS_BASE_ADDR        + 16#0A#;
    constant   REGS_BUF_PTR_BITS  :  integer := 16;
    constant   REGS_BUF_PTR_LO    :  integer := 8*REGS_BUF_PTR_ADDR   + 0;
    constant   REGS_BUF_PTR_HI    :  integer := REGS_BUF_PTR_LO       + REGS_BUF_PTR_BITS-1;
    signal     rbuf_offset        :  std_logic_vector(RXD_BUF_DEPTH  -1 downto 0);
    signal     rbuf_ptr           :  std_logic_vector(REGS_BUF_PTR_BITS downto 0);
    -------------------------------------------------------------------------------
    -- PullSize[15:0]
    -------------------------------------------------------------------------------
    constant   REGS_PULL_SIZE_ADDR:  integer := REGS_BASE_ADDR        + 16#0C#;
    constant   REGS_PULL_SIZE_BITS:  integer := 16;
    constant   REGS_PULL_SIZE_LO  :  integer := 8*REGS_PULL_SIZE_ADDR + 0;
    constant   REGS_PULL_SIZE_HI  :  integer := REGS_PULL_SIZE_LO     + REGS_PULL_SIZE_BITS-1;
    signal     rbuf_pull_size     :  std_logic_vector(RXD_BUF_DEPTH downto 0);
    -------------------------------------------------------------------------------
    -- Status[7:0]
    -------------------------------------------------------------------------------
    -- Status[7]   = I_LAST がアサートされたことを示すフラグ
    -- Status[6:1] = 予約
    -- Status[0]   = バッファにデータがある かつ Control[2]=1 の時このフラグがセットされる
    -------------------------------------------------------------------------------
    constant   REGS_STAT_ADDR     :  integer := REGS_BASE_ADDR        + 16#0E#;
    constant   REGS_STAT_LAST_POS :  integer := 8*REGS_STAT_ADDR      +  7;
    constant   REGS_STAT_RESV_HI  :  integer := 8*REGS_STAT_ADDR      +  6;
    constant   REGS_STAT_RESV_LO  :  integer := 8*REGS_STAT_ADDR      +  1;
    constant   REGS_STAT_READY_POS:  integer := 8*REGS_STAT_ADDR      +  0;
    signal     stat_ready_bit     :  std_logic;
    signal     rbuf_last          :  std_logic;
    -------------------------------------------------------------------------------
    -- Control[7:0]
    -------------------------------------------------------------------------------
    -- Control[7]  = 1:モジュールをリセットする. 0:リセットを解除する.
    -- Control[6]  = 1:転送を一時中断する.       0:転送を再開する.
    -- Control[5]  = 1:転送を中止する.           0:意味無し.
    -- Control[4]  = 1:転送を開始する.           0:意味無し.
    -- Control[3]  = 予約.
    -- Control[2]  = 1:バッファにデータがある時にStatus[0]がセットされる.
    -- Control[1]  = 予約.
    -- Control[0]  = 予約.
    -------------------------------------------------------------------------------
    constant   REGS_CTRL_ADDR     :  integer := REGS_BASE_ADDR        + 16#0F#;
    constant   REGS_CTRL_RESET_POS:  integer := 8*REGS_CTRL_ADDR      +  7;
    constant   REGS_CTRL_PAUSE_POS:  integer := 8*REGS_CTRL_ADDR      +  6;
    constant   REGS_CTRL_ABORT_POS:  integer := 8*REGS_CTRL_ADDR      +  5;
    constant   REGS_CTRL_PULL_POS :  integer := 8*REGS_CTRL_ADDR      +  4;
    constant   REGS_CTRL_RSV3_POS :  integer := 8*REGS_CTRL_ADDR      +  3;
    constant   REGS_CTRL_READY_POS:  integer := 8*REGS_CTRL_ADDR      +  2;
    constant   REGS_CTRL_RSV1_POS :  integer := 8*REGS_CTRL_ADDR      +  1;
    constant   REGS_CTRL_RSV0_POS :  integer := 8*REGS_CTRL_ADDR      +  0;
    signal     ctrl_reset_bit     :  std_logic;
    signal     ctrl_reset_load    :  std_logic;
    signal     ctrl_reset_data    :  std_logic;
    signal     ctrl_pause_bit     :  std_logic;
    signal     ctrl_pause_load    :  std_logic;
    signal     ctrl_pause_data    :  std_logic;
    signal     ctrl_abort_bit     :  std_logic;
    signal     ctrl_abort_busy    :  std_logic;
    signal     ctrl_pull_bit      :  std_logic;
    signal     ctrl_ready_bit     :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function   resize(I : std_logic_vector; BITS: integer) return std_logic_vector is
        alias    vec    : std_logic_vector(I'length-1 downto 0) is I;
        variable result : std_logic_vector(    BITS-1 downto 0);
    begin
        for i in result'range loop
            if vec'low <= i and i <= vec'high then
                result(i) := vec(i);
            else
                result(i) := '0';
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    component  PTTY_RXD_BUF 
        generic (
            BUF_DEPTH   : integer := 8;
            BUF_WIDTH   : integer := 2;
            I_BYTES     : integer := 1;
            I_CLK_RATE  : integer := 1;
            S_CLK_RATE  : integer := 1
        );
        port (
            RST         : in  std_logic;
            I_CLK       : in  std_logic;
            I_CKE       : in  std_logic;
            I_DATA      : in  std_logic_vector(8*I_BYTES-1 downto 0);
            I_STRB      : in  std_logic_vector(  I_BYTES-1 downto 0);
            I_LAST      : in  std_logic;
            I_VALID     : in  std_logic;
            I_READY     : out std_logic;
            S_CLK       : in  std_logic;
            S_CKE       : in  std_logic;
            BUF_RDATA   : out std_logic_vector(2**(BUF_WIDTH+3)-1 downto 0);
            BUF_RADDR   : in  std_logic_vector(BUF_DEPTH-1 downto 0);
            BUF_COUNT   : out std_logic_vector(BUF_DEPTH   downto 0);
            BUF_CADDR   : out std_logic_vector(BUF_DEPTH-1 downto 0);
            BUF_LAST    : out std_logic;
            PULL_SIZE   : in  std_logic_vector(BUF_DEPTH   downto 0);
            PULL_LOAD   : in  std_logic;
            ABORT_START : in  std_logic;
            ABORT_BUSY  : out std_logic;
            PAUSE_DATA  : in  std_logic;
            PAUSE_LOAD  : in  std_logic;
            RESET_DATA  : in  std_logic;
            RESET_LOAD  : in  std_logic
        );
    end component;
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    regs_addr <= CSR_ADDR(regs_addr'range);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    rbuf_addr <= CSR_ADDR(rbuf_addr'range);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    rbuf_err  <= '0';
    process (CSR_CLK, RST) begin
        if (RST = '1') then
                rbuf_ack <= '0';
        elsif (CSR_CLK'event and CSR_CLK = '1') then
            if (CLR = '1') then
                rbuf_ack <= '0';
            elsif (rbuf_ack = '0' and CSR_BUF_REQ = '1') then
                rbuf_ack <= '1';
            else
                rbuf_ack <= '0';
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    CSR_RDATA <= regs_rdata when (CSR_REG_REQ = '1') else
                 rbuf_rdata when (CSR_BUF_REQ = '1') else (others => '0');
    CSR_ACK   <= '1'        when (CSR_REG_REQ = '1' and regs_ack = '1') or
                                 (CSR_BUF_REQ = '1' and rbuf_ack = '1') else '0';
    CSR_ERR   <= '1'        when (CSR_REG_REQ = '1' and regs_err = '1') or
                                 (CSR_BUF_REQ = '1' and rbuf_err = '1') else '0';
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    DEC: REGISTER_ACCESS_ADAPTER                               -- 
        generic map (                                          -- 
            ADDR_WIDTH      => REGS_ADDR_WIDTH               , -- 
            DATA_WIDTH      => CSR_DATA_WIDTH                , -- 
            WBIT_MIN        => regs_wbit'low                 , -- 
            WBIT_MAX        => regs_wbit'high                , -- 
            RBIT_MIN        => regs_rbit'low                 , -- 
            RBIT_MAX        => regs_rbit'high                , -- 
            I_CLK_RATE      => 1                             , -- 
            O_CLK_RATE      => 1                             , -- 
            O_CLK_REGS      => 1                               -- 
        )                                                      -- 
        port map (                                             -- 
            RST             => RST                           , -- In  :
            I_CLK           => CSR_CLK                       , -- In  :
            I_CLR           => CLR                           , -- In  :
            I_CKE           => '1'                           , -- In  :
            I_REQ           => CSR_REG_REQ                   , -- In  :
            I_SEL           => '1'                           , -- In  :
            I_WRITE         => CSR_WRITE                     , -- In  :
            I_ADDR          => regs_addr                     , -- In  :
            I_BEN           => CSR_BEN                       , -- In  :
            I_WDATA         => CSR_WDATA                     , -- In  :
            I_RDATA         => regs_rdata                    , -- Out :
            I_ACK           => regs_ack                      , -- Out :
            I_ERR           => regs_err                      , -- Out :
            O_CLK           => CSR_CLK                       , -- In  :
            O_CLR           => CLR                           , -- In  :
            O_CKE           => '1'                           , -- In  :
            O_WDATA         => regs_wbit                     , -- Out :
            O_WLOAD         => regs_load                     , -- Out :
            O_RDATA         => regs_rbit                       -- In  :
        );                                                     -- 
    -------------------------------------------------------------------------------
    -- Header[31:0]
    -------------------------------------------------------------------------------
    regs_rbit(REGS_HEADER_HI     downto REGS_HEADER_LO    ) <= REGS_HEADER_VALUE;
    -------------------------------------------------------------------------------
    -- Configuration[31:0]
    -------------------------------------------------------------------------------
    regs_rbit(REGS_BUF_SIZE_HI   downto REGS_BUF_SIZE_LO  ) <= REGS_BUF_SIZE;
    regs_rbit(REGS_CONFIG_RSV_HI downto REGS_CONFIG_RSV_LO) <= REGS_CONFIG_RSV;
    -------------------------------------------------------------------------------
    -- BufCount[15:0]
    -------------------------------------------------------------------------------
    regs_rbit(REGS_BUF_COUNT_HI  downto REGS_BUF_COUNT_LO ) <= resize(rbuf_count, REGS_BUF_COUNT_BITS);
    -------------------------------------------------------------------------------
    -- BufPtr[15:0]
    -------------------------------------------------------------------------------
    regs_rbit(REGS_BUF_PTR_HI    downto REGS_BUF_PTR_LO   ) <= resize(rbuf_ptr  , REGS_BUF_PTR_BITS);
    rbuf_ptr <= std_logic_vector(to_unsigned(RXD_BUF_BASE, rbuf_ptr'length) + to_01(unsigned(rbuf_offset)));
    -------------------------------------------------------------------------------
    -- PullSize[15:0]
    -------------------------------------------------------------------------------
    process (CSR_CLK, RST) begin
        if (RST = '1') then
                rbuf_pull_size <= (others => '0');
        elsif (CSR_CLK'event and CSR_CLK = '1') then
            if (CLR = '1' or ctrl_reset_bit = '1') then
                rbuf_pull_size <= (others => '0');
            else
                for i in rbuf_pull_size'range loop
                    if (regs_load(REGS_PULL_SIZE_LO+i) = '1') then
                        rbuf_pull_size(i) <= regs_wbit(REGS_PULL_SIZE_LO+i);
                    end if;
                end loop;
            end if;
        end if;
    end process;
    regs_rbit(REGS_PULL_SIZE_HI downto REGS_PULL_SIZE_LO) <= resize(rbuf_pull_size, REGS_PULL_SIZE_BITS);
    -------------------------------------------------------------------------------
    -- Status[7:0] (T.B.D)
    -------------------------------------------------------------------------------
    process (CSR_CLK, RST) begin
        if (RST = '1') then
                stat_ready_bit <= '0';
        elsif (CSR_CLK'event and CSR_CLK = '1') then
            if (CLR = '1' or ctrl_reset_bit = '1') then
                stat_ready_bit <= '0';
            elsif (regs_load(REGS_STAT_READY_POS) = '1' and regs_wbit(REGS_STAT_READY_POS) = '0') then
                stat_ready_bit <= '0';
            elsif (ctrl_ready_bit = '1' and ctrl_pull_bit = '0' and unsigned(rbuf_count) > 0) then
                stat_ready_bit <= '1';
            end if;
        end if;
    end process;
    CSR_IRQ <= '1' when (stat_ready_bit = '1') else '0';
    regs_rbit(REGS_STAT_READY_POS) <= stat_ready_bit;
    regs_rbit(REGS_STAT_LAST_POS ) <= rbuf_last;
    regs_rbit(REGS_STAT_RESV_HI downto REGS_STAT_RESV_LO) <= (REGS_STAT_RESV_HI downto REGS_STAT_RESV_LO => '0');
    -------------------------------------------------------------------------------
    -- Control[7] : ctrl_reset_bit
    -------------------------------------------------------------------------------
    process (CSR_CLK, RST) begin
        if     (RST = '1') then
                ctrl_reset_bit  <= '0';
                ctrl_reset_load <= '0';
                ctrl_reset_data <= '0';
        elsif  (CSR_CLK'event and CSR_CLK = '1') then
            if (CLR = '1') then
                ctrl_reset_bit  <= '0';
                ctrl_reset_load <= '0';
                ctrl_reset_data <= '0';
            else
                if (regs_load(REGS_CTRL_RESET_POS) = '1') then
                    ctrl_reset_bit <= regs_wbit(REGS_CTRL_RESET_POS);
                end if;
                ctrl_reset_load <= regs_load(REGS_CTRL_RESET_POS);
                ctrl_reset_data <= regs_wbit(REGS_CTRL_RESET_POS);
            end if;
        end if;
    end process;
    regs_rbit(REGS_CTRL_RESET_POS) <= ctrl_reset_bit;
    -------------------------------------------------------------------------------
    -- Control[6] : ctrl_pause_bit
    -------------------------------------------------------------------------------
    process (CSR_CLK, RST) begin
        if     (RST = '1') then
                ctrl_pause_bit  <= '0';
                ctrl_pause_load <= '0';
                ctrl_pause_data <= '0';
        elsif  (CSR_CLK'event and CSR_CLK = '1') then
            if (CLR = '1') then
                ctrl_pause_bit  <= '0';
                ctrl_pause_load <= '0';
                ctrl_pause_data <= '0';
            else
                if (ctrl_reset_bit = '1') then
                    ctrl_pause_bit <= '0';
                elsif (regs_load(REGS_CTRL_PAUSE_POS) = '1') then
                    ctrl_pause_bit <= regs_wbit(REGS_CTRL_PAUSE_POS);
                end if;
                ctrl_pause_load <= regs_load(REGS_CTRL_PAUSE_POS);
                ctrl_pause_data <= regs_wbit(REGS_CTRL_PAUSE_POS);
            end if;
        end if;
    end process;
    regs_rbit(REGS_CTRL_PAUSE_POS) <= ctrl_pause_bit;
    -------------------------------------------------------------------------------
    -- Control[5:0]
    -------------------------------------------------------------------------------
    process (CSR_CLK, RST) begin
        if (RST = '1') then
                ctrl_abort_bit <= '0';
                ctrl_pull_bit  <= '0';
                ctrl_ready_bit <= '0';
        elsif (CSR_CLK'event and CSR_CLK = '1') then
            if (CLR = '1' or ctrl_reset_bit = '1') then
                ctrl_abort_bit <= '0';
                ctrl_pull_bit  <= '0';
                ctrl_ready_bit <= '0';
            else
                if (regs_load(REGS_CTRL_ABORT_POS) = '1') then
                    ctrl_abort_bit <= regs_wbit(REGS_CTRL_ABORT_POS);
                else
                    ctrl_abort_bit <= '0';
                end if;
                if (regs_load(REGS_CTRL_PULL_POS ) = '1') then
                    ctrl_pull_bit  <= regs_wbit(REGS_CTRL_PULL_POS );
                else
                    ctrl_pull_bit  <= '0';
                end if;
                if (regs_load(REGS_CTRL_READY_POS ) = '1') then
                    ctrl_ready_bit  <= regs_wbit(REGS_CTRL_READY_POS );
                end if;
            end if;
        end if;
    end process;
    regs_rbit(REGS_CTRL_ABORT_POS) <= '1' when (ctrl_abort_bit = '1' and ctrl_abort_busy = '1') else '0';
    regs_rbit(REGS_CTRL_PULL_POS ) <= ctrl_pull_bit;
    regs_rbit(REGS_CTRL_RSV3_POS ) <= '0';
    regs_rbit(REGS_CTRL_READY_POS) <= ctrl_ready_bit;
    regs_rbit(REGS_CTRL_RSV1_POS ) <= '0';
    regs_rbit(REGS_CTRL_RSV0_POS ) <= '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    BUF: PTTY_RXD_BUF                                  -- 
        generic map (                                  -- 
            BUF_DEPTH       => RXD_BUF_DEPTH         , --
            BUF_WIDTH       => RXD_BUF_WIDTH         , --
            I_BYTES         => RXD_BYTES             , --
            I_CLK_RATE      => RXD_CLK_RATE          , --
            S_CLK_RATE      => CSR_CLK_RATE            -- 
        )                                              -- 
        port map (                                     -- 
            RST             => RST                   , -- In  :
            I_CLK           => RXD_CLK               , -- In  :
            I_CKE           => RXD_CKE               , -- In  :
            I_DATA          => RXD_DATA              , -- In  :
            I_STRB          => RXD_STRB              , -- In  :
            I_LAST          => RXD_LAST              , -- In  :
            I_VALID         => RXD_VALID             , -- In  :
            I_READY         => RXD_READY             , -- Out :
            S_CLK           => CSR_CLK               , -- In  :
            S_CKE           => CSR_CKE               , -- In  :
            BUF_RDATA       => rbuf_rdata            , -- Out :
            BUF_RADDR       => rbuf_addr             , -- In  :
            BUF_COUNT       => rbuf_count            , -- Out :
            BUF_CADDR       => rbuf_offset           , -- Out :
            BUF_LAST        => rbuf_last             , -- Out :
            PULL_SIZE       => rbuf_pull_size        , -- In  :
            PULL_LOAD       => ctrl_pull_bit         , -- In  :
            ABORT_START     => ctrl_abort_bit        , -- In  :
            ABORT_BUSY      => ctrl_abort_busy       , -- In  :
            PAUSE_DATA      => ctrl_pause_data       , -- In  :
            PAUSE_LOAD      => ctrl_pause_load       , -- In  :
            RESET_DATA      => ctrl_reset_data       , -- In  :
            RESET_LOAD      => ctrl_reset_load         -- In  :
        );
end RTL;

