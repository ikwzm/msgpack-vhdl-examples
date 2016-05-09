-----------------------------------------------------------------------------------
--!     @file    set_interface.vhd
--!     @brief   Set Interface Module
--!     @version 0.1.0
--!     @date    2015/10/27
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
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_RPC;
entity  Set_Interface is
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
        reg_in          : out signed(32-1 downto 0);
        reg_we          : out std_logic
    );
end  Set_Interface;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Server_KVMap_Set_Value;
use     MsgPack.MsgPack_KVMap_Components.MsgPack_KVMap_Set_Integer;
architecture RTL of Set_Interface is
    constant  STORE_SIZE        :  integer := 1;
    signal    map_match_req     :  std_logic_vector       (MATCH_PHASE-1 downto 0);
    signal    map_match_code    :  MsgPack_RPC.Code_Type;
    signal    map_match_ok      :  std_logic_vector        (STORE_SIZE-1 downto 0);
    signal    map_match_not     :  std_logic_vector        (STORE_SIZE-1 downto 0);
    signal    map_match_shift   :  MsgPack_RPC.Shift_Vector(STORE_SIZE-1 downto 0);
    signal    map_value_code    :  MsgPack_RPC.Code_Type;
    signal    map_value_valid   :  std_logic_vector        (STORE_SIZE-1 downto 0);
    signal    map_value_last    :  std_logic;
    signal    map_value_error   :  std_logic_vector        (STORE_SIZE-1 downto 0);
    signal    map_value_done    :  std_logic_vector        (STORE_SIZE-1 downto 0);
    signal    map_value_shift   :  MsgPack_RPC.Shift_Vector(STORE_SIZE-1 downto 0);
    signal    reg_value         :  std_logic_vector(reg_in'length-1 downto 0);
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    MAIN: MsgPack_RPC_Server_KVMap_Set_Value         -- 
        generic map (                                -- 
            NAME            => NAME                , -- 
            STORE_SIZE      => STORE_SIZE          , -- 
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
            PARAM_CODE      => PARAM_CODE          , -- In  :
            PARAM_VALID     => PARAM_VALID         , -- In  :
            PARAM_LAST      => PARAM_LAST          , -- In  :
            PARAM_SHIFT     => PARAM_SHIFT         , -- Out :
            MAP_MATCH_REQ   => map_match_req       , -- Out :
            MAP_MATCH_CODE  => map_match_code      , -- Out :
            MAP_MATCH_OK    => map_match_ok        , -- In  :
            MAP_MATCH_NOT   => map_match_not       , -- In  :
            MAP_MATCH_SHIFT => map_match_shift     , -- In  :
            MAP_VALUE_VALID => map_value_valid     , -- Out :
            MAP_VALUE_CODE  => map_value_code      , -- Out :
            MAP_VALUE_LAST  => map_value_last      , -- Out :
            MAP_VALUE_ERROR => map_value_error     , -- In  :
            MAP_VALUE_DONE  => map_value_done      , -- In  :
            MAP_VALUE_SHIFT => map_value_shift     , -- In  :
            RES_ID          => PROC_RES_ID         , -- Out :
            RES_CODE        => PROC_RES_CODE       , -- Out :
            RES_VALID       => PROC_RES_VALID      , -- Out :
            RES_LAST        => PROC_RES_LAST       , -- Out :
            RES_READY       => PROC_RES_READY        -- In  :
        );                                           -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    REG:  MsgPack_KVMap_Set_Integer                  -- 
        generic map (                                -- 
            KEY             => STRING'("reg")      , --
            CODE_WIDTH      => MsgPack_RPC.Code_Length  , --
            MATCH_PHASE     => MATCH_PHASE         , --
            VALUE_BITS      => reg_value'length    , --
            VALUE_SIGN      => TRUE                , --
            CHECK_RANGE     => TRUE                , --
            ENABLE64        => TRUE                  --
        )                                            -- 
        port map (                                   -- 
            CLK             => CLK                 , -- In  :
            RST             => RST                 , -- in  :
            CLR             => CLR                 , -- In  :
            I_CODE          => map_value_code      , -- In  :
            I_LAST          => map_value_last      , -- In  :
            I_VALID         => map_value_valid(0)  , -- In  :
            I_ERROR         => map_value_error(0)  , -- Out :
            I_DONE          => map_value_done (0)  , -- Out :
            I_SHIFT         => map_value_shift(0)  , -- Out :
            MATCH_REQ       => map_match_req       , -- In  :
            MATCH_CODE      => map_match_code      , -- In  :
            MATCH_OK        => map_match_ok   (0)  , -- Out :
            MATCH_NOT       => map_match_not  (0)  , -- Out :
            MATCH_SHIFT     => map_match_shift(0)  , -- Out :
            VALUE           => reg_value           , -- Out :
            SIGN            => open                , -- Out :
            LAST            => open                , -- Out :
            VALID           => reg_we              , -- Out :
            READY           => '1'                   -- Out :
        );                                           --
    reg_in <= signed(reg_value);
end RTL;
