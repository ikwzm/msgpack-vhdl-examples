-----------------------------------------------------------------------------------
--!     @file    fib_interface.vhd
--!     @brief   Fib Interface Module
--!     @version 0.2.5
--!     @date    2017/3/14
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012-2017 Ichiro Kawazome
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
library MsgPack;
use     MsgPack.MsgPack_RPC;
entity  Fib_Interface is
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
        PARAM_VALID     : in  std_logic;
        PARAM_CODE      : in  MsgPack_RPC.Code_Type;
        PARAM_LAST      : in  std_logic;
        PARAM_SHIFT     : out MsgPack_RPC.Shift_Type;
        PROC_RES_ID     : out MsgPack_RPC.MsgID_Type;
        PROC_RES_CODE   : out MsgPack_RPC.Code_Type;
        PROC_RES_VALID  : out std_logic;
        PROC_RES_LAST   : out std_logic;
        PROC_RES_READY  : in  std_logic;
        fib_n           : out std_logic_vector(31 downto 0);
        fib_o           : in  std_logic_vector(31 downto 0);
        fib_req         : out std_logic;
        fib_fin         : in  std_logic
    );
end  Fib_Interface;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Method_Main_with_Param;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Method_Return_Integer;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Method_Set_Param_Integer;
architecture RTL of Fib_Interface is
    constant  PARAM_NUM         :  integer := 1;
    signal    set_param_code    :  MsgPack_RPC.Code_Type;
    signal    set_param_last    :  std_logic;
    signal    set_param_valid   :  std_logic_vector        (PARAM_NUM-1 downto 0);
    signal    set_param_error   :  std_logic_vector        (PARAM_NUM-1 downto 0);
    signal    set_param_done    :  std_logic_vector        (PARAM_NUM-1 downto 0);
    signal    set_param_shift   :  MsgPack_RPC.Shift_Vector(PARAM_NUM-1 downto 0);
    signal    return_id         :  MsgPack_RPC.MsgID_Type;
    signal    return_error      :  std_logic;
    signal    return_start      :  std_logic;
    signal    return_done       :  std_logic;
    signal    return_busy       :  std_logic;
    signal    proc_start        :  std_logic;
    signal    fib_n_default     :  std_logic_vector(fib_n'range) := (others => '0');
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    CORE: MsgPack_RPC_Method_Main_with_Param         -- 
        generic map (                                -- 
            NAME            => NAME                , --
            PARAM_NUM       => PARAM_NUM           , --
            MATCH_PHASE     => MATCH_PHASE           --
        )                                            -- 
        port map (                                   -- 
            CLK             => CLK                 , -- In  :
            RST             => RST                 , -- In  :
            CLR             => CLR                 , -- In  :
            MATCH_REQ       => MATCH_REQ           , -- In  :
            MATCH_CODE      => MATCH_CODE          , -- In  :
            MATCH_OK        => MATCH_OK            , -- Out :
            MATCH_NOT       => MATCH_NOT           , -- Out :
            MATCH_SHIFT     => MATCH_SHIFT         , -- Out :
            PROC_REQ_ID     => PROC_REQ_ID         , -- In  :
            PROC_REQ        => PROC_REQ            , -- In  :
            PROC_BUSY       => PROC_BUSY           , -- Out :
            PROC_START      => proc_start          , -- Out :
            PARAM_CODE      => PARAM_CODE          , -- In  :
            PARAM_VALID     => PARAM_VALID         , -- In  :
            PARAM_LAST      => PARAM_LAST          , -- In  :
            PARAM_SHIFT     => PARAM_SHIFT         , -- Out :
            SET_PARAM_CODE  => set_param_code      , -- Out :
            SET_PARAM_LAST  => set_param_last      , -- Out :
            SET_PARAM_VALID => set_param_valid     , -- Out :
            SET_PARAM_ERROR => set_param_error     , -- In  :
            SET_PARAM_DONE  => set_param_done      , -- In  :
            SET_PARAM_SHIFT => set_param_shift     , -- In  :
            RUN_REQ_VAL     => fib_req             , -- Out :
            RUN_REQ_RDY     => '1'                 , -- In  :
            RUN_RES_VAL     => fib_fin             , -- In  :
            RUN_RES_RDY     => open                , -- Out :
            RUNNING         => open                , -- Out :
            RET_ID          => PROC_RES_ID         , -- Out :
            RET_ERROR       => return_error        , -- Out :
            RET_START       => return_start        , -- Out :
            RET_DONE        => return_done         , -- Out :
            RET_BUSY        => return_busy           -- In  :
        );                                           --
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    ARG0: MsgPack_RPC_Method_Set_Param_Integer       -- 
        generic map (                                -- 
            VALUE_BITS      => fib_n'length        , --
            VALUE_SIGN      => TRUE                , --
            CHECK_RANGE     => TRUE                , --
            ENABLE64        => TRUE                  --
        )
        port map (
            CLK             => CLK                 , -- : In  :
            RST             => RST                 , -- : In  :
            CLR             => CLR                 , -- : In  :
            SET_PARAM_CODE  => set_param_code      , -- : In  :
            SET_PARAM_LAST  => set_param_last      , -- : In  :
            SET_PARAM_VALID => set_param_valid(0)  , -- : In  :
            SET_PARAM_ERROR => set_param_error(0)  , -- : Out :
            SET_PARAM_DONE  => set_param_done (0)  , -- : Out :
            SET_PARAM_SHIFT => set_param_shift(0)  , -- : Out :
            DEFAULT_WE      => proc_start          , -- : In  :
            DEFAULT_VALUE   => fib_n_default       , -- : In  :
            PARAM_VALUE     => fib_n               , -- : Out :
            PARAM_WE        => open                  -- : Out :
        );                                           --
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    RET : MsgPack_RPC_Method_Return_Integer          -- 
        generic map (                                -- 
            VALUE_WIDTH     => fib_o'length        , --
            RETURN_UINT     => TRUE                , --
            RETURN_INT      => FALSE               , --
            RETURN_FLOAT    => FALSE               , --
            RETURN_BOOLEAN  => FALSE                 --
        )                                            -- 
        port map (                                   -- 
            CLK             => CLK                 , -- In  :
            RST             => RST                 , -- In  :
            CLR             => CLR                 , -- In  :
            RET_ERROR       => return_error        , -- In  :
            RET_START       => return_start        , -- In  :
            RET_DONE        => return_done         , -- In  :
            RET_BUSY        => return_busy         , -- Out :
            RES_CODE        => PROC_RES_CODE       , -- Out :
            RES_VALID       => PROC_RES_VALID      , -- Out :
            RES_LAST        => PROC_RES_LAST       , -- Out :
            RES_READY       => PROC_RES_READY      , -- In  :
            VALUE           => fib_o                 -- In  :
        );                                           -- 
end RTL;
