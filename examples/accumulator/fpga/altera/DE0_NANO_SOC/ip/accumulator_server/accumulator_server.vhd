-----------------------------------------------------------------------------------
--!     @file    accumulator_server.vhd
--!     @brief   Sample Module for MsgPack_RPC_Server
--!     @version 0.1.0
--!     @date    2015/10/2
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
use     ieee.numeric_std.all;
entity  Accumulator_Server is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        I_BYTES         : positive := 4;
        O_BYTES         : positive := 4
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        ARESETn         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Data Input Interface
    -------------------------------------------------------------------------------
        I_TDATA         : in  std_logic_vector(8*I_BYTES-1 downto 0);
        I_TKEEP         : in  std_logic_vector(  I_BYTES-1 downto 0);
        I_TLAST         : in  std_logic := '0';
        I_TVALID        : in  std_logic;
        I_TREADY        : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Data Output Interface
    -------------------------------------------------------------------------------
        O_TDATA         : out std_logic_vector(8*O_BYTES-1 downto 0);
        O_TKEEP         : out std_logic_vector(  O_BYTES-1 downto 0);
        O_TLAST         : out std_logic;
        O_TVALID        : out std_logic;
        O_TREADY        : in  std_logic
    );
end  Accumulator_Server;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Server;
architecture RTL of Accumulator_Server is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant PROC_NUM       :  integer :=  3;
    constant MATCH_PHASE    :  integer :=  8;
    signal   reset          :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   match_req      :  std_logic_vector        (MATCH_PHASE-1 downto 0);
    signal   match_code     :  MsgPack_RPC.Code_Type;
    signal   match_ok       :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal   match_not      :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal   match_shift    :  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    signal   proc_req_id    :  MsgPack_RPC.MsgID_Type;
    signal   proc_req       :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal   proc_busy      :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal   param_code     :  MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
    signal   param_valid    :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal   param_last     :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal   param_shift    :  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    signal   proc_res_id    :  MsgPack_RPC.MsgID_Vector(PROC_NUM-1 downto 0);
    signal   proc_res_code  :  MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
    signal   proc_res_valid :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal   proc_res_last  :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal   proc_res_ready :  std_logic_vector        (PROC_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal   reg_out        :  signed(31 downto 0);
    signal   reg_in         :  signed(31 downto 0);
    signal   reg_we         :  std_logic;
    signal   add_x          :  signed(31 downto 0);
    signal   add_return     :  signed(31 downto 0);
    signal   add_req        :  std_logic;
    signal   add_busy       :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    component Add_Interface
        generic (
            NAME            : string;
            MATCH_PHASE     : integer
        );
        port (
            CLK             : in  std_logic; 
            RST             : in  std_logic;
            CLR             : in  std_logic;
            MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
            MATCH_CODE      : in  MsgPack_RPC.Code_Type;
            MATCH_OK        : out std_logic;
            MATCH_NOT       : out std_logic;
            MATCH_SHIFT     : out MsgPack_RPC.Shift_Type;
            PROC_REQ_ID     : in  MsgPack_RPC.MsgID_Type;
            PROC_REQ        : in  std_logic;
            PROC_BUSY       : out std_logic;
            PARAM_CODE      : in  MsgPack_RPC.Code_Type;
            PARAM_VALID     : in  std_logic;
            PARAM_LAST      : in  std_logic;
            PARAM_SHIFT     : out MsgPack_RPC.Shift_Type;
            PROC_RES_ID     : out MsgPack_RPC.MsgID_Type;
            PROC_RES_CODE   : out MsgPack_RPC.Code_Type;
            PROC_RES_VALID  : out std_logic;
            PROC_RES_LAST   : out std_logic;
            PROC_RES_READY  : in  std_logic;
            add_x           : out signed(32-1 downto 0);
            add_return      : in  signed(32-1 downto 0);
            add_busy        : in  std_logic;
            add_req         : out std_logic
        );
    end  component;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    component Set_Interface
        generic (
            NAME            : string;
            MATCH_PHASE     : integer
        );
        port (
            CLK             : in  std_logic; 
            RST             : in  std_logic;
            CLR             : in  std_logic;
            MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
            MATCH_CODE      : in  MsgPack_RPC.Code_Type;
            MATCH_OK        : out std_logic;
            MATCH_NOT       : out std_logic;
            MATCH_SHIFT     : out MsgPack_RPC.Shift_Type;
            PROC_REQ_ID     : in  MsgPack_RPC.MsgID_Type;
            PROC_REQ        : in  std_logic;
            PROC_BUSY       : out std_logic;
            PARAM_CODE      : in  MsgPack_RPC.Code_Type;
            PARAM_VALID     : in  std_logic;
            PARAM_LAST      : in  std_logic;
            PARAM_SHIFT     : out MsgPack_RPC.Shift_Type;
            PROC_RES_ID     : out MsgPack_RPC.MsgID_Type;
            PROC_RES_CODE   : out MsgPack_RPC.Code_Type;
            PROC_RES_VALID  : out std_logic;
            PROC_RES_LAST   : out std_logic;
            PROC_RES_READY  : in  std_logic;
            reg_in          : out signed(32-1 downto 0);
            reg_we          : out std_logic
        );
    end  component;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    component Get_Interface
        generic (
            NAME            : string;
            MATCH_PHASE     : integer
        );
        port (
            CLK             : in  std_logic; 
            RST             : in  std_logic;
            CLR             : in  std_logic;
            MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
            MATCH_CODE      : in  MsgPack_RPC.Code_Type;
            MATCH_OK        : out std_logic;
            MATCH_NOT       : out std_logic;
            MATCH_SHIFT     : out MsgPack_RPC.Shift_Type;
            PROC_REQ_ID     : in  MsgPack_RPC.MsgID_Type;
            PROC_REQ        : in  std_logic;
            PROC_BUSY       : out std_logic;
            PARAM_CODE      : in  MsgPack_RPC.Code_Type;
            PARAM_VALID     : in  std_logic;
            PARAM_LAST      : in  std_logic;
            PARAM_SHIFT     : out MsgPack_RPC.Shift_Type;
            PROC_RES_ID     : out MsgPack_RPC.MsgID_Type;
            PROC_RES_CODE   : out MsgPack_RPC.Code_Type;
            PROC_RES_VALID  : out std_logic;
            PROC_RES_LAST   : out std_logic;
            PROC_RES_READY  : in  std_logic;
            reg_out         : in  signed(32-1 downto 0)
        );
    end  component;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    component Accumulator is
        port (
            clk        : in  std_logic;
            reset      : in  std_logic;
            reg_in     : in  signed(32-1 downto 0);
            reg_we     : in  std_logic;
            reg_out    : out signed(32-1 downto 0);
            add_x      : in  signed(32-1 downto 0);
            add_return : out signed(32-1 downto 0);
            add_busy   : out std_logic;
            add_req    : in  std_logic
        );
    end component;
begin
    reset <= '1' when (ARESETn = '0') else '0';
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    Server: MsgPack_RPC_Server                   -- 
        generic map (                            -- 
            I_BYTES         => I_BYTES         , --
            O_BYTES         => O_BYTES         , --
            PROC_NUM        => PROC_NUM        , -- 
            MATCH_PHASE     => MATCH_PHASE       --
        )                                        -- 
        port map (                               -- 
            CLK             => CLK             , -- In  :
            RST             => reset           , -- In  :
            CLR             => '0'             , -- In  :
            I_DATA          => I_TDATA         , -- In  :
            I_STRB          => I_TKEEP         , -- In  :
            I_LAST          => I_TLAST         , -- In  :
            I_VALID         => I_TVALID        , -- In  :
            I_READY         => I_TREADY        , -- Out :
            O_DATA          => O_TDATA         , -- Out :
            O_STRB          => O_TKEEP         , -- Out :
            O_LAST          => O_TLAST         , -- Out :
            O_VALID         => O_TVALID        , -- Out :
            O_READY         => O_TREADY        , -- In  :
            MATCH_REQ       => match_req       , -- Out :
            MATCH_CODE      => match_code      , -- Out :
            MATCH_OK        => match_ok        , -- In  :
            MATCH_NOT       => match_not       , -- In  :
            MATCH_SHIFT     => match_shift     , -- In  :
            PROC_REQ_ID     => proc_req_id     , -- Out :
            PROC_REQ        => proc_req        , -- Out :
            PROC_BUSY       => proc_busy       , -- In  :
            PARAM_VALID     => param_valid     , -- Out :
            PARAM_CODE      => param_code      , -- Out :
            PARAM_LAST      => param_last      , -- Out :
            PARAM_SHIFT     => param_shift     , -- In  :
            PROC_RES_ID     => proc_res_id     , -- In  :
            PROC_RES_CODE   => proc_res_code   , -- In  :
            PROC_RES_VALID  => proc_res_valid  , -- In  :
            PROC_RES_LAST   => proc_res_last   , -- In  :
            PROC_RES_READY  => proc_res_ready    -- Out :
        );                                       -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    Add_IF: Add_Interface                            -- 
        generic map (                                -- 
            NAME            => string'("add"),       -- 
            MATCH_PHASE     => MATCH_PHASE           -- 
        )                                            -- 
        port map (                                   -- 
            CLK             => CLK                 , -- In  :
            RST             => reset               , -- In  :
            CLR             => '0'                 , -- In  :
            MATCH_REQ       => match_req           , -- In  :
            MATCH_CODE      => match_code          , -- In  :
            MATCH_OK        => match_ok      (0)   , -- Out :
            MATCH_NOT       => match_not     (0)   , -- Out :
            MATCH_SHIFT     => match_shift   (0)   , -- Out :
            PROC_REQ_ID     => proc_req_id         , -- In  :
            PROC_REQ        => proc_req      (0)   , -- In  :
            PROC_BUSY       => proc_busy     (0)   , -- Out :
            PARAM_VALID     => param_valid   (0)   , -- In  :
            PARAM_CODE      => param_code    (0)   , -- In  :
            PARAM_LAST      => param_last    (0)   , -- In  :
            PARAM_SHIFT     => param_shift   (0)   , -- Out :
            PROC_RES_ID     => proc_res_id   (0)   , -- Out :
            PROC_RES_CODE   => proc_res_code (0)   , -- Out :
            PROC_RES_VALID  => proc_res_valid(0)   , -- Out :
            PROC_RES_LAST   => proc_res_last (0)   , -- Out :
            PROC_RES_READY  => proc_res_ready(0)   , -- In  :
            add_x           => add_x               , -- Out :
            add_return      => add_return          , -- In  :
            add_busy        => add_busy            , -- In  :
            add_req         => add_req               -- Out :
        );                                           -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    Set_IF: Set_Interface                            -- 
        generic map (                                -- 
            NAME            => string'("$SET"),      -- 
            MATCH_PHASE     => MATCH_PHASE           -- 
        )                                            -- 
        port map (                                   -- 
            CLK             => CLK                 , -- In  :
            RST             => reset               , -- In  :
            CLR             => '0'                 , -- In  :
            MATCH_REQ       => match_req           , -- In  :
            MATCH_CODE      => match_code          , -- In  :
            MATCH_OK        => match_ok      (1)   , -- Out :
            MATCH_NOT       => match_not     (1)   , -- Out :
            MATCH_SHIFT     => match_shift   (1)   , -- Out :
            PROC_REQ_ID     => proc_req_id         , -- In  :
            PROC_REQ        => proc_req      (1)   , -- In  :
            PROC_BUSY       => proc_busy     (1)   , -- Out :
            PARAM_VALID     => param_valid   (1)   , -- In  :
            PARAM_CODE      => param_code    (1)   , -- In  :
            PARAM_LAST      => param_last    (1)   , -- In  :
            PARAM_SHIFT     => param_shift   (1)   , -- Out :
            PROC_RES_ID     => proc_res_id   (1)   , -- Out :
            PROC_RES_CODE   => proc_res_code (1)   , -- Out :
            PROC_RES_VALID  => proc_res_valid(1)   , -- Out :
            PROC_RES_LAST   => proc_res_last (1)   , -- Out :
            PROC_RES_READY  => proc_res_ready(1)   , -- In  :
            reg_in          => reg_in              , -- Out :
            reg_we          => reg_we                -- Out :
        );                                           -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    Get_IF: Get_Interface                            -- 
        generic map (                                -- 
            NAME            => string'("$GET"),      -- 
            MATCH_PHASE     => MATCH_PHASE           -- 
        )                                            -- 
        port map (                                   -- 
            CLK             => CLK                 , -- In  :
            RST             => reset               , -- In  :
            CLR             => '0'                 , -- In  :
            MATCH_REQ       => match_req           , -- In  :
            MATCH_CODE      => match_code          , -- In  :
            MATCH_OK        => match_ok      (2)   , -- Out :
            MATCH_NOT       => match_not     (2)   , -- Out :
            MATCH_SHIFT     => match_shift   (2)   , -- Out :
            PROC_REQ_ID     => proc_req_id         , -- In  :
            PROC_REQ        => proc_req      (2)   , -- In  :
            PROC_BUSY       => proc_busy     (2)   , -- Out :
            PARAM_VALID     => param_valid   (2)   , -- In  :
            PARAM_CODE      => param_code    (2)   , -- In  :
            PARAM_LAST      => param_last    (2)   , -- In  :
            PARAM_SHIFT     => param_shift   (2)   , -- Out :
            PROC_RES_ID     => proc_res_id   (2)   , -- Out :
            PROC_RES_CODE   => proc_res_code (2)   , -- Out :
            PROC_RES_VALID  => proc_res_valid(2)   , -- Out :
            PROC_RES_LAST   => proc_res_last (2)   , -- Out :
            PROC_RES_READY  => proc_res_ready(2)   , -- In  :
            reg_out         => reg_out               -- In  :
        );                                           -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    ACC: Accumulator                                 -- 
        port map (                                   -- 
            clk             => CLK                 , -- In  :
            reset           => reset               , -- In  :
            reg_in          => reg_in              , -- In  :
            reg_we          => reg_we              , -- In  :
            reg_out         => reg_out             , -- Out :
            add_x           => add_x               , -- In  :
            add_return      => add_return          , -- Out :
            add_busy        => add_busy            , -- Out :
            add_req         => add_req               -- In  :
        );
end RTL;
