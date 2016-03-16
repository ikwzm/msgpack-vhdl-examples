-----------------------------------------------------------------------------------
--!     @file    led_csr.vhd
--!     @brief   LED Control Status Registers
--!     @version 0.0.1
--!     @date    2014/7/28
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
--! @brief LED Control Status Registers
-----------------------------------------------------------------------------------
entity  LED_CSR is
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
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
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals.
    -------------------------------------------------------------------------------
        CLK             : in    std_logic;
        CLR             : in    std_logic;
        RST             : in    std_logic;
    -------------------------------------------------------------------------------
    -- Register Access Interface
    -------------------------------------------------------------------------------
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
    -------------------------------------------------------------------------------
    -- Output LED Signals.
    -------------------------------------------------------------------------------
        LED             : out   std_logic_vector(LED_NUM    -1 downto 0)
    );
end     LED_CSR;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
architecture RTL of LED_CSR is
    -------------------------------------------------------------------------------
    -- REGISTER PROCEDURE
    -------------------------------------------------------------------------------
    procedure REGS(
        signal   CLK   : in    std_logic;
        signal   RST   : in    std_logic;
        signal   CLR   : in    std_logic;
        constant DEF   : in    integer;
        signal   L     : in    std_logic_vector;
        signal   D     : in    std_logic_vector;
        signal   Q     : inout std_logic_vector
    ) is
        alias    load  :       std_logic_vector(Q'length-1 downto 0) is L;
        alias    wdata :       std_logic_vector(Q'length-1 downto 0) is D;
    begin
        if (RST = '1') then
                Q <= std_logic_vector(to_unsigned(DEF,Q'length));
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                Q <= std_logic_vector(to_unsigned(DEF,Q'length));
            else
                for i in Q'range loop
                    if (load(i) = '1') then
                        Q(i) <= wdata(i);
                    end if;
                end loop;
            end if;
        end if;
    end procedure;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    subtype  LED_TYPE   is std_logic_vector(LED_NUM-1 downto 0);
    type     LED_VECTER is array(integer range <>) of LED_TYPE;
    signal   seq_regs   :  LED_VECTER(0 to SEQ_NUM-1);
    signal   seq_last   :  std_logic_vector(2 downto 0);
    signal   timer      :  std_logic_vector(TIMER_BITS-1 downto 0);
    signal   counter    :  unsigned        (TIMER_BITS-1 downto 0);
    signal   trigger    :  boolean;
    signal   curr_led   :  LED_TYPE;
    signal   curr_seq   :  integer range 0 to SEQ_NUM-1;
    signal   run        :  boolean;
begin
    -------------------------------------------------------------------------------
    -- SEQ_[0-7] REGISTERS
    -------------------------------------------------------------------------------
    SEQ_0: if (SEQ_NUM > 0) generate
        process (CLK, RST) begin
            REGS(CLK, RST, CLR, DEFAULT_SEQ_0, SEQ_0_L, SEQ_0_D, seq_regs(0));
        end process;
        SEQ_0_Q <= seq_regs(0);
    end generate;
    SEQ_1: if (SEQ_NUM > 1) generate
        process (CLK, RST) begin
            REGS(CLK, RST, CLR, DEFAULT_SEQ_1, SEQ_1_L, SEQ_1_D, seq_regs(1));
        end process;
        SEQ_1_Q <= seq_regs(1);
    end generate;
    SEQ_2: if (SEQ_NUM > 2) generate
        process (CLK, RST) begin
            REGS(CLK, RST, CLR, DEFAULT_SEQ_2, SEQ_2_L, SEQ_2_D, seq_regs(2));
        end process;
        SEQ_2_Q <= seq_regs(2);
    end generate;
    SEQ_3: if (SEQ_NUM > 3) generate
        process (CLK, RST) begin
            REGS(CLK, RST, CLR, DEFAULT_SEQ_3, SEQ_3_L, SEQ_3_D, seq_regs(3));
        end process;
        SEQ_3_Q <= seq_regs(3);
    end generate;
    SEQ_4: if (SEQ_NUM > 4) generate
        process (CLK, RST) begin
            REGS(CLK, RST, CLR, DEFAULT_SEQ_4, SEQ_4_L, SEQ_4_D, seq_regs(4));
        end process;
        SEQ_4_Q <= seq_regs(4);
    end generate;
    SEQ_5: if (SEQ_NUM > 5) generate
        process (CLK, RST) begin
            REGS(CLK, RST, CLR, DEFAULT_SEQ_5, SEQ_5_L, SEQ_5_D, seq_regs(5));
        end process;
        SEQ_5_Q <= seq_regs(5);
    end generate;
    SEQ_6: if (SEQ_NUM > 6) generate
        process (CLK, RST) begin
            REGS(CLK, RST, CLR, DEFAULT_SEQ_6, SEQ_6_L, SEQ_6_D, seq_regs(6));
        end process;
        SEQ_6_Q <= seq_regs(6);
    end generate;
    SEQ_7: if (SEQ_NUM > 7) generate
        process (CLK, RST) begin
            REGS(CLK, RST, CLR, DEFAULT_SEQ_7, SEQ_7_L, SEQ_7_D, seq_regs(7));
        end process;
        SEQ_7_Q <= seq_regs(7);
    end generate;
    -------------------------------------------------------------------------------
    -- timer    : 
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        REGS(CLK, RST, CLR, DEFAULT_TIMER   , TIMER_L   , TIMER_D   , timer   );
    end process;
    TIMER_Q <= timer;
    -------------------------------------------------------------------------------
    -- seq_last :
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        REGS(CLK, RST, CLR, DEFAULT_SEQ_LAST, SEQ_LAST_L, SEQ_LAST_D, seq_last);
    end process;
    SEQ_LAST_Q <= seq_last;
    -------------------------------------------------------------------------------
    -- counter  :
    -------------------------------------------------------------------------------
    process (CLK, RST)
        variable curr_count : unsigned(counter'high+1 downto 0);
        variable next_count : unsigned(counter'high+1 downto 0);
    begin
        if (RST = '1') then
                counter <= (others => '0');
                trigger <= FALSE;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1' or run = FALSE) then
                counter <= (others => '0');
                trigger <= FALSE;
            else
                curr_count := "0" & counter;
                next_count := curr_count - 1;
                if (next_count(next_count'high) = '1') then
                    counter <= unsigned(timer);
                    trigger <= TRUE;
                else
                    counter <= next_count(counter'range);
                    trigger <= FALSE;
                end if;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- curr_seq : 
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                curr_seq <= 0;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1' or run = FALSE) then
                curr_seq <= 0;
            elsif (trigger = TRUE) then
                if (curr_seq >= SEQ_NUM-1) or
                   (curr_seq =  unsigned(seq_last)) then
                    curr_seq <= 0;
                else
                    curr_seq <= curr_seq + 1;
                end if;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- LED : 
    -------------------------------------------------------------------------------
    process (CLK, RST)
        variable next_led : LED_TYPE;
    begin
        if (RST = '1') then
                curr_led <= std_logic_vector(to_unsigned(DEFAULT_SEQ_0, LED_NUM));
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_led <= std_logic_vector(to_unsigned(DEFAULT_SEQ_0, LED_NUM));
            else
                next_led := curr_led;
                for seq in 0 to SEQ_NUM-1 loop
                    if (run = TRUE and trigger = TRUE and seq = curr_seq) then
                        next_led := seq_regs(seq);
                    end if;
                end loop;
                for i in 0 to LED_NUM-1 loop
                    if (LED_L(i) = '1') then
                        curr_led(i) <= LED_D(i);
                    else
                        curr_led(i) <= next_led(i);
                    end if;
                end loop;
            end if;
        end if;
    end process;
    LED   <= curr_led;
    LED_Q <= curr_led;
    -------------------------------------------------------------------------------
    -- RUN : 
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                run <= AUTO_START;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                run <= AUTO_START;
            elsif (START_L = '1') then
                run <= (START_D = '1');
            end if;
        end if;
    end process;
    START_Q <= '1' when (run = TRUE) else '0';
end RTL;
