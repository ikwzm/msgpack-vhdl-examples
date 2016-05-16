-----------------------------------------------------------------------------------
--!     @file    led8_axi.vhd
--!     @brief   LEDx8 Control Status Registers with AXI Slave Interface
--!     @version 0.0.1
--!     @date    2016/2/3
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
-----------------------------------------------------------------------------------
--! @brief 
-----------------------------------------------------------------------------------
entity  LED8_AXI is
    generic (
        C_ADDR_WIDTH    : integer range 4 to   64 :=  4;
        C_DATA_WIDTH    : integer range 8 to 1024 := 32;
        C_ID_WIDTH      : integer                 :=  8;
        AUTO_START      : boolean := TRUE;
        DEFAULT_TIMER   : integer := 100*1000*1000;
        DEFAULT_SEQ_0   : integer range 0 to 255  := 2#00011000#;
        DEFAULT_SEQ_1   : integer range 0 to 255  := 2#00100100#;
        DEFAULT_SEQ_2   : integer range 0 to 255  := 2#01000010#;
        DEFAULT_SEQ_3   : integer range 0 to 255  := 2#10000001#;
        DEFAULT_SEQ_4   : integer range 0 to 255  := 2#01000010#;
        DEFAULT_SEQ_5   : integer range 0 to 255  := 2#00100100#;
        DEFAULT_SEQ_6   : integer range 0 to 255  := 2#00000000#;
        DEFAULT_SEQ_7   : integer range 0 to 255  := 2#00000000#;
        DEFAULT_SEQ_LAST: integer range 0 to 7    := 5
    );
    port(
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    -------------------------------------------------------------------------------
        ACLOCK          : in    std_logic;
        ARESETn         : in    std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Read Address Channel Signals.
    -------------------------------------------------------------------------------
        C_ARID          : in    std_logic_vector(C_ID_WIDTH    -1 downto 0);
        C_ARADDR        : in    std_logic_vector(C_ADDR_WIDTH  -1 downto 0);
        C_ARLEN         : in    std_logic_vector(7 downto 0);
        C_ARSIZE        : in    std_logic_vector(2 downto 0);
        C_ARBURST       : in    std_logic_vector(1 downto 0);
        C_ARVALID       : in    std_logic;
        C_ARREADY       : out   std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Read Data Channel Signals.
    -------------------------------------------------------------------------------
        C_RID           : out   std_logic_vector(C_ID_WIDTH    -1 downto 0);
        C_RDATA         : out   std_logic_vector(C_DATA_WIDTH  -1 downto 0);
        C_RRESP         : out   std_logic_vector(1 downto 0);
        C_RLAST         : out   std_logic;
        C_RVALID        : out   std_logic;
        C_RREADY        : in    std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Write Address Channel Signals.
    -------------------------------------------------------------------------------
        C_AWID          : in    std_logic_vector(C_ID_WIDTH    -1 downto 0);
        C_AWADDR        : in    std_logic_vector(C_ADDR_WIDTH  -1 downto 0);
        C_AWLEN         : in    std_logic_vector(7 downto 0);
        C_AWSIZE        : in    std_logic_vector(2 downto 0);
        C_AWBURST       : in    std_logic_vector(1 downto 0);
        C_AWVALID       : in    std_logic;
        C_AWREADY       : out   std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Write Data Channel Signals.
    -------------------------------------------------------------------------------
        C_WDATA         : in    std_logic_vector(C_DATA_WIDTH  -1 downto 0);
        C_WSTRB         : in    std_logic_vector(C_DATA_WIDTH/8-1 downto 0);
        C_WLAST         : in    std_logic;
        C_WVALID        : in    std_logic;
        C_WREADY        : out   std_logic;
    -------------------------------------------------------------------------------
    -- Control Status Register I/F AXI4 Write Response Channel Signals.
    -------------------------------------------------------------------------------
        C_BID           : out   std_logic_vector(C_ID_WIDTH    -1 downto 0);
        C_BRESP         : out   std_logic_vector(1 downto 0);
        C_BVALID        : out   std_logic;
        C_BREADY        : in    std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        LED             : out   std_logic_vector(7 downto 0)
    );
end LED8_AXI;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library PIPEWORK;
use     PIPEWORK.AXI4_COMPONENTS.AXI4_REGISTER_INTERFACE;
use     PIPEWORK.COMPONENTS.REGISTER_ACCESS_ADAPTER;
architecture RTL of LED8_AXI is
    -------------------------------------------------------------------------------
    -- リセット信号.
    -------------------------------------------------------------------------------
    signal   RST                : std_logic;
    constant CLR                : std_logic := '0';
    -------------------------------------------------------------------------------
    -- レジスタアクセスインターフェースのアドレスのビット数.
    -------------------------------------------------------------------------------
    constant REGS_ADDR_WIDTH    : integer := 4;
    -------------------------------------------------------------------------------
    -- 全レジスタのビット数.
    -------------------------------------------------------------------------------
    constant REGS_DATA_BITS     : integer := (2**REGS_ADDR_WIDTH)*8;
    -------------------------------------------------------------------------------
    -- レジスタアクセスインターフェースのデータのビット数.
    -------------------------------------------------------------------------------
    constant REGS_DATA_WIDTH    : integer := 32;
    -------------------------------------------------------------------------------
    -- レジスタアクセス用の信号群.
    -------------------------------------------------------------------------------
    signal   regs_load          : std_logic_vector(REGS_DATA_BITS   -1 downto 0);
    signal   regs_wbit          : std_logic_vector(REGS_DATA_BITS   -1 downto 0);
    signal   regs_rbit          : std_logic_vector(REGS_DATA_BITS   -1 downto 0);
    signal   regs_req           : std_logic;
    signal   regs_write         : std_logic;
    signal   regs_ack           : std_logic;
    signal   regs_err           : std_logic;
    signal   regs_addr          : std_logic_vector(REGS_ADDR_WIDTH  -1 downto 0);
    signal   regs_ben           : std_logic_vector(REGS_DATA_WIDTH/8-1 downto 0);
    signal   regs_wdata         : std_logic_vector(REGS_DATA_WIDTH  -1 downto 0);
    signal   regs_rdata         : std_logic_vector(REGS_DATA_WIDTH  -1 downto 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    component LED_CSR is
        generic (
            LED_NUM         : integer :=  4;
            SEQ_NUM         : integer :=  8;
            TIMER_BITS      : integer := 32;
            AUTO_START      : boolean := TRUE;
            DEFAULT_TIMER   : integer := 100*1000*1000;
            DEFAULT_SEQ_0   : integer := 2#1111#;
            DEFAULT_SEQ_1   : integer := 2#1110#;
            DEFAULT_SEQ_2   : integer := 2#1100#;
            DEFAULT_SEQ_3   : integer := 2#1001#;
            DEFAULT_SEQ_4   : integer := 2#0011#;
            DEFAULT_SEQ_5   : integer := 2#0111#;
            DEFAULT_SEQ_6   : integer := 2#0000#;
            DEFAULT_SEQ_7   : integer := 2#0000#;
            DEFAULT_SEQ_LAST: integer := 5
        );
        port(
            CLK             : in    std_logic;
            CLR             : in    std_logic;
            RST             : in    std_logic;
            LED_L           : in    std_logic_vector(LED_NUM   -1 downto 0);
            LED_D           : in    std_logic_vector(LED_NUM   -1 downto 0);
            LED_Q           : out   std_logic_vector(LED_NUM   -1 downto 0);
            TIMER_L         : in    std_logic_vector(TIMER_BITS-1 downto 0);
            TIMER_D         : in    std_logic_vector(TIMER_BITS-1 downto 0);
            TIMER_Q         : out   std_logic_vector(TIMER_BITS-1 downto 0);
            SEQ_0_L         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_0_D         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_0_Q         : out   std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_1_L         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_1_D         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_1_Q         : out   std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_2_L         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_2_D         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_2_Q         : out   std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_3_L         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_3_D         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_3_Q         : out   std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_4_L         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_4_D         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_4_Q         : out   std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_5_L         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_5_D         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_5_Q         : out   std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_6_L         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_6_D         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_6_Q         : out   std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_7_L         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_7_D         : in    std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_7_Q         : out   std_logic_vector(LED_NUM   -1 downto 0);
            SEQ_LAST_L      : in    std_logic_vector(2 downto 0);
            SEQ_LAST_D      : in    std_logic_vector(2 downto 0);
            SEQ_LAST_Q      : out   std_logic_vector(2 downto 0);
            START_L         : in    std_logic;
            START_D         : in    std_logic;
            START_Q         : out   std_logic;
            LED             : out   std_logic_vector(LED_NUM    -1 downto 0)
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
    AXI_IF: AXI4_REGISTER_INTERFACE                        --
        generic map (                                      -- 
            AXI4_ADDR_WIDTH => C_ADDR_WIDTH              , --
            AXI4_DATA_WIDTH => C_DATA_WIDTH              , --
            AXI4_ID_WIDTH   => C_ID_WIDTH                , --
            REGS_ADDR_WIDTH => REGS_ADDR_WIDTH           , --
            REGS_DATA_WIDTH => REGS_DATA_WIDTH             --
        )                                                  -- 
        port map (                                         -- 
        ---------------------------------------------------------------------------
        -- Clock and Reset Signals.
        ---------------------------------------------------------------------------
            CLK             => ACLOCK                    , -- In  :
            RST             => RST                       , -- In  :
            CLR             => CLR                       , -- In  :
        ---------------------------------------------------------------------------
        -- AXI4 Read Address Channel Signals.
        ---------------------------------------------------------------------------
            ARID            => C_ARID                    , -- In  :
            ARADDR          => C_ARADDR                  , -- In  :
            ARLEN           => C_ARLEN                   , -- In  :
            ARSIZE          => C_ARSIZE                  , -- In  :
            ARBURST         => C_ARBURST                 , -- In  :
            ARVALID         => C_ARVALID                 , -- In  :
            ARREADY         => C_ARREADY                 , -- Out :
        ---------------------------------------------------------------------------
        -- AXI4 Read Data Channel Signals.
        ---------------------------------------------------------------------------
            RID             => C_RID                     , -- Out :
            RDATA           => C_RDATA                   , -- Out :
            RRESP           => C_RRESP                   , -- Out :
            RLAST           => C_RLAST                   , -- Out :
            RVALID          => C_RVALID                  , -- Out :
            RREADY          => C_RREADY                  , -- In  :
        ---------------------------------------------------------------------------
        -- AXI4 Write Address Channel Signals.
        ---------------------------------------------------------------------------
            AWID            => C_AWID                    , -- In  :
            AWADDR          => C_AWADDR                  , -- In  :
            AWLEN           => C_AWLEN                   , -- In  :
            AWSIZE          => C_AWSIZE                  , -- In  :
            AWBURST         => C_AWBURST                 , -- In  :
            AWVALID         => C_AWVALID                 , -- In  :
            AWREADY         => C_AWREADY                 , -- Out :
        ---------------------------------------------------------------------------
        -- AXI4 Write Data Channel Signals.
        ---------------------------------------------------------------------------
            WDATA           => C_WDATA                   , -- In  :
            WSTRB           => C_WSTRB                   , -- In  :
            WLAST           => C_WLAST                   , -- In  :
            WVALID          => C_WVALID                  , -- In  :
            WREADY          => C_WREADY                  , -- Out :
        ---------------------------------------------------------------------------
        -- AXI4 Write Response Channel Signals.
        ---------------------------------------------------------------------------
            BID             => C_BID                     , -- Out :
            BRESP           => C_BRESP                   , -- Out :
            BVALID          => C_BVALID                  , -- Out :
            BREADY          => C_BREADY                  , -- In  :
        ---------------------------------------------------------------------------
        -- Register Interface.
        ---------------------------------------------------------------------------
            REGS_REQ        => regs_req                  , -- Out :
            REGS_WRITE      => regs_write                , -- Out :
            REGS_ACK        => regs_ack                  , -- In  :
            REGS_ERR        => regs_err                  , -- In  :
            REGS_ADDR       => regs_addr                 , -- Out :
            REGS_BEN        => regs_ben                  , -- Out :
            REGS_WDATA      => regs_wdata                , -- Out :
            REGS_RDATA      => regs_rdata                  -- In  :
        );                                                 -- 
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    DEC: REGISTER_ACCESS_ADAPTER                           -- 
        generic map (                                      -- 
            ADDR_WIDTH      => REGS_ADDR_WIDTH           , -- 
            DATA_WIDTH      => REGS_DATA_WIDTH           , -- 
            WBIT_MIN        => regs_wbit'low             , -- 
            WBIT_MAX        => regs_wbit'high            , -- 
            RBIT_MIN        => regs_rbit'low             , -- 
            RBIT_MAX        => regs_rbit'high            , -- 
            I_CLK_RATE      => 1                         , -- 
            O_CLK_RATE      => 1                         , -- 
            O_CLK_REGS      => 0                           -- 
        )                                                  -- 
        port map (                                         -- 
            RST             => RST                       , -- In  :
            I_CLK           => ACLOCK                    , -- In  :
            I_CLR           => CLR                       , -- In  :
            I_CKE           => '1'                       , -- In  :
            I_REQ           => regs_req                  , -- In  :
            I_SEL           => '1'                       , -- In  :
            I_WRITE         => regs_write                , -- In  :
            I_ADDR          => regs_addr                 , -- In  :
            I_BEN           => regs_ben                  , -- In  :
            I_WDATA         => regs_wdata                , -- In  :
            I_RDATA         => regs_rdata                , -- Out :
            I_ACK           => regs_ack                  , -- Out :
            I_ERR           => regs_err                  , -- Out :
            O_CLK           => ACLOCK                    , -- In  :
            O_CLR           => CLR                       , -- In  :
            O_CKE           => '1'                       , -- In  :
            O_WDATA         => regs_wbit                 , -- Out :
            O_WLOAD         => regs_load                 , -- Out :
            O_RDATA         => regs_rbit                   -- In  :
        );                                                 -- 
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    CSR: LED_CSR                                           -- 
        generic map (                                      -- 
            LED_NUM         => 8                         , -- 
            SEQ_NUM         => 8                         , -- 
            TIMER_BITS      => 28                        , -- 
            AUTO_START      => AUTO_START                , --
            DEFAULT_TIMER   => DEFAULT_TIMER             , --
            DEFAULT_SEQ_0   => DEFAULT_SEQ_0             , --
            DEFAULT_SEQ_1   => DEFAULT_SEQ_1             , --
            DEFAULT_SEQ_2   => DEFAULT_SEQ_2             , --
            DEFAULT_SEQ_3   => DEFAULT_SEQ_3             , --
            DEFAULT_SEQ_4   => DEFAULT_SEQ_4             , --
            DEFAULT_SEQ_5   => DEFAULT_SEQ_5             , --
            DEFAULT_SEQ_6   => DEFAULT_SEQ_6             , --
            DEFAULT_SEQ_7   => DEFAULT_SEQ_7             , --
            DEFAULT_SEQ_LAST=> DEFAULT_SEQ_LAST            -- 
        )                                                  -- 
        port map (                                         -- 
            CLK             => ACLOCK                    , -- In  :
            CLR             => CLR                       , -- In  :
            RST             => RST                       , -- In  :
            LED_L           => regs_load(  7 downto   0) , -- In  :
            LED_D           => regs_wbit(  7 downto   0) , -- In  :
            LED_Q           => regs_rbit(  7 downto   0) , -- Out :
            SEQ_0_L         => regs_load( 71 downto  64) , -- In  :
            SEQ_0_D         => regs_wbit( 71 downto  64) , -- In  :
            SEQ_0_Q         => regs_rbit( 71 downto  64) , -- Out :
            SEQ_1_L         => regs_load( 79 downto  72) , -- In  :
            SEQ_1_D         => regs_wbit( 79 downto  72) , -- In  :
            SEQ_1_Q         => regs_rbit( 79 downto  72) , -- Out :
            SEQ_2_L         => regs_load( 87 downto  80) , -- In  :
            SEQ_2_D         => regs_wbit( 87 downto  80) , -- In  :
            SEQ_2_Q         => regs_rbit( 87 downto  80) , -- Out :
            SEQ_3_L         => regs_load( 95 downto  88) , -- In  :
            SEQ_3_D         => regs_wbit( 95 downto  88) , -- In  :
            SEQ_3_Q         => regs_rbit( 95 downto  88) , -- Out :
            SEQ_4_L         => regs_load(103 downto  96) , -- In  :
            SEQ_4_D         => regs_wbit(103 downto  96) , -- In  :
            SEQ_4_Q         => regs_rbit(103 downto  96) , -- Out :
            SEQ_5_L         => regs_load(111 downto 104) , -- In  :
            SEQ_5_D         => regs_wbit(111 downto 104) , -- In  :
            SEQ_5_Q         => regs_rbit(111 downto 104) , -- Out :
            SEQ_6_L         => regs_load(119 downto 112) , -- In  :
            SEQ_6_D         => regs_wbit(119 downto 112) , -- In  :
            SEQ_6_Q         => regs_rbit(119 downto 112) , -- Out :
            SEQ_7_L         => regs_load(127 downto 120) , -- In  :
            SEQ_7_D         => regs_wbit(127 downto 120) , -- In  :
            SEQ_7_Q         => regs_rbit(127 downto 120) , -- Out :
            TIMER_L         => regs_load( 59 downto  32) , -- In  :
            TIMER_D         => regs_wbit( 59 downto  32) , -- In  :
            TIMER_Q         => regs_rbit( 59 downto  32) , -- Out :
            SEQ_LAST_L      => regs_load( 62 downto  60) , -- In  :
            SEQ_LAST_D      => regs_wbit( 62 downto  60) , -- In  :
            SEQ_LAST_Q      => regs_rbit( 62 downto  60) , -- Out :
            START_L         => regs_load(63)             , -- In  :
            START_D         => regs_wbit(63)             , -- In  :
            START_Q         => regs_rbit(63)             , -- Out :
            LED             => LED                         -- Out :
        );
    regs_rbit(31 downto 8) <= (31 downto 8 => '0');
end RTL;
