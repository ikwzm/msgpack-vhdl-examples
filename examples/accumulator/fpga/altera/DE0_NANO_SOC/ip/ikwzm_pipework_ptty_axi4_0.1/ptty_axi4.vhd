-----------------------------------------------------------------------------------
--!     @file    ptty_axi4.vhd
--!     @brief   PTTY_AXI4
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
entity  PTTY_AXI4 is
    generic (
        TXD_BUF_DEPTH   : integer range  4 to    9 :=  7;
        RXD_BUF_DEPTH   : integer range  4 to    9 :=  7;
        CSR_ADDR_WIDTH  : integer range 12 to   64 := 12;
        CSR_DATA_WIDTH  : integer range  8 to 1024 := 32;
        CSR_ID_WIDTH    : integer                  := 12;
        RXD_BYTES       : positive                 :=  1;
        TXD_BYTES       : positive                 :=  1
    );
    port (
    -------------------------------------------------------------------------------
    -- Reset Signals.
    -------------------------------------------------------------------------------
        ARESETn         : in    std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F Clock.
    -------------------------------------------------------------------------------
        CSR_CLK         : in    std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Read Address Channel Signals.
    -------------------------------------------------------------------------------
        CSR_ARID        : in    std_logic_vector(CSR_ID_WIDTH    -1 downto 0);
        CSR_ARADDR      : in    std_logic_vector(CSR_ADDR_WIDTH  -1 downto 0);
        CSR_ARLEN       : in    std_logic_vector(7 downto 0);
        CSR_ARSIZE      : in    std_logic_vector(2 downto 0);
        CSR_ARBURST     : in    std_logic_vector(1 downto 0);
        CSR_ARVALID     : in    std_logic;
        CSR_ARREADY     : out   std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Read Data Channel Signals.
    -------------------------------------------------------------------------------
        CSR_RID         : out   std_logic_vector(CSR_ID_WIDTH    -1 downto 0);
        CSR_RDATA       : out   std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
        CSR_RRESP       : out   std_logic_vector(1 downto 0);
        CSR_RLAST       : out   std_logic;
        CSR_RVALID      : out   std_logic;
        CSR_RREADY      : in    std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Write Address Channel Signals.
    -------------------------------------------------------------------------------
        CSR_AWID        : in    std_logic_vector(CSR_ID_WIDTH    -1 downto 0);
        CSR_AWADDR      : in    std_logic_vector(CSR_ADDR_WIDTH  -1 downto 0);
        CSR_AWLEN       : in    std_logic_vector(7 downto 0);
        CSR_AWSIZE      : in    std_logic_vector(2 downto 0);
        CSR_AWBURST     : in    std_logic_vector(1 downto 0);
        CSR_AWVALID     : in    std_logic;
        CSR_AWREADY     : out   std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Write Data Channel Signals.
    -------------------------------------------------------------------------------
        CSR_WDATA       : in    std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
        CSR_WSTRB       : in    std_logic_vector(CSR_DATA_WIDTH/8-1 downto 0);
        CSR_WLAST       : in    std_logic;
        CSR_WVALID      : in    std_logic;
        CSR_WREADY      : out   std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Write Response Channel Signals.
    -------------------------------------------------------------------------------
        CSR_BID         : out   std_logic_vector(CSR_ID_WIDTH    -1 downto 0);
        CSR_BRESP       : out   std_logic_vector(1 downto 0);
        CSR_BVALID      : out   std_logic;
        CSR_BREADY      : in    std_logic;
    -------------------------------------------------------------------------------
    -- Interrupt
    -------------------------------------------------------------------------------
        CSR_IRQ         : out   std_logic;
    -------------------------------------------------------------------------------
    -- 入力側の信号
    -------------------------------------------------------------------------------
        RXD_CLK         : --! @brief RECEIVE DATA CLOCK :
                          --! 入力側のクロック信号.
                          in  std_logic;
        RXD_TDATA       : --! @brief RECEIVE DATA DATA :
                          --! 入力側データ
                          in  std_logic_vector(8*RXD_BYTES-1 downto 0);
        RXD_TKEEP       : --! @brief RECEIVE DATA STROBE :
                          --! 入力側データ
                          in  std_logic_vector(  RXD_BYTES-1 downto 0);
        RXD_TLAST       : --! @brief RECEIVE DATA LAST :
                          --! 入力側データ
                          in  std_logic;
        RXD_TVALID      : --! @brief RECEIVE DATA ENABLE :
                          --! 入力有効信号.
                          in  std_logic;
        RXD_TREADY      : --! @brief RECEIVE DATA READY :
                          --! 入力許可信号.
                          out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側の信号
    -------------------------------------------------------------------------------
        TXD_CLK         : --! @brief TRANSMIT DATA CLOCK :
                          --! 出力側のクロック信号.
                          in  std_logic;
        TXD_TDATA       : --! @brief TRANSMIT DATA DATA :
                          --! 出力側データ
                          out std_logic_vector(8*TXD_BYTES-1 downto 0);
        TXD_TKEEP       : --! @brief TRANSMIT DATA STROBE :
                          --! 出力側データ
                          out std_logic_vector(  TXD_BYTES-1 downto 0);
        TXD_TLAST       : --! @brief TRANSMIT DATA LAST :
                          --! 出力側データ
                          out std_logic;
        TXD_TVALID      : --! @brief TRANSMIT DATA ENABLE :
                          --! 出力有効信号.
                          out std_logic;
        TXD_TREADY      : --! @brief TRANSMIT DATA READY :
                          --! 出力許可信号.
                          in  std_logic
    );
end PTTY_AXI4;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.AXI4_TYPES.all;
use     PIPEWORK.AXI4_COMPONENTS.AXI4_REGISTER_INTERFACE;
architecture RTL of PTTY_AXI4 is
    -------------------------------------------------------------------------------
    -- リセット信号.
    -------------------------------------------------------------------------------
    signal   RST                :  std_logic;
    constant CLR                :  std_logic := '0';
    -------------------------------------------------------------------------------
    -- レジスタアクセス用の信号群.
    -------------------------------------------------------------------------------
    signal   regs_req           :  std_logic;
    signal   regs_write         :  std_logic;
    signal   regs_ack           :  std_logic;
    signal   regs_err           :  std_logic;
    signal   regs_addr          :  std_logic_vector(CSR_ADDR_WIDTH  -1 downto 0);
    signal   regs_ben           :  std_logic_vector(CSR_DATA_WIDTH/8-1 downto 0);
    signal   regs_wdata         :  std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
    signal   regs_rdata         :  std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
    signal   regs_err_req       :  std_logic;
    signal   regs_err_ack       :  std_logic;
    -------------------------------------------------------------------------------
    -- PTTY_SEND アクセス用信号群.
    -------------------------------------------------------------------------------
    signal   tx_regs_req        :  std_logic;
    signal   txd_buf_req        :  std_logic;
    signal   tx_ack             :  std_logic;
    signal   tx_err             :  std_logic;
    signal   tx_rdata           :  std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
    signal   tx_irq             :  std_logic;
    -------------------------------------------------------------------------------
    -- PTTY_RECV アクセス用信号群.
    -------------------------------------------------------------------------------
    signal   rx_regs_req       :  std_logic;
    signal   rxd_buf_req       :  std_logic;
    signal   rx_ack            :  std_logic;
    signal   rx_err            :  std_logic;
    signal   rx_rdata          :  std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
    signal   rx_irq            :  std_logic;
    -------------------------------------------------------------------------------
    -- レジスタマップ
    -------------------------------------------------------------------------------
    constant TX_REGS_AREA_LO   :  integer := 16#0010#;
    constant TX_REGS_AREA_HI   :  integer := 16#001F#;
    constant RX_REGS_AREA_LO   :  integer := 16#0020#;
    constant RX_REGS_AREA_HI   :  integer := 16#002F#;
    constant TXD_BUF_AREA_LO   :  integer := 16#0800#;
    constant TXD_BUF_AREA_HI   :  integer := 16#0BFF#;
    constant RXD_BUF_AREA_LO   :  integer := 16#0C00#;
    constant RXD_BUF_AREA_HI   :  integer := 16#0FFF#;
    -------------------------------------------------------------------------------
    -- PTTY_TX
    -------------------------------------------------------------------------------
    component  PTTY_TX
        generic (
            PORT_NUM        : integer range 0 to   99 :=  0;
            TXD_BUF_DEPTH   : integer range 4 to   15 :=  7;
            TXD_BUF_BASE    : integer := 0;
            CSR_ADDR_WIDTH  : integer range 1 to   64 := 32;
            CSR_DATA_WIDTH  : integer range 8 to 1024 := 32;
            TXD_BYTES       : integer := 1;
            TXD_CLK_RATE    : integer := 1;
            CSR_CLK_RATE    : integer := 1
        );
        port (
            RST             : in  std_logic;
            CLR             : in  std_logic;
            CSR_CLK         : in  std_logic;
            CSR_CKE         : in  std_logic;
            CSR_ADDR        : in  std_logic_vector(CSR_ADDR_WIDTH  -1 downto 0);
            CSR_BEN         : in  std_logic_vector(CSR_DATA_WIDTH/8-1 downto 0);
            CSR_WDATA       : in  std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
            CSR_RDATA       : out std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
            CSR_REG_REQ     : in  std_logic;
            CSR_BUF_REQ     : in  std_logic;
            CSR_WRITE       : in  std_logic;
            CSR_ACK         : out std_logic;
            CSR_ERR         : out std_logic;
            CSR_IRQ         : out std_logic;
            TXD_CLK         : in  std_logic;
            TXD_CKE         : in  std_logic;
            TXD_DATA        : out std_logic_vector(8*TXD_BYTES-1 downto 0);
            TXD_STRB        : out std_logic_vector(  TXD_BYTES-1 downto 0);
            TXD_LAST        : out std_logic;
            TXD_VALID       : out std_logic;
            TXD_READY       : in  std_logic
        );
    end component;
    -------------------------------------------------------------------------------
    -- PTTY_RX
    -------------------------------------------------------------------------------
    component  PTTY_RX
        generic (
            PORT_NUM        : integer range 0 to   99 :=  0;
            RXD_BUF_DEPTH   : integer range 4 to   15 :=  7;
            RXD_BUF_BASE    : integer := 0;
            CSR_ADDR_WIDTH  : integer range 1 to   64 := 32;
            CSR_DATA_WIDTH  : integer range 8 to 1024 := 32;
            RXD_BYTES       : integer := 1;
            RXD_CLK_RATE    : integer := 1;
            CSR_CLK_RATE    : integer := 1
        );
        port (
            RST             : in  std_logic;
            CLR             : in  std_logic;
            CSR_CLK         : in  std_logic;
            CSR_CKE         : in  std_logic;
            CSR_ADDR        : in  std_logic_vector(CSR_ADDR_WIDTH  -1 downto 0);
            CSR_BEN         : in  std_logic_vector(CSR_DATA_WIDTH/8-1 downto 0);
            CSR_WDATA       : in  std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
            CSR_RDATA       : out std_logic_vector(CSR_DATA_WIDTH  -1 downto 0);
            CSR_REG_REQ     : in  std_logic;
            CSR_BUF_REQ     : in  std_logic;
            CSR_WRITE       : in  std_logic;
            CSR_ACK         : out std_logic;
            CSR_ERR         : out std_logic;
            CSR_IRQ         : out std_logic;
            RXD_CLK         : in  std_logic;
            RXD_CKE         : in  std_logic;
            RXD_DATA        : in  std_logic_vector(8*RXD_BYTES-1 downto 0);
            RXD_STRB        : in  std_logic_vector(  RXD_BYTES-1 downto 0);
            RXD_LAST        : in  std_logic;
            RXD_VALID       : in  std_logic;
            RXD_READY       : out std_logic
        );
    end component;
begin
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    RST <= '1' when (ARESETn = '0') else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    AXI4: AXI4_REGISTER_INTERFACE                  --
        generic map (                              -- 
            AXI4_ADDR_WIDTH => CSR_ADDR_WIDTH    , --
            AXI4_DATA_WIDTH => CSR_DATA_WIDTH    , --
            AXI4_ID_WIDTH   => CSR_ID_WIDTH      , --
            REGS_ADDR_WIDTH => CSR_ADDR_WIDTH    , --
            REGS_DATA_WIDTH => CSR_DATA_WIDTH      --
        )                                          -- 
        port map (                                 -- 
        -----------------------------------------------------------------------
        -- Clock and Reset Signals.
        -----------------------------------------------------------------------
            CLK             => CSR_CLK           , -- In  :
            RST             => RST               , -- In  :
            CLR             => CLR               , -- In  :
        -----------------------------------------------------------------------
        -- AXI4 Read Address Channel Signals.
        -----------------------------------------------------------------------
            ARID            => CSR_ARID          , -- In  :
            ARADDR          => CSR_ARADDR        , -- In  :
            ARLEN           => CSR_ARLEN         , -- In  :
            ARSIZE          => CSR_ARSIZE        , -- In  :
            ARBURST         => CSR_ARBURST       , -- In  :
            ARVALID         => CSR_ARVALID       , -- In  :
            ARREADY         => CSR_ARREADY       , -- Out :
        -----------------------------------------------------------------------
        -- AXI4 Read Data Channel Signals.
        -----------------------------------------------------------------------
            RID             => CSR_RID           , -- Out :
            RDATA           => CSR_RDATA         , -- Out :
            RRESP           => CSR_RRESP         , -- Out :
            RLAST           => CSR_RLAST         , -- Out :
            RVALID          => CSR_RVALID        , -- Out :
            RREADY          => CSR_RREADY        , -- In  :
        -----------------------------------------------------------------------
        -- AXI4 Write Address Channel Signals.
        -----------------------------------------------------------------------
            AWID            => CSR_AWID          , -- In  :
            AWADDR          => CSR_AWADDR        , -- In  :
            AWLEN           => CSR_AWLEN         , -- In  :
            AWSIZE          => CSR_AWSIZE        , -- In  :
            AWBURST         => CSR_AWBURST       , -- In  :
            AWVALID         => CSR_AWVALID       , -- In  :
            AWREADY         => CSR_AWREADY       , -- Out :
        -----------------------------------------------------------------------
        -- AXI4 Write Data Channel Signals.
        -----------------------------------------------------------------------
            WDATA           => CSR_WDATA         , -- In  :
            WSTRB           => CSR_WSTRB         , -- In  :
            WLAST           => CSR_WLAST         , -- In  :
            WVALID          => CSR_WVALID        , -- In  :
            WREADY          => CSR_WREADY        , -- Out :
        -----------------------------------------------------------------------
        -- AXI4 Write Response Channel Signals.
        -----------------------------------------------------------------------
            BID             => CSR_BID           , -- Out :
            BRESP           => CSR_BRESP         , -- Out :
            BVALID          => CSR_BVALID        , -- Out :
            BREADY          => CSR_BREADY        , -- In  :
        -----------------------------------------------------------------------
        -- Register Interface.
        -----------------------------------------------------------------------
            REGS_REQ        => regs_req          , -- Out :
            REGS_WRITE      => regs_write        , -- Out :
            REGS_ACK        => regs_ack          , -- In  :
            REGS_ERR        => regs_err          , -- In  :
            REGS_ADDR       => regs_addr         , -- Out :
            REGS_BEN        => regs_ben          , -- Out :
            REGS_WDATA      => regs_wdata        , -- Out :
            REGS_RDATA      => regs_rdata          -- In  :
        );                                         -- 
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    process (regs_req, regs_addr)
        variable u_addr       : unsigned(CSR_ADDR_WIDTH-1 downto 0);
        variable tx_regs_sel : boolean;
        variable txd_buf_sel : boolean;
        variable rx_regs_sel : boolean;
        variable rxd_buf_sel : boolean;
    begin
        if (regs_req = '1') then
            u_addr       := to_01(unsigned(regs_addr));
            tx_regs_sel := (TX_REGS_AREA_LO <= u_addr and u_addr <= TX_REGS_AREA_HI);
            txd_buf_sel := (TXD_BUF_AREA_LO <= u_addr and u_addr <= TXD_BUF_AREA_HI);
            rx_regs_sel := (RX_REGS_AREA_LO <= u_addr and u_addr <= RX_REGS_AREA_HI);
            rxd_buf_sel := (RXD_BUF_AREA_LO <= u_addr and u_addr <= RXD_BUF_AREA_HI);
            if (tx_regs_sel) then
                tx_regs_req <= '1';
            else
                tx_regs_req <= '0';
            end if;
            if (txd_buf_sel) then
                txd_buf_req <= '1';
            else
                txd_buf_req <= '0';
            end if;
            if (rx_regs_sel) then
                rx_regs_req <= '1';
            else
                rx_regs_req <= '0';
            end if;
            if (rxd_buf_sel) then
                rxd_buf_req <= '1';
            else
                rxd_buf_req <= '0';
            end if;
            if (tx_regs_sel = FALSE) and
               (txd_buf_sel = FALSE) and
               (rx_regs_sel = FALSE) and
               (rxd_buf_sel = FALSE) then
                regs_err_req <= '1';
            else
                regs_err_req <= '0';
            end if;
        else
                tx_regs_req <= '0';
                txd_buf_req <= '0';
                rx_regs_req <= '0';
                rxd_buf_req <= '0';
                regs_err_req <= '0';
        end if;
    end process;
    regs_err_ack <= regs_err_req;
    regs_ack     <= tx_ack   or rx_ack or regs_err_ack;
    regs_err     <= tx_err   or rx_err;
    regs_rdata   <= tx_rdata or rx_rdata;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    TX:  PTTY_TX                                   -- 
        generic map (                              --
            PORT_NUM        => 0                 , -- 
            TXD_BUF_DEPTH   => TXD_BUF_DEPTH     , --
            TXD_BUF_BASE    => TXD_BUF_AREA_LO   , --
            CSR_ADDR_WIDTH  => CSR_ADDR_WIDTH    , -- 
            CSR_DATA_WIDTH  => CSR_DATA_WIDTH    , -- 
            TXD_BYTES       => TXD_BYTES         , -- 
            TXD_CLK_RATE    => 0                 , -- 
            CSR_CLK_RATE    => 0                   -- 
        )                                          -- 
        port map (                                 -- 
            RST             => RST               , -- In  :
            CLR             => CLR               , -- In  :
            CSR_CLK         => CSR_CLK           , -- In  :
            CSR_CKE         => '1'               , -- In  :
            CSR_ADDR        => regs_addr         , -- In  :
            CSR_BEN         => regs_ben          , -- In  :
            CSR_WDATA       => regs_wdata        , -- In  :
            CSR_RDATA       => tx_rdata          , -- Out :
            CSR_REG_REQ     => tx_regs_req       , -- In  :
            CSR_BUF_REQ     => txd_buf_req       , -- In  :
            CSR_WRITE       => regs_write        , -- In  :
            CSR_ACK         => tx_ack            , -- Out :
            CSR_ERR         => tx_err            , -- Out :
            CSR_IRQ         => tx_irq            , -- Out :
            TXD_CLK         => TXD_CLK           , -- In  :
            TXD_CKE         => '1'               , -- In  :
            TXD_DATA        => TXD_TDATA         , -- Out :
            TXD_STRB        => TXD_TKEEP         , -- Out :
            TXD_LAST        => TXD_TLAST         , -- Out :
            TXD_VALID       => TXD_TVALID        , -- Out :
            TXD_READY       => TXD_TREADY          -- In  :
        );                                         -- 
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    RX: PTTY_RX                                    -- 
        generic map (                              -- 
            PORT_NUM        => 0                 , -- 
            RXD_BUF_DEPTH   => RXD_BUF_DEPTH     , --
            RXD_BUF_BASE    => RXD_BUF_AREA_LO   , --
            CSR_ADDR_WIDTH  => CSR_ADDR_WIDTH    , --
            CSR_DATA_WIDTH  => CSR_DATA_WIDTH    , --
            RXD_BYTES       => RXD_BYTES         , --
            RXD_CLK_RATE    => 0                 , --
            CSR_CLK_RATE    => 0                   --
        )                                          -- 
        port map (                                 -- 
            RST             => RST               , -- In  :
            CLR             => CLR               , -- In  :
            CSR_CLK         => CSR_CLK           , -- In  :
            CSR_CKE         => '1'               , -- In  :
            CSR_ADDR        => regs_addr         , -- In  :
            CSR_BEN         => regs_ben          , -- In  :
            CSR_WDATA       => regs_wdata        , -- In  :
            CSR_RDATA       => rx_rdata          , -- Out :
            CSR_REG_REQ     => rx_regs_req       , -- In  :
            CSR_BUF_REQ     => rxd_buf_req       , -- In  :
            CSR_WRITE       => regs_write        , -- In  :
            CSR_ACK         => rx_ack            , -- Out :
            CSR_ERR         => rx_err            , -- Out :
            CSR_IRQ         => rx_irq            , -- Out :
            RXD_CLK         => RXD_CLK           , -- In  :
            RXD_CKE         => '1'               , -- In  :
            RXD_DATA        => RXD_TDATA         , -- In  :
            RXD_STRB        => RXD_TKEEP         , -- In  :
            RXD_LAST        => RXD_TLAST         , -- In  :
            RXD_VALID       => RXD_TVALID        , -- In  :
            RXD_READY       => RXD_TREADY          -- Out :
        );                                         --
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    CSR_IRQ <= '1' when (tx_irq = '1' or rx_irq = '1') else '0';
end RTL;
