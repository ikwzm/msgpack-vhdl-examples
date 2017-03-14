-----------------------------------------------------------------------------------
--!     @file    zundoko_main.vhd
--!     @brief   Zun-Doko Main Module
--!     @version 0.1.0
--!     @date    2016/3/20
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2016 Ichiro Kawazome
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
library MsgPack;
use     MsgPack.MsgPack_RPC;
entity  ZunDoko_Main is
    port (
        clk             : in  std_logic;
        reset           : in  std_logic;
        req_valid       : in  std_logic;
        req_ready       : out std_logic;
        res_valid       : out std_logic;
        res_ready       : in  std_logic;
        ret_valid       : out std_logic;
        ret_code        : out MsgPack_RPC.Code_Type;
        ret_last        : out std_logic;
        ret_ready       : in  std_logic
    );
end  ZunDoko_Main;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Encode_Array;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Encode_String_Constant;
use     Work.TINYMT32.all;
architecture RTL of ZunDoko_Main is
    constant BUF_DEPTH     :  integer := 16;
    subtype  WORD_TYPE     is std_logic_vector(1 downto 0);
    type     WORD_VECTOR   is array(integer range <>) of WORD_TYPE;
    constant NULL_WORD     :  WORD_TYPE := "00";
    constant ZUN_WORD      :  WORD_TYPE := "10";
    constant DOKO_WORD     :  WORD_TYPE := "11";
    signal   zundoko_word  :  WORD_TYPE;
    signal   zundoko_gen   :  boolean;
    signal   kiyoshi_shout :  boolean;
    signal   buf_count     :  unsigned(BUF_DEPTH downto 0);
    signal   buf_read      :  std_logic;
    signal   buf_word      :  WORD_TYPE;
    signal   buf_full      :  boolean;
    signal   buf_empty     :  boolean;
    signal   return_kiyoshi:  boolean;
    signal   return_dummy  :  boolean;
    signal   return_done   :  boolean;
    signal   zundoko_run   :  boolean;
begin
    ZUN_DOKO_GENERATOR: block
        constant DEFAULT_PARAM :  PSEUDO_RANDOM_NUMBER_GENERATOR_TYPE
                               := NEW_PSEUDO_RANDOM_NUMBER_GENERATOR(
                                     X"8f7011ee",
                                     X"fc78ff1f",
                                     X"3793fdff",
                                     TO_SEED_TYPE(1)
                                  );
        signal   curr_status   :  PSEUDO_RANDOM_NUMBER_GENERATOR_TYPE;
        signal   random_number :  RANDOM_NUMBER_TYPE;
        signal   random_valid  :  std_logic;
    begin
        process (clk, reset)
            variable next_status :  PSEUDO_RANDOM_NUMBER_GENERATOR_TYPE;
        begin
            if (reset = '1') then
                curr_status   <= DEFAULT_PARAM;
                random_number <= (others => '0');
                random_valid  <= '0';
            elsif (clk'event and clk = '1') then
                if (zundoko_gen = TRUE) then
                    next_status := curr_status;
                    NEXT_PSEUDO_RANDOM_NUMBER_GENERATOR(next_status);
                    curr_status <= next_status;
                else
                    next_status := curr_status;
                end if;
                random_number <= GENERATE_TEMPER(next_status);
                random_valid  <= '1';
            end if;
        end process;
        zundoko_word <= NULL_WORD when (random_valid      = '0') else
                        ZUN_WORD  when (random_number(31) = '1') else
                        DOKO_WORD;
    end block;

    KIYOSHI_CHECKER: block
        constant ALL_ZUN_WORD  :  WORD_VECTOR(3 downto 0) := (others => ZUN_WORD);
        signal   queue_words   :  WORD_VECTOR(3 downto 0);
    begin
        process (clk, reset) begin
            if (reset = '1') then
                    queue_words <= (others => NULL_WORD);
            elsif (clk'event and clk = '1') then
                if    (zundoko_gen  = FALSE) then
                    queue_words <= (others => NULL_WORD);
                elsif (zundoko_word = ZUN_WORD or zundoko_word = DOKO_WORD) then
                    for i in queue_words'range loop
                        if (i = 0) then
                            queue_words(i) <= zundoko_word;
                        else
                            queue_words(i) <= queue_words(i-1);
                        end if;
                    end loop;
                end if;
            end if;
        end process;
        kiyoshi_shout <= (queue_words = ALL_ZUN_WORD and zundoko_word = DOKO_WORD);
    end block;

    ZUN_DOKO_BUF: block
        signal   w_en     :  std_logic;
        signal   w_addr   :  unsigned(BUF_DEPTH-1 downto 0);
        signal   r_addr   :  unsigned(BUF_DEPTH-1 downto 0);
    begin
        MEM: block
            type     RAM_TYPE is array(integer range <>) of std_logic_vector(0 downto 0);
            signal   ram      :  RAM_TYPE(0 to 2**BUF_DEPTH-1);
            signal   w_data   :  std_logic_vector(0 downto 0);
            signal   r_data   :  std_logic_vector(0 downto 0);
        begin
            w_data    <= "1" when (zundoko_word = DOKO_WORD) else "0";
            buf_word  <= DOKO_WORD when (r_data = "1") else
                         ZUN_WORD;
            process (clk) begin
                if (clk'event and clk = '1') then
                    if (w_en = '1') then
                        ram(to_integer(to_01(w_addr))) <= w_data;
                    end if;
                    r_data <= ram(to_integer(to_01(r_addr)));
                end if;
            end process;
        end block;
        W: block
            signal   req         :  boolean;
            signal   full        :  boolean;
            signal   last        :  boolean;
            signal   curr_count  :  unsigned(BUF_DEPTH   downto 0);
        begin
            req      <= ((zundoko_gen  = TRUE) and
                         (zundoko_word = ZUN_WORD or zundoko_word = DOKO_WORD));
            last     <= (curr_count = 2**BUF_DEPTH-1);
            w_en     <= '1' when (req = TRUE and full = FALSE) else '0';
            w_addr   <= curr_count(w_addr'range);
            buf_full <= ((last = TRUE and req = TRUE) or (full = TRUE));
            process (clk) begin
                if (reset = '1') then
                        curr_count <= (others => '0');
                        full    <= FALSE;
                elsif (clk'event and clk = '1') then
                    if (zundoko_run = FALSE) then
                        curr_count <= (others => '0');
                        full    <= FALSE;
                    elsif (w_en = '1') then
                        curr_count <= curr_count + 1;
                        full    <= last;
                    end if;
                end if;
            end process;
            buf_count <= curr_count;
        end block;
        R: block
            signal   curr_count  :  unsigned(BUF_DEPTH downto 0);
            signal   next_count  :  unsigned(BUF_DEPTH downto 0);
        begin
            next_count <= curr_count + 1 when (buf_read = '1') else curr_count;
            r_addr     <= next_count(r_addr'range);
            process (clk) begin
                if (reset = '1') then
                        curr_count <= (others => '0');
                elsif (clk'event and clk = '1') then
                    if (zundoko_run = FALSE) then
                        curr_count <= (others => '0');
                    else
                        curr_count <= next_count;
                    end if;
                end if;
            end process;
            buf_empty <= (curr_count = buf_count);
        end block;
    end block;

    RET: block
        type     STATE_TYPE      is(IDLE_STATE, ARRAY_STATE, CHECK_STATE, DONE_STATE,
                                    ZUN_STATE , DOKO_STATE , KIYOSHI_STATE);
        signal   state           :  STATE_TYPE;
        signal   array_start     :  std_logic;
        signal   array_size      :  std_logic_vector(BUF_DEPTH downto 0);
        signal   entry_code      :  MsgPack_RPC.Code_Type;
        signal   entry_last      :  std_logic;
        signal   entry_valid     :  std_logic;
        signal   entry_ready     :  std_logic;
        signal   zun_code        :  MsgPack_RPC.Code_Type;
        signal   zun_last        :  std_logic;
        signal   zun_valid       :  std_logic;
        signal   zun_ready       :  std_logic;
        signal   doko_code       :  MsgPack_RPC.Code_Type;
        signal   doko_last       :  std_logic;
        signal   doko_valid      :  std_logic;
        signal   doko_ready      :  std_logic;
        signal   kiyoshi_code    :  MsgPack_RPC.Code_Type;
        signal   kiyoshi_last    :  std_logic;
        signal   kiyoshi_valid   :  std_logic;
        signal   kiyoshi_ready   :  std_logic;
    begin
        ENC_ARRAY: MsgPack_Object_Encode_Array
            generic map (
                CODE_WIDTH => MsgPack_RPC.Code_Length,
                SIZE_BITS  => array_size'length
            )
            port map (
                CLK        => clk           , 
                RST        => reset         ,
                CLR        => '0'           ,
                START      => array_start   , 
                SIZE       => array_size    ,
                I_CODE     => entry_code    ,
                I_LAST     => entry_last    ,
                I_ERROR    => '0'           ,
                I_VALID    => entry_valid   ,
                I_READY    => entry_ready   ,
                O_CODE     => ret_code      ,
                O_LAST     => ret_last      ,
                O_ERROR    => open          ,
                O_VALID    => ret_valid     ,
                O_READY    => ret_ready
            );
        ENC_ZUN: MsgPack_Object_Encode_String_Constant
            generic map (
                VALUE      => "ZUN",
                CODE_WIDTH => MsgPack_RPC.Code_Length
            )
            port map (
                CLK        => clk           , 
                RST        => reset         ,
                CLR        => '0'           ,
                START      => '1'           ,
                BUSY       => open          ,
                O_CODE     => zun_code      ,
                O_LAST     => zun_last      ,
                O_ERROR    => open          ,
                O_VALID    => zun_valid     ,
                O_READY    => zun_ready
            );
        ENC_DOKO: MsgPack_Object_Encode_String_Constant
            generic map (
                VALUE      => "DOKO",
                CODE_WIDTH => MsgPack_RPC.Code_Length
            )
            port map (
                CLK        => clk           , 
                RST        => reset         ,
                CLR        => '0'           ,
                START      => '1'           ,
                BUSY       => open          ,
                O_CODE     => doko_code     ,
                O_LAST     => doko_last     ,
                O_ERROR    => open          ,
                O_VALID    => doko_valid    ,
                O_READY    => doko_ready
            );
        ENC_KIYOSHI: MsgPack_Object_Encode_String_Constant
            generic map (
                VALUE      => "KI.YO.SHI!"  ,
                CODE_WIDTH => MsgPack_RPC.Code_Length
            )
            port map (
                CLK        => clk           , 
                RST        => reset         ,
                CLR        => '0'           ,
                START      => '1'           ,
                BUSY       => open          ,
                O_CODE     => kiyoshi_code  ,
                O_LAST     => kiyoshi_last  ,
                O_ERROR    => open          ,
                O_VALID    => kiyoshi_valid ,
                O_READY    => kiyoshi_ready
            );
        process(clk, reset) begin
            if (reset = '1') then
                state <= IDLE_STATE;
            elsif (clk'event and clk = '1') then
                case state is
                    when IDLE_STATE =>
                        if (return_kiyoshi = TRUE or return_dummy = TRUE) then
                            state <= ARRAY_STATE;
                        else
                            state <= IDLE_STATE;
                        end if;
                        if (return_kiyoshi = TRUE) then
                            array_size <= std_logic_vector(buf_count + 1);
                        else
                            array_size <= std_logic_vector(buf_count    );
                        end if;
                    when ARRAY_STATE =>
                        state <= CHECK_STATE;
                    when CHECK_STATE =>
                        if (buf_empty = TRUE) then
                            if (return_kiyoshi = TRUE) then
                                state <= KIYOSHI_STATE;
                            else
                                state <= DONE_STATE;
                            end if;
                        elsif (buf_word = DOKO_WORD) then
                            state <= DOKO_STATE;
                        else
                            state <= ZUN_STATE;
                        end if;
                    when ZUN_STATE =>
                        if (zun_valid = '1' and zun_ready = '1' and zun_last = '1') then
                            state <= CHECK_STATE;
                        else
                            state <= ZUN_STATE;
                        end if;
                    when DOKO_STATE =>
                        if (doko_valid = '1' and doko_ready = '1' and doko_last = '1') then
                            state <= CHECK_STATE;
                        else
                            state <= DOKO_STATE;
                        end if;
                    when KIYOSHI_STATE =>
                        if (kiyoshi_valid = '1' and kiyoshi_ready = '1' and kiyoshi_last = '1') then
                            state <= DONE_STATE;
                        else
                            state <= KIYOSHI_STATE;
                        end if;
                    when DONE_STATE =>
                        state <= IDLE_STATE;
                    when others =>
                        state <= IDLE_STATE;
                end case;
            end if;
        end process;
        array_start   <= '1' when (state = ARRAY_STATE  ) else '0';
        buf_read      <= '1' when (state = CHECK_STATE  ) else '0';
        zun_ready     <= '1' when (state = ZUN_STATE     and entry_ready   = '1') else '0';
        doko_ready    <= '1' when (state = DOKO_STATE    and entry_ready   = '1') else '0';
        kiyoshi_ready <= '1' when (state = KIYOSHI_STATE and entry_ready   = '1') else '0';
        entry_valid   <= '1' when (state = ZUN_STATE     and zun_valid     = '1') or
                                  (state = DOKO_STATE    and doko_valid    = '1') or
                                  (state = KIYOSHI_STATE and kiyoshi_valid = '1') else '0';
        entry_last    <= '1' when (state = ZUN_STATE     and zun_last      = '1') or
                                  (state = DOKO_STATE    and doko_last     = '1') or
                                  (state = KIYOSHI_STATE and kiyoshi_last  = '1') else '0';
        entry_code    <= zun_code  when (state = ZUN_STATE ) else
                         doko_code when (state = DOKO_STATE) else
                         kiyoshi_code;
        return_done   <= (state = DONE_STATE);
    end block;

    MAIN: block
        type     STATE_TYPE      is(IDLE_STATE, ZUNDOKO_GEN_STATE, KIYOSHI_RET_STATE, DUMMY_RET_STATE, RES_STATE);
        signal   state           :  STATE_TYPE;
    begin
        process(clk, reset) begin
            if (reset = '1') then
                state <= IDLE_STATE;
            elsif (clk'event and clk = '1') then
                case state is
                    when IDLE_STATE =>
                        if (req_valid = '1') then
                            state <= ZUNDOKO_GEN_STATE;
                        else
                            state <= IDLE_STATE;
                        end if;
                    when ZUNDOKO_GEN_STATE =>
                        if (zundoko_word = ZUN_WORD or zundoko_word = DOKO_WORD) then
                            if    (kiyoshi_shout = TRUE) then
                                state <= KIYOSHI_RET_STATE;
                            elsif (buf_full      = TRUE) then
                                state <= DUMMY_RET_STATE;
                            else
                                state <= ZUNDOKO_GEN_STATE;
                            end if;
                        else
                                state <= ZUNDOKO_GEN_STATE;
                        end if;
                    when KIYOSHI_RET_STATE =>
                        if (return_done = TRUE) then
                            state <= RES_STATE;
                        else
                            state <= KIYOSHI_RET_STATE;
                        end if;
                    when DUMMY_RET_STATE   =>
                        if (return_done = TRUE) then
                            state <= RES_STATE;
                        else
                            state <= DUMMY_RET_STATE;
                        end if;
                    when RES_STATE =>
                        if (res_ready = '1') then
                            state <= IDLE_STATE;
                        else
                            state <= RES_STATE;
                        end if;
                    when others =>
                            state <= IDLE_STATE;
                end case;
            end if;
        end process;
        zundoko_run    <= (state /= IDLE_STATE       );
        zundoko_gen    <= (state  = ZUNDOKO_GEN_STATE);
        return_dummy   <= (state  = DUMMY_RET_STATE  );
        return_kiyoshi <= (state  = KIYOSHI_RET_STATE);
        req_ready      <= '1' when (state = IDLE_STATE) else '0';
        res_valid      <= '1' when (state = RES_STATE ) else '0';
    end block;
end RTL;
