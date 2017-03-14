-----------------------------------------------------------------------------------
--!     @file    msgpack_object.vhd
--!     @brief   MessagePack Object Code Package :
--!     @version 0.2.0
--!     @date    2016/6/26
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2015-2016 Ichiro Kawazome
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
package MsgPack_Object is

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    subtype   CLASS_TYPE        is std_logic_vector(3 downto 0);
    constant  CLASS_NONE        :  CLASS_TYPE := "0000";
    constant  CLASS_BOOLEAN     :  CLASS_TYPE := "0001";
    constant  CLASS_ARRAY       :  CLASS_TYPE := "0010";
    constant  CLASS_MAP         :  CLASS_TYPE := "0011";
    constant  CLASS_UINT        :  CLASS_TYPE := "0100";
    constant  CLASS_INT         :  CLASS_TYPE := "0101";
    constant  CLASS_FLOAT       :  CLASS_TYPE := "0110";
    constant  CLASS_NIL         :  CLASS_TYPE := "0111";
    constant  CLASS_STRING_SIZE :  CLASS_TYPE := "1000";
    constant  CLASS_STRING_DATA :  CLASS_TYPE := "1001";
    constant  CLASS_BINARY_SIZE :  CLASS_TYPE := "1010";
    constant  CLASS_BINARY_DATA :  CLASS_TYPE := "1011";
    constant  CLASS_EXT_SIZE    :  CLASS_TYPE := "1100";
    constant  CLASS_EXT_DATA    :  CLASS_TYPE := "1101";
    constant  CLASS_EXT_TYPE    :  CLASS_TYPE := "1110";
    constant  CLASS_RESERVE     :  CLASS_TYPE := "1111";

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  CODE_DATA_BITS    :  integer := 32;
    constant  CODE_DATA_BYTES   :  integer := CODE_DATA_BITS/8;
    constant  CODE_STRB_BITS    :  integer := CODE_DATA_BITS/8;
    constant  CODE_DATA_NULL    :  std_logic_vector(CODE_DATA_BITS-1 downto 0)
                                := (others => '0');
    constant  CODE_STRB_NULL    :  std_logic_vector(CODE_STRB_BITS-1 downto 0)
                                := (others => '0');
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type      Code_Type         is record
                  data          :  std_logic_vector(CODE_DATA_BITS-1 downto 0);
                  strb          :  std_logic_vector(CODE_STRB_BITS-1 downto 0);
                  class         :  CLASS_TYPE;
                  complete      :  std_logic;
                  valid         :  std_logic;
    end record;
    type      Code_Vector       is array (integer range <>) of Code_Type;
    constant  CODE_NULL         :  Code_Type := (
                  data          => CODE_DATA_NULL,
                  strb          => CODE_STRB_NULL,
                  class         => CLASS_NONE    ,
                  complete      => '0'           ,
                  valid         => '0'
              );
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code(
                  CLASS         :  CLASS_TYPE;
                  DATA          :  std_logic_vector;
                  STRB          :  std_logic_vector;
                  COMPLETE      :  std_logic
              )   return           Code_Type;
    function  New_Code(
                  CLASS         :  CLASS_TYPE;
                  DATA          :  std_logic_vector;
                  COMPLETE      :  std_logic
              )   return           Code_Type;
    function  New_Code(
                  CLASS         :  CLASS_TYPE;
                  DATA          :  std_logic_vector
              )   return           Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Unsigned  (DATA:integer         ;COMPLETE:std_logic:='1') return Code_Type;
    function  New_Code_Unsigned  (DATA:unsigned        ;COMPLETE:std_logic:='1') return Code_Type;
    function  New_Code_Unsigned  (DATA:std_logic_vector;COMPLETE:std_logic:='1') return Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Signed    (DATA:integer         ;COMPLETE:std_logic:='1') return Code_Type;
    function  New_Code_Signed    (DATA:unsigned        ;COMPLETE:std_logic:='1') return Code_Type;
    function  New_Code_Signed    (DATA:signed          ;COMPLETE:std_logic:='1') return Code_Type;
    function  New_Code_Signed    (DATA:std_logic_vector;COMPLETE:std_logic:='1') return Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Float     (DATA:std_logic_vector;COMPLETE:std_logic:='1') return Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_ArraySize (SIZE:integer                                 ) return Code_Type;
    function  New_Code_ArraySize (SIZE:unsigned                                ) return Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_MapSize   (SIZE:integer                                 ) return Code_Type;
    function  New_Code_MapSize   (SIZE:unsigned                                ) return Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_StringSize(SIZE:integer                                 ) return Code_Type;
    function  New_Code_StringSize(SIZE:integer         ;COMPLETE:std_logic     ) return Code_Type;
    function  New_Code_StringSize(SIZE:unsigned                                ) return Code_Type;
    function  New_Code_StringSize(SIZE:unsigned        ;COMPLETE:std_logic     ) return Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_StringData(DATA:std_logic_vector;COMPLETE:std_logic     ) return Code_Type;
    function  New_Code_StringData(DATA:STRING          ;COMPLETE:std_logic     ) return Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_BinarySize(SIZE:integer                                 ) return Code_Type;
    function  New_Code_BinarySize(SIZE:integer         ;COMPLETE:std_logic     ) return Code_Type;
    function  New_Code_BinarySize(SIZE:unsigned                                ) return Code_Type;
    function  New_Code_BinarySize(SIZE:unsigned        ;COMPLETE:std_logic     ) return Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_ExtSize   (SIZE:integer                                 ) return Code_Type;
    function  New_Code_ExtSize   (SIZE:unsigned                                ) return Code_Type;
    function  New_Code_ExtType   (DATA:std_logic_vector;COMPLETE:std_logic     ) return Code_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  New_Code_Nil      :  Code_Type := New_Code(CLASS_NIL    , std_logic_vector'("00000000"));
    constant  New_Code_True     :  Code_Type := New_Code(CLASS_BOOLEAN, std_logic_vector'("00000001"));
    constant  New_Code_False    :  Code_Type := New_Code(CLASS_BOOLEAN, std_logic_vector'("00000000"));
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Reserve   (DATA:integer         ) return Code_Type;
    function  New_Code_Reserve   (DATA:unsigned        ) return Code_Type;
    function  New_Code_Reserve   (DATA:std_logic_vector) return Code_Type;

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector(
                  LENGTH        :  integer;
                  CLASS         :  CLASS_TYPE;
                  DATA          :  std_logic_vector;
                  STRB          :  std_logic_vector;
                  COMPLETE      :  std_logic
              )   return           Code_Vector;
    function  New_Code_Vector(
                  LENGTH        :  integer;
                  CLASS         :  CLASS_TYPE;
                  DATA          :  std_logic_vector;
                  COMPLETE      :  std_logic
              )   return           Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Integer   (LENGTH:integer;DATA:unsigned                   ) return Code_Vector;
    function  New_Code_Vector_Integer   (LENGTH:integer;DATA:  signed                   ) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Unsigned  (LENGTH:integer;DATA:integer                    ) return Code_Vector;
    function  New_Code_Vector_Unsigned  (LENGTH:integer;DATA:unsigned                   ) return Code_Vector;
    function  New_Code_Vector_Unsigned  (LENGTH:integer;DATA:std_logic_vector           ) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Signed    (LENGTH:integer;DATA:integer                    ) return Code_Vector;
    function  New_Code_Vector_Signed    (LENGTH:integer;DATA:signed                     ) return Code_Vector;
    function  New_Code_Vector_Signed    (LENGTH:integer;DATA:std_logic_vector           ) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Float     (LENGTH:integer;DATA:std_logic_vector           ) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_ArraySize (LENGTH:integer;SIZE:integer                    ) return Code_Vector;
    function  New_Code_Vector_ArraySize (LENGTH:integer;SIZE:unsigned                   ) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_MapSize   (LENGTH:integer;SIZE:integer                    ) return Code_Vector;
    function  New_Code_Vector_MapSize   (LENGTH:integer;SIZE:unsigned                   ) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_StringSize(LENGTH:integer;SIZE:integer                    ) return Code_Vector;
    function  New_Code_Vector_StringSize(LENGTH:integer;SIZE:integer ;COMPLETE:std_logic) return Code_Vector;
    function  New_Code_Vector_StringSize(LENGTH:integer;SIZE:unsigned                   ) return Code_Vector;
    function  New_Code_Vector_StringSize(LENGTH:integer;SIZE:unsigned;COMPLETE:std_logic) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_StringData(LENGTH:integer;DATA:std_logic_vector;COMPLETE:std_logic:='1') return Code_Vector;
    function  New_Code_Vector_StringData(LENGTH:integer;DATA:STRING          ;COMPLETE:std_logic:='1') return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_String    (LENGTH:integer;DATA:std_logic_vector;COMPLETE:std_logic:='1') return Code_Vector;
    function  New_Code_Vector_String    (LENGTH:integer;DATA:STRING          ;COMPLETE:std_logic:='1') return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_BinarySize(LENGTH:integer;SIZE:integer                    ) return Code_Vector;
    function  New_Code_Vector_BinarySize(LENGTH:integer;SIZE:integer ;COMPLETE:std_logic) return Code_Vector;
    function  New_Code_Vector_BinarySize(LENGTH:integer;SIZE:unsigned                   ) return Code_Vector;
    function  New_Code_Vector_BinarySize(LENGTH:integer;SIZE:unsigned;COMPLETE:std_logic) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_ExtSize   (LENGTH:integer;SIZE:integer                            ) return Code_Vector;
    function  New_Code_Vector_ExtSize   (LENGTH:integer;SIZE:unsigned                           ) return Code_Vector;
    function  New_Code_Vector_ExtType   (LENGTH:integer;DATA:std_logic_vector                   ) return Code_Vector;
    function  New_Code_Vector_ExtType   (LENGTH:integer;DATA:std_logic_vector;COMPLETE:std_logic) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Nil       (LENGTH:integer) return Code_Vector;
    function  New_Code_Vector_True      (LENGTH:integer) return Code_Vector;
    function  New_Code_Vector_False     (LENGTH:integer) return Code_Vector;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Reserve   (LENGTH:integer                      ) return Code_Vector;
    function  New_Code_Vector_Reserve   (LENGTH:integer;DATA:integer         ) return Code_Vector;
    function  New_Code_Vector_Reserve   (LENGTH:integer;DATA:unsigned        ) return Code_Vector;
    function  New_Code_Vector_Reserve   (LENGTH:integer;DATA:std_logic_vector) return Code_Vector;

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type      Match_State_Type  is  (MATCH_IDLE_STATE               ,
                                     MATCH_BUSY_STATE               ,
                                     MATCH_DONE_FOUND_LAST_STATE    ,
                                     MATCH_DONE_FOUND_CONT_STATE    ,
                                     MATCH_BUSY_NOT_FOUND_STATE     ,
                                     MATCH_DONE_NOT_FOUND_LAST_STATE,
                                     MATCH_DONE_NOT_FOUND_CONT_STATE
                                    );
end MsgPack_Object;

library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
package body MsgPack_Object is
    -------------------------------------------------------------------------------
    -- resize
    -------------------------------------------------------------------------------
    function  resize(VEC: std_logic_vector; LEN: integer) return std_logic_vector is
        variable r_vec :  std_logic_vector(       LEN-1 downto 0);
        alias    i_vec :  std_logic_vector(VEC'length-1 downto 0) is VEC;
    begin
        for i in r_vec'range loop
            if (i <= i_vec'high) then
                r_vec(i) := i_vec(i);
            else
                r_vec(i) := '0';
            end if;
        end loop;
        return r_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code
    -------------------------------------------------------------------------------
    function  New_Code(
                  CLASS     :  CLASS_TYPE;
                  DATA      :  std_logic_vector;
                  STRB      :  std_logic_vector;
                  COMPLETE  :  std_logic
              ) return         Code_Type is
        alias     i_data    :  std_logic_vector(DATA'length-1 downto 0) is DATA;
        variable  code      :  Code_Type;
    begin
        code.class := CLASS;
        code.data  := resize(DATA, CODE_DATA_BITS);
        code.strb  := resize(STRB, CODE_STRB_BITS);
        if (code.strb /= CODE_STRB_NULL) then
            code.valid    := '1';
            code.complete := COMPLETE;
        else
            code.valid    := '0';
            code.complete := '0';
        end if;
        return code;
    end function;

    function  New_Code(
                  CLASS     :  CLASS_TYPE;
                  DATA      :  std_logic_vector;
                  COMPLETE  :  std_logic
              ) return         Code_Type is
        variable  i_strb    :  std_logic_vector(CODE_STRB_BITS-1 downto 0);
        alias     i_data    :  std_logic_vector(DATA'length   -1 downto 0) is DATA;
    begin
        for i in i_strb'range loop
            if (i < (i_data'length+7)/8) then
                i_strb(i) := '1';
            else
                i_strb(i) := '0';
            end if;
        end loop;
        return New_Code(CLASS, i_data, i_strb, COMPLETE);
    end function;

    function  New_Code(
                  CLASS     :  CLASS_TYPE;
                  DATA      :  std_logic_vector
              ) return         Code_Type is
    begin
        return New_Code(CLASS, DATA, std_logic'('1'));
    end function;

    -------------------------------------------------------------------------------
    -- New_Code_Unsigned
    -------------------------------------------------------------------------------
    function  New_Code_Unsigned  (DATA:std_logic_vector;COMPLETE:std_logic := '1') return Code_Type is
    begin
        return New_Code(CLASS_UINT, DATA, COMPLETE);
    end function;

    function  New_Code_Unsigned  (DATA:unsigned        ;COMPLETE:std_logic := '1') return Code_Type is
    begin
        return New_Code(CLASS_UINT, std_logic_vector(DATA), COMPLETE);
    end function;

    function  New_Code_Unsigned  (DATA:integer         ;COMPLETE:std_logic := '1') return Code_Type is
    begin
        return New_Code(CLASS_UINT, std_logic_vector(to_unsigned(DATA, CODE_DATA_BITS)), COMPLETE);
    end function;

    -------------------------------------------------------------------------------
    -- New_Code_Signed
    -------------------------------------------------------------------------------
    function  New_Code_Signed    (DATA:std_logic_vector;COMPLETE:std_logic := '1') return Code_Type is
    begin
        return New_Code(CLASS_INT, DATA, COMPLETE);
    end function;

    function  New_Code_Signed    (DATA:signed          ;COMPLETE:std_logic := '1') return Code_Type is
        variable  i_strb    :  std_logic_vector(CODE_STRB_BITS-1 downto 0);
    begin
        for i in i_strb'range loop
            if (i < (DATA'length+7)/8) then
                i_strb(i) := '1';
            else
                i_strb(i) := '0';
            end if;
        end loop;
        return New_Code(CLASS_INT, std_logic_vector(resize(DATA, CODE_DATA_BITS)), i_strb, COMPLETE);
    end function;

    function  New_Code_Signed    (DATA:unsigned        ;COMPLETE:std_logic := '1') return Code_Type is
        variable  i_strb    :  std_logic_vector(CODE_STRB_BITS-1 downto 0);
    begin
        for i in i_strb'range loop
            if (i < (DATA'length+7)/8) then
                i_strb(i) := '1';
            else
                i_strb(i) := '0';
            end if;
        end loop;
        return New_Code(CLASS_INT, std_logic_vector(resize(DATA, CODE_DATA_BITS)), i_strb, COMPLETE);
    end function;

    function  New_Code_Signed    (DATA:integer         ;COMPLETE:std_logic := '1') return Code_Type is
    begin
        return New_Code(CLASS_INT, std_logic_vector(to_signed(DATA, CODE_DATA_BITS)), COMPLETE);
    end function;
    
    -------------------------------------------------------------------------------
    -- New_Code_Float
    -------------------------------------------------------------------------------
    function  New_Code_Float     (DATA:std_logic_vector;COMPLETE:std_logic := '1') return Code_Type is
    begin
        return New_Code(CLASS_FLOAT, DATA, COMPLETE);
    end function;

    -------------------------------------------------------------------------------
    -- New_Code_ArraySize
    -------------------------------------------------------------------------------
    function  New_Code_ArraySize (SIZE:unsigned) return Code_Type is
    begin
        return New_Code(CLASS_ARRAY, std_logic_vector(SIZE), '1');
    end function;
    
    function  New_Code_ArraySize (SIZE:integer ) return Code_Type is
    begin
        return New_Code(CLASS_ARRAY, std_logic_vector(to_unsigned(SIZE, CODE_DATA_BITS)), '1');
    end function;
        
    -------------------------------------------------------------------------------
    -- New_Code_MapSize
    -------------------------------------------------------------------------------
    function  New_Code_MapSize   (SIZE:unsigned) return Code_Type is
    begin
        return New_Code(CLASS_MAP, std_logic_vector(SIZE), '1');
    end function;
    
    function  New_Code_MapSize   (SIZE:integer ) return Code_Type is
    begin
        return New_Code(CLASS_MAP, std_logic_vector(to_unsigned(SIZE, CODE_DATA_BITS)), '1');
    end function;
        
    -------------------------------------------------------------------------------
    -- New_Code_StringSize
    -------------------------------------------------------------------------------
    function  New_Code_StringSize(SIZE:unsigned;COMPLETE:std_logic) return Code_Type is
    begin
        return New_Code(CLASS_STRING_SIZE, std_logic_vector(SIZE), COMPLETE);
    end function;
    
    function  New_Code_StringSize(SIZE:unsigned               ) return Code_Type is
    begin
        if (SIZE = 0) then
            return New_Code_StringSize(SIZE, '1');
        else
            return New_Code_StringSize(SIZE, '0');
        end if;
    end function;
    
    function  New_Code_StringSize(SIZE:integer; COMPLETE:std_logic) return Code_Type is
    begin
        return New_Code_StringSize(to_unsigned(SIZE, CODE_DATA_BITS), COMPLETE);
    end function;
        
    function  New_Code_StringSize(SIZE:integer                ) return Code_Type is
    begin
        if (SIZE = 0) then
            return New_Code_StringSize(SIZE, '1');
        else
            return New_Code_StringSize(SIZE, '0');
        end if;
    end function;
        
    -------------------------------------------------------------------------------
    -- New_Code_StringData
    -------------------------------------------------------------------------------
    function  New_Code_StringData(DATA:std_logic_vector;COMPLETE:std_logic       ) return Code_Type is
    begin
        return New_Code(CLASS_STRING_DATA, DATA, COMPLETE);
    end function;        
    function  New_Code_StringData(DATA:STRING          ;COMPLETE:std_logic       ) return Code_Type is
        alias     i_str   :  STRING(1 to DATA'length) is DATA;
        variable  i_data  :  std_logic_vector(8*DATA'length-1 downto 0);
    begin
        for i in i_str'range loop
            i_data(8*(i)-1 downto 8*(i-1)) := std_logic_vector(to_unsigned(CHARACTER'pos(i_str(i)),8));
        end loop;
        return New_Code_StringData(i_data, complete);
    end function;

    -------------------------------------------------------------------------------
    -- New_Code_BinarySize
    -------------------------------------------------------------------------------
    function  New_Code_BinarySize(SIZE:unsigned;COMPLETE:std_logic) return Code_Type is
    begin
        return New_Code(CLASS_BINARY_SIZE, std_logic_vector(SIZE), COMPLETE);
    end function;
    
    function  New_Code_BinarySize(SIZE:unsigned               ) return Code_Type is
    begin
        if (SIZE = 0) then
            return New_Code_BinarySize(SIZE, '1');
        else
            return New_Code_BinarySize(SIZE, '0');
        end if;
    end function;
    
    function  New_Code_BinarySize(SIZE:integer ;COMPLETE:std_logic) return Code_Type is
    begin
        return New_Code_BinarySize(to_unsigned(SIZE, CODE_DATA_BITS), COMPLETE);
    end function;

    function  New_Code_BinarySize(SIZE:integer         ) return Code_Type is
    begin
        if (SIZE = 0) then
            return New_Code_BinarySize(SIZE, '1');
        else
            return New_Code_BinarySize(SIZE, '0');
        end if;
    end function;

    -------------------------------------------------------------------------------
    -- New_Code_ExtSize
    -------------------------------------------------------------------------------
    function  New_Code_ExtSize   (SIZE:unsigned        ) return Code_Type is
    begin
        return New_Code(CLASS_EXT_SIZE, std_logic_vector(SIZE), '0');
    end function;
    
    function  New_Code_ExtSize   (SIZE:integer         ) return Code_Type is
    begin
        return New_Code(CLASS_EXT_SIZE, std_logic_vector(to_unsigned(SIZE, CODE_DATA_BITS)), '0');
    end function;
    
    -------------------------------------------------------------------------------
    -- New_Code_ExtType
    -------------------------------------------------------------------------------
    function  New_Code_ExtType  (DATA:std_logic_vector;COMPLETE:std_logic) return Code_Type is
    begin
        return New_Code(CLASS_EXT_TYPE, resize(DATA, 8), COMPLETE);
    end function;

    -------------------------------------------------------------------------------
    -- New_Code_Reserve
    -------------------------------------------------------------------------------
    function  New_Code_Reserve   (DATA:std_logic_vector) return Code_Type is begin
        return New_Code(CLASS_RESERVE, DATA);
    end function;
    function  New_Code_Reserve   (DATA:unsigned        ) return Code_Type is begin
        return New_Code_Reserve(std_logic_vector(DATA));
    end function;
    function  New_Code_Reserve   (DATA:integer         ) return Code_Type is begin
        return New_Code_Reserve(to_unsigned(DATA, CODE_DATA_BITS));
    end function;

    -------------------------------------------------------------------------------
    -- New_Code_Vector
    -------------------------------------------------------------------------------
    function  New_Code_Vector(
                  LENGTH    :  integer;
                  CLASS     :  CLASS_TYPE;
                  DATA      :  std_logic_vector;
                  STRB      :  std_logic_vector;
                  COMPLETE  :  std_logic
              ) return         Code_Vector is
        variable  code_vec  :  Code_Vector     (               LENGTH-1 downto 0);
        variable  i_data    :  std_logic_vector(CODE_DATA_BITS*LENGTH-1 downto 0);
        variable  i_strb    :  std_logic_vector(CODE_STRB_BITS*LENGTH-1 downto 0);
        variable  t_data    :  std_logic_vector(CODE_DATA_BITS       -1 downto 0);
        variable  t_strb    :  std_logic_vector(CODE_STRB_BITS       -1 downto 0);
        variable  t_complete:  boolean;
        variable  t_valid   :  boolean;
    begin
        i_data     := resize(DATA, CODE_DATA_BITS*LENGTH);
        i_strb     := resize(STRB, CODE_STRB_BITS*LENGTH);
        t_complete := (COMPLETE = '1');

        for i in LENGTH-1 downto 0 loop
            t_data  := i_data(CODE_DATA_BITS*(i+1)-1 downto CODE_DATA_BITS*i);
            t_strb  := i_strb(CODE_STRB_BITS*(i+1)-1 downto CODE_STRB_BITS*i);
            t_valid := (t_strb /= CODE_STRB_NULL);
            
            for n in 0 to CODE_STRB_BITS-1 loop
                if (t_strb(n) = '1') then
                    code_vec(i).data(8*(n+1)-1 downto 8*n) := t_data(8*(n+1)-1 downto 8*n);
                else
                    code_vec(i).data(8*(n+1)-1 downto 8*n) := (8*(n+1)-1 downto 8*n => '0');
                end if;
            end loop;

            code_vec(i).strb := t_strb;
            
            if (t_valid) then
                code_vec(i).valid := '1';
                code_vec(i).class := CLASS;
            else
                code_vec(i).valid := '0';
                code_vec(i).class := CLASS_NONE;
            end if;

            if (t_complete = TRUE and t_valid = TRUE) then
                code_vec(i).complete  := '1';
                t_complete            := FALSE;
            else
                code_vec(i).complete  := '0';
            end if;

        end loop;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector
    -------------------------------------------------------------------------------
    function  New_Code_Vector(
                  LENGTH    :  integer;
                  CLASS     :  CLASS_TYPE;
                  DATA      :  std_logic_vector;
                  COMPLETE  :  std_logic
              ) return         Code_Vector is
        variable  i_strb    :  std_logic_vector((DATA'length+7)/8-1 downto 0);
    begin
        for i in i_strb'range loop
            if (i < (DATA'length+7)/8) then
                i_strb(i) := '1';
            else
                i_strb(i) := '0';
            end if;
        end loop;
        return New_Code_Vector(LENGTH, CLASS, DATA, i_strb, COMPLETE);
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_Unsigned
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Unsigned  (LENGTH:integer;DATA:integer) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_Unsigned(DATA,'1');
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_Unsigned  (LENGTH:integer;DATA:unsigned) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
        alias    i_data   :  unsigned(DATA'length-1 downto 0) is DATA;
    begin
        if (i_data'high > 32) then
            if (LENGTH >= 2) then
                code_vec(0) := New_Code_Unsigned(i_data(i_data'high downto 32), '0');
                code_vec(1) := New_Code_Unsigned(i_data(         31 downto  0), '1');
            else
                assert FALSE report "New_Code_Vector_Unsigned argument bit width is to large." severity FAILURE;
            end if;
            if (LENGTH >  2) then
                code_vec(LENGTH-1 downto 2) := (LENGTH-1 downto 2 => CODE_NULL);
            end if;
        else
            if (LENGTH >= 1) then
                code_vec(0) := New_Code_Unsigned(i_data, '1');
            end if;
            if (LENGTH >  1) then
                code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
            end if;
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_Unsigned  (LENGTH:integer;DATA:std_logic_vector) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
        alias    i_data   :  std_logic_vector(DATA'length-1 downto 0) is DATA;
    begin
        if (i_data'high > 32) then
            if (LENGTH >= 2) then
                code_vec(0) := New_Code_Unsigned(i_data(i_data'high downto 32), '0');
                code_vec(1) := New_Code_Unsigned(i_data(         31 downto  0), '1');
            else
                assert FALSE report "New_Code_Vector_Unsigned argument bit width is to large." severity FAILURE;
            end if;
            if (LENGTH >  2) then
                code_vec(LENGTH-1 downto 2) := (LENGTH-1 downto 2 => CODE_NULL);
            end if;
        else
            if (LENGTH >= 1) then
                code_vec(0) := New_Code_Unsigned(i_data, '1');
            end if;
            if (LENGTH >  1) then
                code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
            end if;
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_Signed
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Signed    (LENGTH:integer;DATA:integer) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_Signed(DATA,'1');
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_Signed    (LENGTH:integer;DATA:signed) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
        alias    i_data   :  signed(DATA'length-1 downto 0) is DATA;
        variable d_data   :  signed(63 downto 0);
    begin
        if (i_data'high > 32) then
            if (LENGTH >= 2) then
                d_data := resize(i_data, 64);
                code_vec(0) := New_Code_Signed(d_data(63 downto 32), '0');
                code_vec(1) := New_Code_Signed(d_data(31 downto  0), '1');
            else
                assert FALSE report "New_Code_Vector_Signed argument bit width is to large." severity FAILURE;
            end if;
            if (LENGTH >  2) then
                code_vec(LENGTH-1 downto 2) := (LENGTH-1 downto 2 => CODE_NULL);
            end if;
        else
            if (LENGTH >= 1) then
                code_vec(0) := New_Code_Signed(i_data, '1');
            end if;
            if (LENGTH >  1) then
                code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
            end if;
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_Signed    (LENGTH:integer;DATA:std_logic_vector) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
        alias    i_data   :  std_logic_vector(DATA'length-1 downto 0) is DATA;
        variable d_data   :  std_logic_vector(63 downto 0);
    begin
        if (i_data'high > 32) then
            if (LENGTH >= 2) then
                d_data := std_logic_vector(resize(signed(i_data), 64));
                code_vec(0) := New_Code_Signed(d_data(63 downto 32), '0');
                code_vec(1) := New_Code_Signed(d_data(31 downto  0), '1');
            else
                assert FALSE report "New_Code_Vector_Signed argument bit width is to large." severity FAILURE;
            end if;
            if (LENGTH >  2) then
                code_vec(LENGTH-1 downto 2) := (LENGTH-1 downto 2 => CODE_NULL);
            end if;
        else
            if (LENGTH >= 1) then
                code_vec(0) := New_Code_Signed(i_data, '1');
            end if;
            if (LENGTH >  1) then
                code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
            end if;
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_Integer
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Integer   (LENGTH:integer;DATA:signed                     ) return Code_Vector is
        variable use_long :  boolean;
        variable i_data   :  std_logic_vector(DATA'length-1 downto 0);
    begin
        i_data := std_logic_vector(DATA);
        if (i_data'length > CODE_DATA_BITS) then
            if (i_data(i_data'high) = '1') then
                use_long := FALSE;
                for pos in i_data'high downto CODE_DATA_BITS-1 loop
                    if (i_data(pos) /= '1') then
                        use_long := TRUE;
                    end if;
                end loop;
                if (use_long) then
                    return New_Code_Vector_Signed(  LENGTH, i_data);
                else
                    return New_Code_Vector_Signed(  LENGTH, i_data(CODE_DATA_BITS-1 downto 0));
                end if;
            else
                use_long := FALSE;
                for pos in i_data'high downto CODE_DATA_BITS loop
                    if (i_data(pos) /= '0') then
                        use_long := TRUE;
                    end if;
                end loop;
                if (use_long) then
                    return New_Code_Vector_Unsigned(LENGTH, i_data);
                else
                    return New_Code_Vector_Unsigned(LENGTH, i_data(CODE_DATA_BITS-1 downto 0));
                end if;
            end if;
        else
            if (i_data(i_data'high) = '1') then
                return New_Code_Vector_Signed  (LENGTH, i_data);
            else
                return New_Code_Vector_Unsigned(LENGTH, i_data);
            end if;
        end if;
    end function;
    function  New_Code_Vector_Integer   (LENGTH:integer;DATA:unsigned                   ) return Code_Vector is
        variable use_long :  boolean;
        alias    i_data   :  unsigned(DATA'length-1 downto 0) is DATA;
    begin
        if (i_data'length > CODE_DATA_BITS) then
            use_long := FALSE;
            for pos in i_data'high downto CODE_DATA_BITS loop
                if (i_data(pos) /= '0') then
                    use_long := TRUE;
                end if;
            end loop;
            if (use_long) then
                return New_Code_Vector_Unsigned(LENGTH, i_data);
            else
                return New_Code_Vector_Unsigned(LENGTH, i_data(CODE_DATA_BITS-1 downto 0));
            end if;
        else
                return New_Code_Vector_Unsigned(LENGTH, i_data);
        end if;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_Float
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Float     (LENGTH:integer;DATA:std_logic_vector) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
        alias    i_data   :  std_logic_vector(DATA'length-1 downto 0) is DATA;
    begin
        if (i_data'high > 32) then
            if (LENGTH >= 2) then
                code_vec(0) := New_Code_Float(i_data(63 downto 32), '0');
                code_vec(1) := New_Code_Float(i_data(31 downto  0), '1');
            else
                assert FALSE report "New_Code_Vector_Float argument bit width is to large." severity FAILURE;
            end if;
            if (LENGTH >  2) then
                code_vec(LENGTH-1 downto 2) := (LENGTH-1 downto 2 => CODE_NULL);
            end if;
        else
            if (LENGTH >= 1) then
                code_vec(0) := New_Code_Float(i_data, '1');
            end if;
            if (LENGTH >  1) then
                code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
            end if;
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_ArraySize
    -------------------------------------------------------------------------------
    function  New_Code_Vector_ArraySize (LENGTH:integer;SIZE:integer ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_ArraySize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_ArraySize (LENGTH:integer;SIZE:unsigned) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_ArraySize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_MapSize
    -------------------------------------------------------------------------------
    function  New_Code_Vector_MapSize   (LENGTH:integer;SIZE:integer ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_MapSize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_MapSize   (LENGTH:integer;SIZE:unsigned) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_MapSize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_StringSize
    -------------------------------------------------------------------------------
    function  New_Code_Vector_StringSize(LENGTH:integer;SIZE:integer                   ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_StringSize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_StringSize(LENGTH:integer;SIZE:integer;COMPLETE:std_logic) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_StringSize(SIZE,COMPLETE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_StringSize(LENGTH:integer;SIZE:unsigned                  ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_StringSize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_StringSize(LENGTH:integer;SIZE:unsigned;COMPLETE:std_logic) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_StringSize(SIZE,COMPLETE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_StringData
    -------------------------------------------------------------------------------
    function  New_Code_Vector_StringData(LENGTH:integer;DATA:std_logic_vector;COMPLETE:std_logic := '1') return Code_Vector is
    begin
        return New_Code_Vector(LENGTH, CLASS_STRING_DATA, DATA, COMPLETE);
    end function;
    function  New_Code_Vector_StringData(LENGTH:integer;DATA:STRING          ;COMPLETE:std_logic := '1') return Code_Vector is
        alias     i_str   :  STRING(1 to DATA'length) is DATA;
        variable  i_data  :  std_logic_vector(8*DATA'length-1 downto 0);
    begin
        for i in i_str'range loop
            i_data(8*(i)-1 downto 8*(i-1)) := std_logic_vector(to_unsigned(CHARACTER'pos(i_str(i)),8));
        end loop;
        return New_Code_Vector_StringData(LENGTH, i_data, COMPLETE);
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_String
    -------------------------------------------------------------------------------
    function  New_Code_Vector_String    (LENGTH:integer;DATA:std_logic_vector;COMPLETE:std_logic := '1') return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_StringSize((DATA'length+7)/8);
        code_vec(LENGTH-1 downto 1) := New_Code_Vector_StringData(LENGTH-1, DATA, COMPLETE);
        return code_vec;
    end function;
    function  New_Code_Vector_String    (LENGTH:integer;DATA:STRING          ;COMPLETE:std_logic := '1') return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_StringSize(DATA'length);
        code_vec(LENGTH-1 downto 1) := New_Code_Vector_StringData(LENGTH-1, DATA, COMPLETE);
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_BinarySize
    -------------------------------------------------------------------------------
    function  New_Code_Vector_BinarySize(LENGTH:integer;SIZE:integer                    ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_BinarySize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_BinarySize(LENGTH:integer;SIZE:integer ;COMPLETE:std_logic) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_BinarySize(SIZE,COMPLETE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_BinarySize(LENGTH:integer;SIZE:unsigned                   ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_BinarySize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_BinarySize(LENGTH:integer;SIZE:unsigned;COMPLETE:std_logic) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_BinarySize(SIZE,COMPLETE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_ExtSize
    -------------------------------------------------------------------------------
    function  New_Code_Vector_ExtSize   (LENGTH:integer;SIZE:integer                           ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_ExtSize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_ExtSize   (LENGTH:integer;SIZE:unsigned                           ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_ExtSize(SIZE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_ExtType   (LENGTH:integer;DATA:std_logic_vector                   ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_ExtType(DATA, '0');
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_ExtType   (LENGTH:integer;DATA:std_logic_vector;COMPLETE:std_logic) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_ExtType(DATA,COMPLETE);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_Nil
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Nil       (LENGTH:integer) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_Nil;
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_True
    -------------------------------------------------------------------------------
    function  New_Code_Vector_True      (LENGTH:integer) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_True;
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_False
    -------------------------------------------------------------------------------
    function  New_Code_Vector_False     (LENGTH:integer) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_False;
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    -- New_Code_Vector_Reserve
    -------------------------------------------------------------------------------
    function  New_Code_Vector_Reserve   (LENGTH:integer;DATA:std_logic_vector) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_Reserve(DATA);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_Reserve   (LENGTH:integer;DATA:unsigned        ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_Reserve(DATA);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_Reserve   (LENGTH:integer;DATA:integer         ) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_Reserve(DATA);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;
    function  New_Code_Vector_Reserve   (LENGTH:integer) return Code_Vector is
        variable code_vec :  Code_Vector(LENGTH-1 downto 0);
    begin
        code_vec(0) := New_Code_Reserve(0);
        if (LENGTH > 1) then
            code_vec(LENGTH-1 downto 1) := (LENGTH-1 downto 1 => CODE_NULL);
        end if;
        return code_vec;
    end function;

end MsgPack_Object;
-----------------------------------------------------------------------------------
--!     @file    pipework/pipework_components.vhd                                --
--!     @brief   MessagaPack Component Library Description                       --
--!     @version 0.2.0                                                           --
--!     @date    2016/05/20                                                      --
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>                     --
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--                                                                               --
--      Copyright (C) 2016 Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>           --
--      All rights reserved.                                                     --
--                                                                               --
--      Redistribution and use in source and binary forms, with or without       --
--      modification, are permitted provided that the following conditions       --
--      are met:                                                                 --
--                                                                               --
--        1. Redistributions of source code must retain the above copyright      --
--           notice, this list of conditions and the following disclaimer.       --
--                                                                               --
--        2. Redistributions in binary form must reproduce the above copyright   --
--           notice, this list of conditions and the following disclaimer in     --
--           the documentation and/or other materials provided with the          --
--           distribution.                                                       --
--                                                                               --
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    --
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    --
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT         --
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    --
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    --
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT      --
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    --
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     --
--                                                                               --
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
--! @brief MessagaPack Component Library Description                             --
-----------------------------------------------------------------------------------
package PipeWork_Components is
-----------------------------------------------------------------------------------
--! @brief REDUCER                                                               --
-----------------------------------------------------------------------------------
component REDUCER
    generic (
        WORD_BITS   : --! @brief WORD BITS :
                      --! １ワードのデータのビット数を指定する.
                      integer := 8;
        STRB_BITS   : --! @brief ENABLE BITS :
                      --! ワードデータのうち有効なデータであることを示す信号(STRB)
                      --! のビット数を指定する.
                      integer := 1;
        I_WIDTH     : --! @brief INPUT WORD WIDTH :
                      --! 入力側のデータのワード数を指定する.
                      integer := 1;
        O_WIDTH     : --! @brief OUTPUT WORD WIDTH :
                      --! 出力側のデータのワード数を指定する.
                      integer := 1;
        QUEUE_SIZE  : --! @brief QUEUE SIZE :
                      --! キューの大きさをワード数で指定する.
                      --! * QUEUE_SIZE=0を指定した場合は、キューの深さは自動的に
                      --!   O_WIDTH+I_WIDTH+I_WIDTH-1 に設定される.
                      --! * QUEUE_SIZE<O_WIDTH+I_WIDTH-1の場合は、キューの深さは
                      --!   自動的にO_WIDTH+I_WIDTH-1に設定される.
                      integer := 0;
        VALID_MIN   : --! @brief BUFFER VALID MINIMUM NUMBER :
                      --! VALID信号の配列の最小値を指定する.
                      integer := 0;
        VALID_MAX   : --! @brief BUFFER VALID MAXIMUM NUMBER :
                      --! VALID信号の配列の最大値を指定する.
                      integer := 0;
        O_VAL_SIZE  : --! @brief OUTPUT WORD VALID SIZE :
                      --! O_VAL 信号アサート時のキューに入っているワード数.
                      --! * キューに O_VAL_SIZE 以上のワード数が入っていると O_VAL 
                      --!   信号をアサートする.
                      --! * 互換性維持のため O_VAL_SIZE=0を指定した場合は、キューに
                      --!   O_WIDTH 以上のワード数が入っていると O_VAL 信号をアサー
                      --!   トする.
                      integer := 0;
        O_SHIFT_MIN : --! @brief OUTPUT SHIFT SIZE MINIMUM NUMBER :
                      --! O_SHIFT信号の配列の最小値を指定する.
                      integer := 1;
        O_SHIFT_MAX : --! @brief OUTPUT SHIFT SIZE MINIMUM NUMBER :
                      --! O_SHIFT信号の配列の最大値を指定する.
                      integer := 1;
        I_JUSTIFIED : --! @brief INPUT WORD JUSTIFIED :
                      --! 入力側の有効なデータが常にLOW側に詰められていることを
                      --! 示すフラグ.
                      --! * 常にLOW側に詰められている場合は、シフタが必要なくなる
                      --!   ため回路が簡単になる.
                      integer range 0 to 1 := 0;
        FLUSH_ENABLE: --! @brief FLUSH ENABLE :
                      --! FLUSH/I_FLUSHによるフラッシュ処理を有効にするかどうかを
                      --! 指定する.
                      --! * FLUSHとDONEとの違いは、DONEは最後のデータの出力時に
                      --!   キューの状態をすべてクリアするのに対して、
                      --!   FLUSHは最後のデータの出力時にSTRBだけをクリアしてVALは
                      --!   クリアしない.
                      --!   そのため次の入力データは、最後のデータの次のワード位置
                      --!   から格納される.
                      --! * フラッシュ処理を行わない場合は、0を指定すると回路が若干
                      --!   簡単になる.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 各種制御信号
    -------------------------------------------------------------------------------
        START       : --! @brief START :
                      --! 開始信号.
                      --! * この信号はOFFSETを内部に設定してキューを初期化する.
                      --! * 最初にデータ入力と同時にアサートしても構わない.
                      in  std_logic := '0';
        OFFSET      : --! @brief OFFSET :
                      --! 最初のワードの出力位置を指定する.
                      --! * START信号がアサートされた時のみ有効.
                      --! * O_WIDTH>I_WIDTHの場合、最初のワードデータを出力する際の
                      --!   オフセットを設定できる.
                      --! * 例えばWORD_BITS=8、I_WIDTH=1(1バイト入力)、O_WIDTH=4(4バイト出力)の場合、
                      --!   OFFSET="0000"に設定すると、最初に入力したバイトデータは
                      --!   1バイト目から出力される.    
                      --!   OFFSET="0001"に設定すると、最初に入力したバイトデータは
                      --!   2バイト目から出力される.    
                      --!   OFFSET="0011"に設定すると、最初に入力したバイトデータは
                      --!   3バイト目から出力される.    
                      --!   OFFSET="0111"に設定すると、最初に入力したバイトデータは
                      --!   4バイト目から出力される.    
                      in  std_logic_vector(O_WIDTH-1 downto 0) := (others => '0');
        DONE        : --! @brief DONE :
                      --! 終了信号.
                      --! * この信号をアサートすることで、キューに残っているデータ
                      --!   を掃き出す.
                      --!   その際、最後のワードと同時にO_DONE信号がアサートされる.
                      --! * FLUSH信号との違いは、FLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        FLUSH       : --! @brief FLUSH :
                      --! フラッシュ信号.
                      --! * この信号をアサートすることで、キューに残っているデータ
                      --!   を掃き出す.
                      --!   その際、最後のワードと同時にO_FLUSH信号がアサートされる.
                      --! * DONE信号との違いは、FLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        BUSY        : --! @brief BUSY :
                      --! ビジー信号.
                      --! * 最初にデータが入力されたときにアサートされる.
                      --! * 最後のデータが出力し終えたらネゲートされる.
                      out std_logic;
        VALID       : --! @brief QUEUE VALID FLAG :
                      --! キュー有効信号.
                      --! * 対応するインデックスのキューに有効なワードが入って
                      --!   いるかどうかを示すフラグ.
                      out std_logic_vector(VALID_MAX downto VALID_MIN);
    -------------------------------------------------------------------------------
    -- 入力側 I/F
    -------------------------------------------------------------------------------
        I_ENABLE    : --! @brief INPUT ENABLE :
                      --! 入力許可信号.
                      --! * この信号がアサートされている場合、キューの入力を許可する.
                      --! * この信号がネゲートされている場合、I_RDY アサートされない.
                      in  std_logic := '1';
        I_DATA      : --! @brief INPUT WORD DATA :
                      --! ワードデータ入力.
                      in  std_logic_vector(I_WIDTH*WORD_BITS-1 downto 0);
        I_STRB      : --! @brief INPUT WORD ENABLE :
                      --! ワードストローブ信号入力.
                      in  std_logic_vector(I_WIDTH*STRB_BITS-1 downto 0);
        I_DONE      : --! @brief INPUT WORD DONE :
                      --! 最終ワード信号入力.
                      --! * 最後の力ワードデータ入であることを示すフラグ.
                      --! * 基本的にはDONE信号と同じ働きをするが、I_DONE信号は
                      --!   最後のワードデータを入力する際に同時にアサートする.
                      --! * I_FLUSH信号との違いはFLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        I_FLUSH     : --! @brief INPUT WORD FLUSH :
                      --! 最終ワード信号入力.
                      --! * 最後のワードデータ入力であることを示すフラグ.
                      --! * 基本的にはFLUSH信号と同じ働きをするが、I_FLUSH信号は
                      --!   最後のワードデータを入力する際に同時にアサートする.
                      --! * I_DONE信号との違いはFLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        I_VAL       : --! @brief INPUT WORD VALID :
                      --! 入力ワード有効信号.
                      --! * I_DATA/I_STRB/I_DONE/I_FLUSHが有効であることを示す.
                      --! * I_VAL='1'and I_RDY='1'でワードデータがキューに取り込まれる.
                      in  std_logic;
        I_RDY       : --! @brief INPUT WORD READY :
                      --! 入力レディ信号.
                      --! * キューが次のワードデータを入力出来ることを示す.
                      --! * I_VAL='1'and I_RDY='1'でワードデータがキューに取り込まれる.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側 I/F
    -------------------------------------------------------------------------------
        O_ENABLE    : --! @brief OUTPUT ENABLE :
                      --! 出力許可信号.
                      --! * この信号がアサートされている場合、キューの出力を許可する.
                      --! * この信号がネゲートされている場合、O_VAL アサートされない.
                      in  std_logic := '1';
        O_DATA      : --! @brief OUTPUT WORD DATA :
                      --! ワードデータ出力.
                      out std_logic_vector(O_WIDTH*WORD_BITS-1 downto 0);
        O_STRB      : --! @brief OUTPUT WORD ENABLE :
                      --! ワードストローブ信号出力.
                      out std_logic_vector(O_WIDTH*STRB_BITS-1 downto 0);
        O_DONE      : --! @brief OUTPUT WORD DONE :
                      --! 最終ワード信号出力.
                      --! * 最後のワードデータ出力であることを示すフラグ.
                      --! * O_FLUSH信号との違いはFLUSH_ENABLEの項を参照.
                      out std_logic;
        O_FLUSH     : --! @brief OUTPUT WORD FLUSH :
                      --! 最終ワード信号出力.
                      --! * 最後のワードデータ出力であることを示すフラグ.
                      --! * O_DONE信号との違いはFLUSH_ENABLEの項を参照.
                      out std_logic;
        O_VAL       : --! @brief OUTPUT WORD VALID :
                      --! 出力ワード有効信号.
                      --! * O_DATA/O_STRB/O_DONE/O_FLUSHが有効であることを示す.
                      --! * O_VAL='1'and O_RDY='1'でワードデータがキューから取り除かれる.
                      out std_logic;
        O_RDY       : --! @brief OUTPUT WORD READY :
                      --! 出力レディ信号.
                      --! * キューから次のワードを取り除く準備が出来ていることを示す.
                      --! * O_VAL='1'and O_RDY='1'でワードデータがキューから取り除かれる.
                      in  std_logic;
        O_SHIFT     : --! @brief OUTPUT SHIFT SIZE :
                      --! 出力シフトサイズ信号.
                      --! * キューからワードを出力する際に、何ワード取り除くかを指定する.
                      --! * O_VAL='1' and O_RDY='1'の場合にのみこの信号は有効.
                      --! * 取り除くワードの位置に'1'をセットする.
                      --! * 例) O_SHIFT_MAX=3、O_SHIFT_MIN=0の場合、    
                      --!   O_SHIFT(3 downto 0)="1111" で4ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0111" で3ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0011" で2ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0001" で1ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0000" で取り除かない.    
                      --!   上記以外の値を指定した場合は動作を保証しない.
                      --! * 例) O_SHIFT_MAX=3、O_SHIFT_MIN=2の場合、    
                      --!   O_SHIFT(3 downto 2)="11" で4ワード取り除く.    
                      --!   O_SHIFT(3 downto 2)="01" で3ワード取り除く.    
                      --!   O_SHIFT(3 downto 2)="00" で2ワード取り除く.    
                      --!   上記以外の値を指定した場合は動作を保証しない.
                      --! * 例) O_SHIFT_MAX=1、O_SHIFT_MIN=1の場合、    
                      --!   O_SHIFT(1 downto 1)="1" で2ワード取り除く.    
                      --!   O_SHIFT(1 downto 1)="0" で1ワード取り除く.
                      --! * 例) O_SHIFT_MAX=0、O_SHIFT_MIN=0の場合、    
                      --!   O_SHIFT(0 downto 0)="1" で1ワード取り除く.    
                      --!   O_SHIFT(0 downto 0)="0" で取り除かない.
                      --! * 出力ワード数(O_WIDTH)分だけ取り除きたい場合は、
                      --!   O_SHIFT_MAX=O_WIDTH、O_SHIFT_MIN=O_WIDTH、
                      --!   O_SHIFT=(others => '0') としておくと良い.
                      in  std_logic_vector(O_SHIFT_MAX downto O_SHIFT_MIN) := (others => '0')
    );
end component;
-----------------------------------------------------------------------------------
--! @brief CHOPPER                                                               --
-----------------------------------------------------------------------------------
component CHOPPER
    -------------------------------------------------------------------------------
    -- ジェネリック変数
    -------------------------------------------------------------------------------
    generic (
        BURST       : --! @brief BURST MODE : 
                      --! バースト転送に対応するかを指定する.
                      --! * 1:バースト転送に対応する.
                      --!   0:バースト転送に対応しない.
                      --! * バースト転送に対応する場合は、CHOP信号をアサートする度に 
                      --!   PIECE_COUNT や各種出力信号が更新される.
                      --! * バースト転送に対応しない場合は、カウンタの初期値は１に設
                      --!   定され、CHOP信号が一回アサートされた時点でカウンタは停止
                      --!   する. つまり、最初のピースのサイズしか生成されない.
                      --! * 当然 BURST=0 の方が回路規模は小さくなる.
                      integer range 0 to 1 := 1;
        MIN_PIECE   : --! @brief MINIMUM PIECE SIZE :
                      --! １ピースの大きさの最小値を2のべき乗値で指定する.
                      --! * 例えば、大きさの単位がバイトの場合次のようになる.
                      --!   0=1バイト、1=2バイト、2=4バイト、3=8バイト
                      integer := 6;
        MAX_PIECE   : --! @brief MAXIMUM PIECE SIZE :
                      --! １ピースの大きさの最大値を2のべき乗値で指定する.
                      --! * 例えば、大きさの単位がバイトの場合次のようになる.
                      --!   0=1バイト、1=2バイト、2=4バイト、3=8バイト
                      --! * MAX_PIECE > MIN_PIECE の場合、１ピースの大きさを 
                      --!   SEL 信号によって選択することができる.
                      --!   SEL信号の対応するビットを'1'に設定して他のビットを'0'に
                      --!   設定することによって１ピースの大きさを指定する.
                      --! * MAX_PIECE = MIN_PIECE の場合、１ピースの大きさは 
                      --!   MIN_PIECEの値になる.
                      --!   この場合は SEL 信号は使用されない.
                      --! * MAX_PIECE と MIN_PIECE の差が大きいほど、回路規模は
                      --!   大きくなる。
                      integer := 6;
        MAX_SIZE    : --! @brief MAXIMUM SIZE :
                      --! 想定している最大の大きさを2のべき乗値で指定する.
                      --! * この回路内で、MAX_SIZE-MIN_PIECEのビット幅のカウンタを
                      --!   生成する。
                      integer := 9;
        ADDR_BITS   : --! @brief BLOCK ADDRESS BITS :
                      --! ブロックの先頭アドレスを指定する信号(ADDR信号)の
                      --! ビット幅を指定する.
                      integer := 9;
        SIZE_BITS   : --! @brief BLOCK SIZE BITS :
                      --! ブロックの大きさを指定する信号(SIZE信号)のビット幅を
                      --! 指定する.
                      integer := 9;
        COUNT_BITS  : --! @brief OUTPUT COUNT BITS :
                      --! 出力するカウンタ信号(COUNT)のビット幅を指定する.
                      --! * 出力するカウンタのビット幅は、想定している最大の大きさ
                      --!   (MAX_SIZE)-１ピースの大きさの最小値(MIN_PIECE)以上で
                      --!   なければならない.
                      --! * カウンタ信号(COUNT)を使わない場合は、エラボレーション時
                      --!   にエラーが発生しないように1以上の値を指定しておく.
                      integer := 9;
        PSIZE_BITS  : --! @brief OUTPUT PIECE SIZE BITS :
                      --! 出力するピースサイズ(PSIZE,NEXT_PSIZE)のビット幅を指定する.
                      --! * ピースサイズのビット幅は、MAX_PIECE(１ピースのサイズを
                      --!   表現できるビット数)以上でなければならない.
                      integer := 9;
        GEN_VALID   : --! @brief GENERATE VALID FLAG :
                      --! ピース有効信号(VALID/NEXT_VALID)を生成するかどうかを指定する.
                      --! * GEN_VALIDが０以外の場合は、ピース有効信号を生成する.
                      --! * GEN_VALIDが０の場合は、ピース有効信号はALL'1'になる.
                      --! * GEN_VALIDが０以外でも、この回路の上位階層で
                      --!   ピース有効をopenにしても論理上は問題ないが、
                      --!   論理合成ツールによっては、コンパイルに膨大な時間を
                      --!   要することがある.
                      --!   その場合はこの変数を０にすることで解決出来る場合がある.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 各種初期値
    -------------------------------------------------------------------------------
        ADDR        : --! @brief BLOCK ADDRESS :
                      --! ブロックの先頭アドレス.
                      --! * LOAD信号のアサート時に内部に保存される.
                      --! * 入力はADDR_BITSで示されるビット数あるが、実際に使用され
                      --!   るのは、1ピース分の下位ビットだけ.
                      in  std_logic_vector(ADDR_BITS-1 downto 0);
        SIZE        : --! @brief BLOCK SIZE :
                      --! ブロックの大きさ.
                      --! * LOAD信号のアサート時に内部に保存される.
                      in  std_logic_vector(SIZE_BITS-1 downto 0);
        SEL         : --! @brief PIECE SIZE SELECT :
                      --! １ピースの大きさを選択するための信号.
                      --! * LOAD信号のアサート時に内部に保存される.
                      --! * １ピースの大きさに対応するビットのみ'1'をセットし、他の
                      --!   ビットは'0'をセットすることで１ピースの大きさを選択する.
                      --! * もしSEL信号のうち複数のビットに'1'が設定されていた場合は
                      --!   もっとも最小値に近い値(MIN_PIECEの値)が選ばれる。
                      --! * この信号は MAX_PIECE > MIN_PIECE の場合にのみ使用される.
                      --! * この信号は MAX_PIECE = MIN_PIECE の場合は無視される.
                      in  std_logic_vector(MAX_PIECE downto MIN_PIECE);
        LOAD        : --! @brief LOAD :
                      --! ADDR,SIZE,SELを内部にロードするための信号.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 制御信号
    -------------------------------------------------------------------------------
        CHOP        : --! @brief CHOP ENABLE :
                      --! ブロックをピースに分割する信号.
                      --! * この信号のアサートによって、ピースカウンタ、各種フラグ、
                      --!   ピースサイズを更新され、次のクロックでこれらの信号が
                      --!   出力される.
                      --! * LOAD信号と同時にアサートされた場合はLOADの方が優先され、
                      --!   CHOP信号は無視される.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- ピースカウンタ/フラグ出力
    -------------------------------------------------------------------------------
        COUNT       : --! @brief PIECE COUNT :
                      --! 残りのピースの数-1を示す.
                      --! * CHOP信号のアサートによりカウントダウンする.
                      out std_logic_vector(COUNT_BITS-1 downto 0);
        NONE        : --! @brief NONE PIECE FLAG :
                      --! 残りのピースの数が０になったことを示すフラグ.
                      --! * COUNT = (others => '1') で'1'が出力される.
                      out std_logic;
        LAST        : --! @brief LAST PIECE FLAG :
                      --! 残りのピースの数が１になったことを示すフラグ.
                      --! * COUNT = (others => '0') で'1'が出力される.
                      --! * 最後のピースであることを示す.
                      out std_logic;
        NEXT_NONE   : --! @brief NONE PIECE FLAG(NEXT CYCLE) :
                      --! 次のクロックで残りのピースの数が０になることを示すフラグ.
                      out std_logic;
        NEXT_LAST   : --! @brief LAST PIECE FLAG(NEXT CYCYE) :
                      --! 次のクロックで残りのピースの数が１になることを示すフラグ.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- ピースサイズ(1ピースの容量)出力
    -------------------------------------------------------------------------------
        PSIZE       : --! @brief PIECE SIZE :
                      --! 現在のピースの大きさを示す.
                      out std_logic_vector(PSIZE_BITS-1 downto 0);
        NEXT_PSIZE  : --! @brief PIECE SIZE(NEXT CYCLE)
                      --! 次のクロックでのピースの大きさを示す.
                      out std_logic_vector(PSIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- ピース有効出力
    -------------------------------------------------------------------------------
        VALID       : --! @brief PIECE VALID FLAG :
                      --! ピース有効信号.
                      --! * 例えば、ADDR=0x0002、SIZE=11、１ピースのサイズ=4の場合、
                      --!   "1100"、"1111"、"1111"、"0001" を生成する.
                      --! * GEN_VALIDが０以外の場合にのみ有効な値を生成する.
                      --! * GEN_VALIDが０の場合は常に ALL'1' を生成する.
                      out std_logic_vector(2**(MAX_PIECE)-1 downto 0);
        NEXT_VALID  : --! @brief PIECE VALID FALG(NEXT CYCLE)
                      --! 次のクロックでのピース有効信号
                      out std_logic_vector(2**(MAX_PIECE)-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief QUEUE_REGISTER                                                        --
-----------------------------------------------------------------------------------
component QUEUE_REGISTER
    -------------------------------------------------------------------------------
    -- ジェネリック変数
    -------------------------------------------------------------------------------
    generic (
        QUEUE_SIZE  : --! @brief QUEUE SIZE :
                      --! キューの大きさをワード数で指定する.
                      integer := 1;
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(I_DATA/O_DATA/Q_DATA)のビット幅を指定する.
                      integer :=  32;
        LOWPOWER    : --! @brief LOW POWER MODE :
                      --! キューのレジスタに不必要なロードを行わないことにより、
                      --! レジスタが不必要にトグルすることを防いで消費電力を
                      --! 下げるようにする.
                      --! ただし、回路が若干増える.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT DATA  :
                      --! 入力データ信号.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT DATA VALID :
                      --! 入力データ有効信号.
                      in  std_logic;
        I_RDY       : --! @brief INPUT READY :
                      --! 入力可能信号.
                      --! キューが空いていて、入力データを受け付けることが可能で
                      --! あることを示す信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT DATA :
                      --! 出力データ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT DATA VALID :
                      --! キューレジスタに有効なデータが入っている事を示すフラグ.
                      --! * キューレジスタは1〜QUEUE_SIZEまであるが、対応する位置の
                      --!   フラグが'1'ならば有効なデータが入っている事を示す.
                      --! * この出力信号の範囲が1からではなく0から始まっている事に
                      --!   注意. これはQUEUE_SIZE=0の場合に対応するため.
                      --!   QUEUE_SIZE>0の場合は、O_VAL(0)はO_VAL(1)と同じ.
                      out std_logic_vector(QUEUE_SIZE  downto 0);
        Q_DATA      : --! @brief OUTPUT REGISTERD DATA :
                      --! レジスタ出力の出力データ.
                      --! 出力データ(O_DATA)をクロックで叩いたもの.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        Q_VAL       : --! @brief OUTPUT REGISTERD DATA VALID :
                      --! キューレジスタに有効なデータが入っている事を示すフラグ.
                      --! O_VALをクロックで叩いたもの.
                      --! * キューレジスタは1〜QUEUE_SIZEまであるが、対応する位置の
                      --!   フラグが'1'ならば有効なデータが入っている事を示す.
                      --! * この出力信号の範囲が1からではなく0から始まっている事に
                      --!   注意. これはQUEUE_SIZE=0の場合に対応するため.
                      --!   QUEUE_SIZE>0の場合は、Q_VAL(0)はQ_VAL(1)と同じ.
                      out std_logic_vector(QUEUE_SIZE  downto 0);
        Q_RDY       : --! @brief OUTPUT READY :
                      --! 出力可能信号.
                      in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief QUEUE_ARBITER                                                         --
-----------------------------------------------------------------------------------
component QUEUE_ARBITER
    generic (
        MIN_NUM     : --! @brief REQUEST MINIMUM NUMBER :
                      --! リクエストの最小番号を指定する.
                      integer := 0;
        MAX_NUM     : --! @brief REQUEST MAXIMUM NUMBER :
                      --! リクエストの最大番号を指定する.
                      integer := 7
    );
    port (
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
        ENABLE      : --! @brief ARBITORATION ENABLE :
                      --! この調停回路を有効にするかどうかを指定する.
                      --! * 幾つかの調停回路を組み合わせて使う場合、設定によっては
                      --!  この調停回路の出力を無効にしたいことがある.
                      --!  その時はこの信号を'0'にすることで簡単に出来る.
                      --! * ENABLE='1'でこの回路は調停を行う.
                      --! * ENABLE='0'でこの回路は調停を行わない.
                      --!   この場合REQUEST信号に関係なREQUEST_OおよびGRANTは'0'になる.
                      --!   リクエストキューの中身は破棄される.
                      in  std_logic := '1';
        REQUEST     : --! @brief REQUEST INPUT :
                      --! リクエスト入力.
                      in  std_logic_vector(MIN_NUM to MAX_NUM);
        GRANT       : --! @brief GRANT OUTPUT :
                      --! 調停結果出力.
                      out std_logic_vector(MIN_NUM to MAX_NUM);
        GRANT_NUM   : --! @brief GRANT NUMBER :
                      --! 許可番号.
                      --! * ただしリクエストキューに次の要求が無い場合でも、
                      --!   なんらかの番号を出力してしまう.
                      out integer   range  MIN_NUM to MAX_NUM;
        REQUEST_O   : --! @brief REQUEST OUTOUT :
                      --! リクエストキューに次の要求があることを示す信号.
                      --! * VALIDと異なり、リクエストキューに次の要求があっても、
                      --!   対応するREQUEST信号が'0'の場合はアサートされない.
                      out std_logic;
        VALID       : --! @brief REQUEST QUEUE VALID :
                      --! リクエストキューに次の要求があることを示す信号.
                      --! * REQUEST_Oと異なり、リスエストキューに次の要求があると
                      --!   対応するREQUEST信号の状態に関わらずアサートされる.
                      out std_logic;
        SHIFT       : --! @brief REQUEST QUEUE SHIFT :
                      --! リクエストキューの先頭からリクエストを取り除く信号.
                      in  std_logic
    );
end component;
end PipeWork_Components;
-----------------------------------------------------------------------------------
--!     @file    reducer.vhd
--!     @brief   REDUCER MODULE :
--!              異なるデータ幅のパスを継ぐためのアダプタ
--!     @version 1.5.8
--!     @date    2015/9/20
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
-----------------------------------------------------------------------------------
--! @brief   REDUCER :
--!          異なるデータ幅のパスを継ぐためのアダプタ.
--!        * REDUCER とは配管用語で径違い継ぎ手、つまり直径違う配管(パイプ)を接続
--!          するために用いる管継手のことです.
--!        * 論理回路の世界でも、ビット幅の異なるデータパスどうしを継ぐことが多い
--!          のでこのような汎用のアダプタを作って REDUCER という名前をつけました.
--!        * ちょっと汎用的に作りすぎたせいか、多少回路が冗長です.
--!          特にI_WIDTHが大きいとかなり大きな回路になってしまいます.
--!          例えば32bit入力64bit出力の場合、
--!          WORD_BITS=8 、STRB_BITS=1、I_WIDTH=4、O_WIDTH=8 とするよりも、
--!          WORD_BITS=32、STRB_BITS=4、I_WIDTH=1、O_WIDTH=2 としたほうが
--!          回路はコンパクトになります.
--!        * O_WIDTH>I_WIDTHの場合、最初のワードデータを出力する際のオフセットを
--!          設定できます. 詳細はOFFSETの項を参照.
-----------------------------------------------------------------------------------
entity  REDUCER is
    generic (
        WORD_BITS   : --! @brief WORD BITS :
                      --! １ワードのデータのビット数を指定する.
                      integer := 8;
        STRB_BITS   : --! @brief ENABLE BITS :
                      --! ワードデータのうち有効なデータであることを示す信号(STRB)
                      --! のビット数を指定する.
                      integer := 1;
        I_WIDTH     : --! @brief INPUT WORD WIDTH :
                      --! 入力側のデータのワード数を指定する.
                      integer := 1;
        O_WIDTH     : --! @brief OUTPUT WORD WIDTH :
                      --! 出力側のデータのワード数を指定する.
                      integer := 1;
        QUEUE_SIZE  : --! @brief QUEUE SIZE :
                      --! キューの大きさをワード数で指定する.
                      --! * QUEUE_SIZE=0を指定した場合は、キューの深さは自動的に
                      --!   O_WIDTH+I_WIDTH+I_WIDTH-1 に設定される.
                      --! * QUEUE_SIZE<O_WIDTH+I_WIDTH-1の場合は、キューの深さは
                      --!   自動的にO_WIDTH+I_WIDTH-1に設定される.
                      integer := 0;
        VALID_MIN   : --! @brief BUFFER VALID MINIMUM NUMBER :
                      --! VALID信号の配列の最小値を指定する.
                      integer := 0;
        VALID_MAX   : --! @brief BUFFER VALID MAXIMUM NUMBER :
                      --! VALID信号の配列の最大値を指定する.
                      integer := 0;
        O_VAL_SIZE  : --! @brief OUTPUT WORD VALID SIZE :
                      --! O_VAL 信号アサート時のキューに入っているワード数.
                      --! * キューに O_VAL_SIZE 以上のワード数が入っていると O_VAL 
                      --!   信号をアサートする.
                      --! * 互換性維持のため O_VAL_SIZE=0を指定した場合は、キューに
                      --!   O_WIDTH 以上のワード数が入っていると O_VAL 信号をアサー
                      --!   トする.
                      integer := 0;
        O_SHIFT_MIN : --! @brief OUTPUT SHIFT SIZE MINIMUM NUMBER :
                      --! O_SHIFT信号の配列の最小値を指定する.
                      integer := 1;
        O_SHIFT_MAX : --! @brief OUTPUT SHIFT SIZE MINIMUM NUMBER :
                      --! O_SHIFT信号の配列の最大値を指定する.
                      integer := 1;
        I_JUSTIFIED : --! @brief INPUT WORD JUSTIFIED :
                      --! 入力側の有効なデータが常にLOW側に詰められていることを
                      --! 示すフラグ.
                      --! * 常にLOW側に詰められている場合は、シフタが必要なくなる
                      --!   ため回路が簡単になる.
                      integer range 0 to 1 := 0;
        FLUSH_ENABLE: --! @brief FLUSH ENABLE :
                      --! FLUSH/I_FLUSHによるフラッシュ処理を有効にするかどうかを
                      --! 指定する.
                      --! * FLUSHとDONEとの違いは、DONEは最後のデータの出力時に
                      --!   キューの状態をすべてクリアするのに対して、
                      --!   FLUSHは最後のデータの出力時にSTRBだけをクリアしてVALは
                      --!   クリアしない.
                      --!   そのため次の入力データは、最後のデータの次のワード位置
                      --!   から格納される.
                      --! * フラッシュ処理を行わない場合は、0を指定すると回路が若干
                      --!   簡単になる.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 各種制御信号
    -------------------------------------------------------------------------------
        START       : --! @brief START :
                      --! 開始信号.
                      --! * この信号はOFFSETを内部に設定してキューを初期化する.
                      --! * 最初にデータ入力と同時にアサートしても構わない.
                      in  std_logic := '0';
        OFFSET      : --! @brief OFFSET :
                      --! 最初のワードの出力位置を指定する.
                      --! * START信号がアサートされた時のみ有効.
                      --! * O_WIDTH>I_WIDTHの場合、最初のワードデータを出力する際の
                      --!   オフセットを設定できる.
                      --! * 例えばWORD_BITS=8、I_WIDTH=1(1バイト入力)、O_WIDTH=4(4バイト出力)の場合、
                      --!   OFFSET="0000"に設定すると、最初に入力したバイトデータは
                      --!   1バイト目から出力される.    
                      --!   OFFSET="0001"に設定すると、最初に入力したバイトデータは
                      --!   2バイト目から出力される.    
                      --!   OFFSET="0011"に設定すると、最初に入力したバイトデータは
                      --!   3バイト目から出力される.    
                      --!   OFFSET="0111"に設定すると、最初に入力したバイトデータは
                      --!   4バイト目から出力される.    
                      in  std_logic_vector(O_WIDTH-1 downto 0) := (others => '0');
        DONE        : --! @brief DONE :
                      --! 終了信号.
                      --! * この信号をアサートすることで、キューに残っているデータ
                      --!   を掃き出す.
                      --!   その際、最後のワードと同時にO_DONE信号がアサートされる.
                      --! * FLUSH信号との違いは、FLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        FLUSH       : --! @brief FLUSH :
                      --! フラッシュ信号.
                      --! * この信号をアサートすることで、キューに残っているデータ
                      --!   を掃き出す.
                      --!   その際、最後のワードと同時にO_FLUSH信号がアサートされる.
                      --! * DONE信号との違いは、FLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        BUSY        : --! @brief BUSY :
                      --! ビジー信号.
                      --! * 最初にデータが入力されたときにアサートされる.
                      --! * 最後のデータが出力し終えたらネゲートされる.
                      out std_logic;
        VALID       : --! @brief QUEUE VALID FLAG :
                      --! キュー有効信号.
                      --! * 対応するインデックスのキューに有効なワードが入って
                      --!   いるかどうかを示すフラグ.
                      out std_logic_vector(VALID_MAX downto VALID_MIN);
    -------------------------------------------------------------------------------
    -- 入力側 I/F
    -------------------------------------------------------------------------------
        I_ENABLE    : --! @brief INPUT ENABLE :
                      --! 入力許可信号.
                      --! * この信号がアサートされている場合、キューの入力を許可する.
                      --! * この信号がネゲートされている場合、I_RDY アサートされない.
                      in  std_logic := '1';
        I_DATA      : --! @brief INPUT WORD DATA :
                      --! ワードデータ入力.
                      in  std_logic_vector(I_WIDTH*WORD_BITS-1 downto 0);
        I_STRB      : --! @brief INPUT WORD ENABLE :
                      --! ワードストローブ信号入力.
                      in  std_logic_vector(I_WIDTH*STRB_BITS-1 downto 0);
        I_DONE      : --! @brief INPUT WORD DONE :
                      --! 最終ワード信号入力.
                      --! * 最後の力ワードデータ入であることを示すフラグ.
                      --! * 基本的にはDONE信号と同じ働きをするが、I_DONE信号は
                      --!   最後のワードデータを入力する際に同時にアサートする.
                      --! * I_FLUSH信号との違いはFLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        I_FLUSH     : --! @brief INPUT WORD FLUSH :
                      --! 最終ワード信号入力.
                      --! * 最後のワードデータ入力であることを示すフラグ.
                      --! * 基本的にはFLUSH信号と同じ働きをするが、I_FLUSH信号は
                      --!   最後のワードデータを入力する際に同時にアサートする.
                      --! * I_DONE信号との違いはFLUSH_ENABLEの項を参照.
                      in  std_logic := '0';
        I_VAL       : --! @brief INPUT WORD VALID :
                      --! 入力ワード有効信号.
                      --! * I_DATA/I_STRB/I_DONE/I_FLUSHが有効であることを示す.
                      --! * I_VAL='1'and I_RDY='1'でワードデータがキューに取り込まれる.
                      in  std_logic;
        I_RDY       : --! @brief INPUT WORD READY :
                      --! 入力レディ信号.
                      --! * キューが次のワードデータを入力出来ることを示す.
                      --! * I_VAL='1'and I_RDY='1'でワードデータがキューに取り込まれる.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側 I/F
    -------------------------------------------------------------------------------
        O_ENABLE    : --! @brief OUTPUT ENABLE :
                      --! 出力許可信号.
                      --! * この信号がアサートされている場合、キューの出力を許可する.
                      --! * この信号がネゲートされている場合、O_VAL アサートされない.
                      in  std_logic := '1';
        O_DATA      : --! @brief OUTPUT WORD DATA :
                      --! ワードデータ出力.
                      out std_logic_vector(O_WIDTH*WORD_BITS-1 downto 0);
        O_STRB      : --! @brief OUTPUT WORD ENABLE :
                      --! ワードストローブ信号出力.
                      out std_logic_vector(O_WIDTH*STRB_BITS-1 downto 0);
        O_DONE      : --! @brief OUTPUT WORD DONE :
                      --! 最終ワード信号出力.
                      --! * 最後のワードデータ出力であることを示すフラグ.
                      --! * O_FLUSH信号との違いはFLUSH_ENABLEの項を参照.
                      out std_logic;
        O_FLUSH     : --! @brief OUTPUT WORD FLUSH :
                      --! 最終ワード信号出力.
                      --! * 最後のワードデータ出力であることを示すフラグ.
                      --! * O_DONE信号との違いはFLUSH_ENABLEの項を参照.
                      out std_logic;
        O_VAL       : --! @brief OUTPUT WORD VALID :
                      --! 出力ワード有効信号.
                      --! * O_DATA/O_STRB/O_DONE/O_FLUSHが有効であることを示す.
                      --! * O_VAL='1'and O_RDY='1'でワードデータがキューから取り除かれる.
                      out std_logic;
        O_RDY       : --! @brief OUTPUT WORD READY :
                      --! 出力レディ信号.
                      --! * キューから次のワードを取り除く準備が出来ていることを示す.
                      --! * O_VAL='1'and O_RDY='1'でワードデータがキューから取り除かれる.
                      in  std_logic;
        O_SHIFT     : --! @brief OUTPUT SHIFT SIZE :
                      --! 出力シフトサイズ信号.
                      --! * キューからワードを出力する際に、何ワード取り除くかを指定する.
                      --! * O_VAL='1' and O_RDY='1'の場合にのみこの信号は有効.
                      --! * 取り除くワードの位置に'1'をセットする.
                      --! * 例) O_SHIFT_MAX=3、O_SHIFT_MIN=0の場合、    
                      --!   O_SHIFT(3 downto 0)="1111" で4ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0111" で3ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0011" で2ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0001" で1ワード取り除く.    
                      --!   O_SHIFT(3 downto 0)="0000" で取り除かない.    
                      --!   上記以外の値を指定した場合は動作を保証しない.
                      --! * 例) O_SHIFT_MAX=3、O_SHIFT_MIN=2の場合、    
                      --!   O_SHIFT(3 downto 2)="11" で4ワード取り除く.    
                      --!   O_SHIFT(3 downto 2)="01" で3ワード取り除く.    
                      --!   O_SHIFT(3 downto 2)="00" で2ワード取り除く.    
                      --!   上記以外の値を指定した場合は動作を保証しない.
                      --! * 例) O_SHIFT_MAX=1、O_SHIFT_MIN=1の場合、    
                      --!   O_SHIFT(1 downto 1)="1" で2ワード取り除く.    
                      --!   O_SHIFT(1 downto 1)="0" で1ワード取り除く.
                      --! * 例) O_SHIFT_MAX=0、O_SHIFT_MIN=0の場合、    
                      --!   O_SHIFT(0 downto 0)="1" で1ワード取り除く.    
                      --!   O_SHIFT(0 downto 0)="0" で取り除かない.
                      --! * 出力ワード数(O_WIDTH)分だけ取り除きたい場合は、
                      --!   O_SHIFT_MAX=O_WIDTH、O_SHIFT_MIN=O_WIDTH、
                      --!   O_SHIFT=(others => '0') としておくと良い.
                      in  std_logic_vector(O_SHIFT_MAX downto O_SHIFT_MIN) := (others => '0')
    );
end REDUCER;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
architecture RTL of REDUCER is
    -------------------------------------------------------------------------------
    --! @brief ワード単位でデータ/データストローブ信号/ワード有効フラグをまとめておく.
    -------------------------------------------------------------------------------
    type      WORD_TYPE    is record
              DATA          : std_logic_vector(WORD_BITS-1 downto 0);
              STRB          : std_logic_vector(STRB_BITS-1 downto 0);
              VAL           : boolean;
    end record;
    -------------------------------------------------------------------------------
    --! @brief WORD TYPE の初期化時の値.
    -------------------------------------------------------------------------------
    constant  WORD_NULL     : WORD_TYPE := (DATA => (others => '0'),
                                            STRB => (others => '0'),
                                            VAL  => FALSE);
    -------------------------------------------------------------------------------
    --! @brief WORD TYPE の配列の定義.
    -------------------------------------------------------------------------------
    type      WORD_VECTOR  is array (INTEGER range <>) of WORD_TYPE;
    -------------------------------------------------------------------------------
    --! @brief 整数の最小値を求める関数.
    -------------------------------------------------------------------------------
    function  minimum(L,R : integer) return integer is
    begin
        if (L < R) then return L;
        else            return R;
        end if;
    end function;
    -------------------------------------------------------------------------------
    --! @brief 指定されたベクタのリダクション論理和を求める.
    -------------------------------------------------------------------------------
    function  or_reduce(Arg : std_logic_vector) return std_logic is
        variable result : std_logic;
    begin
        result := '0';
        for i in Arg'range loop
            result := result or Arg(i);
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief 入力信号のうち最も低い位置の'1'だけを取り出す関数.
    -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    -- 例) Data(0 to 3) = "1110" => SEL(0 to 3) = "1000"
    --     Data(0 to 3) = "0111" => SEL(0 to 3) = "0100"
    --     Data(0 to 3) = "0011" => SEL(0 to 3) = "0010"
    --     Data(0 to 3) = "0001" => SEL(0 to 3) = "0001"
    --     Data(0 to 3) = "0000" => SEL(0 to 3) = "0000"
    --     Data(0 to 3) = "0101" => SEL(0 to 3) = "0101" <- このような入力は禁止
    -------------------------------------------------------------------------------
    function  priority_selector(
                 Data    : std_logic_vector
    )            return    std_logic_vector
    is
        variable result  : std_logic_vector(Data'range);
    begin
        for i in Data'range loop
            if (i = Data'low) then
                result(i) := Data(i);
            else
                result(i) := Data(i) and (not Data(i-1));
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief ワードの配列からSELで指定されたワードを選択する関数.
    -------------------------------------------------------------------------------
    function  select_word(
                 WORDS   :  WORD_VECTOR;
                 SEL     :  std_logic_vector
    )            return     WORD_TYPE
    is
        alias    i_words :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        alias    i_sel   :  std_logic_vector(0 to   SEL'length-1) is SEL;
        variable result  :  WORD_TYPE;
        variable s_vec   :  std_logic_vector(0 to WORDS'length-1);
    begin
        for n in WORD_BITS-1 downto 0 loop
            for i in i_words'range loop
                if (i_sel'low <= i and i <= i_sel'high) then
                    s_vec(i) := i_words(i).DATA(n) and i_sel(i);
                else
                    s_vec(i) := '0';
                end if;
            end loop;
            result.DATA(n) := or_reduce(s_vec);
        end loop;
        for n in STRB_BITS-1 downto 0 loop
            for i in i_words'range loop
                if (i_sel'low <= i and i <= i_sel'high) then
                    s_vec(i) := i_words(i).STRB(n) and i_sel(i);
                else
                    s_vec(i) := '0';
                end if;
            end loop;
            result.STRB(n) := or_reduce(s_vec);
        end loop;
        for i in i_words'range loop
            if (i_sel'low <= i and i <= i_sel'high) then
                if (i_words(i).VAL and i_sel(i) = '1') then
                    s_vec(i) := '1';
                else
                    s_vec(i) := '0';
                end if;
            else
                    s_vec(i) := '0';
            end if;
        end loop;
        result.VAL := (or_reduce(s_vec) = '1');
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューの最後にワードを追加した新しいキューを求める関数.
    -------------------------------------------------------------------------------
    function  append_words(
                 QUEUE   :  WORD_VECTOR;
                 WORDS   :  WORD_VECTOR
    )            return     WORD_VECTOR
    is
        alias    i_vec   :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        variable i_val   :  std_logic_vector(0 to WORDS'length-1);
        variable i_sel   :  std_logic_vector(0 to WORDS'length-1);
        type     bv      is array (INTEGER range <>) of boolean;
        variable q_val   :  bv(QUEUE'low to QUEUE'high);
        variable result  :  WORD_VECTOR     (QUEUE'range);
    begin
        for q in QUEUE'range loop
            q_val(q) := QUEUE(q).VAL;
        end loop;
        for q in QUEUE'range loop 
            if (q_val(q) = FALSE) then
                for i in i_val'range loop
                    if (q-i-1 >= QUEUE'low) then
                        if (q_val(q-i-1)) then
                            i_val(i) := '1';
                        else
                            i_val(i) := '0';
                        end if;
                    else
                            i_val(i) := '1';
                    end if;
                end loop;
                i_sel := priority_selector(i_val);
                result(q) := select_word(WORDS=>i_vec, SEL=>i_sel);
            else
                result(q) := QUEUE(q);
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief O_SHIFT信号からONE-HOTのセレクト信号を生成する関数.
    -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    -- 例) SHIFT(3 downto 0)="0000" => SEL(0 to 4)=(0=>'1',1=>'0',2=>'0',3=>'0',4=>'0')
    --     SHIFT(3 downto 0)="0001" => SEL(0 to 4)=(0=>'0',1=>'1',2=>'0',3=>'0',4=>'0')
    --     SHIFT(3 downto 0)="0011" => SEL(0 to 4)=(0=>'0',1=>'0',2=>'1',3=>'0',4=>'0')
    --     SHIFT(3 downto 0)="0111" => SEL(0 to 4)=(0=>'0',1=>'0',2=>'0',3=>'1',4=>'0')
    --     SHIFT(3 downto 0)="1111" => SEL(0 to 4)=(0=>'0',1=>'0',2=>'0',3=>'0',4=>'1')
    -------------------------------------------------------------------------------
    function  shift_to_selector(
                 SHIFT   :  std_logic_vector;
                 MIN     :  integer;
                 MAX     :  integer
    )            return     std_logic_vector
    is
        variable result  :  std_logic_vector(MIN to MAX);
    begin
        for i in result'range loop
            if    (i < SHIFT'low ) then
                    result(i) := '0';
            elsif (i = SHIFT'low ) then
                if (SHIFT(i) = '0') then
                    result(i) := '1';
                else
                    result(i) := '0';
                end if;
            elsif (i <= SHIFT'high) then
                if (SHIFT(i) = '0' and SHIFT(i-1) = '1') then
                    result(i) := '1';
                else
                    result(i) := '0';
                end if;
            elsif (i = SHIFT'high+1) then
                if (SHIFT(i-1) = '1') then
                    result(i) := '1';
                else
                    result(i) := '0';
                end if;
            else
                    result(i) := '0';
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief ワード配列の有効なデータをLOW側に詰めたワード配列を求める関数.
    -------------------------------------------------------------------------------
    function  justify_words(
                 WORDS   :  WORD_VECTOR
    )            return     WORD_VECTOR
    is
        alias    i_vec   :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        variable i_val   :  std_logic_vector(0 to WORDS'length-1);
        variable s_vec   :  WORD_VECTOR     (0 to WORDS'length-1);
        variable s_sel   :  std_logic_vector(0 to WORDS'length-1);
        variable result  :  WORD_VECTOR     (0 to WORDS'length-1);
    begin
        for i in i_vec'range loop
            if (i_vec(i).VAL) then
                i_val(i) := '1';
            else
                i_val(i) := '0';
            end if;
        end loop;
        s_sel := priority_selector(i_val);
        for i in result'range loop
            result(i) := select_word(
                WORDS => i_vec(i to WORDS'length-1  ),
                SEL   => s_sel(0 to WORDS'length-i-1)
            );
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューを指定した分だけLOW側にシフトした新しいキューを求める関数.
    -------------------------------------------------------------------------------
    function  shift_words(
                 WORDS   :  WORD_VECTOR;
                 SHIFT   :  std_logic_vector
    )            return     WORD_VECTOR
    is
        alias    i_vec   :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        variable i_sel   :  std_logic_vector(0 to SHIFT'high  +1);
        variable result  :  WORD_VECTOR     (0 to WORDS'length-1);
    begin
        i_sel := shift_to_selector(SHIFT, i_sel'low, i_sel'high);
        for i in result'range loop
            result(i) := select_word(
                WORDS => i_vec(i to minimum(i+i_sel'high,i_vec'high)),
                SEL   => i_sel
            );
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューから指定した分だけキューに残して残りを削除したキューを求める関数.
    -------------------------------------------------------------------------------
    function  flush_words(
                 WORDS   :  WORD_VECTOR;
                 SHIFT   :  std_logic_vector
    )            return     WORD_VECTOR
    is
        alias    i_vec   :  WORD_VECTOR(0 to WORDS'length-1) is WORDS;
        variable result  :  WORD_VECTOR(0 to WORDS'length-1);
    begin
        for i in result'range loop
            if    (i <  SHIFT'low ) then
                result(i).VAL := i_vec(i).VAL;
            elsif (i <= SHIFT'high) then
                result(i).VAL := i_vec(i).VAL and (SHIFT(i) = '1');
            else
                result(i).VAL := FALSE;
            end if;
            result(i).DATA := (others => '0');
            result(i).STRB := (others => '0');
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューに入っているワード数がSHIFTで指定された数未満かどうかを求める関数
    -------------------------------------------------------------------------------
    function  words_less_than_shift_size(
                 WORDS   :  WORD_VECTOR;
                 SHIFT   :  std_logic_vector
    )            return     boolean
    is
        alias    i_vec   :  WORD_VECTOR(0 to WORDS'length-1) is WORDS;
        variable result  :  boolean;
    begin
        result := FALSE;
        for i in SHIFT'high downto i_vec'low loop
            if (i < SHIFT'low) then
                if (i_vec(i).VAL = FALSE) then
                    result := TRUE;
                end if;
            else
                if (i_vec(i).VAL = FALSE and SHIFT(i) = '1') then
                    result := TRUE;
                end if;
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューに入っているワード数がSHIFTで指定された数を越えているかどうかを求める関数
    -------------------------------------------------------------------------------
    function  words_more_than_shift_size(
                 WORDS   :  WORD_VECTOR;
                 SHIFT   :  std_logic_vector
    )            return     boolean
    is
        alias    i_vec   :  WORD_VECTOR     (0 to WORDS'length-1) is WORDS;
        variable i_sel   :  std_logic_vector(0 to SHIFT'high  +1);
        variable result  :  boolean;
    begin
        i_sel  := shift_to_selector(SHIFT, i_sel'low, i_sel'high);
        result := FALSE;
        for i in i_vec'range loop
            if (i_sel'low <= i and i <= i_sel'high) then
                if (i_sel(i) = '1' and i_vec(i).VAL) then
                    result := TRUE;
                end if;
            end if;
        end loop;
        return result;
    end function;
    -------------------------------------------------------------------------------
    --! @brief キューのサイズを計算する関数.
    -------------------------------------------------------------------------------
    function  QUEUE_DEPTH return integer is begin
        if (QUEUE_SIZE > 0) then
            if (QUEUE_SIZE >= O_WIDTH+I_WIDTH-1) then
                return QUEUE_SIZE;
            else
                assert (QUEUE_SIZE >= I_WIDTH+O_WIDTH-1)
                    report "require QUEUE_SIZE >= I_WIDTH+O_WIDTH-1" severity WARNING;
                return O_WIDTH+I_WIDTH-1;
            end if;
        else
                return O_WIDTH+I_WIDTH+I_WIDTH-1;
        end if;
    end function;
    -------------------------------------------------------------------------------
    --! @brief 現在のキューの状態.
    -------------------------------------------------------------------------------
    signal    curr_queue    : WORD_VECTOR(0 to QUEUE_DEPTH-1);
    -------------------------------------------------------------------------------
    --! @brief 1ワード分のイネーブル信号がオール0であることを示す定数.
    -------------------------------------------------------------------------------
    constant  STRB_NULL     : std_logic_vector(STRB_BITS-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    --! @brief FLUSH 出力フラグ.
    -------------------------------------------------------------------------------
    signal    flush_output  : std_logic;
    -------------------------------------------------------------------------------
    --! @brief FLUSH 保留フラグ.
    -------------------------------------------------------------------------------
    signal    flush_pending : std_logic;
    -------------------------------------------------------------------------------
    --! @brief DONE 出力フラグ.
    -------------------------------------------------------------------------------
    signal    done_output   : std_logic;
    -------------------------------------------------------------------------------
    --! @brief DONE 保留フラグ.
    -------------------------------------------------------------------------------
    signal    done_pending  : std_logic;
    -------------------------------------------------------------------------------
    --! @brief O_VAL信号を内部で使うための信号.
    -------------------------------------------------------------------------------
    signal    o_valid       : std_logic;
    -------------------------------------------------------------------------------
    --! @brief I_RDY信号を内部で使うための信号.
    -------------------------------------------------------------------------------
    signal    i_ready       : std_logic;
    -------------------------------------------------------------------------------
    --! @brief BUSY信号を内部で使うための信号.
    -------------------------------------------------------------------------------
    signal    curr_busy     : std_logic;
begin
    -------------------------------------------------------------------------------
    -- メインプロセス
    -------------------------------------------------------------------------------
    process (CLK, RST) 
        variable    in_words          : WORD_VECTOR(0 to I_WIDTH-1);
        variable    next_queue        : WORD_VECTOR(curr_queue'range);
        variable    next_valid_output : boolean;
        variable    next_flush_output : std_logic;
        variable    next_flush_pending: std_logic;
        variable    next_flush_fall   : std_logic;
        variable    next_done_output  : std_logic;
        variable    next_done_pending : std_logic;
        variable    next_done_fall    : std_logic;
        variable    pending_flag      : boolean;
        variable    flush_output_done : boolean;
        variable    flush_output_last : boolean;
    begin
        if (RST = '1') then
                curr_queue    <= (others => WORD_NULL);
                flush_output  <= '0';
                flush_pending <= '0';
                done_output   <= '0';
                done_pending  <= '0';
                i_ready       <= '0';
                o_valid       <= '0';
                curr_busy     <= '0';
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_queue    <= (others => WORD_NULL);
                flush_output  <= '0';
                flush_pending <= '0';
                done_output   <= '0';
                done_pending  <= '0';
                i_ready       <= '0';
                o_valid       <= '0';
                curr_busy     <= '0';
            else
                -------------------------------------------------------------------
                -- 次のクロックでのキューの状態を示す変数に現在のキューの状態をセット.
                -------------------------------------------------------------------
                next_queue := curr_queue;
                -------------------------------------------------------------------
                -- キュー初期化時は、OFFSETで指定された分だけ、あらかじめキューに
                -- ダミーのデータを入れておく.
                -------------------------------------------------------------------
                if (START = '1') then
                    for i in next_queue'range loop
                        if (i < O_WIDTH-1) then
                            next_queue(i).VAL := (OFFSET(i) = '1');
                        else
                            next_queue(i).VAL := FALSE;
                        end if;
                        next_queue(i).DATA := (others => '0');
                        next_queue(i).STRB := (others => '0');
                    end loop;
                end if;
                -------------------------------------------------------------------
                -- データ入力時は、キューに入力されたワードを追加する.
                -------------------------------------------------------------------
                if (I_VAL = '1' and i_ready = '1') then
                    for i in in_words'range loop
                        in_words(i).DATA :=  I_DATA((i+1)*WORD_BITS-1 downto i*WORD_BITS);
                        in_words(i).STRB :=  I_STRB((i+1)*STRB_BITS-1 downto i*STRB_BITS);
                        in_words(i).VAL  := (I_STRB((i+1)*STRB_BITS-1 downto i*STRB_BITS) /= STRB_NULL);
                    end loop;
                    if (I_JUSTIFIED     = 0) and
                       (in_words'length > 1) then
                        in_words := justify_words(in_words);
                    end if;
                    next_queue := append_words(next_queue, in_words);
                end if;
                -------------------------------------------------------------------
                -- データ出力時は、キューの先頭からO_SHIFTで指定された分だけ、
                -- データを取り除く.
                -------------------------------------------------------------------
                if (o_valid = '1' and O_RDY = '1') then
                    if (FLUSH_ENABLE >  0 ) and
                       (flush_output = '1') then
                        flush_output_last :=     words_less_than_shift_size(next_queue, O_SHIFT);
                        flush_output_done := not words_more_than_shift_size(next_queue, O_SHIFT);
                    else
                        flush_output_last := FALSE;
                        flush_output_done := FALSE;
                    end if;
                    if (flush_output_last) then
                        next_queue := flush_words(next_queue, O_SHIFT);
                    else
                        next_queue := shift_words(next_queue, O_SHIFT);
                    end if;
                else
                        flush_output_last := FALSE;
                        flush_output_done := FALSE;
                end if;
                -------------------------------------------------------------------
                -- 次のクロックでのキューの状態をレジスタに保持
                -------------------------------------------------------------------
                curr_queue <= next_queue;
                -------------------------------------------------------------------
                -- 次のクロックでのキューの状態でO_WIDTHの位置にデータが入って
                -- いるか否かをチェック.
                -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                -- この位置にデータがある場合は、O_DONE、O_FLUSH はまだアサートせ
                -- ずに、一旦ペンディングしておく.
                -------------------------------------------------------------------
                if (next_queue'high >= O_WIDTH) then
                    pending_flag := (next_queue(O_WIDTH).VAL);
                else
                    pending_flag := FALSE;
                end if;
                -------------------------------------------------------------------
                -- FLUSH制御
                -------------------------------------------------------------------
                if    (FLUSH_ENABLE = 0) then
                        next_flush_output  := '0';
                        next_flush_pending := '0';
                        next_flush_fall    := '0';
                elsif (flush_output = '1') then
                    if (flush_output_done) then
                        next_flush_output  := '0';
                        next_flush_pending := '0';
                        next_flush_fall    := '1';
                    else
                        next_flush_output  := '1';
                        next_flush_pending := '0';
                        next_flush_fall    := '0';
                    end if;
                elsif (flush_pending = '1') or
                      (FLUSH         = '1') or
                      (I_VAL = '1' and i_ready = '1' and I_FLUSH = '1') then
                    if (pending_flag) then
                        next_flush_output  := '0';
                        next_flush_pending := '1';
                        next_flush_fall    := '0';
                    else
                        next_flush_output  := '1';
                        next_flush_pending := '0';
                        next_flush_fall    := '0';
                    end if;
                else
                        next_flush_output  := '0';
                        next_flush_pending := '0';
                        next_flush_fall    := '0';
                end if;
                flush_output  <= next_flush_output;
                flush_pending <= next_flush_pending;
                -------------------------------------------------------------------
                -- DONE制御
                -------------------------------------------------------------------
                if    (done_output = '1') then
                    if (next_queue(next_queue'low).VAL = FALSE) then
                        next_done_output   := '0';
                        next_done_pending  := '0';
                        next_done_fall     := '1';
                    else
                        next_done_output   := '1';
                        next_done_pending  := '0';
                        next_done_fall     := '0';
                    end if;
                elsif (done_pending = '1') or
                      (DONE         = '1') or
                      (I_VAL = '1' and i_ready = '1' and I_DONE = '1') then
                    if (pending_flag) then
                        next_done_output   := '0';
                        next_done_pending  := '1';
                        next_done_fall     := '0';
                    else
                        next_done_output   := '1';
                        next_done_pending  := '0';
                        next_done_fall     := '0';
                    end if;
                else
                        next_done_output   := '0';
                        next_done_pending  := '0';
                        next_done_fall     := '0';
                end if;
                done_output   <= next_done_output;
                done_pending  <= next_done_pending;
                -------------------------------------------------------------------
                -- 出力有効信号の生成.
                -------------------------------------------------------------------
                if (O_VAL_SIZE = 0) then
                    next_valid_output := next_queue(O_WIDTH   -1).VAL;
                else
                    next_valid_output := next_queue(O_VAL_SIZE-1).VAL;
                end if;
                if (O_ENABLE = '1') and
                   ((next_done_output  = '1') or
                    (next_flush_output = '1') or
                    (next_valid_output = TRUE)) then
                    o_valid <= '1';
                else
                    o_valid <= '0';
                end if;
                -------------------------------------------------------------------
                -- 入力可能信号の生成.
                -------------------------------------------------------------------
                if (I_ENABLE = '1') and 
                   (next_done_output  = '0' and next_done_pending  = '0') and
                   (next_flush_output = '0' and next_flush_pending = '0') and
                   (next_queue(next_queue'length-I_WIDTH).VAL = FALSE) then
                    i_ready <= '1';
                else
                    i_ready <= '0';
                end if;
                -------------------------------------------------------------------
                -- 現在処理中であることを示すフラグ.
                -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                -- 最初に入力があった時点で'1'になり、O_DONEまたはO_FLUSHが出力完了
                -- した時点で'0'になる。
                -------------------------------------------------------------------
                if (curr_busy = '1') then
                    if (next_flush_fall = '1') or
                       (next_done_fall  = '1') then
                        curr_busy <= '0';
                    else
                        curr_busy <= '1';
                    end if;
                else
                    if (I_VAL = '1' and i_ready = '1') then
                        curr_busy <= '1';
                    else
                        curr_busy <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- 各種出力信号の生成.
    -------------------------------------------------------------------------------
    O_FLUSH <= flush_output when(FLUSH_ENABLE > 0) else '0';
    O_DONE  <= done_output;
    O_VAL   <= o_valid;
    I_RDY   <= i_ready;
    BUSY    <= curr_busy;
    process (curr_queue) begin
        for i in 0 to O_WIDTH-1 loop
            O_DATA((i+1)*WORD_BITS-1 downto i*WORD_BITS) <= curr_queue(i).DATA;
            O_STRB((i+1)*STRB_BITS-1 downto i*STRB_BITS) <= curr_queue(i).STRB;
        end loop;
        for i in VALID'range loop
            if (curr_queue'low <= i and i <= curr_queue'high) then
                if (curr_queue(i).VAL) then
                    VALID(i) <= '1';
                else
                    VALID(i) <= '0';
                end if;
            else
                    VALID(i) <= '0';
            end if;
        end loop;
    end process;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_object_code_reducer.vhd
--!     @brief   MessagePack Object Code Reducer :
--!     @version 0.2.0
--!     @date    2015/11/9
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
library MsgPack;
use     MsgPack.MsgPack_Object;
entity  MsgPack_Object_Code_Reducer is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        I_WIDTH         : positive := 1;
        O_WIDTH         : positive := 1;
        O_VALID_SIZE    : integer range 0 to 64 := 1;
        QUEUE_SIZE      : integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Control and Status Signals 
    -------------------------------------------------------------------------------
        DONE            : in  std_logic := '0';
        BUSY            : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_ENABLE        : in  std_logic := '1';
        I_CODE          : in  MsgPack_Object.Code_Vector(I_WIDTH-1 downto 0);
        I_DONE          : in  std_logic := '0';
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_ENABLE        : in  std_logic := '1';
        O_CODE          : out MsgPack_Object.Code_Vector(O_WIDTH-1 downto 0);
        O_DONE          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
        O_SHIFT         : in  std_logic_vector(O_WIDTH-1 downto 0) := (others => '0')
    );
end MsgPack_Object_Code_Reducer;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.PipeWork_Components.REDUCER;
architecture RTL of MsgPack_Object_Code_Reducer is
    constant   WORD_LO       :  integer := 0;
    constant   WORD_DATA_LO  :  integer := WORD_LO;
    constant   WORD_DATA_HI  :  integer := WORD_DATA_LO + MsgPack_Object.CODE_DATA_BITS    - 1;
    constant   WORD_STRB_LO  :  integer := WORD_DATA_HI + 1;
    constant   WORD_STRB_HI  :  integer := WORD_STRB_LO + MsgPack_Object.CODE_STRB_BITS    - 1;
    constant   WORD_TYPE_LO  :  integer := WORD_STRB_HI + 1;
    constant   WORD_TYPE_HI  :  integer := WORD_TYPE_LO + MsgPack_Object.CLASS_TYPE'length - 1;
    constant   WORD_COMP_POS :  integer := WORD_TYPE_HI + 1;
    constant   WORD_HI       :  integer := WORD_COMP_POS;
    constant   WORD_BITS     :  integer := WORD_HI - WORD_LO + 1;
    constant   offset        :  std_logic_vector(O_WIDTH          -1 downto 0) := (others => '0');
    signal     i_word        :  std_logic_vector(I_WIDTH*WORD_BITS-1 downto 0);
    signal     i_strb        :  std_logic_vector(I_WIDTH          -1 downto 0);
    signal     o_word        :  std_logic_vector(O_WIDTH*WORD_BITS-1 downto 0);
    signal     o_strb        :  std_logic_vector(O_WIDTH          -1 downto 0);
    signal     t_valid       :  std_logic_vector(O_WIDTH          -1 downto 0);
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (I_CODE)begin
        for i in 0 to I_WIDTH-1 loop
            i_word(WORD_BITS*i+WORD_DATA_HI downto WORD_BITS*i+WORD_DATA_LO) <= I_CODE(i).data;
            i_word(WORD_BITS*i+WORD_TYPE_HI downto WORD_BITS*i+WORD_TYPE_LO) <= I_CODE(i).class;
            i_word(WORD_BITS*i+WORD_STRB_HI downto WORD_BITS*i+WORD_STRB_LO) <= I_CODE(i).strb;
            i_word(WORD_BITS*i+WORD_COMP_POS                               ) <= I_CODE(i).complete;
            i_strb(i)                                                        <= I_CODE(i).valid;
        end loop;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    QUEUE: REDUCER                              -- 
        generic map (                           -- 
            WORD_BITS       => WORD_BITS      , -- 
            STRB_BITS       => 1              , -- 
            I_WIDTH         => I_WIDTH        , -- 
            O_WIDTH         => O_WIDTH        , -- 
            QUEUE_SIZE      => QUEUE_SIZE     , -- 
            VALID_MIN       => 0              , -- 
            VALID_MAX       => O_WIDTH-1      , -- 
            O_VAL_SIZE      => O_VALID_SIZE   , -- 
            O_SHIFT_MIN     => 0              , --
            O_SHIFT_MAX     => O_WIDTH-1      , --
            I_JUSTIFIED     => 1              , -- 
            FLUSH_ENABLE    => 0                -- 
        )                                       -- 
        port map (                              --
            CLK             => CLK            , -- In  :
            RST             => RST            , -- In  :
            CLR             => CLR            , -- In  :
            START           => '0'            , -- In  :
            OFFSET          => offset         , -- In  :
            DONE            => DONE           , -- In  :
            FLUSH           => '0'            , -- In  :
            BUSY            => BUSY           , -- Out :
            VALID           => t_valid        , -- Out :
            I_ENABLE        => I_ENABLE       , -- In  :
            I_STRB          => i_strb         , -- In  :
            I_DATA          => i_word         , -- In  :
            I_DONE          => I_DONE         , -- In  :
            I_FLUSH         => '0'            , -- In  :
            I_VAL           => I_VALID        , -- In  :
            I_RDY           => I_READY        , -- Out :
            O_ENABLE        => O_ENABLE       , -- In  :
            O_DATA          => o_word         , -- Out :
            O_STRB          => o_strb         , -- Out :
            O_DONE          => O_DONE         , -- Out :
            O_FLUSH         => open           , -- Out :
            O_VAL           => O_VALID        , -- Out :
            O_RDY           => O_READY        , -- In  :
            O_SHIFT         => O_SHIFT          -- In  :
    );                                          -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process(o_word, o_strb, t_valid) begin
        for i in 0 to O_WIDTH-1 loop
            O_CODE(i).data     <= o_word(WORD_BITS*i+WORD_DATA_HI downto WORD_BITS*i+WORD_DATA_LO);
            O_CODE(i).strb     <= o_word(WORD_BITS*i+WORD_STRB_HI downto WORD_BITS*i+WORD_STRB_LO);
            O_CODE(i).class    <= o_word(WORD_BITS*i+WORD_TYPE_HI downto WORD_BITS*i+WORD_TYPE_LO);
            O_CODE(i).complete <= o_word(WORD_BITS*i+WORD_COMP_POS);
            O_CODE(i).valid    <= t_valid(i);
        end loop;
    end process;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    object/msgpack_object_components.vhd                            --
--!     @brief   MessagaPack Component Library Description                       --
--!     @version 0.2.0                                                           --
--!     @date    2016/07/26                                                      --
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>                     --
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--                                                                               --
--      Copyright (C) 2016 Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>           --
--      All rights reserved.                                                     --
--                                                                               --
--      Redistribution and use in source and binary forms, with or without       --
--      modification, are permitted provided that the following conditions       --
--      are met:                                                                 --
--                                                                               --
--        1. Redistributions of source code must retain the above copyright      --
--           notice, this list of conditions and the following disclaimer.       --
--                                                                               --
--        2. Redistributions in binary form must reproduce the above copyright   --
--           notice, this list of conditions and the following disclaimer in     --
--           the documentation and/or other materials provided with the          --
--           distribution.                                                       --
--                                                                               --
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    --
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    --
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT         --
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    --
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    --
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT      --
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    --
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     --
--                                                                               --
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
-----------------------------------------------------------------------------------
--! @brief MessagaPack Component Library Description                             --
-----------------------------------------------------------------------------------
package MsgPack_Object_Components is
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Packer                                                 --
-----------------------------------------------------------------------------------
component MsgPack_Object_Packer
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      : positive := 1;
        O_BYTES         : positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_SHIFT         : out std_logic_vector(          CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Byte Stream Output Interface
    -------------------------------------------------------------------------------
        O_DATA          : out std_logic_vector(           8*O_BYTES-1 downto 0);
        O_STRB          : out std_logic_vector(             O_BYTES-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Unpacker                                               --
-----------------------------------------------------------------------------------
component MsgPack_Object_Unpacker
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        I_BYTES         : positive := 1;
        CODE_WIDTH      : positive := 1;
        O_VALID_SIZE    : integer range 0 to 64 := 1;
        DECODE_UNIT     : integer range 0 to  3 := 1;
        SHORT_STR_SIZE  : integer range 0 to 31 := 8;
        STACK_DEPTH     : integer := 4
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Byte Stream Input Interface
    -------------------------------------------------------------------------------
        I_DATA          : in  std_logic_vector(           8*I_BYTES-1 downto 0);
        I_STRB          : in  std_logic_vector(             I_BYTES-1 downto 0);
        I_LAST          : in  std_logic := '0';
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
        O_SHIFT         : in  std_logic_vector(          CODE_WIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Code_Reducer                                           --
-----------------------------------------------------------------------------------
component MsgPack_Object_Code_Reducer
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        I_WIDTH         : positive := 1;
        O_WIDTH         : positive := 1;
        O_VALID_SIZE    : integer range 0 to 64 := 1;
        QUEUE_SIZE      : integer := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Control and Status Signals 
    -------------------------------------------------------------------------------
        DONE            : in  std_logic := '0';
        BUSY            : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_ENABLE        : in  std_logic := '1';
        I_CODE          : in  MsgPack_Object.Code_Vector(I_WIDTH-1 downto 0);
        I_DONE          : in  std_logic := '0';
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_ENABLE        : in  std_logic := '1';
        O_CODE          : out MsgPack_Object.Code_Vector(O_WIDTH-1 downto 0);
        O_DONE          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
        O_SHIFT         : in  std_logic_vector(O_WIDTH-1 downto 0) := (others => '0')
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Code_FIFO                                              --
-----------------------------------------------------------------------------------
component MsgPack_Object_Code_FIFO
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        WIDTH           :  positive := 1;
        DEPTH           :  positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Code_Compare                                           --
-----------------------------------------------------------------------------------
component MsgPack_Object_Code_Compare
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        C_WIDTH         : positive := 1;
        I_WIDTH         : positive := 1;
        I_MAX_PHASE     : positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Input Object Code Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(I_WIDTH-1 downto 0);
        I_REQ_PHASE     : in  std_logic_vector(I_MAX_PHASE-1 downto 0);
    -------------------------------------------------------------------------------
    -- Comparison Object Code Interface
    -------------------------------------------------------------------------------
        C_CODE          : in  MsgPack_Object.Code_Vector(C_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Compare Result Output 
    -------------------------------------------------------------------------------
        MATCH           : out std_logic;
        MISMATCH        : out std_logic;
        SHIFT           : out std_logic_vector(I_WIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Array                                           --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Control/Status Signals
    -------------------------------------------------------------------------------
        ENABLE          : in  std_logic := '1';
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        ARRAY_START     : out std_logic;
        ARRAY_SIZE      : out std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        ENTRY_START     : out std_logic;
        ENTRY_BUSY      : out std_logic;
        ENTRY_LAST      : out std_logic;
        ENTRY_SIZE      : out std_logic_vector(SIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        VALUE_START     : out std_logic;
        VALUE_VALID     : out std_logic;
        VALUE_CODE      : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        VALUE_LAST      : out std_logic;
        VALUE_ERROR     : in  std_logic;
        VALUE_DONE      : in  std_logic;
        VALUE_SHIFT     : in  std_logic_vector(CODE_WIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Binary_Core                                     --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Binary_Core
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        DECODE_BINARY   :  boolean  := TRUE;
        DECODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Output Interface
    -------------------------------------------------------------------------------
        O_ENABLE        : out std_logic;
        O_START         : out std_logic;
        O_BUSY          : out std_logic;
        O_SIZE          : out std_logic_vector(SIZE_BITS-1 downto 0);
        O_DATA          : out std_logic_vector(MsgPack_Object.CODE_DATA_BITS*CODE_WIDTH-1 downto 0);
        O_STRB          : out std_logic_vector(MsgPack_Object.CODE_STRB_BITS*CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Binary_Array                                    --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Binary_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 4;
        ADDR_BITS       :  integer  := 8;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        DECODE_BINARY   :  boolean  := TRUE;
        DECODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_ADDR          : in  std_logic_vector(ADDR_BITS  -1 downto 0);
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Binary/String Data Output Interface
    -------------------------------------------------------------------------------
        O_START         : out std_logic;
        O_BUSY          : out std_logic;
        O_SIZE          : out std_logic_vector(SIZE_BITS  -1 downto 0);
        O_ADDR          : out std_logic_vector(ADDR_BITS  -1 downto 0);
        O_DATA          : out std_logic_vector(DATA_BITS  -1 downto 0);
        O_STRB          : out std_logic_vector(DATA_BITS/8-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Binary_Stream                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Binary_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 4;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        DECODE_BINARY   :  boolean  := TRUE;
        DECODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Binary/String Data Output Interface
    -------------------------------------------------------------------------------
        O_START         : out std_logic;
        O_BUSY          : out std_logic;
        O_SIZE          : out std_logic_vector(SIZE_BITS  -1 downto 0);
        O_DATA          : out std_logic_vector(DATA_BITS  -1 downto 0);
        O_STRB          : out std_logic_vector(DATA_BITS/8-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Map                                             --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Map
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Control/Status Signals
    -------------------------------------------------------------------------------
        ENABLE          : in  std_logic := '1';
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        MAP_START       : out std_logic;
        MAP_SIZE        : out std_logic_vector(31 downto 0);
        MAP_LAST        : out std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        KEY_START       : out std_logic;
        KEY_VALID       : out std_logic;
        KEY_CODE        : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        KEY_LAST        : out std_logic;
        KEY_ERROR       : in  std_logic;
        KEY_DONE        : in  std_logic;
        KEY_SHIFT       : in  std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        VALUE_START     : out std_logic;
        VALUE_ABORT     : out std_logic;
        VALUE_VALID     : out std_logic;
        VALUE_CODE      : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        VALUE_LAST      : out std_logic;
        VALUE_ERROR     : in  std_logic;
        VALUE_DONE      : in  std_logic;
        VALUE_SHIFT     : in  std_logic_vector(CODE_WIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Boolean                                         --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Boolean
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Output Interface
    -------------------------------------------------------------------------------
        O_VALUE         : out std_logic;
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Boolean_Array                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Boolean_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 1;
        ADDR_BITS       :  positive := 8;
        SIZE_BITS       :  positive := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_ADDR          : in  std_logic_vector( ADDR_BITS-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Boolean Value Data and Address Output
    -------------------------------------------------------------------------------
        O_START         : out std_logic;
        O_BUSY          : out std_logic;
        O_SIZE          : out std_logic_vector(SIZE_BITS-1 downto 0);
        O_ADDR          : out std_logic_vector(ADDR_BITS-1 downto 0);
        O_DATA          : out std_logic_vector(DATA_BITS-1 downto 0);
        O_STRB          : out std_logic_vector(DATA_BITS-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Boolean_Stream                                  --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Boolean_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 1;
        SIZE_BITS       :  positive := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Boolean Value Data and Address Output
    -------------------------------------------------------------------------------
        O_START         : out std_logic;
        O_BUSY          : out std_logic;
        O_SIZE          : out std_logic_vector(SIZE_BITS-1 downto 0);
        O_DATA          : out std_logic_vector(DATA_BITS-1 downto 0);
        O_STRB          : out std_logic_vector(DATA_BITS-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Integer                                         --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Integer
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE 
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Output Interface
    -------------------------------------------------------------------------------
        O_VALUE         : out std_logic_vector(VALUE_BITS-1 downto 0);
        O_SIGN          : out std_logic;
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Integer_Array                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Integer_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        ADDR_BITS       :  positive := 8;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_ADDR          : in  std_logic_vector( ADDR_BITS-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Data and Address Output
    -------------------------------------------------------------------------------
        O_START         : out std_logic;
        O_BUSY          : out std_logic;
        O_SIZE          : out std_logic_vector( SIZE_BITS-1 downto 0);
        O_ADDR          : out std_logic_vector( ADDR_BITS-1 downto 0);
        O_VALUE         : out std_logic_vector(VALUE_BITS-1 downto 0);
        O_SIGN          : out std_logic;
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Decode_Integer_Stream                                  --
-----------------------------------------------------------------------------------
component MsgPack_Object_Decode_Integer_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Data and Address Output
    -------------------------------------------------------------------------------
        O_START         : out std_logic;
        O_BUSY          : out std_logic;
        O_SIZE          : out std_logic_vector( SIZE_BITS-1 downto 0);
        O_VALUE         : out std_logic_vector(VALUE_BITS-1 downto 0);
        O_SIGN          : out std_logic;
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Array                                           --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        SIZE_BITS       :  positive := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        START           : in  std_logic;
        SIZE            : in  std_logic_vector(SIZE_BITS-1 downto 0);
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Value Object Encode Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_ERROR         : in  std_logic;
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- Array Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Map                                             --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Map
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        SIZE_BITS       :  positive := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        START           : in  std_logic;
        SIZE            : in  std_logic_vector(SIZE_BITS-1 downto 0);
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Encode Input Interface
    -------------------------------------------------------------------------------
        I_KEY_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_KEY_LAST      : in  std_logic;
        I_KEY_ERROR     : in  std_logic;
        I_KEY_VALID     : in  std_logic;
        I_KEY_READY     : out std_logic;
    -------------------------------------------------------------------------------
    -- Value Object Encode Input Interface
    -------------------------------------------------------------------------------
        I_VAL_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_VAL_LAST      : in  std_logic;
        I_VAL_ERROR     : in  std_logic;
        I_VAL_VALID     : in  std_logic;
        I_VAL_READY     : out std_logic;
    -------------------------------------------------------------------------------
    -- Key Value Map Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_MAP_CODE      : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_MAP_LAST      : out std_logic;
        O_MAP_ERROR     : out std_logic;
        O_MAP_VALID     : out std_logic;
        O_MAP_READY     : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Binary_Array                                    --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Binary_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 1;
        ADDR_BITS       :  positive := 1;
        SIZE_BITS       :  positive := 32;
        ENCODE_BINARY   :  boolean  := TRUE;
        ENCODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        START           : in  std_logic;
        ADDR            : in  std_logic_vector(ADDR_BITS  -1 downto 0);
        SIZE            : in  std_logic_vector(SIZE_BITS  -1 downto 0);
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Binary/String Data Stream Input Interface
    -------------------------------------------------------------------------------
        I_START         : out std_logic;
        I_BUSY          : out std_logic;
        I_SIZE          : out std_logic_vector(SIZE_BITS  -1 downto 0);
        I_ADDR          : out std_logic_vector(ADDR_BITS  -1 downto 0);
        I_STRB          : out std_logic_vector(DATA_BITS/8-1 downto 0);
        I_LAST          : out std_logic;
        I_DATA          : in  std_logic_vector(DATA_BITS  -1 downto 0);
        I_VALID         : in  std_logic;
        I_READY         : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Binary_Stream                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Binary_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 32;
        SIZE_BITS       :  positive := 32;
        ENCODE_BINARY   :  boolean  := TRUE;
        ENCODE_STRING   :  boolean  := FALSE;
        I_JUSTIFIED     :  boolean  := TRUE;
        I_BUFFERED      :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        START           : in  std_logic;
        SIZE            : in  std_logic_vector(SIZE_BITS  -1 downto 0);
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Binary/String Data Stream Input Interface
    -------------------------------------------------------------------------------
        I_START         : out std_logic;
        I_BUSY          : out std_logic;
        I_SIZE          : out std_logic_vector(SIZE_BITS  -1 downto 0);
        I_DATA          : in  std_logic_vector(DATA_BITS  -1 downto 0);
        I_STRB          : in  std_logic_vector(DATA_BITS/8-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_READY         : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Boolean                                         --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Boolean
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        QUEUE_SIZE      :  integer  := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Control and Status Signals 
    -------------------------------------------------------------------------------
        START           : in  std_logic := '1';
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Integer Value Input
    -------------------------------------------------------------------------------
        I_VALUE         : in  std_logic;
        I_VALID         : in  std_logic;
        I_READY         : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Boolean_Array                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Boolean_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 1;
        ADDR_BITS       :  positive := 32;
        SIZE_BITS       :  positive := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        START           : in  std_logic;
        ADDR            : in  std_logic_vector(ADDR_BITS-1 downto 0);
        SIZE            : in  std_logic_vector(SIZE_BITS-1 downto 0);
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Boolean Value Input Interface
    -------------------------------------------------------------------------------
        I_START         : out std_logic;
        I_BUSY          : out std_logic;
        I_SIZE          : out std_logic_vector(SIZE_BITS-1 downto 0);
        I_ADDR          : out std_logic_vector(ADDR_BITS-1 downto 0);
        I_STRB          : out std_logic_vector(DATA_BITS-1 downto 0);
        I_LAST          : out std_logic;
        I_DATA          : in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- Array Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Boolean_Stream                                  --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Boolean_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 1;
        SIZE_BITS       :  positive := 32;
        I_JUSTIFIED     :  boolean  := TRUE;
        I_BUFFERED      :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        START           : in  std_logic;
        SIZE            : in  std_logic_vector(SIZE_BITS  -1 downto 0);
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Boolean/String Data Stream Input Interface
    -------------------------------------------------------------------------------
        I_START         : out std_logic;
        I_BUSY          : out std_logic;
        I_SIZE          : out std_logic_vector(SIZE_BITS-1 downto 0);
        I_DATA          : in  std_logic_vector(DATA_BITS-1 downto 0);
        I_STRB          : in  std_logic_vector(DATA_BITS-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_READY         : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Integer                                         --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Integer
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Control and Status Signals 
    -------------------------------------------------------------------------------
        START           : in  std_logic := '1';
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Integer Value Input
    -------------------------------------------------------------------------------
        I_VALUE         : in  std_logic_vector(VALUE_BITS-1 downto 0);
        I_VALID         : in  std_logic;
        I_READY         : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Integer_Array                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Integer_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        ADDR_BITS       :  positive := 32;
        SIZE_BITS       :  positive := 32;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        START           : in  std_logic;
        ADDR            : in  std_logic_vector( ADDR_BITS-1 downto 0);
        SIZE            : in  std_logic_vector( SIZE_BITS-1 downto 0);
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Integer Value Input Interface
    -------------------------------------------------------------------------------
        I_START         : out std_logic;
        I_BUSY          : out std_logic;
        I_SIZE          : out std_logic_vector( SIZE_BITS-1 downto 0);
        I_ADDR          : out std_logic_vector( ADDR_BITS-1 downto 0);
        I_VALUE         : in  std_logic_vector(VALUE_BITS-1 downto 0);
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- Array Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_Integer_Stream                                  --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_Integer_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        SIZE_BITS       :  positive := 32;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        START           : in  std_logic;
        SIZE            : in  std_logic_vector( SIZE_BITS-1 downto 0);
        BUSY            : out std_logic;
        READY           : out std_logic;
    -------------------------------------------------------------------------------
    -- Integer Value Input Interface
    -------------------------------------------------------------------------------
        I_START         : out std_logic;
        I_BUSY          : out std_logic;
        I_SIZE          : out std_logic_vector( SIZE_BITS-1 downto 0);
        I_VALUE         : in  std_logic_vector(VALUE_BITS-1 downto 0);
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- Array Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Encode_String_Constant                                 --
-----------------------------------------------------------------------------------
component MsgPack_Object_Encode_String_Constant
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        VALUE           : string;
        CODE_WIDTH      : positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Control and Status Signals 
    -------------------------------------------------------------------------------
        START           : in  std_logic := '1';
        BUSY            : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Structure_Stack                                               --
-----------------------------------------------------------------------------------
component MsgPack_Structure_Stack
    generic (
        DEPTH           : integer :=  4
    );
    port (
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
        I_SIZE          : in  std_logic_vector(31 downto 0);
        I_MAP           : in  std_logic;
        I_ARRAY         : in  std_logic;
        I_COMPLETE      : in  std_logic;
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
        O_LAST          : out std_logic;
        O_NONE          : out std_logic;
        O_FULL          : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Match_Aggregator                                       --
-----------------------------------------------------------------------------------
component MsgPack_Object_Match_Aggregator
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH         : positive := 1;
        MATCH_NUM       : integer  := 1;
        MATCH_PHASE     : integer  := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_VALID         : in  std_logic;
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic := '0';
        I_SHIFT         : out std_logic_vector(          CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Phase Control Status Signals
    -------------------------------------------------------------------------------
        PHASE_NEXT      : out std_logic;
        PHASE_READY     : in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- Object Code Compare Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector(         MATCH_PHASE-1 downto 0);
        MATCH_OK        : in  std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_NOT       : in  std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_SHIFT     : in  std_logic_vector(MATCH_NUM*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Aggregated Result Output
    -------------------------------------------------------------------------------
        MATCH_SEL       : out std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_STATE     : out MsgPack_Object.Match_State_Type
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Store_Array                                            --
-----------------------------------------------------------------------------------
component MsgPack_Object_Store_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        ADDR_BITS       :  integer  := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Value Map Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(          CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Decode Output Interface
    -------------------------------------------------------------------------------
        VALUE_START     : out std_logic;
        VALUE_ADDR      : out std_logic_vector(           ADDR_BITS-1 downto 0);
        VALUE_VALID     : out std_logic;
        VALUE_CODE      : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        VALUE_LAST      : out std_logic;
        VALUE_ERROR     : in  std_logic;
        VALUE_DONE      : in  std_logic;
        VALUE_SHIFT     : in  std_logic_vector(          CODE_WIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Store_Boolean_Register                                 --
-----------------------------------------------------------------------------------
component MsgPack_Object_Store_Boolean_Register
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Output Interface
    -------------------------------------------------------------------------------
        VALUE           : out std_logic;
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Store_Boolean_Array                                    --
-----------------------------------------------------------------------------------
component MsgPack_Object_Store_Boolean_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 1;
        ADDR_BITS       :  positive := 8;
        SIZE_BITS       :  positive := MsgPack_Object.CODE_DATA_BITS
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Boolean Value Data and Address Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS-1 downto 0);
        ADDR            : out std_logic_vector(ADDR_BITS-1 downto 0);
        DATA            : out std_logic_vector(DATA_BITS-1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS-1 downto 0);
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Store_Boolean_Stream                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Store_Boolean_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 1;
        SIZE_BITS       :  positive := MsgPack_Object.CODE_DATA_BITS
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Boolean Value Data and Address Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS-1 downto 0);
        DATA            : out std_logic_vector(DATA_BITS-1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS-1 downto 0);
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Store_Integer_Register                                 --
-----------------------------------------------------------------------------------
component MsgPack_Object_Store_Integer_Register
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Output Interface
    -------------------------------------------------------------------------------
        VALUE           : out std_logic_vector(VALUE_BITS-1 downto 0);
        SIGN            : out std_logic;
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Store_Integer_Array                                    --
-----------------------------------------------------------------------------------
component MsgPack_Object_Store_Integer_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        ADDR_BITS       :  integer  := 8;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Data and Address Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector( SIZE_BITS-1 downto 0);
        ADDR            : out std_logic_vector( ADDR_BITS-1 downto 0);
        VALUE           : out std_logic_vector(VALUE_BITS-1 downto 0);
        SIGN            : out std_logic;
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Store_Integer_Stream                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Store_Integer_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Data and Address Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector( SIZE_BITS-1 downto 0);
        VALUE           : out std_logic_vector(VALUE_BITS-1 downto 0);
        SIGN            : out std_logic;
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Store_Binary_Array                                     --
-----------------------------------------------------------------------------------
component MsgPack_Object_Store_Binary_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 4;
        ADDR_BITS       :  integer  := 8;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        DECODE_BINARY   :  boolean  := TRUE;
        DECODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Data and Address Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS  -1 downto 0);
        ADDR            : out std_logic_vector(ADDR_BITS  -1 downto 0);
        DATA            : out std_logic_vector(DATA_BITS  -1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS/8-1 downto 0);
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Store_Binary_Stream                                    --
-----------------------------------------------------------------------------------
component MsgPack_Object_Store_Binary_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 4;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        DECODE_BINARY   :  boolean  := TRUE;
        DECODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Binary/String Data Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS  -1 downto 0);
        DATA            : out std_logic_vector(DATA_BITS  -1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS/8-1 downto 0);
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Stream_Parameter                                 --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Stream_Parameter
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        SIZE_BITS       :  integer range 1 to 32 := 32
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector(SIZE_BITS -1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        ENABLE          : in  std_logic;
        START           : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Boolean_Register                                 --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Boolean_Register
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        VALUE           : in  std_logic;
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Boolean_Array                                    --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Boolean_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 1;
        ADDR_BITS       :  positive := 32;
        SIZE_BITS       :  positive := MsgPack_Object.CODE_DATA_BITS
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector( SIZE_BITS-1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Boolean Value Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS-1 downto 0);
        ADDR            : out std_logic_vector(ADDR_BITS-1 downto 0);
        DATA            : in  std_logic_vector(DATA_BITS-1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Boolean_Stream                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Boolean_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 1;
        SIZE_BITS       :  positive := MsgPack_Object.CODE_DATA_BITS
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector(SIZE_BITS-1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Boolean Value Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS-1 downto 0);
        DATA            : in  std_logic_vector(DATA_BITS-1 downto 0);
        STRB            : in  std_logic_vector(DATA_BITS-1 downto 0);
        LAST            : in  std_logic;
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Integer_Register                                 --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Integer_Register
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        VALUE_BITS      :  integer range 1 to 64 := 32;
        VALUE_SIGN      :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        VALUE           : in  std_logic_vector(VALUE_BITS-1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Integer_Array                                    --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Integer_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        ADDR_BITS       :  positive := 32;
        SIZE_BITS       :  integer range 1 to 32 := 32;
        VALUE_BITS      :  integer range 1 to 64 := 32;
        VALUE_SIGN      :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector( SIZE_BITS-1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Integer Value Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector( SIZE_BITS-1 downto 0);
        ADDR            : out std_logic_vector( ADDR_BITS-1 downto 0);
        VALUE           : in  std_logic_vector(VALUE_BITS-1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Integer_Stream                                   --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Integer_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        SIZE_BITS       :  integer range 1 to 32 := 32;
        VALUE_BITS      :  integer range 1 to 64 := 32;
        VALUE_SIGN      :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector(SIZE_BITS-1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Integer Value Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector( SIZE_BITS-1 downto 0);
        VALUE           : in  std_logic_vector(VALUE_BITS-1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Binary_Array                                     --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Binary_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 32;
        ADDR_BITS       :  positive := 32;
        SIZE_BITS       :  integer range 1 to 32 := 32;
        ENCODE_BINARY   :  boolean  := TRUE;
        ENCODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector(SIZE_BITS  -1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Binary/String Data Stream Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS  -1 downto 0);
        ADDR            : out std_logic_vector(ADDR_BITS  -1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS/8-1 downto 0);
        LAST            : out std_logic;
        DATA            : in  std_logic_vector(DATA_BITS  -1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Binary_Stream                                    --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Binary_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        DATA_BITS       :  positive := 32;
        SIZE_BITS       :  integer range 1 to 32 := 32;
        ENCODE_BINARY   :  boolean  := TRUE;
        ENCODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector(SIZE_BITS  -1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Binary/String Data Stream Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS  -1 downto 0);
        DATA            : in  std_logic_vector(DATA_BITS  -1 downto 0);
        STRB            : in  std_logic_vector(DATA_BITS/8-1 downto 0);
        LAST            : in  std_logic;
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_Object_Query_Array                                            --
-----------------------------------------------------------------------------------
component MsgPack_Object_Query_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        ADDR_BITS       :  integer  := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Array Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(          CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Key Value Map Encode Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_VALID         : out std_logic;
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Parameter Object Decode Output Interface
    -------------------------------------------------------------------------------
        PARAM_START     : out std_logic;
        PARAM_ADDR      : out std_logic_vector(           ADDR_BITS-1 downto 0);
        PARAM_VALID     : out std_logic;
        PARAM_CODE      : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        PARAM_LAST      : out std_logic;
        PARAM_ERROR     : in  std_logic;
        PARAM_DONE      : in  std_logic;
        PARAM_SHIFT     : in  std_logic_vector(          CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Encode Input Interface
    -------------------------------------------------------------------------------
        VALUE_VALID     : in  std_logic;
        VALUE_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        VALUE_LAST      : in  std_logic;
        VALUE_ERROR     : in  std_logic;
        VALUE_READY     : out std_logic
    );
end component;
end MsgPack_Object_Components;
-----------------------------------------------------------------------------------
--!     @file    msgpack_structre_stack.vhd
--!     @brief   MessagePack Array/Map Structure Stack :
--!     @version 0.2.0
--!     @date    2015/11/9
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
-----------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------
entity  MsgPack_Structure_Stack is
    generic (
        DEPTH           : integer :=  4
    );
    port (
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
        I_SIZE          : in  std_logic_vector(31 downto 0);
        I_MAP           : in  std_logic;
        I_ARRAY         : in  std_logic;
        I_COMPLETE      : in  std_logic;
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
        O_LAST          : out std_logic;
        O_NONE          : out std_logic;
        O_FULL          : out std_logic
    );
end MsgPack_Structure_Stack;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
architecture RTL of MsgPack_Structure_Stack is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type     OP_TYPE        is (OP_NONE, OP_OVER, OP_LOAD, OP_PUSH, OP_POP1, OP_POP2, OP_DEC);
    signal   op             :  OP_TYPE;
    signal   complete       :  boolean;
    signal   stack_count    :  unsigned(DEPTH   downto 0);
    signal   stack_full     :  boolean;
    signal   stack_empty    :  boolean;
    signal   stack_last     :  boolean;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant COUNT_BITS     :  integer :=  I_SIZE'length+1;
    signal   object_count   :  unsigned(COUNT_BITS-1 downto 0);
    signal   object_map     :  std_logic;
    signal   object_last    :  boolean;
    signal   object_pop     :  boolean;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant RAM_COUNT_LO   :  integer := 0;
    constant RAM_COUNT_HI   :  integer := RAM_COUNT_LO + COUNT_BITS - 1;
    constant RAM_MAP_POS    :  integer := RAM_COUNT_HI + 1;
    constant RAM_BITS       :  integer := RAM_MAP_POS  - RAM_COUNT_LO + 1;
    type     RAM_TYPE       is array(integer range <>) of std_logic_vector(RAM_BITS-1 downto 0);
    signal   ram            :  RAM_TYPE(0 to 2**DEPTH-1);
    signal   ram_waddr      :  std_logic_vector(DEPTH-1 downto 0);
    signal   ram_raddr      :  std_logic_vector(DEPTH-1 downto 0);
    signal   ram_wdata      :  std_logic_vector(RAM_BITS-1 downto 0);
    signal   ram_rdata      :  std_logic_vector(RAM_BITS-1 downto 0);
    signal   ram_we         :  std_logic;
    signal   ram_wptr       :  unsigned(DEPTH downto 0);
    signal   ram_rptr       :  unsigned(DEPTH downto 0);
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (I_VALID, I_SIZE, I_MAP, I_ARRAY, I_COMPLETE, object_pop, object_last, stack_empty, stack_full) begin
        if    (object_pop = TRUE) then
                op       <= OP_POP2;
                complete <= FALSE;
        elsif (I_VALID = '1') then
            if    (I_MAP = '1' or I_ARRAY = '1') and
                  (to_01(unsigned(I_SIZE)) /= 0 ) then
                if    (stack_empty = FALSE and object_last = TRUE) then
                    op <= OP_LOAD;
                elsif (stack_full  = FALSE) then
                    op <= OP_PUSH;
                else
                    op <= OP_OVER;
                end if;
                complete <= FALSE;
            elsif (I_COMPLETE = '1') then
                if    (stack_empty = TRUE) then
                    op <= OP_NONE;
                elsif (object_last = TRUE) then
                    op <= OP_POP1;
                else
                    op <= OP_DEC;
                end if;
                complete <= TRUE;
            else
                op       <= OP_NONE;
                complete <= FALSE;
            end if;
        else
                op       <= OP_NONE;
                complete <= FALSE;
        end if;
    end process;
    I_READY <= '1' when (object_pop = FALSE) else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST)
        variable next_count : unsigned(COUNT_BITS-1 downto 0);
    begin
        if (RST = '1') then
                object_count <= (others => '0');
                object_map   <= '0';
                object_last  <= TRUE;
                object_pop   <= FALSE;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                object_count <= (others => '0');
                object_map   <= '0';
                object_last  <= TRUE;
                object_pop   <= FALSE;
            else
                case op is
                    when OP_PUSH | OP_LOAD =>
                        if (I_MAP = '1') then
                            next_count := unsigned(I_SIZE) & "0";
                            object_map <= '1';
                        else
                            next_count := "0" & unsigned(I_SIZE);
                            object_map <= '0';
                        end if;
                    when OP_POP1 =>
                            next_count := object_count;
                            object_pop <= TRUE;
                    when OP_POP2 =>
                            next_count := unsigned(ram_rdata(RAM_COUNT_HI downto RAM_COUNT_LO)) - 1;
                            object_map <= ram_rdata(RAM_MAP_POS);
                            object_pop <= FALSE;
                    when OP_DEC  =>
                            next_count := object_count - 1;
                    when others  =>
                            next_count := object_count;
                end case;
                object_count <= next_count;
                object_last  <= (next_count = 0 or next_count = 1);
             -- assert (op /= OP_OVER) report "stack error" severity error;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    STACK_CTRL: block
        signal   next_count :  unsigned(DEPTH   downto 0);
    begin 
        process (stack_count, CLR, op) begin
            if    (CLR  = '1') then
                next_count <= (others => '0');
            elsif (op = OP_PUSH) then
                next_count <= to_01(stack_count) + 1;
            elsif (op = OP_POP1) then
                next_count <= to_01(stack_count) - 1;
            else
                next_count <= stack_count;
            end if;
        end process;

        process (CLK, RST) begin
            if (RST = '1') then
                stack_count <= (others => '0');
                stack_full  <= FALSE;
                stack_empty <= TRUE;
            elsif (CLK'event and CLK = '1') then
                stack_count <= next_count;
                stack_full  <= (to_01(next_count) >= 2**DEPTH);
                stack_empty <= (to_01(next_count)  =        0);
            end if;
        end process;
        ram_wptr   <= stack_count;
        ram_rptr   <= stack_count-1;
        stack_last <= (to_01(next_count) <= 0);
    end block;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    O_LAST  <= '1' when (stack_empty = TRUE and complete = TRUE) or
                        (stack_last  = TRUE and complete = TRUE) else '0';
    O_FULL  <= '1' when (stack_full  = TRUE) else '0';
    O_NONE  <= '1' when (stack_empty = TRUE) else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    ram_wdata(RAM_MAP_POS                     ) <= object_map;
    ram_wdata(RAM_COUNT_HI downto RAM_COUNT_LO) <= std_logic_vector(object_count);
    ram_waddr   <= std_logic_vector(ram_wptr(ram_waddr'range));
    ram_raddr   <= std_logic_vector(ram_rptr(ram_raddr'range));
    ram_we      <= '1' when (op = OP_PUSH and stack_full = FALSE) else '0';

    process (CLK) begin
        if (CLK'event and CLK = '1') then
            if (ram_we = '1') then
                ram(to_integer(to_01(unsigned(ram_waddr)))) <= ram_wdata;
            end if;
            ram_rdata <= ram(to_integer(to_01(unsigned(ram_raddr))));
        end if;
    end process;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    chopper.vhd
--!     @brief   CHOPPER MODULE :
--!              先頭アドレス(ADDR信号)と容量(SIZE信号)で表されたブロックを、
--!              指定された単位(SEL信号およびMIN_PIECE変数、MAX_PIECE変数)のピース
--!              に分割するモジュール.
--!     @version 1.5.8
--!     @date    2015/5/19
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
-----------------------------------------------------------------------------------
--! @brief   CHOPPER :
--!          先頭アドレス(ADDR信号)と容量(SIZE信号)で表されたブロックを、
--!          指定された単位(SEL信号およびMIN_PIECE変数、MAX_PIECE変数)のピースに
--!          分割するモジュール.
--!        * 例1) ADDR=0x0002、SIZE=11、１ピースのサイズ=4の場合、
--!          2、4、4、1のサイズのピースに分割します.
--!        * 例2) ADDR=0x0048、SIZE=0x400、１ピースのサイズ=0x100の場合、
--!          0x0B8、0x100、0x100、0x100、0x048のサイズのピースに分割します.
--!        * ついでにピース有効信号(１ピースのうちどの部分が有効かを示す信号)も出力
--!          します.
--!          例えば、ADDR=0x0002、SIZE=11、１ピースのサイズ=4の場合、
--!          "1100"、"1111"、"1111"、"0001" を生成します.
--!          機能的には別モジュールでも良かったのですが、このモジュールで生成する
--!          ことにより回路が削減できるため、一緒にしました.
-----------------------------------------------------------------------------------
entity  CHOPPER is
    -------------------------------------------------------------------------------
    -- ジェネリック変数
    -------------------------------------------------------------------------------
    generic (
        BURST       : --! @brief BURST MODE : 
                      --! バースト転送に対応するかを指定する.
                      --! * 1:バースト転送に対応する.
                      --!   0:バースト転送に対応しない.
                      --! * バースト転送に対応する場合は、CHOP信号をアサートする度に 
                      --!   PIECE_COUNT や各種出力信号が更新される.
                      --! * バースト転送に対応しない場合は、カウンタの初期値は１に設
                      --!   定され、CHOP信号が一回アサートされた時点でカウンタは停止
                      --!   する. つまり、最初のピースのサイズしか生成されない.
                      --! * 当然 BURST=0 の方が回路規模は小さくなる.
                      integer range 0 to 1 := 1;
        MIN_PIECE   : --! @brief MINIMUM PIECE SIZE :
                      --! １ピースの大きさの最小値を2のべき乗値で指定する.
                      --! * 例えば、大きさの単位がバイトの場合次のようになる.
                      --!   0=1バイト、1=2バイト、2=4バイト、3=8バイト
                      integer := 6;
        MAX_PIECE   : --! @brief MAXIMUM PIECE SIZE :
                      --! １ピースの大きさの最大値を2のべき乗値で指定する.
                      --! * 例えば、大きさの単位がバイトの場合次のようになる.
                      --!   0=1バイト、1=2バイト、2=4バイト、3=8バイト
                      --! * MAX_PIECE > MIN_PIECE の場合、１ピースの大きさを 
                      --!   SEL 信号によって選択することができる.
                      --!   SEL信号の対応するビットを'1'に設定して他のビットを'0'に
                      --!   設定することによって１ピースの大きさを指定する.
                      --! * MAX_PIECE = MIN_PIECE の場合、１ピースの大きさは 
                      --!   MIN_PIECEの値になる.
                      --!   この場合は SEL 信号は使用されない.
                      --! * MAX_PIECE と MIN_PIECE の差が大きいほど、回路規模は
                      --!   大きくなる。
                      integer := 6;
        MAX_SIZE    : --! @brief MAXIMUM SIZE :
                      --! 想定している最大の大きさを2のべき乗値で指定する.
                      --! * この回路内で、MAX_SIZE-MIN_PIECEのビット幅のカウンタを
                      --!   生成する。
                      integer := 9;
        ADDR_BITS   : --! @brief BLOCK ADDRESS BITS :
                      --! ブロックの先頭アドレスを指定する信号(ADDR信号)の
                      --! ビット幅を指定する.
                      integer := 9;
        SIZE_BITS   : --! @brief BLOCK SIZE BITS :
                      --! ブロックの大きさを指定する信号(SIZE信号)のビット幅を
                      --! 指定する.
                      integer := 9;
        COUNT_BITS  : --! @brief OUTPUT COUNT BITS :
                      --! 出力するカウンタ信号(COUNT)のビット幅を指定する.
                      --! * 出力するカウンタのビット幅は、想定している最大の大きさ
                      --!   (MAX_SIZE)-１ピースの大きさの最小値(MIN_PIECE)以上で
                      --!   なければならない.
                      --! * カウンタ信号(COUNT)を使わない場合は、エラボレーション時
                      --!   にエラーが発生しないように1以上の値を指定しておく.
                      integer := 9;
        PSIZE_BITS  : --! @brief OUTPUT PIECE SIZE BITS :
                      --! 出力するピースサイズ(PSIZE,NEXT_PSIZE)のビット幅を指定する.
                      --! * ピースサイズのビット幅は、MAX_PIECE(１ピースのサイズを
                      --!   表現できるビット数)以上でなければならない.
                      integer := 9;
        GEN_VALID   : --! @brief GENERATE VALID FLAG :
                      --! ピース有効信号(VALID/NEXT_VALID)を生成するかどうかを指定する.
                      --! * GEN_VALIDが０以外の場合は、ピース有効信号を生成する.
                      --! * GEN_VALIDが０の場合は、ピース有効信号はALL'1'になる.
                      --! * GEN_VALIDが０以外でも、この回路の上位階層で
                      --!   ピース有効をopenにしても論理上は問題ないが、
                      --!   論理合成ツールによっては、コンパイルに膨大な時間を
                      --!   要することがある.
                      --!   その場合はこの変数を０にすることで解決出来る場合がある.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 各種初期値
    -------------------------------------------------------------------------------
        ADDR        : --! @brief BLOCK ADDRESS :
                      --! ブロックの先頭アドレス.
                      --! * LOAD信号のアサート時に内部に保存される.
                      --! * 入力はADDR_BITSで示されるビット数あるが、実際に使用され
                      --!   るのは、1ピース分の下位ビットだけ.
                      in  std_logic_vector(ADDR_BITS-1 downto 0);
        SIZE        : --! @brief BLOCK SIZE :
                      --! ブロックの大きさ.
                      --! * LOAD信号のアサート時に内部に保存される.
                      in  std_logic_vector(SIZE_BITS-1 downto 0);
        SEL         : --! @brief PIECE SIZE SELECT :
                      --! １ピースの大きさを選択するための信号.
                      --! * LOAD信号のアサート時に内部に保存される.
                      --! * １ピースの大きさに対応するビットのみ'1'をセットし、他の
                      --!   ビットは'0'をセットすることで１ピースの大きさを選択する.
                      --! * もしSEL信号のうち複数のビットに'1'が設定されていた場合は
                      --!   もっとも最小値に近い値(MIN_PIECEの値)が選ばれる。
                      --! * この信号は MAX_PIECE > MIN_PIECE の場合にのみ使用される.
                      --! * この信号は MAX_PIECE = MIN_PIECE の場合は無視される.
                      in  std_logic_vector(MAX_PIECE downto MIN_PIECE);
        LOAD        : --! @brief LOAD :
                      --! ADDR,SIZE,SELを内部にロードするための信号.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 制御信号
    -------------------------------------------------------------------------------
        CHOP        : --! @brief CHOP ENABLE :
                      --! ブロックをピースに分割する信号.
                      --! * この信号のアサートによって、ピースカウンタ、各種フラグ、
                      --!   ピースサイズを更新され、次のクロックでこれらの信号が
                      --!   出力される.
                      --! * LOAD信号と同時にアサートされた場合はLOADの方が優先され、
                      --!   CHOP信号は無視される.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- ピースカウンタ/フラグ出力
    -------------------------------------------------------------------------------
        COUNT       : --! @brief PIECE COUNT :
                      --! 残りのピースの数-1を示す.
                      --! * CHOP信号のアサートによりカウントダウンする.
                      out std_logic_vector(COUNT_BITS-1 downto 0);
        NONE        : --! @brief NONE PIECE FLAG :
                      --! 残りのピースの数が０になったことを示すフラグ.
                      --! * COUNT = (others => '1') で'1'が出力される.
                      out std_logic;
        LAST        : --! @brief LAST PIECE FLAG :
                      --! 残りのピースの数が１になったことを示すフラグ.
                      --! * COUNT = (others => '0') で'1'が出力される.
                      --! * 最後のピースであることを示す.
                      out std_logic;
        NEXT_NONE   : --! @brief NONE PIECE FLAG(NEXT CYCLE) :
                      --! 次のクロックで残りのピースの数が０になることを示すフラグ.
                      out std_logic;
        NEXT_LAST   : --! @brief LAST PIECE FLAG(NEXT CYCYE) :
                      --! 次のクロックで残りのピースの数が１になることを示すフラグ.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- ピースサイズ(1ピースの容量)出力
    -------------------------------------------------------------------------------
        PSIZE       : --! @brief PIECE SIZE :
                      --! 現在のピースの大きさを示す.
                      out std_logic_vector(PSIZE_BITS-1 downto 0);
        NEXT_PSIZE  : --! @brief PIECE SIZE(NEXT CYCLE)
                      --! 次のクロックでのピースの大きさを示す.
                      out std_logic_vector(PSIZE_BITS-1 downto 0);
    -------------------------------------------------------------------------------
    -- ピース有効出力
    -------------------------------------------------------------------------------
        VALID       : --! @brief PIECE VALID FLAG :
                      --! ピース有効信号.
                      --! * 例えば、ADDR=0x0002、SIZE=11、１ピースのサイズ=4の場合、
                      --!   "1100"、"1111"、"1111"、"0001" を生成する.
                      --! * GEN_VALIDが０以外の場合にのみ有効な値を生成する.
                      --! * GEN_VALIDが０の場合は常に ALL'1' を生成する.
                      out std_logic_vector(2**(MAX_PIECE)-1 downto 0);
        NEXT_VALID  : --! @brief PIECE VALID FALG(NEXT CYCLE)
                      --! 次のクロックでのピース有効信号
                      out std_logic_vector(2**(MAX_PIECE)-1 downto 0)
    );
end CHOPPER;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
architecture RTL of CHOPPER is
    -------------------------------------------------------------------------------
    -- ブロックの先頭アドレス(ADDR)/ブロックのサイズ(SIZE)を扱い易いように内部形式に
    -- 変換した信号
    -------------------------------------------------------------------------------
    signal    block_size        : unsigned(MAX_SIZE downto 0);
    signal    block_size_dec    : unsigned(MAX_SIZE downto 0);
    signal    block_addr_top    : unsigned(MAX_SIZE downto 0);
    signal    block_addr_last   : unsigned(MAX_SIZE downto 0);
    -------------------------------------------------------------------------------
    -- 残りピース数をカウントしているカウンタおよび各種フラグ関連の信号
    -------------------------------------------------------------------------------
    constant  PIECE_COUNT_BITS  : integer := MAX_SIZE - MIN_PIECE;
    signal    curr_piece_count  : unsigned(PIECE_COUNT_BITS downto 0);
    signal    init_piece_count  : unsigned(PIECE_COUNT_BITS downto 0);
    signal    next_piece_count  : unsigned(PIECE_COUNT_BITS downto 0);
    signal    curr_piece_last   : boolean;
    signal    curr_piece_none   : boolean;
    signal    next_piece_last   : boolean;
    signal    next_piece_none   : boolean;
    signal    init_piece_last   : boolean;
    signal    init_piece_none   : boolean;
    -------------------------------------------------------------------------------
    -- 分割された１ピースのサイズを生成するための信号
    -------------------------------------------------------------------------------
    signal    curr_piece_size   : unsigned(MAX_PIECE downto 0);
    signal    next_piece_size   : unsigned(MAX_PIECE downto 0);
    signal    last_piece_size   : unsigned(MAX_PIECE downto 0);
    signal    max_piece_size    : unsigned(MAX_PIECE downto 0);
    signal    max_piece_size_q  : unsigned(MAX_PIECE downto 0);
    -------------------------------------------------------------------------------
    -- SEL信号から１ピースのサイズを整数値に変換した信号
    -------------------------------------------------------------------------------
    signal    sel_piece         : integer range MIN_PIECE to MAX_PIECE;
begin
    -------------------------------------------------------------------------------
    -- LOAD = '1' の時に ADDR または SIZE に不定があった場合は警告を出力するための
    -- プロセス。
    -------------------------------------------------------------------------------
    process (CLK) 
        variable  u_addr :  unsigned(ADDR_BITS-1 downto 0);
        variable  u_size :  unsigned(SIZE_BITS-1 downto 0);
    begin
        if (CLK'event and CLK = '1') then
            if (LOAD = '1') then
                u_addr := 0 + unsigned(ADDR);
                u_size := 0 + unsigned(SIZE);
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- sel_piece : SEL信号から１ピースのバイト数を整数値に変換したした信号.
    --             もしSEL信号のうち複数のビットに'1'が設定されていた場合は、
    --             もっとも最小値に近い値(MIN_PIECEの値)が選ばれる.
    -------------------------------------------------------------------------------
    process (SEL) 
        variable n : integer range MIN_PIECE to MAX_PIECE;
    begin
        n := MIN_PIECE;            
        if (MIN_PIECE < MAX_PIECE) then
            for i in MIN_PIECE to MAX_PIECE loop
                if (SEL(i) = '1') then
                    n := i;
                    exit;
                end if;
            end loop;
        end if;
        sel_piece <= n;
    end process;
    -------------------------------------------------------------------------------
    -- block_size     : 入力サイズ信号(SIZE)を、後々使い易いように unsigned 形式に
    --                  変換して、ビット長を MAX_SIZE で指定されている長さまで
    --                  ０拡張しておく.
    -- block_size_dec : block_size から、さらに1を引いておく.
    -------------------------------------------------------------------------------
    process (SIZE) 
        variable u_size : unsigned(block_size'range);
    begin
        u_size := RESIZE(TO_01(unsigned(SIZE),'0'),u_size'length);
        block_size     <= u_size;
        block_size_dec <= u_size - 1;
    end process;
    -------------------------------------------------------------------------------
    -- block_addr_top : 入力アドレス信号(ADDR)のうち、１ピース分のアドレスだけ抽出
    --                  して unsigned 形式に変換して、ビット長を MAX_SIZE で指定さ
    --                  れている長さまで０拡張しておく.
    -------------------------------------------------------------------------------
    process (ADDR, sel_piece)
        variable u_addr : unsigned(block_addr_top'range);
    begin
        for i in block_addr_top'range loop
            if (i < ADDR_BITS and i < sel_piece and MIN_PIECE < MAX_PIECE) or
               (i < ADDR_BITS and i < MIN_PIECE and MIN_PIECE = MAX_PIECE) then
                u_addr(i) := ADDR(i);
            else
                u_addr(i) := '0';
            end if;
        end loop;
        block_addr_top <= TO_01(u_addr,'0');
    end process;
    -------------------------------------------------------------------------------
    -- block_addr_last : block_addr_top に block_size_dec を加算して
    --                   ブロックの最終アドレスを計算する.
    -------------------------------------------------------------------------------
    block_addr_last <= block_addr_top + ('0' & block_size_dec(block_size_dec'left-1 downto 0));
    -------------------------------------------------------------------------------
    -- init_piece_count : piece_count の初期値.
    --                    block_addr_last を sel_piece 分だけ右にシフトすることに
    --                    よって計算される.
    -- init_piece_last  : init_piece_count = 0 であることを示すフラグ.
    -- init_piece_none  : block_size       = 0 であることを示すフラグ.
    -------------------------------------------------------------------------------
    process (block_addr_last, SEL)
        type     COUNT_VECTOR is array (INTEGER range <>) 
                              of unsigned(PIECE_COUNT_BITS downto 0);
        variable count_vec     : COUNT_VECTOR(MIN_PIECE to MAX_PIECE);
        variable count_val     : unsigned(PIECE_COUNT_BITS downto 0);
        variable non_0_vec     : std_logic_vector(MIN_PIECE to MAX_PIECE);
        variable non_0_val     : std_logic;
    begin
        for i in MIN_PIECE to MAX_PIECE loop
            non_0_vec(i) := '0';
            for j in 0 to PIECE_COUNT_BITS loop
                if (i+j <= block_addr_last'left) then 
                    count_vec(i)(j) := block_addr_last(i+j);
                    non_0_vec(i)    := block_addr_last(i+j) or non_0_vec(i);
                else
                    count_vec(i)(j) := '0';
                end if;
            end loop;
        end loop;
        count_val := count_vec(MIN_PIECE);
        non_0_val := non_0_vec(MIN_PIECE);
        if (MIN_PIECE < MAX_PIECE) then
            for i in MIN_PIECE to MAX_PIECE loop
                if (SEL(i) = '1') then
                    count_val := count_vec(i);
                    non_0_val := non_0_vec(i);
                    exit;
                end if;
            end loop;
        end if;
        init_piece_count <= count_val;
        init_piece_last  <= (non_0_val = '0');
    end process;
    init_piece_none <= (block_size_dec(block_size_dec'left) = '1');
    -------------------------------------------------------------------------------
    -- next_piece_count : 次のクロックでのピースカウンタの値
    -- next_piece_none  : 次のクロックでのカウンタ終了信号
    -- next_piece_last  : 次のクロックでのカウンタ最終信号
    -------------------------------------------------------------------------------
    PCOUNT_NEXT: process (init_piece_count, init_piece_none, init_piece_last, LOAD,  
                          curr_piece_count, curr_piece_none, curr_piece_last, CHOP)
        variable piece_count_dec : unsigned(curr_piece_count'left+1 downto curr_piece_count'right);
    begin
        if    (LOAD = '1') then
            if    (init_piece_none) then
                next_piece_count <= (others => '1');
                next_piece_none  <= TRUE;
                next_piece_last  <= FALSE;
            elsif (BURST = 1) then
                next_piece_count <= init_piece_count;
                next_piece_none  <= FALSE;
                next_piece_last  <= init_piece_last;
            else
                next_piece_count <= (others => '0');
                next_piece_none  <= FALSE;
                next_piece_last  <= TRUE;
            end if;
        elsif (CHOP = '1' and curr_piece_none = FALSE) then
            if (BURST = 1) then
                piece_count_dec  := RESIZE(curr_piece_count, piece_count_dec'length) - 1;
                next_piece_count <= piece_count_dec(next_piece_count'range);
                next_piece_none  <= (piece_count_dec(piece_count_dec'left) = '1');
                next_piece_last  <= (piece_count_dec = 0);
            else
                next_piece_count <= (others => '1');
                next_piece_none  <= TRUE;
                next_piece_last  <= FALSE;
            end if;
        else
                next_piece_count <= curr_piece_count;
                next_piece_none  <= curr_piece_none;
                next_piece_last  <= curr_piece_last;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- curr_piece_count : ピースカウンタ
    -- curr_piece_none  : ピースカウンタ終了信号(curr_piece_count = 0)
    -- curr_piece_last  : ピースカウンタ最終信号(curr_piece_count = 1)
    -------------------------------------------------------------------------------
    PCOUNT_REGS: process (CLK, RST) begin
        if (RST = '1') then
                curr_piece_count <= (others => '1');
                curr_piece_none  <= TRUE;
                curr_piece_last  <= FALSE;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_piece_count <= (others => '1');
                curr_piece_none  <= TRUE;
                curr_piece_last  <= FALSE;
            else
                curr_piece_count <= next_piece_count;
                curr_piece_none  <= next_piece_none;
                curr_piece_last  <= next_piece_last;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- max_piece_size   : ピース毎に転送するバイト数の最大値
    --                    MIN_PIECE=MAX_PIECEの場合は、2**MIN_PIECE の固定値とな
    --                    り、回路規模は少ない。
    --                    MIN_PIECE<MAX_PIECEの場合は、SEL信号により指定された１
    --                    ピース毎のバイト数となる。
    -------------------------------------------------------------------------------
    process (SEL, LOAD, max_piece_size_q) 
        variable max : unsigned(max_piece_size'range);
    begin
        if (MIN_PIECE < MAX_PIECE) then
            if (LOAD = '1') then
                max := TO_UNSIGNED(2**MIN_PIECE, max_piece_size'length);
                for i in MIN_PIECE to MAX_PIECE loop
                    if (SEL(i) = '1') then
                        max := TO_UNSIGNED(2**i, max_piece_size'length);
                        exit;
                    end if;
                end loop;
                max_piece_size <= max;
            else
                max_piece_size <= TO_01(max_piece_size_q,'0');
            end if;
        else
                max_piece_size <= TO_UNSIGNED(2**MIN_PIECE, max_piece_size'length);
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- max_piece_size_q : ピース毎に転送するバイト数の最大値を LOAD 信号ネゲート
    --                    後も保持しておく信号
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                max_piece_size_q <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                max_piece_size_q <= (others => '0');
            else
                max_piece_size_q <= max_piece_size;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- next_piece_size : 次のクロックでのピース毎に転送するサイズ
    -------------------------------------------------------------------------------
    PSIZE_NEXT: process (curr_piece_size, max_piece_size , last_piece_size,
                         init_piece_none, init_piece_last, block_addr_top , LOAD,
                         next_piece_none, next_piece_last, block_size     , CHOP) begin
        if    (LOAD = '1') then
            if    (init_piece_none) then
                next_piece_size <= (others => '0');
            elsif (init_piece_last) then
                next_piece_size <= block_size(next_piece_size'range);
            else
                next_piece_size <= max_piece_size - block_addr_top(next_piece_size'range);
            end if;
        elsif (CHOP = '1') then
            if    (next_piece_none or BURST = 0) then
                next_piece_size <= (others => '0');
            elsif (next_piece_last) then
                next_piece_size <= last_piece_size;
            else
                next_piece_size <= max_piece_size;
            end if;
        else
                next_piece_size <= curr_piece_size;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- curr_piece_size : ピース毎に転送するサイズ
    -------------------------------------------------------------------------------
    PSIZE_REGS: process (CLK, RST) begin
        if (RST = '1') then
                curr_piece_size <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_piece_size <= (others => '0');
            else
                curr_piece_size <= next_piece_size;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- last_piece_size : 最終ピースでのバイト数
    -------------------------------------------------------------------------------
    PSIZE_LAST: process (CLK, RST) 
        variable lo_block_addr_last : unsigned(MAX_PIECE downto 0);
    begin
        if (RST = '1') then
            last_piece_size <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                last_piece_size <= (others => '0');
            elsif (LOAD = '1') then
                for i in 0 to MAX_PIECE loop
                    if (i < sel_piece and MIN_PIECE < MAX_PIECE) or
                       (i < MIN_PIECE and MIN_PIECE = MAX_PIECE) then
                        lo_block_addr_last(i) := block_addr_last(i);
                    else
                        lo_block_addr_last(i) := '0';
                    end if;
                end loop;
                last_piece_size <= lo_block_addr_last + 1;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- ピース有効信号の生成
    -------------------------------------------------------------------------------
    VALID_GEN_T: if (GEN_VALID /= 0) generate
        signal    curr_piece_valid   : std_logic_vector(VALID'range);
        signal    next_piece_valid   : std_logic_vector(VALID'range);
        signal    piece_valid_1st    : std_logic_vector(VALID'range);
        signal    piece_valid_last   : std_logic_vector(VALID'range);
        signal    piece_valid_last_q : std_logic_vector(VALID'range);
        signal    piece_valid_mask   : std_logic_vector(VALID'range);
    begin
        ---------------------------------------------------------------------------
        -- next_piece_valid : 次のクロックでのピース有効信号
        ---------------------------------------------------------------------------
        VALID_NEXT: process (curr_piece_valid,
                             piece_valid_1st, piece_valid_last, piece_valid_mask,
                             init_piece_none, init_piece_last, LOAD,
                             next_piece_none, next_piece_last, CHOP) begin
            if    (LOAD = '1') then
                if    (init_piece_none) then
                    next_piece_valid <= (others => '0');
                elsif (init_piece_last) then
                    next_piece_valid <= piece_valid_1st and piece_valid_last;
                else
                    next_piece_valid <= piece_valid_1st and piece_valid_mask;
                end if;
            elsif (CHOP = '1') then
                if    (next_piece_none or BURST = 0) then
                    next_piece_valid <= (others => '0');
                elsif (next_piece_last) then
                    next_piece_valid <= piece_valid_last;
                else
                    next_piece_valid <= piece_valid_mask;
                end if;
            else
                    next_piece_valid <= curr_piece_valid;
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- curr_piece_valid : ピース有効信号
        ---------------------------------------------------------------------------
        VALID_REGS: process (CLK, RST) begin
            if (RST = '1') then
                    curr_piece_valid <= (others => '0');
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    curr_piece_valid <= (others => '0');
                else
                    curr_piece_valid <= next_piece_valid;
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- piece_valid_mask : 指定された１ピース毎のバイト数分だけピース有効信号を
        --                    マスクするための信号
        ---------------------------------------------------------------------------
        VALID_MSK_COMB: process (max_piece_size)
            variable max : unsigned(MAX_PIECE downto 0);
        begin
            if (MAX_PIECE > MIN_PIECE) then
                max := TO_01(max_piece_size, '0');
                for i in piece_valid_mask'range loop
                    if (i < max) then
                        piece_valid_mask(i) <= '1';
                    else
                        piece_valid_mask(i) <= '0';
                    end if;
                end loop;
            else
                piece_valid_mask <= (others => '1');
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- piece_valid_1st  : 開始ピースでのピース有効信号
        ---------------------------------------------------------------------------
        VALID_1ST_COMB: process (block_addr_top, sel_piece) 
            variable lo_block_addr_top : unsigned(MAX_PIECE downto 0);
        begin
            for i in 0 to MAX_PIECE loop
                if (i < sel_piece and MIN_PIECE < MAX_PIECE) or
                   (i < MIN_PIECE and MIN_PIECE = MAX_PIECE) then
                    lo_block_addr_top(i) := block_addr_top(i);
                else
                    lo_block_addr_top(i) := '0';
                end if;
            end loop;
            lo_block_addr_top := TO_01(lo_block_addr_top,'0');
            for i in piece_valid_1st'range loop
                if (i >= lo_block_addr_top) then
                    piece_valid_1st(i) <= '1';
                else
                    piece_valid_1st(i) <= '0';
                end if;
            end loop;
        end process;
        ---------------------------------------------------------------------------
        -- piece_valid_last : 最終ピースでのピース有効信号
        ---------------------------------------------------------------------------
        VALID_LAST_COMB: process (piece_valid_last_q, block_addr_last, sel_piece, LOAD) 
            variable lo_block_addr_last   : unsigned(MAX_PIECE downto 0);
        begin
            if (LOAD = '1') then
                for i in 0 to MAX_PIECE loop
                    if (i < sel_piece and MIN_PIECE < MAX_PIECE) or
                       (i < MIN_PIECE and MIN_PIECE = MAX_PIECE) then
                        lo_block_addr_last(i) := block_addr_last(i);
                    else
                        lo_block_addr_last(i) := '0';
                    end if;
                end loop;
                lo_block_addr_last := TO_01(lo_block_addr_last,'0');
                for i in piece_valid_last'range loop
                    if (i <= lo_block_addr_last) then
                        piece_valid_last(i) <= '1';
                    else
                        piece_valid_last(i) <= '0';
                    end if;
                end loop;
            else
                piece_valid_last <= piece_valid_last_q;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --  piece_valid_last_q : 最終ピースでのピース有効の値を LOAD 信号ネゲート後
        --                       も保持しておく信号
        ---------------------------------------------------------------------------
        VALID_LAST_REGS: process (CLK, RST) begin
            if (RST = '1') then
                    piece_valid_last_q <= (others => '0');
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    piece_valid_last_q <= (others => '0');
                else
                    piece_valid_last_q <= piece_valid_last;
                end if;
            end if;
        end process;
        VALID      <= curr_piece_valid;
        NEXT_VALID <= next_piece_valid;
    end generate;
    VALID_GEN_F: if (GEN_VALID = 0) generate
        VALID      <= (others => '1');
        NEXT_VALID <= (others => '1');
    end generate;
    -------------------------------------------------------------------------------
    -- 各種出力信号の生成
    -------------------------------------------------------------------------------
    process (curr_piece_count, curr_piece_none) begin
        for i in COUNT'range loop
            if (i > curr_piece_count'high) then
                if (curr_piece_none) then
                    COUNT(i) <= '1';
                else
                    COUNT(i) <= '0';
                end if;
            else
                COUNT(i) <= curr_piece_count(i);
            end if;
        end loop;
    end process;
    NONE       <= '1' when (curr_piece_none) else '0';
    LAST       <= '1' when (curr_piece_last) else '0';
    NEXT_NONE  <= '1' when (next_piece_none) else '0';
    NEXT_LAST  <= '1' when (next_piece_last) else '0';
    PSIZE      <= std_logic_vector(RESIZE(curr_piece_size, PSIZE'length));
    NEXT_PSIZE <= std_logic_vector(RESIZE(next_piece_size, PSIZE'length));
end RTL;
-----------------------------------------------------------------------------------
--!     @file    kvmap/msgpack_kvmap_components.vhd                              --
--!     @brief   MessagaPack Component Library Description                       --
--!     @version 0.2.0                                                           --
--!     @date    2016/07/26                                                      --
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>                     --
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--                                                                               --
--      Copyright (C) 2016 Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>           --
--      All rights reserved.                                                     --
--                                                                               --
--      Redistribution and use in source and binary forms, with or without       --
--      modification, are permitted provided that the following conditions       --
--      are met:                                                                 --
--                                                                               --
--        1. Redistributions of source code must retain the above copyright      --
--           notice, this list of conditions and the following disclaimer.       --
--                                                                               --
--        2. Redistributions in binary form must reproduce the above copyright   --
--           notice, this list of conditions and the following disclaimer in     --
--           the documentation and/or other materials provided with the          --
--           distribution.                                                       --
--                                                                               --
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    --
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    --
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT         --
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    --
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    --
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT      --
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    --
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     --
--                                                                               --
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
-----------------------------------------------------------------------------------
--! @brief MessagaPack Component Library Description                             --
-----------------------------------------------------------------------------------
package MsgPack_KVMap_Components is
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Key_Compare                                             --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Key_Compare
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      : positive := 1;
        I_MAX_PHASE     : positive := 1;
        KEYWORD         : string
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Input Object Code Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_REQ_PHASE     : in  std_logic_vector(I_MAX_PHASE-1 downto 0);
    -------------------------------------------------------------------------------
    -- Compare Result Output
    -------------------------------------------------------------------------------
        MATCH           : out std_logic;
        MISMATCH        : out std_logic;
        SHIFT           : out std_logic_vector(CODE_WIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Key_Match_Aggregator                                    --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Key_Match_Aggregator
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      : positive := 1;
        MATCH_NUM       : integer  := 1;
        MATCH_PHASE     : integer  := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_KEY_VALID     : in  std_logic;
        I_KEY_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_KEY_LAST      : in  std_logic := '0';
        I_KEY_SHIFT     : out std_logic_vector(          CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Key Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_KEY_VALID     : out std_logic;
        O_KEY_CODE      : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_KEY_LAST      : out std_logic;
        O_KEY_READY     : in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- Key Object Compare Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector(         MATCH_PHASE-1 downto 0);
        MATCH_OK        : in  std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_NOT       : in  std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_SHIFT     : in  std_logic_vector(MATCH_NUM*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Aggregated Result Output
    -------------------------------------------------------------------------------
        MATCH_SEL       : out std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_STATE     : out MsgPack_Object.Match_State_Type
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Dispatcher                                              --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Dispatcher
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        STORE_SIZE      :  positive := 8;
        MATCH_PHASE     :  positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_KEY_CODE      : in  MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        I_KEY_LAST      : in  std_logic;
        I_KEY_VALID     : in  std_logic;
        I_KEY_ERROR     : out std_logic;
        I_KEY_DONE      : out std_logic;
        I_KEY_SHIFT     : out std_logic_vector(           CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_VAL_START     : in  std_logic;
        I_VAL_ABORT     : in  std_logic;
        I_VAL_CODE      : in  MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        I_VAL_LAST      : in  std_logic;
        I_VAL_VALID     : in  std_logic;
        I_VAL_ERROR     : out std_logic;
        I_VAL_DONE      : out std_logic;
        I_VAL_SHIFT     : out std_logic_vector(           CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Key Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_KEY_CODE      : out MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        O_KEY_VALID     : out std_logic;
        O_KEY_LAST      : out std_logic;
        O_KEY_ERROR     : out std_logic;
        O_KEY_READY     : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Compare Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector(          MATCH_PHASE-1 downto 0);
        MATCH_CODE      : out MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        MATCH_OK        : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        MATCH_NOT       : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        MATCH_SHIFT     : in  std_logic_vector(STORE_SIZE*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Decode Output Interface
    -------------------------------------------------------------------------------
        VALUE_START     : out std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_VALID     : out std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_CODE      : out MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        VALUE_LAST      : out std_logic;
        VALUE_ERROR     : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_DONE      : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_SHIFT     : in  std_logic_vector(STORE_SIZE*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Dispatch Control/Status Interface
    -------------------------------------------------------------------------------
        DISPATCH_SELECT : out std_logic_vector(STORE_SIZE           -1 downto 0);
        DISPATCH_START  : out std_logic;
        DISPATCH_ERROR  : out std_logic;
        DISPATCH_ABORT  : out std_logic;
        DISPATCH_BUSY   : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store_Boolean_Register                                  --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store_Boolean_Register
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        QUEUE_SIZE      :  integer  := 0
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Output Interface
    -------------------------------------------------------------------------------
        VALUE           : out std_logic;
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store_Boolean_Array                                     --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store_Boolean_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        DATA_BITS       :  positive := 1;
        ADDR_BITS       :  positive := 8;
        SIZE_BITS       :  positive := MsgPack_Object.CODE_DATA_BITS
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Boolean Value Data and Address Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS-1 downto 0);
        ADDR            : out std_logic_vector(ADDR_BITS-1 downto 0);
        DATA            : out std_logic_vector(DATA_BITS-1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS-1 downto 0);
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store_Boolean_Stream                                    --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store_Boolean_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        DATA_BITS       :  positive := 1;
        SIZE_BITS       :  positive := MsgPack_Object.CODE_DATA_BITS
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Boolean Value Data and Address Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS-1 downto 0);
        DATA            : out std_logic_vector(DATA_BITS-1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS-1 downto 0);
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store_Integer_Register                                  --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store_Integer_Register
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Output Interface
    -------------------------------------------------------------------------------
        VALUE           : out std_logic_vector(VALUE_BITS-1 downto 0);
        SIGN            : out std_logic;
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store_Integer_Array                                     --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store_Integer_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        ADDR_BITS       :  integer  := 8;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Data and Address Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector( SIZE_BITS-1 downto 0);
        ADDR            : out std_logic_vector( ADDR_BITS-1 downto 0);
        VALUE           : out std_logic_vector(VALUE_BITS-1 downto 0);
        SIGN            : out std_logic;
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store_Integer_Stream                                    --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store_Integer_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Data and Address Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector( SIZE_BITS-1 downto 0);
        VALUE           : out std_logic_vector(VALUE_BITS-1 downto 0);
        SIGN            : out std_logic;
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store_Binary_Array                                      --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store_Binary_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        ADDR_BITS       :  integer  := 8;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        DATA_BITS       :  positive := 8;
        DECODE_BINARY   :  boolean  := TRUE;
        DECODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Binary/String Data Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS  -1 downto 0);
        ADDR            : out std_logic_vector(ADDR_BITS  -1 downto 0);
        DATA            : out std_logic_vector(DATA_BITS  -1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS/8-1 downto 0);
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store_Binary_Stream                                     --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store_Binary_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        SIZE_BITS       :  integer  := MsgPack_Object.CODE_DATA_BITS;
        DATA_BITS       :  positive := 8;
        DECODE_BINARY   :  boolean  := TRUE;
        DECODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Binary/String Data Output
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS  -1 downto 0);
        DATA            : out std_logic_vector(DATA_BITS  -1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS/8-1 downto 0);
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store_Map_Value                                         --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store_Map_Value
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        STORE_SIZE      :  positive := 8;
        MATCH_PHASE     :  positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_KEY_CODE      : in  MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        I_KEY_LAST      : in  std_logic;
        I_KEY_VALID     : in  std_logic;
        I_KEY_ERROR     : out std_logic;
        I_KEY_DONE      : out std_logic;
        I_KEY_SHIFT     : out std_logic_vector(           CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_VAL_START     : in  std_logic;
        I_VAL_ABORT     : in  std_logic;
        I_VAL_CODE      : in  MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        I_VAL_LAST      : in  std_logic;
        I_VAL_VALID     : in  std_logic;
        I_VAL_ERROR     : out std_logic;
        I_VAL_DONE      : out std_logic;
        I_VAL_SHIFT     : out std_logic_vector(           CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Key Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_KEY_CODE      : out MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        O_KEY_VALID     : out std_logic;
        O_KEY_LAST      : out std_logic;
        O_KEY_ERROR     : out std_logic;
        O_KEY_READY     : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Compare Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector(          MATCH_PHASE-1 downto 0);
        MATCH_CODE      : out MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        MATCH_OK        : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        MATCH_NOT       : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        MATCH_SHIFT     : in  std_logic_vector(STORE_SIZE*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Decode Output Interface
    -------------------------------------------------------------------------------
        VALUE_START     : out std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_VALID     : out std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_CODE      : out MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        VALUE_LAST      : out std_logic;
        VALUE_ERROR     : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_DONE      : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_SHIFT     : in  std_logic_vector(STORE_SIZE*CODE_WIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Store                                                   --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Store
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        STORE_SIZE      :  positive := 8;
        MATCH_PHASE     :  positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Value Map Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(           CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Key Object Compare Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector(          MATCH_PHASE-1 downto 0);
        MATCH_CODE      : out MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        MATCH_OK        : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        MATCH_NOT       : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        MATCH_SHIFT     : in  std_logic_vector(STORE_SIZE*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Decode Output Interface
    -------------------------------------------------------------------------------
        VALUE_START     : out std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_VALID     : out std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_CODE      : out MsgPack_Object.Code_Vector( CODE_WIDTH-1 downto 0);
        VALUE_LAST      : out std_logic;
        VALUE_ERROR     : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_DONE      : in  std_logic_vector(STORE_SIZE           -1 downto 0);
        VALUE_SHIFT     : in  std_logic_vector(STORE_SIZE*CODE_WIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query_Boolean_Register                                  --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query_Boolean_Register
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        VALUE           : in  std_logic;
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query_Boolean_Array                                     --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query_Boolean_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        DATA_BITS       :  positive := 1;
        ADDR_BITS       :  positive := 32;
        SIZE_BITS       :  positive := MsgPack_Object.CODE_DATA_BITS
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector( SIZE_BITS-1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Boolean Value Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS-1 downto 0);
        ADDR            : out std_logic_vector(ADDR_BITS-1 downto 0);
        DATA            : in  std_logic_vector(DATA_BITS-1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query_Boolean_Stream                                    --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query_Boolean_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        DATA_BITS       :  positive := 1;
        SIZE_BITS       :  positive := MsgPack_Object.CODE_DATA_BITS
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector( SIZE_BITS-1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Boolean Value Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS-1 downto 0);
        DATA            : in  std_logic_vector(DATA_BITS-1 downto 0);
        STRB            : in  std_logic_vector(DATA_BITS-1 downto 0);
        LAST            : in  std_logic;
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query_Integer_Register                                  --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query_Integer_Register
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
        VALUE           : in  std_logic_vector(VALUE_BITS-1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query_Integer_Array                                     --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query_Integer_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        ADDR_BITS       :  positive := 32;
        SIZE_BITS       :  integer range 1 to 32 := 32;
        VALUE_BITS      :  integer range 1 to 64 := 32;
        VALUE_SIGN      :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector( SIZE_BITS-1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector( SIZE_BITS-1 downto 0);
        ADDR            : out std_logic_vector( ADDR_BITS-1 downto 0);
        VALUE           : in  std_logic_vector(VALUE_BITS-1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query_Integer_Stream                                    --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query_Integer_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        SIZE_BITS       :  integer range 1 to 32 := 32;
        VALUE_BITS      :  integer range 1 to 64 := 32;
        VALUE_SIGN      :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector( SIZE_BITS-1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector( SIZE_BITS-1 downto 0);
        VALUE           : in  std_logic_vector(VALUE_BITS-1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query_Binary_Array                                      --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query_Binary_Array
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        DATA_BITS       :  positive := 1;
        ADDR_BITS       :  positive := 32;
        SIZE_BITS       :  integer range 1 to 32 := 32;
        ENCODE_BINARY   :  boolean  := TRUE;
        ENCODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector(SIZE_BITS  -1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Binary/String Data Stream Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS  -1 downto 0);
        ADDR            : out std_logic_vector(ADDR_BITS  -1 downto 0);
        STRB            : out std_logic_vector(DATA_BITS/8-1 downto 0);
        LAST            : out std_logic;
        DATA            : in  std_logic_vector(DATA_BITS  -1 downto 0);
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query_Binary_Stream                                     --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query_Binary_Stream
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        KEY             :  STRING;
        CODE_WIDTH      :  positive := 1;
        MATCH_PHASE     :  positive := 8;
        DATA_BITS       :  positive := 1;
        SIZE_BITS       :  integer range 1 to 32 := 32;
        ENCODE_BINARY   :  boolean  := TRUE;
        ENCODE_STRING   :  boolean  := FALSE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Default(when parameter == nil) Query Size 
    -------------------------------------------------------------------------------
        DEFAULT_SIZE    : in  std_logic_vector(SIZE_BITS  -1 downto 0) := (others => '1');
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH -1 downto 0);
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Key Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Binary/String Data Stream Input Interface
    -------------------------------------------------------------------------------
        START           : out std_logic;
        BUSY            : out std_logic;
        SIZE            : out std_logic_vector(SIZE_BITS  -1 downto 0);
        DATA            : in  std_logic_vector(DATA_BITS  -1 downto 0);
        STRB            : in  std_logic_vector(DATA_BITS/8-1 downto 0);
        LAST            : in  std_logic;
        VALID           : in  std_logic;
        READY           : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query_Map_Value                                         --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query_Map_Value
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        STORE_SIZE      :  positive := 8;
        MATCH_PHASE     :  positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_KEY_CODE      : in  MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        I_KEY_LAST      : in  std_logic;
        I_KEY_VALID     : in  std_logic;
        I_KEY_ERROR     : out std_logic;
        I_KEY_DONE      : out std_logic;
        I_KEY_SHIFT     : out std_logic_vector(                     CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_VAL_START     : in  std_logic;
        I_VAL_ABORT     : in  std_logic;
        I_VAL_CODE      : in  MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        I_VAL_LAST      : in  std_logic;
        I_VAL_VALID     : in  std_logic;
        I_VAL_ERROR     : out std_logic;
        I_VAL_DONE      : out std_logic;
        I_VAL_SHIFT     : out std_logic_vector(                     CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Key Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_KEY_CODE      : out MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        O_KEY_VALID     : out std_logic;
        O_KEY_LAST      : out std_logic;
        O_KEY_ERROR     : out std_logic;
        O_KEY_READY     : in  std_logic;
    -------------------------------------------------------------------------------
    -- Value Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_VAL_CODE      : out MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        O_VAL_VALID     : out std_logic;
        O_VAL_LAST      : out std_logic;
        O_VAL_ERROR     : out std_logic;
        O_VAL_READY     : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Compare Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector(                    MATCH_PHASE-1 downto 0);
        MATCH_CODE      : out MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        MATCH_OK        : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        MATCH_NOT       : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        MATCH_SHIFT     : in  std_logic_vector(          STORE_SIZE*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Parameter Object Decode Output Interface
    -------------------------------------------------------------------------------
        PARAM_START     : out std_logic_vector(          STORE_SIZE           -1 downto 0);
        PARAM_VALID     : out std_logic_vector(          STORE_SIZE           -1 downto 0);
        PARAM_CODE      : out MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        PARAM_LAST      : out std_logic;
        PARAM_ERROR     : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        PARAM_DONE      : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        PARAM_SHIFT     : in  std_logic_vector(          STORE_SIZE*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Encode Input Interface
    -------------------------------------------------------------------------------
        VALUE_VALID     : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        VALUE_CODE      : in  MsgPack_Object.Code_Vector(STORE_SIZE*CODE_WIDTH-1 downto 0);
        VALUE_LAST      : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        VALUE_ERROR     : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        VALUE_READY     : out std_logic_vector(          STORE_SIZE           -1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_KVMap_Query                                                   --
-----------------------------------------------------------------------------------
component MsgPack_KVMap_Query
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        STORE_SIZE      :  positive := 8;
        MATCH_PHASE     :  positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Array Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(                     CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Key Value Map Encode Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        O_VALID         : out std_logic;
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Compare Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector(                    MATCH_PHASE-1 downto 0);
        MATCH_CODE      : out MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        MATCH_OK        : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        MATCH_NOT       : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        MATCH_SHIFT     : in  std_logic_vector(          STORE_SIZE*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Parameter Object Decode Output Interface
    -------------------------------------------------------------------------------
        PARAM_START     : out std_logic_vector(          STORE_SIZE           -1 downto 0);
        PARAM_VALID     : out std_logic_vector(          STORE_SIZE           -1 downto 0);
        PARAM_CODE      : out MsgPack_Object.Code_Vector(           CODE_WIDTH-1 downto 0);
        PARAM_LAST      : out std_logic;
        PARAM_ERROR     : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        PARAM_DONE      : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        PARAM_SHIFT     : in  std_logic_vector(          STORE_SIZE*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Object Encode Input Interface
    -------------------------------------------------------------------------------
        VALUE_VALID     : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        VALUE_CODE      : in  MsgPack_Object.Code_Vector(STORE_SIZE*CODE_WIDTH-1 downto 0);
        VALUE_LAST      : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        VALUE_ERROR     : in  std_logic_vector(          STORE_SIZE           -1 downto 0);
        VALUE_READY     : out std_logic_vector(          STORE_SIZE           -1 downto 0)
    );
end component;
end MsgPack_KVMap_Components;
-----------------------------------------------------------------------------------
--!     @file    msgpack_kvmap_key_match_aggregator.vhd
--!     @brief   MessagePack-KVMap(Key Value Map) Key Match Aggregator Module :
--!     @version 0.2.0
--!     @date    2015/11/9
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
library MsgPack;
use     MsgPack.MsgPack_Object;
entity  MsgPack_KVMap_Key_Match_Aggregator is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      : positive := 1;
        MATCH_NUM       : integer  := 1;
        MATCH_PHASE     : integer  := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Key Object Decode Input Interface
    -------------------------------------------------------------------------------
        I_KEY_VALID     : in  std_logic;
        I_KEY_CODE      : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_KEY_LAST      : in  std_logic := '0';
        I_KEY_SHIFT     : out std_logic_vector(          CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Key Object Encode Output Interface
    -------------------------------------------------------------------------------
        O_KEY_VALID     : out std_logic;
        O_KEY_CODE      : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_KEY_LAST      : out std_logic;
        O_KEY_READY     : in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- Key Object Compare Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector(         MATCH_PHASE-1 downto 0);
        MATCH_OK        : in  std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_NOT       : in  std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_SHIFT     : in  std_logic_vector(MATCH_NUM*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Aggregated Result Output
    -------------------------------------------------------------------------------
        MATCH_SEL       : out std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_STATE     : out MsgPack_Object.Match_State_Type
    );
end MsgPack_KVMap_Key_Match_Aggregator;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
architecture RTL of MsgPack_KVMap_Key_Match_Aggregator is
    constant  MATCH_ALL_0       :  std_logic_vector(  MATCH_NUM-1 downto 0) := (others => '0');
    constant  MATCH_ALL_1       :  std_logic_vector(  MATCH_NUM-1 downto 0) := (others => '1');
    constant  SHIFT_ALL_0       :  std_logic_vector( CODE_WIDTH-1 downto 0) := (others => '0');
    constant  SHIFT_ALL_1       :  std_logic_vector( CODE_WIDTH-1 downto 0) := (others => '1');
    constant  VALID_ALL_0       :  std_logic_vector( CODE_WIDTH-1 downto 0) := (others => '0');
    signal    curr_req_phase    :  std_logic_vector(MATCH_PHASE-1 downto 0);
    signal    intake_code_valid :  std_logic_vector( CODE_WIDTH-1 downto 0);
    signal    intake_code_last  :  std_logic;
    signal    intake_valid      :  std_logic;
    signal    intake_complete   :  std_logic;
    type      STATE_TYPE        is (RUN_STATE, SKIP_STATE);
    signal    curr_state        :  STATE_TYPE;
    signal    next_state        :  STATE_TYPE;
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (I_KEY_CODE, I_KEY_LAST)
        variable  i_code_valid    :  std_logic_vector(CODE_WIDTH-1 downto 0);
        variable  i_code_complete :  std_logic_vector(CODE_WIDTH-1 downto 0);
        variable  o_code_valid    :  std_logic_vector(CODE_WIDTH-1 downto 0);
        variable  valid_on        :  boolean;
    begin
        for i in 0 to CODE_WIDTH-1 loop
            i_code_valid   (i) := I_KEY_CODE(i).valid;
            i_code_complete(i) := I_KEY_CODE(i).complete;
        end loop;

        valid_on := TRUE;
        for i in 0 to CODE_WIDTH-1 loop
            if (valid_on) then
                o_code_valid(i) := i_code_valid(i);
                if (i_code_valid(i) = '1' and i_code_complete(i) = '1') then
                    valid_on := FALSE;
                end if;
            else
                o_code_valid(i) := '0';
            end if;
        end loop;

        if (I_KEY_LAST = '1') or
           ((i_code_valid and i_code_complete) /= VALID_ALL_0) then
            intake_complete <= '1';
            intake_valid    <= i_code_valid(intake_code_valid'low );
        else
            intake_complete <= '0';
            intake_valid    <= i_code_valid(intake_code_valid'high);
        end if;
            
        intake_code_valid <= o_code_valid;

        if (I_KEY_LAST = '1') and
           ((i_code_valid and not o_code_valid) = VALID_ALL_0) then
            intake_code_last <= '1';
        else
            intake_code_last <= '0';
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (curr_state, curr_req_phase,
             I_KEY_VALID, intake_valid, intake_code_valid, intake_code_last, intake_complete,
             MATCH_OK, MATCH_NOT, O_KEY_READY)
    begin
        case curr_state is
            when RUN_STATE => 
                if (I_KEY_VALID = '1') then
                    if    (O_KEY_READY = '0') then
                            MATCH_STATE <= MsgPack_Object.MATCH_BUSY_STATE;
                            I_KEY_SHIFT <= SHIFT_ALL_0;
                            next_state  <= RUN_STATE;
                    elsif (MATCH_OK  /= MATCH_ALL_0) then
                        if (intake_code_last = '1') then
                            MATCH_STATE <= MsgPack_Object.MATCH_DONE_FOUND_LAST_STATE;
                            I_KEY_SHIFT <= intake_code_valid;
                            next_state  <= RUN_STATE;
                        else
                            MATCH_STATE <= MsgPack_Object.MATCH_DONE_FOUND_CONT_STATE;
                            I_KEY_SHIFT <= intake_code_valid;
                            next_state  <= RUN_STATE;
                        end if;
                    elsif ((curr_req_phase(curr_req_phase'high) = '1') and intake_valid = '1') or
                          ((MATCH_NOT /= MATCH_ALL_0) and
                           ((MATCH_OK or MATCH_NOT) = MATCH_ALL_1)) then
                        if    (intake_complete  = '0') then
                            MATCH_STATE <= MsgPack_Object.MATCH_BUSY_NOT_FOUND_STATE;
                            I_KEY_SHIFT <= intake_code_valid;
                            next_state  <= SKIP_STATE;
                        elsif (intake_code_last = '1') then
                            MATCH_STATE <= MsgPack_Object.MATCH_DONE_NOT_FOUND_LAST_STATE;
                            I_KEY_SHIFT <= intake_code_valid;
                            next_state  <= RUN_STATE;
                        else
                            MATCH_STATE <= MsgPack_Object.MATCH_DONE_NOT_FOUND_CONT_STATE;
                            I_KEY_SHIFT <= intake_code_valid;
                            next_state  <= RUN_STATE;
                        end if;
                    else
                            MATCH_STATE <= MsgPack_Object.MATCH_BUSY_STATE;
                            I_KEY_SHIFT <= intake_code_valid;
                            next_state  <= RUN_STATE;
                    end if;
                else
                            MATCH_STATE <= MsgPack_Object.MATCH_IDLE_STATE;
                            I_KEY_SHIFT <= SHIFT_ALL_0;
                            next_state  <= RUN_STATE;
                end if;
            when SKIP_STATE =>
                if (I_KEY_VALID = '1') then
                    if    (O_KEY_READY = '0') then
                            MATCH_STATE <= MsgPack_Object.MATCH_BUSY_NOT_FOUND_STATE;
                            I_KEY_SHIFT <= SHIFT_ALL_0;
                            next_state  <= SKIP_STATE;
                    elsif (intake_complete = '0') then
                            MATCH_STATE <= MsgPack_Object.MATCH_BUSY_NOT_FOUND_STATE;
                            I_KEY_SHIFT <= intake_code_valid;
                            next_state  <= SKIP_STATE;
                    elsif (intake_code_last = '1') then
                            MATCH_STATE <= MsgPack_Object.MATCH_DONE_NOT_FOUND_LAST_STATE;
                            I_KEY_SHIFT <= intake_code_valid;
                            next_state  <= RUN_STATE;
                    else
                            MATCH_STATE <= MsgPack_Object.MATCH_DONE_NOT_FOUND_CONT_STATE;
                            I_KEY_SHIFT <= intake_code_valid;
                            next_state  <= RUN_STATE;
                    end if;
                else
                            MATCH_STATE <= MsgPack_Object.MATCH_IDLE_STATE;
                            I_KEY_SHIFT <= SHIFT_ALL_0;
                            next_state  <= RUN_STATE;
                end if;
            when others => 
                            MATCH_STATE <= MsgPack_Object.MATCH_IDLE_STATE;
                            I_KEY_SHIFT <= SHIFT_ALL_0;
                            next_state  <= RUN_STATE;
        end case;
    end process;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    MATCH_SEL  <= MATCH_OK;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    MATCH_REQ  <= curr_req_phase when (I_KEY_VALID = '1') and
                                      (curr_state = RUN_STATE) else (others => '0');
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    process(CLK, RST) begin
        if (RST = '1') then
                curr_req_phase <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') or
               (I_KEY_VALID = '0') then
                curr_req_phase <= (0 => '1', others => '0');
            elsif (curr_state = RUN_STATE and intake_valid = '1' and O_KEY_READY = '1') then
                for i in curr_req_phase'range loop
                    if (i > 0) then
                        curr_req_phase(i) <= curr_req_phase(i-1);
                    else
                        curr_req_phase(i) <= '0';
                    end if;
                end loop;
             end if ;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    process(CLK, RST) begin
        if (RST = '1') then
                curr_state <= RUN_STATE;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_state <= RUN_STATE;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (I_KEY_CODE, intake_code_valid) begin
        for i in O_KEY_CODE'range loop
            O_KEY_CODE(i)       <= I_KEY_CODE(i);
            O_KEY_CODE(i).valid <= intake_code_valid(i);
        end loop;
    end process;
    O_KEY_VALID <= '1' when (intake_valid    = '1' and I_KEY_VALID = '1') else '0';
    O_KEY_LAST  <= '1' when (intake_complete = '1' and I_KEY_VALID = '1') else '0';
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_object_code_compare.vhd
--!     @brief   MessagePack Object Code Compare Module :
--!     @version 0.2.0
--!     @date    2016/6/24
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
library MsgPack;
use     MsgPack.MsgPack_Object;
entity  MsgPack_Object_Code_Compare is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        C_WIDTH         : positive := 1;
        I_WIDTH         : positive := 1;
        I_MAX_PHASE     : positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Input Object Code Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(I_WIDTH-1 downto 0);
        I_REQ_PHASE     : in  std_logic_vector(I_MAX_PHASE-1 downto 0);
    -------------------------------------------------------------------------------
    -- Comparison Object Code Interface
    -------------------------------------------------------------------------------
        C_CODE          : in  MsgPack_Object.Code_Vector(C_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Compare Result Output 
    -------------------------------------------------------------------------------
        MATCH           : out std_logic;
        MISMATCH        : out std_logic;
        SHIFT           : out std_logic_vector(I_WIDTH-1 downto 0)
    );
end MsgPack_Object_Code_Compare;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
architecture RTL of MsgPack_Object_Code_Compare is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  LAST_PHASE        :  integer := (C_WIDTH+I_WIDTH-1)/I_WIDTH - 1;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    subtype   SHIFT_TYPE        is std_logic_vector(I_WIDTH-1 downto 0);
    subtype   CCODE_TYPE        is MsgPack_Object.Code_Vector(I_WIDTH-1 downto 0);
    type      SHIFT_VECTOR      is array (integer range <>) of SHIFT_TYPE;
    type      CCODE_VECTOR      is array (integer range <>) of CCODE_TYPE;
    signal    comp_code_vec     :  CCODE_VECTOR(LAST_PHASE downto 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    procedure COMPARE_CODE(
                  I_CODE        :  in  MsgPack_Object.Code_Type;
                  C_CODE        :  in  MsgPack_Object.Code_Type;
                  MATCH         :  out std_logic;
                  MISMATCH      :  out std_logic;
                  UNRELATED     :  out std_logic;
                  PENDING       :  out std_logic
    ) is
    begin
        if    (I_CODE.valid = '1' and C_CODE.valid = '1') then
            case C_CODE.class is
                when MsgPack_Object.CLASS_NIL | MsgPack_Object.CLASS_RESERVE =>
                    if (I_CODE.class = C_CODE.class) then
                        MATCH    := '1';
                        MISMATCH := '0';
                    else
                        MATCH    := '0';
                        MISMATCH := '1';
                    end if;
                when MsgPack_Object.CLASS_BOOLEAN =>
                    if (I_CODE.class   = C_CODE.class) and
                       (I_CODE.data(0) = C_CODE.data(0)) then
                        MATCH    := '1';
                        MISMATCH := '0';
                    else
                        MATCH    := '0';
                        MISMATCH := '1';
                    end if;
                when MsgPack_Object.CLASS_EXT_TYPE =>
                    if (I_CODE.class            = C_CODE.class           ) and
                       (I_CODE.complete         = C_CODE.complete        ) and 
                       (I_CODE.data(7 downto 0) = C_CODE.data(7 downto 0)) then
                        MATCH    := '1';
                        MISMATCH := '0';
                    else
                        MATCH    := '0';
                        MISMATCH := '1';
                    end if;
                when MsgPack_Object.CLASS_STRING_DATA |
                     MsgPack_Object.CLASS_BINARY_DATA |
                     MsgPack_Object.CLASS_EXT_DATA    =>
                    if (I_CODE.class    = C_CODE.class   ) and
                       (I_CODE.complete = C_CODE.complete) and 
                       (I_CODE.strb     = C_CODE.strb    ) then
                        MATCH    := '1';
                        MISMATCH := '0';
                        for i in 0 to MsgPack_Object.CODE_STRB_BITS-1 loop
                            if (I_CODE.strb(i) = '1') and
                               (I_CODE.data(8*(i+1)-1 downto 8*i) /= C_CODE.data(8*(i+1)-1 downto 8*i)) then
                                MATCH    := '0';
                                MISMATCH := '1';
                            end if;
                        end loop;
                    else
                        MATCH    := '0';
                        MISMATCH := '1';
                    end if;
                when others =>
                    if (I_CODE.class    = C_CODE.class   ) and
                       (I_CODE.complete = C_CODE.complete) and 
                       (I_CODE.data     = C_CODE.data    ) then
                        MATCH    := '1';
                        MISMATCH := '0';
                    else
                        MATCH    := '0';
                        MISMATCH := '1';
                    end if;
            end case;
            UNRELATED := '0';
            PENDING   := '0';
        elsif (I_CODE.valid = '0' and C_CODE.valid = '1') then
            MATCH     := '0';
            MISMATCH  := '0';
            UNRELATED := '0';
            PENDING   := '1';
        else
            MATCH     := '0';
            MISMATCH  := '0';
            UNRELATED := '1';
            PENDING   := '0';
        end if;
    end procedure;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    procedure COMPARE_CODE_VECTER(
                  I_CODE        :  in  MsgPack_Object.Code_Vector(I_WIDTH-1 downto 0);
                  C_CODE        :  in  MsgPack_Object.Code_Vector(I_WIDTH-1 downto 0);
                  SHIFT         :  out SHIFT_TYPE;
                  MATCH         :  out std_logic;
                  MISMATCH      :  out std_logic
    ) is
        variable  match_vec     :      std_logic_vector(I_WIDTH-1 downto 0);
        variable  mismatch_vec  :      std_logic_vector(I_WIDTH-1 downto 0);
        variable  unrelated_vec :      std_logic_vector(I_WIDTH-1 downto 0);
        variable  pending_vec   :      std_logic_vector(I_WIDTH-1 downto 0);
        constant  ALL_1         :      std_logic_vector(I_WIDTH-1 downto 0) := (others => '1');
        constant  ALL_0         :      std_logic_vector(I_WIDTH-1 downto 0) := (others => '0');
    begin
        for i in 0 to I_WIDTH-1 loop
            COMPARE_CODE(
                  I_CODE        => I_CODE       (i),
                  C_CODE        => C_CODE       (i),
                  MATCH         => match_vec    (i),
                  MISMATCH      => mismatch_vec (i),
                  UNRELATED     => unrelated_vec(i),
                  PENDING       => pending_vec  (i)
            );
        end loop;
        if  (match_vec /= ALL_0) and
            ((match_vec or unrelated_vec) = ALL_1) then
            SHIFT    := match_vec;
            MATCH    := '1';
        else
            SHIFT    := (others => '0');
            MATCH    := '0';
        end if;
        if (mismatch_vec /= ALL_0) then
            MISMATCH := '1';
        else
            MISMATCH := '0';
        end if;
    end procedure;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    ack_match    :  std_logic;
    signal    ack_mismatch :  std_logic;
    signal    ack_shift    :  std_logic_vector(I_WIDTH-1 downto 0);
    signal    mismatched   :  boolean;
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (C_CODE) begin
        for phase in 0 to LAST_PHASE loop
            for word_pos in 0 to I_WIDTH-1 loop
                if (phase*I_WIDTH+word_pos <= C_CODE'high) then
                    comp_code_vec(phase)(word_pos) <= C_CODE(phase*I_WIDTH+word_pos);
                else
                    comp_code_vec(phase)(word_pos) <= MsgPack_Object.CODE_NULL;
                end if;
            end loop;
        end loop;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (I_CODE, I_REQ_PHASE, comp_code_vec, mismatched)
        variable  comp_shift     :  SHIFT_VECTOR    (I_MAX_PHASE-1 downto 0);
        variable  comp_match     :  std_logic_vector(I_MAX_PHASE-1 downto 0);
        variable  comp_mismatch  :  std_logic_vector(I_MAX_PHASE-1 downto 0);
        variable  temp_shift     :  SHIFT_VECTOR    (I_MAX_PHASE-1 downto 0);
        variable  temp_match     :  std_logic_vector(I_MAX_PHASE-1 downto 0);
        variable  temp_mismatch  :  std_logic_vector(I_MAX_PHASE-1 downto 0);
        variable  phase_shift    :  SHIFT_TYPE;
        variable  phase_match    :  std_logic;
        variable  phase_mismatch :  std_logic;
    begin
        for i in 0 to I_MAX_PHASE-1 loop
            if (i <= LAST_PHASE) then
                COMPARE_CODE_VECTER(               -- 
                    I_CODE   => I_CODE          ,  -- In  :
                    C_CODE   => comp_code_vec(i),  -- In  :
                    SHIFT    => comp_shift   (i),  -- Out :
                    MATCH    => comp_match   (i),  -- Out :
                    MISMATCH => comp_mismatch(i)   -- Out :
                );
            else
                comp_match   (i) := '0';
                comp_mismatch(i) := '0';
                comp_shift   (i) := (others => '0');
            end if;
        end loop;
        for i in 0 to I_MAX_PHASE-1 loop
            if (i > 0 and mismatched) or
               (i > LAST_PHASE      ) then
                temp_match   (i) := '0';
                temp_mismatch(i) := '1';
                temp_shift   (i) := (others => '0');
            else
                temp_match   (i) := comp_match   (i);
                temp_mismatch(i) := comp_mismatch(i);
                temp_shift   (i) := comp_shift   (i);
            end if;
        end loop;
        phase_shift    := (others => '0');
        phase_match    := '0';
        phase_mismatch := '0';
        for i in 0 to I_MAX_PHASE-1 loop
            if (I_REQ_PHASE(i) = '1' and i = LAST_PHASE) then
                phase_match    := phase_match    or temp_match(i);
                phase_shift    := phase_shift    or temp_shift(i);
            end if;
            if (I_REQ_PHASE(i) = '1') then
                phase_mismatch := phase_mismatch or temp_mismatch(i);
            end if;
        end loop;
        ack_shift    <= phase_shift;
        ack_match    <= phase_match;
        ack_mismatch <= phase_mismatch;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                mismatched <= FALSE;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                mismatched <= FALSE;
            elsif (I_REQ_PHASE(0) = '1') then
                mismatched <= (ack_mismatch = '1');
            else
                mismatched <= (ack_mismatch = '1' or mismatched);
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    MATCH    <= ack_match;
    MISMATCH <= ack_mismatch;
    SHIFT    <= ack_shift;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_object_code_fifo.vhd
--!     @brief   MessagePack Object Code FIFO
--!     @version 0.2.0
--!     @date    2015/11/9
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
library MsgPack;
use     MsgPack.MsgPack_Object;
entity  MsgPack_Object_Code_FIFO is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        WIDTH           :  positive := 1;
        DEPTH           :  positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end MsgPack_Object_Code_FIFO;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
architecture RTL of MsgPack_Object_Code_FIFO is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    subtype   CODE_BITS_TYPE  is std_logic_vector(39 downto 0);
    function  to_bits(CODE: MsgPack_Object.Code_Type) return CODE_BITS_TYPE
    is
        variable  word :  CODE_BITS_TYPE;
    begin
        word(31 downto 0 ) := CODE.data;
        word(35 downto 32) := CODE.class;
        if (CODE.valid = '0') then
            word(39 downto 36) := "0000";
        else
            word(39) := CODE.complete;
            if    (CODE.STRB(3) = '1') then
                word(38 downto 36) := "111";
            elsif (CODE.STRB(2) = '1') then
                word(38 downto 36) := "110";
            elsif (CODE.STRB(1) = '1') then
                word(38 downto 36) := "101";
            elsif (CODE.STRB(0) = '1') then
                word(38 downto 36) := "100";
            else
                word(38 downto 36) := "011";
            end if;
        end if;
        return word;
    end function;
    function  to_code(WORD: CODE_BITS_TYPE) return MsgPack_Object.Code_Type is
        variable  code :  MsgPack_Object.Code_Type;
    begin
        code.data    := WORD(31 downto  0);
        code.class   := WORD(35 downto 32);
        if (WORD(39 downto 36) = "0000") then
            code.valid    := '0';
            code.complete := '0';
            code.strb     := "0000";
        else
            code.valid    := '1';
            code.complete := WORD(39);
            if    (WORD(38 downto 36) = "111") then
                code.strb := "1111";
            elsif (WORD(38 downto 36) = "110") then
                code.strb := "0111";
            elsif (WORD(38 downto 36) = "101") then
                code.strb := "0011";
            elsif (WORD(38 downto 36) = "100") then
                code.strb := "0001";
            else
                code.strb := "0000";
            end if;
        end if;
        return code;
    end function;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  WORD_BITS       :  integer := 40*WIDTH;
    subtype   WORD_TYPE       is std_logic_vector(WORD_BITS-1 downto 0);
    function  to_word(CODE_VEC:  MsgPack_Object.Code_Vector) return WORD_TYPE is
        alias     i_code_vec  :  MsgPack_Object.Code_Vector(WIDTH-1 downto 0) is CODE_VEC;
        variable  word        :  WORD_TYPE;
    begin 
        for i in 0 to WIDTH-1 loop
            word(40*(i+1)-1 downto 40*i) := to_bits(i_code_vec(i));
        end loop;
        return word;
    end function;
    function  to_code(WORD: std_logic_vector) return MsgPack_Object.Code_Vector is
        variable  code_vec    :  MsgPack_Object.Code_Vector(WIDTH-1 downto 0);
    begin
        for i in 0 to WIDTH-1 loop
            code_vec(i) := to_code(word(40*(i+1)-1 downto 40*i));
        end loop;
        return code_vec;
    end function;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    intake_ready    :  boolean;
    signal    outlet_valid    :  boolean;
    signal    outlet_last     :  boolean;
    signal    outlet_done     :  boolean;
    signal    wait_last       :  boolean;
    signal    curr_counter    :  unsigned(DEPTH   downto 0);
    signal    next_counter    :  unsigned(DEPTH   downto 0);
    signal    curr_wr_ptr     :  unsigned(DEPTH-1 downto 0);
    signal    next_wr_ptr     :  unsigned(DEPTH-1 downto 0);
    signal    curr_rd_ptr     :  unsigned(DEPTH-1 downto 0);
    signal    next_rd_ptr     :  unsigned(DEPTH-1 downto 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type     RAM_TYPE         is array(integer range <>) of std_logic_vector(WORD_BITS-1 downto 0);
    signal   ram              :  RAM_TYPE(0 to 2**DEPTH-1);
    signal   ram_we           :  std_logic;
    signal   ram_waddr        :  std_logic_vector(DEPTH-1 downto 0);
    signal   ram_raddr        :  std_logic_vector(DEPTH-1 downto 0);
    signal   ram_wdata        :  std_logic_vector(WORD_BITS-1 downto 0);
    signal   ram_rdata        :  std_logic_vector(WORD_BITS-1 downto 0);
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    I_READY <= '1' when (intake_ready) else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    outlet_done <= (outlet_last and next_counter = 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (curr_counter, I_VALID, intake_ready, outlet_valid, O_READY)
        variable  temp_counter :  unsigned(DEPTH downto 0);
    begin
        temp_counter := curr_counter;
        if (I_VALID = '1' and intake_ready = TRUE) then
            temp_counter := temp_counter + 1;
        end if;
        if (outlet_valid = TRUE and O_READY = '1') then
            temp_counter := temp_counter - 1;
        end if;
        next_counter <= temp_counter;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (curr_wr_ptr, I_VALID, intake_ready) begin
        if (I_VALID = '1' and intake_ready = TRUE) then
            next_wr_ptr <= to_01(curr_wr_ptr) + 1;
        else
            next_wr_ptr <= to_01(curr_wr_ptr);
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (curr_rd_ptr, outlet_valid, O_READY) begin
        if (outlet_valid = TRUE and O_READY = '1') then
            next_rd_ptr <= to_01(curr_rd_ptr) + 1;
        else
            next_rd_ptr <= to_01(curr_rd_ptr);
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST)
        variable   next_last :  boolean;
    begin
        if   (RST = '1') then
                curr_counter <= (others => '0');
                curr_wr_ptr  <= (others => '0');
                curr_rd_ptr  <= (others => '0');
                intake_ready <= FALSE;
                wait_last    <= FALSE;
                outlet_valid <= FALSE;
                outlet_last  <= FALSE;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_counter <= (others => '0');
                curr_wr_ptr  <= (others => '0');
                curr_rd_ptr  <= (others => '0');
                intake_ready <= FALSE;
                wait_last    <= FALSE;
                outlet_valid <= FALSE;
                outlet_last  <= FALSE;
            else
                if (outlet_done = TRUE) then
                    curr_counter <= (others => '0');
                    curr_wr_ptr  <= (others => '0');
                    curr_rd_ptr  <= (others => '0');
                else
                    curr_counter <= next_counter;
                    curr_wr_ptr  <= next_wr_ptr;
                    curr_rd_ptr  <= next_rd_ptr;
                end if;

                if (outlet_done = TRUE) then
                    next_last    := FALSE;
                    wait_last    <= FALSE;
                    intake_ready <= TRUE;
                elsif (wait_last = TRUE) or
                      (I_VALID = '1' and I_LAST = '1' and intake_ready = TRUE) then
                    next_last    := TRUE;
                    wait_last    <= TRUE;
                    intake_ready <= FALSE;
                else
                    next_last    := FALSE;
                    wait_last    <= FALSE;
                    intake_ready <= (next_counter(next_counter'high) = '0');
                end if;

                outlet_last  <= (next_counter = 1 and next_last = TRUE);
                outlet_valid <= (next_counter > 0) and
                                (not (ram_we = '1' and ram_waddr = ram_raddr));
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    ram_waddr <= std_logic_vector(curr_wr_ptr);
    ram_raddr <= std_logic_vector(next_rd_ptr);
    ram_we    <= '1' when (I_VALID = '1' and intake_ready = TRUE) else '0';
    ram_wdata <= to_word(I_CODE);
    process (CLK) begin
        if (CLK'event and CLK = '1') then
            if (ram_we = '1') then
                ram(to_integer(to_01(unsigned(ram_waddr)))) <= ram_wdata;
            end if;
            ram_rdata <= ram(to_integer(to_01(unsigned(ram_raddr))));
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    O_CODE  <= to_code(ram_rdata);
    O_VALID <= '1' when (outlet_valid) else '0';
    O_LAST  <= '1' when (outlet_last ) else '0';
            
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_object_encode_string_constant.vhd
--!     @brief   MessagePack Object encode string constant :
--!     @version 0.2.0
--!     @date    2015/11/9
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
library MsgPack;
use     MsgPack.MsgPack_Object;
entity  MsgPack_Object_Encode_String_Constant is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        VALUE           : string;
        CODE_WIDTH      : positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Control and Status Signals 
    -------------------------------------------------------------------------------
        START           : in  std_logic := '1';
        BUSY            : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_ERROR         : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end MsgPack_Object_Encode_String_Constant;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
architecture RTL of MsgPack_Object_Encode_String_Constant is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  CODE_DATA_BYTES    :  integer := MsgPack_Object.CODE_DATA_BYTES;
    constant  STR_CODE_SIZE      :  integer := (VALUE'length+CODE_DATA_BYTES-1)/CODE_DATA_BYTES + 1;
    constant  PHASE_NUM          :  integer := (STR_CODE_SIZE+CODE_WIDTH-1)/CODE_WIDTH;
    constant  PHASE_MAX          :  integer := PHASE_NUM - 1;
    constant  STR_CODE_WIDTH     :  integer := PHASE_NUM*CODE_WIDTH;
    constant  STR_CODE           :  MsgPack_Object.Code_Vector(STR_CODE_WIDTH-1 downto 0)
                                 := MsgPack_Object.New_Code_Vector_String(STR_CODE_WIDTH, VALUE);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    curr_phase         :  integer range 0 to PHASE_MAX;
    signal    last_phase         :  boolean;
    type      STATE_TYPE         is (IDLE_STATE, RUN_STATE);
    signal    curr_state         :  STATE_TYPE;
    signal    curr_code          :  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST)
        variable  next_phase     :  integer range 0 to PHASE_MAX;
        variable  next_code      :  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
    begin
        if (RST = '1') then
                curr_state <= IDLE_STATE;
                curr_phase <= 0;
                last_phase <= false;
                curr_code  <= (others => MsgPack_Object.CODE_NULL);
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_state <= IDLE_STATE;
                curr_phase <= 0;
                last_phase <= false;
                curr_code  <= (others => MsgPack_Object.CODE_NULL);
            else
                case curr_state is
                    when IDLE_STATE =>
                        if (START = '1') then
                            curr_state <= RUN_STATE;
                        else
                            curr_state <= IDLE_STATE;
                        end if;
                        next_phase := 0;
                    when RUN_STATE =>
                        if (last_phase = TRUE  and O_READY = '1') then
                            curr_state <= IDLE_STATE;
                        else
                            curr_state <= RUN_STATE;
                        end if;
                        if (last_phase = FALSE and O_READY = '1') then
                            next_phase := curr_phase + 1;
                        else
                            next_phase := curr_phase;
                        end if;
                    when others =>
                            curr_state <= IDLE_STATE;
                            next_phase := 0;
                end case;
                next_code  := (others => MsgPack_Object.CODE_NULL);
                for i in 0 to PHASE_MAX loop
                    if (i = next_phase) then
                        next_code(CODE_WIDTH-1 downto 0) := STR_CODE(CODE_WIDTH*(i+1)-1 downto CODE_WIDTH*i);
                    end if;
                end loop;
                curr_code  <= next_code;
                last_phase <= (next_phase >= PHASE_MAX);
                curr_phase <= next_phase;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    BUSY    <= '1' when (curr_state = RUN_STATE) else '0';
    O_VALID <= '1' when (curr_state = RUN_STATE) else '0';
    O_LAST  <= '1' when (last_phase = TRUE     ) else '0';
    O_ERROR <= '0';
    O_CODE  <= curr_code;
end RTL;
                
-----------------------------------------------------------------------------------
--!     @file    msgpack_object_match_aggregator.vhd
--!     @brief   MessagePack Object Match Aggregator Module :
--!     @version 0.2.0
--!     @date    2015/11/9
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
library MsgPack;
use     MsgPack.MsgPack_Object;
entity  MsgPack_Object_Match_Aggregator is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH         : positive := 1;
        MATCH_NUM       : integer  := 1;
        MATCH_PHASE     : integer  := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_VALID         : in  std_logic;
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic := '0';
        I_SHIFT         : out std_logic_vector(          CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Phase Control Status Signals
    -------------------------------------------------------------------------------
        PHASE_NEXT      : out std_logic;
        PHASE_READY     : in  std_logic := '1';
    -------------------------------------------------------------------------------
    -- Object Code Compare Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector(         MATCH_PHASE-1 downto 0);
        MATCH_OK        : in  std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_NOT       : in  std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_SHIFT     : in  std_logic_vector(MATCH_NUM*CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Aggregated Result Output
    -------------------------------------------------------------------------------
        MATCH_SEL       : out std_logic_vector(MATCH_NUM           -1 downto 0);
        MATCH_STATE     : out MsgPack_Object.Match_State_Type
    );
end MsgPack_Object_Match_Aggregator;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
architecture RTL of MsgPack_Object_Match_Aggregator is
    constant  MATCH_ALL_0   :  std_logic_vector( MATCH_NUM-1 downto 0) := (others => '0');
    constant  MATCH_ALL_1   :  std_logic_vector( MATCH_NUM-1 downto 0) := (others => '1');
    constant  SHIFT_ALL_0   :  std_logic_vector(CODE_WIDTH-1 downto 0) := (others => '0');
    constant  SHIFT_ALL_1   :  std_logic_vector(CODE_WIDTH-1 downto 0) := (others => '1');
    constant  VALID_ALL_0   :  std_logic_vector(CODE_WIDTH-1 downto 0) := (others => '0');
    signal    i_phase_next  :  std_logic;
    signal    curr_phase    :  std_logic_vector(MATCH_PHASE-1 downto 0);
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (I_VALID, I_CODE, I_LAST, MATCH_OK, MATCH_NOT, MATCH_SHIFT, PHASE_READY, curr_phase)
        variable  i_match_shift :  std_logic_vector(CODE_WIDTH-1 downto 0);
        variable  i_code_valid  :  std_logic_vector(CODE_WIDTH-1 downto 0);
    begin
        i_match_shift := (others => '0');
        for i in 0 to MATCH_NUM-1 loop
            i_match_shift := i_match_shift or MATCH_SHIFT(CODE_WIDTH*(i+1)-1 downto CODE_WIDTH*i);
        end loop;
        for i in 0 to CODE_WIDTH-1 loop
            i_code_valid(i) := I_CODE(i).valid;
        end loop;
        if (I_VALID = '1') then
            if    (PHASE_READY = '0') then
                MATCH_STATE  <= MsgPack_Object.MATCH_BUSY_STATE;
                I_SHIFT      <= SHIFT_ALL_0;
                i_phase_next <= '0';
            elsif (MATCH_OK  /= MATCH_ALL_0) then
                if (I_LAST = '1' and ((i_code_valid and not i_match_shift) = VALID_ALL_0)) then
                    MATCH_STATE <= MsgPack_Object.MATCH_DONE_FOUND_LAST_STATE;
                else
                    MATCH_STATE <= MsgPack_Object.MATCH_DONE_FOUND_CONT_STATE;
                end if;
                I_SHIFT      <= i_match_shift;
                i_phase_next <= '0';
            elsif (curr_phase(curr_phase'high) = '1' and i_code_valid(i_code_valid'high) = '1') or
                  (I_LAST = '1') or
                  ((MATCH_NOT /= MATCH_ALL_0) and
                   ((MATCH_OK or MATCH_NOT) = MATCH_ALL_1)) then
                MATCH_STATE  <= MsgPack_Object.MATCH_DONE_NOT_FOUND_CONT_STATE;
                I_SHIFT      <= SHIFT_ALL_0;
                i_phase_next <= '0';
            elsif (i_code_valid(i_code_valid'high) = '1') then
                MATCH_STATE  <= MsgPack_Object.MATCH_BUSY_STATE;
                I_SHIFT      <= SHIFT_ALL_1;
                i_phase_next <= '1';
            else
                MATCH_STATE  <= MsgPack_Object.MATCH_BUSY_STATE;
                I_SHIFT      <= SHIFT_ALL_0;
                i_phase_next <= '0';
            end if;
        else
                MATCH_STATE  <= MsgPack_Object.MATCH_IDLE_STATE;
                I_SHIFT      <= SHIFT_ALL_0;
                i_phase_next <= '0';
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    MATCH_SEL  <= MATCH_OK;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    MATCH_REQ  <= curr_phase when (I_VALID = '1') else (others => '0');
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    PHASE_NEXT <= i_phase_next;
    -------------------------------------------------------------------------------
    -- 
    -------------------------------------------------------------------------------
    process(CLK, RST) begin
        if (RST = '1') then
                curr_phase <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') or
               (I_VALID = '0') then
                curr_phase <= (0 => '1', others => '0');
            elsif (i_phase_next = '1') then
                for i in curr_phase'range loop
                    if (i > 0) then
                        curr_phase(i) <= curr_phase(i-1);
                    else
                        curr_phase(i) <= '0';
                    end if;
                end loop;
             end if ;
        end if;
    end process;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_object_packer.vhd
--!     @brief   MessagePack Object Code Pack to Byte Stream Module :
--!     @version 0.2.0
--!     @date    2015/11/9
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
library MsgPack;
use     MsgPack.MsgPack_Object;
-----------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------
entity  MsgPack_Object_Packer is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      : positive := 1;
        O_BYTES         : positive := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_SHIFT         : out std_logic_vector(          CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Byte Stream Output Interface
    -------------------------------------------------------------------------------
        O_DATA          : out std_logic_vector(           8*O_BYTES-1 downto 0);
        O_STRB          : out std_logic_vector(             O_BYTES-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end MsgPack_Object_Packer;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.PipeWork_Components.REDUCER;
architecture RTL of MsgPack_Object_Packer is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function   max(A,B:integer) return integer is begin
        if (A > B) then return A;
        else            return B;
        end if;
    end function;
    constant   BUFFER_WORDS      :  integer := max(3, CODE_WIDTH);
    constant   BUFFER_BYTES      :  integer := BUFFER_WORDS*4+1;
    signal     intake_code       :  MsgPack_Object.Code_Vector(BUFFER_WORDS-1 downto 0);
    signal     intake_valid      :  std_logic_vector       (BUFFER_WORDS-1 downto 0);
    signal     intake_shift      :  std_logic_vector       (BUFFER_WORDS-1 downto 0);
    signal     intake_last       :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant   ENCODE_WIDTH      :  integer := CODE_WIDTH;
    constant   ENCODE_BYTES      :  integer := CODE_WIDTH*4;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant   OUTLET_BYTES      :  integer := ENCODE_BYTES+1;
    constant   outlet_offset     :  std_logic_vector(       O_BYTES-1 downto 0) := (others => '0');
    signal     outlet_strb       :  std_logic_vector(  BUFFER_BYTES-1 downto 0);
    signal     outlet_data       :  std_logic_vector(8*BUFFER_BYTES-1 downto 0);
    signal     outlet_last       :  std_logic;
    signal     outlet_valid      :  std_logic;
    signal     outlet_ready      :  std_logic;
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    INTAKE: block
    begin
        process (I_CODE) begin
            for i in 0 to BUFFER_WORDS-1 loop
                if (i < CODE_WIDTH) then
                    intake_code (i) <= I_CODE(i);
                    intake_valid(i) <= I_CODE(i).valid;
                else
                    intake_code (i) <= MsgPack_Object.CODE_NULL;
                    intake_valid(i) <= '0';
                end if;
            end loop;
        end process;
        I_SHIFT     <= intake_shift(CODE_WIDTH-1 downto 0);
        intake_last <= I_LAST;
    end block;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    ENCODE: block
        type      STATE_TYPE  is(FIRST_STATE,
                                 ERROR_STATE,
                                 UINT64_STATE,
                                 INT64_STATE,
                                 FLOAT64_STATE,
                                 STR_DATA_STATE,
                                 BIN_DATA_STATE,
                                 EXT_DATA_STATE,
                                 EXT_TYPE_NONE_DATA_STATE,
                                 EXT_TYPE_WITH_DATA_STATE);
        signal    next_state  :  STATE_TYPE;
        signal    curr_state  :  STATE_TYPE;
    begin
        process (curr_state, intake_code, intake_last, intake_valid, outlet_ready)
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            type      ENCODE_TYPE     is record
                          data    :  std_logic_vector(8*BUFFER_BYTES-1 downto 0);
                          strb    :  std_logic_vector(  BUFFER_BYTES-1 downto 0);
                          valid   :  std_logic;
                          last    :  std_logic;
                          shift   :  std_logic_vector(  BUFFER_WORDS-1 downto 0);
            end record;
            constant  ENC_NULL    :  ENCODE_TYPE := (
                          data    => (others => '0'),
                          strb    => (others => '0'),
                          valid   => '0',
                          last    => '0',
                          shift   => (others => '0'));
            variable  enc         :  ENCODE_TYPE;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            function  to_enc_strb(size: integer) return std_logic_vector is
                variable strb  : std_logic_vector(BUFFER_BYTES-1 downto 0);
            begin
                for i in strb'range loop
                    if (i < size) then
                        strb(i) := '1';
                    else
                        strb(i) := '0';
                    end if;
                end loop;
                return strb;
            end function;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            function  to_enc_shift(size: integer) return std_logic_vector is
                variable ready : std_logic_vector(BUFFER_WORDS-1 downto 0);
            begin
                for i in ready'range loop
                    if (i < size) then
                        ready(i) := '1';
                    else
                        ready(i) := '0';
                    end if;
                end loop;
                return ready;
            end function;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            function to_enc_last(shift,valid: std_logic_vector;last:std_logic) return std_logic is
                constant all_0 : std_logic_vector(BUFFER_WORDS-1 downto 0) := (others => '0');
            begin 
                if (last = '1' and ((valid and not shift) = all_0)) then
                    return '1';
                else
                    return '0';
                end if;
            end function;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            procedure set_enc is
            begin
                enc.data := std_logic_vector(to_unsigned(0, 8*BUFFER_BYTES));
                enc.strb := to_enc_strb(0);
                if (intake_valid(0) = '1') then
                    enc.valid := '1';
                    enc.shift := to_enc_shift(1);
                else
                    enc.valid := '0';
                    enc.shift := to_enc_shift(0);
                end if;
                enc.last := to_enc_last(enc.shift, intake_valid, intake_last);
            end procedure;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            procedure set_enc(code: in integer range 0 to 255) is
            begin
                enc.data := std_logic_vector(to_unsigned(code, 8*BUFFER_BYTES));
                enc.strb := to_enc_strb(1);
                if (intake_valid(0) = '1') then
                    enc.valid := '1';
                    enc.shift := to_enc_shift(1);
                else
                    enc.valid := '0';
                    enc.shift := to_enc_shift(0);
                end if;
                enc.last := to_enc_last(enc.shift, intake_valid, intake_last);
            end procedure;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            procedure set_enc(code: in integer range 0 to 255; I0:std_logic_vector) is
            begin
                enc.data( 7 downto  0) := std_logic_vector(to_unsigned(code, 8));
                enc.data(15 downto  8) := I0;
                enc.data(enc.data'high downto 16) := (enc.data'high downto 16 => '0');
                enc.strb := to_enc_strb(2);
                if (intake_valid(0) = '1') then
                    enc.valid := '1';
                    enc.shift := to_enc_shift(1);
                else
                    enc.valid := '0';
                    enc.shift := to_enc_shift(0);
                end if;
                enc.last := to_enc_last(enc.shift, intake_valid, intake_last);
            end procedure;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            procedure set_enc(code: in integer range 0 to 255; I0,I1:std_logic_vector) is
            begin
                enc.data( 7 downto  0) := std_logic_vector(to_unsigned(code, 8));
                enc.data(15 downto  8) := I0;
                enc.data(23 downto 16) := I1;
                enc.data(enc.data'high downto 24) := (enc.data'high downto 24 => '0');
                enc.strb := to_enc_strb(3);
                if (intake_valid(0) = '1') then
                    enc.valid := '1';
                    enc.shift := to_enc_shift(1);
                else
                    enc.valid := '0';
                    enc.shift := to_enc_shift(0);
                end if;
                enc.last := to_enc_last(enc.shift, intake_valid, intake_last);
            end procedure;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            procedure set_enc(code: in integer range 0 to 255; I0,I1,I2,I3:std_logic_vector) is
            begin
                enc.data( 7 downto  0) := std_logic_vector(to_unsigned(code, 8));
                enc.data(15 downto  8) := I0;
                enc.data(23 downto 16) := I1;
                enc.data(31 downto 24) := I2;
                enc.data(39 downto 32) := I3;
                enc.data(enc.data'high downto 40) := (enc.data'high downto 40 => '0');
                enc.strb := to_enc_strb(5);
                if (intake_valid(0) = '1') then
                    enc.valid := '1';
                    enc.shift := to_enc_shift(1);
                else
                    enc.valid := '0';
                    enc.shift := to_enc_shift(0);
                end if;
                enc.last := to_enc_last(enc.shift, intake_valid, intake_last);
            end procedure;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            procedure set_enc(code: in integer range 0 to 255; I0,I1,I2,I3,I4,I5,I6,I7:std_logic_vector) is
            begin
                enc.data( 7 downto  0) := std_logic_vector(to_unsigned(code, 8));
                enc.data(15 downto  8) := I0;
                enc.data(23 downto 16) := I1;
                enc.data(31 downto 24) := I2;
                enc.data(39 downto 32) := I3;
                enc.data(47 downto 40) := I4;
                enc.data(55 downto 48) := I5;
                enc.data(63 downto 56) := I6;
                enc.data(71 downto 64) := I7;
                enc.data(enc.data'high downto 73) := (enc.data'high downto 73 => '0');
                enc.strb := to_enc_strb(9);
                if (intake_valid(0) = '1' and intake_valid(1) = '1') then
                    enc.valid := '1';
                    enc.shift := to_enc_shift(2);
                else
                    enc.valid := '0';
                    enc.shift := to_enc_shift(0);
                end if;
                enc.last := to_enc_last(enc.shift, intake_valid, intake_last);
            end procedure;
            -----------------------------------------------------------------------
            -- 
            -----------------------------------------------------------------------
            procedure set_enc(I0,I1,I2,I3:std_logic_vector) is
            begin
                enc.data( 7 downto  0) := I0;
                enc.data(15 downto  8) := I1;
                enc.data(23 downto 16) := I2;
                enc.data(31 downto 24) := I3;
                enc.data(enc.data'high downto 32) := (enc.data'high downto 32 => '0');
                enc.strb := to_enc_strb(4);
                if (intake_valid(0) = '1') then
                    enc.valid := '1';
                    enc.shift := to_enc_shift(1);
                else
                    enc.valid := '0';
                    enc.shift := to_enc_shift(0);
                end if;
                enc.last := to_enc_last(enc.shift, intake_valid, intake_last);
            end procedure;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            variable  obj_size  :  unsigned(31 downto 0);
            variable  byte_code :  integer range 0 to 255;
            variable  complete  :  boolean;
            variable  valid     :  std_logic;
        begin
            case curr_state is
                when FIRST_STATE =>
                    case intake_code(0).class is
                        -----------------------------------------------------------
                        -- None or Reserve
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_NONE    |
                             MsgPack_Object.CLASS_RESERVE =>
                            set_enc;
                            next_state <= FIRST_STATE;
                        -----------------------------------------------------------
                        -- Nil format
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_NIL =>
                            set_enc(16#C0#);
                            next_state <= FIRST_STATE;
                        -----------------------------------------------------------
                        -- Boolean format family
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_BOOLEAN =>
                            if (intake_code(0).DATA(0) = '1') then
                                set_enc(16#C3#);
                            else
                                set_enc(16#C2#);
                            end if;
                            next_state <= FIRST_STATE;
                        -----------------------------------------------------------
                        -- Array format family
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_ARRAY =>
                            obj_size := unsigned(intake_code(0).DATA);
                            if    (obj_size < 16) then
                                byte_code := 16#90# + to_integer(to_01(unsigned(intake_code(0).DATA(3 downto 0))));
                                set_enc(byte_code);
                                next_state <= FIRST_STATE;
                            elsif (obj_size < 16#10000#) then
                                set_enc(16#DC#,
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            else
                                set_enc(16#DD#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            end if;
                        -----------------------------------------------------------
                        -- Map format family
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_MAP =>
                            obj_size := unsigned(intake_code(0).DATA);
                            if    (obj_size < 16) then
                                byte_code := 16#80# + to_integer(to_01(unsigned(intake_code(0).DATA(3 downto 0))));
                                set_enc(byte_code);
                                next_state <= FIRST_STATE;
                            elsif (obj_size < 16#10000#) then
                                set_enc(16#DE#,
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            else
                                set_enc(16#DF#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            end if;
                        -----------------------------------------------------------
                        -- Unsigned Integer format family
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_UINT =>
                            if    (intake_code(0).complete = '0' and ENCODE_WIDTH >= 2) then
                                set_enc(16#CF#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0),
                                        intake_code(1).DATA(31 downto 24),
                                        intake_code(1).DATA(23 downto 16),
                                        intake_code(1).DATA(15 downto  8),
                                        intake_code(1).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            elsif (intake_code(0).complete = '0' and ENCODE_WIDTH <  2) then
                                set_enc(16#CF#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                if (enc.valid = '1' and outlet_ready = '1') then
                                    next_state <= UINT64_STATE;
                                else
                                    next_state <= FIRST_STATE;
                                end if;
                            elsif (unsigned(intake_code(0).DATA) < 16#80#) then
                                set_enc(to_integer(unsigned(intake_code(0).DATA(6 downto 0))));
                                next_state <= FIRST_STATE;
                            elsif (unsigned(intake_code(0).DATA) < 16#100#) then
                                set_enc(16#CC#,
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            elsif (unsigned(intake_code(0).DATA) < 16#10000#) then
                                set_enc(16#CD#,
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            else
                                set_enc(16#CE#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            end if;
                        -----------------------------------------------------------
                        -- Signed Integer format family
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_INT =>
                            if    (intake_code(0).complete = '0' and ENCODE_WIDTH >= 2) then
                                set_enc(16#D3#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0),
                                        intake_code(1).DATA(31 downto 24),
                                        intake_code(1).DATA(23 downto 16),
                                        intake_code(1).DATA(15 downto  8),
                                        intake_code(1).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            elsif (intake_code(0).complete = '0' and ENCODE_WIDTH <  2) then
                                set_enc(16#D3#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                if (enc.valid = '1' and outlet_ready = '1') then
                                    next_state <= INT64_STATE;
                                else
                                    next_state <= FIRST_STATE;
                                end if;
                            elsif (signed(intake_code(0).DATA) >= -32) and
                                  (signed(intake_code(0).DATA) <= 127) then
                                set_enc(to_integer(unsigned(intake_code(0).DATA(7 downto 0))));
                                next_state <= FIRST_STATE;
                            elsif (signed(intake_code(0).DATA) >= -128) and
                                  (signed(intake_code(0).DATA) <=  127) then
                                set_enc(16#D0#,
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            elsif (signed(intake_code(0).DATA) >= -32768) and
                                  (signed(intake_code(0).DATA) <=  32767) then
                                set_enc(16#D1#,
                                        intake_code(0).DATA( 15 downto  8),
                                        intake_code(0).DATA(  7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            else
                                set_enc(16#D2#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            end if;
                        -----------------------------------------------------------
                        -- Float format family
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_FLOAT =>
                            if    (intake_code(0).complete = '0' and ENCODE_WIDTH >= 2) then
                                set_enc(16#CB#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0),
                                        intake_code(1).DATA(31 downto 24),
                                        intake_code(1).DATA(23 downto 16),
                                        intake_code(1).DATA(15 downto  8),
                                        intake_code(1).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            elsif (intake_code(0).complete = '0' and ENCODE_WIDTH <  2) then
                                set_enc(16#CB#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                if (enc.valid = '1' and outlet_ready = '1') then
                                    next_state <= FLOAT64_STATE;
                                else
                                    next_state <= FIRST_STATE;
                                end if;
                            else
                                set_enc(16#CA#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                                next_state <= FIRST_STATE;
                            end if;
                        -----------------------------------------------------------
                        -- String format family
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_STRING_SIZE =>
                            obj_size := unsigned(intake_code(0).DATA);
                            if    (obj_size < 32) then
                                byte_code := 16#A0# + to_integer(to_01(unsigned(intake_code(0).DATA(4 downto 0))));
                                set_enc(byte_code);
                            elsif (obj_size < 16#100#) then
                                set_enc(16#D9#,
                                        intake_code(0).DATA( 7 downto  0)
                                );
                            elsif (obj_size < 16#10000#) then
                                set_enc(16#DA#,
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                            else
                                set_enc(16#DB#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                            end if;
                            if (enc.valid = '1' and outlet_ready = '1' and obj_size > 0) then
                                next_state <= STR_DATA_STATE;
                            else
                                next_state <= FIRST_STATE;
                            end if;
                        -----------------------------------------------------------
                        -- Binary format family
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_BINARY_SIZE =>
                            obj_size := unsigned(intake_code(0).DATA);
                            if    (obj_size < 16#100#) then
                                set_enc(16#C4#,
                                        intake_code(0).DATA( 7 downto  0)
                                );
                            elsif (obj_size < 16#10000#) then
                                set_enc(16#C5#,
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                            else
                                set_enc(16#C6#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                            end if;
                            if (enc.valid = '1' and outlet_ready = '1' and obj_size > 0) then
                                next_state <= BIN_DATA_STATE;
                            else
                                next_state <= FIRST_STATE;
                            end if;
                        -----------------------------------------------------------
                        -- Ext format family
                        -----------------------------------------------------------
                        when MsgPack_Object.CLASS_EXT_SIZE =>
                            obj_size := unsigned(intake_code(0).DATA);
                            if    (obj_size = 1) then
                                set_enc(16#D4#);
                            elsif (obj_size = 2) then
                                set_enc(16#D5#);
                            elsif (obj_size = 4) then
                                set_enc(16#D6#);
                            elsif (obj_size = 8) then
                                set_enc(16#D7#);
                            elsif (obj_size = 16) then
                                set_enc(16#D8#);
                            elsif (obj_size < 16#100#) then
                                set_enc(16#C7#,
                                        intake_code(0).DATA( 7 downto  0)
                                );
                            elsif (obj_size < 16#10000#) then
                                set_enc(16#C8#,
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                            else
                                set_enc(16#C9#,
                                        intake_code(0).DATA(31 downto 24),
                                        intake_code(0).DATA(23 downto 16),
                                        intake_code(0).DATA(15 downto  8),
                                        intake_code(0).DATA( 7 downto  0)
                                );
                            end if;
                            if (enc.valid = '1' and outlet_ready = '1') then
                                if (obj_size > 0) then
                                    next_state <= EXT_TYPE_WITH_DATA_STATE;
                                else
                                    next_state <= EXT_TYPE_NONE_DATA_STATE;
                                end if;
                            else
                                    next_state <= FIRST_STATE;
                            end if;
                        -----------------------------------------------------------
                        -- Format Error 
                        -----------------------------------------------------------
                        when others =>
                            set_enc(0);
                            if (enc.valid = '1' and outlet_ready = '1') then
                                next_state <= ERROR_STATE;
                            else
                                next_state <= FIRST_STATE;
                            end if;
                    end case;
                -------------------------------------------------------------------
                -- UINT64/INT64/FLOAT64
                -------------------------------------------------------------------
                when UINT64_STATE | INT64_STATE | FLOAT64_STATE =>
                    set_enc(
                        intake_code(0).DATA(31 downto 24),
                        intake_code(0).DATA(23 downto 16),
                        intake_code(0).DATA(15 downto  8),
                        intake_code(0).DATA( 7 downto  0)
                    );
                    if (enc.valid = '1' and outlet_ready = '1') then
                        next_state <= FIRST_STATE;
                    else
                        next_state <= curr_state;
                    end if;
                -------------------------------------------------------------------
                -- Ext type 
                -------------------------------------------------------------------
                when EXT_TYPE_WITH_DATA_STATE | EXT_TYPE_NONE_DATA_STATE =>
                    byte_code := to_integer(unsigned(intake_code(0).DATA(7 downto 0)));
                    set_enc(byte_code);
                    if (enc.valid = '1' and outlet_ready = '1' and curr_state = EXT_TYPE_WITH_DATA_STATE) then
                        next_state <= EXT_DATA_STATE;
                    else
                        next_state <= FIRST_STATE;
                    end if;
                -------------------------------------------------------------------
                -- String/Binary/Ext data 
                -------------------------------------------------------------------
                when STR_DATA_STATE | BIN_DATA_STATE | EXT_DATA_STATE =>
                    complete  := FALSE;
                    enc.valid := '0';
                    for i in 0 to BUFFER_WORDS-1 loop
                        enc.data(32*(i+1)-1 downto 32*i) := intake_code(i).DATA;
                        if (complete = FALSE and intake_valid(i) = '1') then
                            enc.strb(4*(i+1)-1 downto 4*i) := intake_code(i).STRB;
                            enc.shift(i) := '1';
                            enc.valid := '1';
                            if (intake_code(i).complete = '1') then
                                complete := TRUE;
                            end if;
                        else
                            enc.strb(4*i+3 downto 4*i) := "0000";
                            enc.shift(i) := '0';
                        end if;
                    end loop;
                    if (complete and enc.valid = '1' and outlet_ready = '1') then
                        next_state <= FIRST_STATE;
                    else
                        next_state <= curr_state;
                    end if;
                    enc.last := to_enc_last(enc.shift, intake_valid, intake_last);
                -------------------------------------------------------------------
                -- Error State
                -------------------------------------------------------------------
                when others =>
                    enc := ENC_NULL;
                    next_state <= ERROR_STATE;
            end case;
            outlet_data  <= enc.data;
            outlet_strb  <= enc.strb;
            outlet_last  <= enc.last;
            outlet_valid <= enc.valid;
            if (outlet_ready = '1') then
                intake_shift <= enc.shift;
            else
                intake_shift <= (others => '0');
            end if;
        end process;
        process(CLK, RST) begin
            if (RST = '1') then
                    curr_state <= FIRST_STATE;
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    curr_state <= FIRST_STATE;
                else
                    curr_state <= next_state;
                end if;
            end if;
        end process;
    end block;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    OUTLET: REDUCER                                 -- 
        generic map (                               -- 
            WORD_BITS       => 8                  , -- 1 byte(8bit)
            STRB_BITS       => 1                  , -- 1 bit
            I_WIDTH         => OUTLET_BYTES       , -- 
            O_WIDTH         => O_BYTES            , -- Output Byte Size
            QUEUE_SIZE      => 0                  , -- Queue size is auto
            VALID_MIN       => 0                  , -- VALID unused
            VALID_MAX       => 0                  , -- VALID unused
            O_VAL_SIZE      => O_BYTES+1          , -- 
            O_SHIFT_MIN     => O_BYTES            , -- SHIFT unused
            O_SHIFT_MAX     => O_BYTES            , -- SHIFT unused
            I_JUSTIFIED     => 1                  , -- 
            FLUSH_ENABLE    => 0                    -- 
        )                                           -- 
        port map (                                  -- 
        ---------------------------------------------------------------------------
        -- Clock and Reset Signals
        ---------------------------------------------------------------------------
            CLK             => CLK                , -- In  :
            RST             => RST                , -- In  :
            CLR             => CLR                , -- In  :
        ---------------------------------------------------------------------------
        -- Control and Status Signals
        ---------------------------------------------------------------------------
            START           => '0'                , -- In  :
            OFFSET          => outlet_offset      , -- In  :
            DONE            => '0'                , -- In  :
            FLUSH           => '0'                , -- In  :
            BUSY            => open               , -- Out :
            VALID           => open               , -- Out :
        ---------------------------------------------------------------------------
        -- Byte Stream Input Interface
        ---------------------------------------------------------------------------
            I_ENABLE        => '1'                , -- In  :
            I_STRB          => outlet_strb(  OUTLET_BYTES-1 downto 0), -- In  :
            I_DATA          => outlet_data(8*OUTLET_BYTES-1 downto 0), -- In  :
            I_DONE          => outlet_last        , -- In  :
            I_FLUSH         => '0'                , -- In  :
            I_VAL           => outlet_valid       , -- In  :
            I_RDY           => outlet_ready       , -- Out :
        ---------------------------------------------------------------------------
        -- Byte Stream Output Interface
        ---------------------------------------------------------------------------
            O_ENABLE        => '1'                , -- In  :
            O_DATA          => O_DATA             , -- Out :
            O_STRB          => O_STRB             , -- Out :
            O_DONE          => O_LAST             , -- Out :
            O_FLUSH         => open               , -- Out :
            O_VAL           => O_VALID            , -- Out :
            O_RDY           => O_READY            , -- In  :
            O_SHIFT         => "0"                  -- In  :
    );                                              --
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_object_unpacker.vhd
--!     @brief   MessagePack Object Code Unpack from Byte Stream Module :
--!     @version 0.2.0
--!     @date    2016/2/4
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
library MsgPack;
use     MsgPack.MsgPack_Object;
-----------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------
entity  MsgPack_Object_Unpacker is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        I_BYTES         : positive := 1;
        CODE_WIDTH      : positive := 1;
        O_VALID_SIZE    : integer range 0 to 64 := 1;
        DECODE_UNIT     : integer range 0 to  3 := 1;
        SHORT_STR_SIZE  : integer range 0 to 31 := 8;
        STACK_DEPTH     : integer := 4
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Byte Stream Input Interface
    -------------------------------------------------------------------------------
        I_DATA          : in  std_logic_vector(           8*I_BYTES-1 downto 0);
        I_STRB          : in  std_logic_vector(             I_BYTES-1 downto 0);
        I_LAST          : in  std_logic := '0';
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- Object Code Output Interface
    -------------------------------------------------------------------------------
        O_CODE          : out MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
        O_SHIFT         : in  std_logic_vector(          CODE_WIDTH-1 downto 0)
    );
end MsgPack_Object_Unpacker;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.PipeWork_Components.REDUCER;
use     MsgPack.PipeWork_Components.CHOPPER;
use     MsgPack.MsgPack_Object_Components.MsgPack_Structure_Stack;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Code_Reducer;
architecture RTL of MsgPack_Object_Unpacker is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function   max(A,B:integer) return integer is begin
        if (A > B) then return A;
        else            return B;
        end if;
    end function;
    constant   BUFFER_BYTES      :  integer := max(9, (2**DECODE_UNIT)*4+1);
    constant   BUFFER_WORDS      :  integer := (BUFFER_BYTES+3)/4;
    constant   BUFFER_BITS       :  integer := 8*BUFFER_BYTES;
    signal     buffer_data       :  std_logic_vector(BUFFER_BITS -1 downto 0);
    signal     buffer_valid      :  std_logic_vector(BUFFER_BYTES-1 downto 0);
    signal     buffer_shift      :  std_logic_vector(BUFFER_BYTES-1 downto 0);
    signal     buffer_last       :  std_logic;
    signal     buffer_ready      :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant   DECODE_WIDTH      :  integer := DECODE_UNIT+2;
    constant   DECODE_WORDS      :  integer := 2**(DECODE_UNIT  );
    constant   DECODE_BYTES      :  integer := 2**(DECODE_UNIT+2);
    constant   DECODE_BITS       :  integer := 2**(DECODE_UNIT+5);
    constant   LENGTH_BITS       :  integer := 32;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant   INTAKE_BYTES      :  integer := DECODE_BYTES+1;
    constant   INTAKE_DEPTH      :  integer := INTAKE_BYTES + DECODE_BYTES - 1;
    constant   intake_offset     :  std_logic_vector(  INTAKE_BYTES-1 downto 0) := (others => '0');
    signal     intake_shift      :  std_logic_vector(  INTAKE_BYTES-1 downto 0);
    signal     intake_valid      :  std_logic_vector(  INTAKE_BYTES-1 downto 0);
    signal     intake_data       :  std_logic_vector(8*INTAKE_BYTES-1 downto 0);
    signal     intake_last       :  std_logic;
    signal     intake_ready      :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal     unpack_code       :  MsgPack_Object.Code_Vector(BUFFER_WORDS-1 downto 0);
    signal     unpack_valid      :  std_logic;
    signal     unpack_complete   :  std_logic;
    signal     unpack_last       :  std_logic;
    signal     object_length     :  unsigned(LENGTH_BITS-1 downto 0);
    signal     object_map        :  std_logic;
    signal     object_array      :  std_logic;
    signal     object_valid      :  std_logic;
    signal     stack_ready       :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal     data_length_load  :  std_logic;
    signal     data_chop         :  std_logic;
    signal     data_length       :  unsigned(LENGTH_BITS-1 downto 0);
    signal     data_valid        :  std_logic_vector(DECODE_BYTES-1 downto 0);
    signal     data_last         :  std_logic;
    signal     data_none         :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal     outlet_valid      :  std_logic;
    signal     outlet_ready      :  std_logic;
    -------------------------------------------------------------------------------
    -- big-endian to little-endian function
    -----------------------------------------------------------------------
    function be_to_le(data: std_logic_vector) return std_logic_vector is
        alias    i_data : std_logic_vector(data'length-1 downto 0) is data;
    begin
        if    (data'length <=  8) then
            return i_data;
        elsif (data'length  = 16) then
            return i_data( 7 downto  0) &
                   i_data(15 downto  8) ;
        elsif (data'length  = 32) then
            return i_data( 7 downto  0) &
                   i_data(15 downto  8) &
                   i_data(23 downto 16) &
                   i_data(31 downto 24) ;
        elsif (data'length  = 64) then
            return i_data( 7 downto  0) &
                   i_data(15 downto  8) &
                   i_data(23 downto 16) &
                   i_data(31 downto 24) &
                   i_data(39 downto 32) &
                   i_data(47 downto 40) &
                   i_data(55 downto 48) &
                   i_data(63 downto 56) ;
        else
            assert FALSE report "be_to_le size error" severity FAILURE;
        end if;
    end function;
    -------------------------------------------------------------------------------
    -- big-endian to unsigned function
    -------------------------------------------------------------------------------
    function be_to_unsigned(data: std_logic_vector; length: integer) return unsigned is
    begin
        return resize(unsigned(be_to_le(data)), length);
    end function;
    -------------------------------------------------------------------------------
    -- big-endian to signed function
    -------------------------------------------------------------------------------
    function be_to_signed  (data: std_logic_vector; length: integer) return   signed is
        alias    i_data : std_logic_vector(data'length-1 downto 0) is data;
    begin
        return resize(  signed(be_to_le(data)), length);
    end function;
begin
    -------------------------------------------------------------------------------
    -- Input Byte Stream Buffer
    -------------------------------------------------------------------------------
    INTAKE: REDUCER                                 -- 
        generic map (                               -- 
            WORD_BITS       => 8                  , -- 1 byte(8bit)
            STRB_BITS       => 1                  , -- 1 bit
            I_WIDTH         => I_BYTES            , -- Input Byte Size
            O_WIDTH         => INTAKE_BYTES       , -- 
            QUEUE_SIZE      => INTAKE_DEPTH       , -- 
            VALID_MIN       => intake_valid'low   , -- 
            VALID_MAX       => intake_valid'high  , -- 
            O_VAL_SIZE      => 1                  , -- 
            O_SHIFT_MIN     => intake_shift'low   , -- 
            O_SHIFT_MAX     => intake_shift'high  , -- 
            I_JUSTIFIED     => 1                  , -- 
            FLUSH_ENABLE    => 0                    -- 
        )                                           -- 
        port map (                                  -- 
        ---------------------------------------------------------------------------
        -- Clock and Reset Signals
        ---------------------------------------------------------------------------
            CLK             => CLK                , -- In  :
            RST             => RST                , -- In  :
            CLR             => CLR                , -- In  :
        ---------------------------------------------------------------------------
        -- Control and Status Signals
        ---------------------------------------------------------------------------
            START           => '0'                , -- In  :
            OFFSET          => intake_offset      , -- In  :
            DONE            => '0'                , -- In  :
            FLUSH           => '0'                , -- In  :
            BUSY            => open               , -- Out :
            VALID           => intake_valid       , -- Out :
        ---------------------------------------------------------------------------
        -- Byte Stream Input Interface
        ---------------------------------------------------------------------------
            I_ENABLE        => '1'                , -- In  :
            I_STRB          => I_STRB             , -- In  :
            I_DATA          => I_DATA             , -- In  :
            I_DONE          => I_LAST             , -- In  :
            I_FLUSH         => '0'                , -- In  :
            I_VAL           => I_VALID            , -- In  :
            I_RDY           => I_READY            , -- Out :
        ---------------------------------------------------------------------------
        -- Byte Stream Output Interface
        ---------------------------------------------------------------------------
            O_ENABLE        => '1'                , -- In  :
            O_DATA          => intake_data        , -- Out :
            O_STRB          => open               , -- Out :
            O_DONE          => intake_last        , -- Out :
            O_FLUSH         => open               , -- Out :
            O_VAL           => open               , -- Out :
            O_RDY           => intake_ready       , -- In  :
            O_SHIFT         => intake_shift         -- In  :
    );                                              --
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    buffer_valid <= std_logic_vector(resize(unsigned(intake_valid), BUFFER_BYTES));
    buffer_data  <= std_logic_vector(resize(unsigned(intake_data ), BUFFER_BITS ));
    buffer_last  <= intake_last;
    intake_shift <= buffer_shift(INTAKE_BYTES-1 downto 0);
    intake_ready <= buffer_ready;
    -------------------------------------------------------------------------------
    -- Byte Code Parser
    -------------------------------------------------------------------------------
    PARSE: block
        type       STATE_TYPE   is (   FIRST_STATE,
                                    STR_DATA_STATE,
                                    BIN_DATA_STATE,
                                    EXT_DATA_STATE,
                                    EXT_TYPE_STATE,
                                     FLOAT64_STATE,
                                      UINT64_STATE,
                                       INT64_STATE);
        signal     next_state    :  STATE_TYPE;
        signal     curr_state    :  STATE_TYPE;
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (curr_state, buffer_valid, buffer_data, data_valid, data_last, data_none)
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            function  to_valid(size: integer; valid: std_logic_vector) return std_logic is
            begin
                if (valid(0) = '1' and valid(size-1) = '1') then
                    return '1';
                else
                    return '0';
                end if;
            end function;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            function  to_valid(need: std_logic_vector; valid: std_logic_vector) return std_logic is
                variable flag_vec  : std_logic_vector(need'range);
                constant FLAG_NULL : std_logic_vector(need'range) := (others => '0');
            begin
                for i in need'range loop
                    if (need(i) = '1' and valid(i) = '0') then
                        flag_vec(i) := '1';
                    else
                        flag_vec(i) := '0';
                    end if;
                end loop;
                if (flag_vec = FLAG_NULL) then
                    return '1';
                else
                    return '0';
                end if;
            end function;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            function  to_shift(size: integer) return std_logic_vector is
                variable shift : std_logic_vector(BUFFER_BYTES-1 downto 0);
            begin
                for i in shift'range loop
                    if (i < size) then
                        shift(i) := '1';
                    else
                        shift(i) := '0';
                    end if;
                end loop;
                return shift;
            end function;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            function  to_strb(size: integer) return std_logic_vector is
                variable strb  : std_logic_vector(DECODE_BYTES-1 downto 0);
            begin
                for i in strb'range loop
                    if (i < size) then
                        strb(i) := '1';
                    else
                        strb(i) := '0';
                    end if;
                end loop;
                return strb;
            end function;
            -----------------------------------------------------------------------
            -- 
            -----------------------------------------------------------------------
            procedure short_fixstr(constant size : in integer) is
            begin
                if (size <= DECODE_BYTES) then
                    unpack_code  <= MsgPack_Object.New_Code_Vector(
                        LENGTH   => BUFFER_WORDS,
                        CLASS    => MsgPack_Object.CLASS_STRING_DATA,
                        STRB     => to_strb(size),
                        DATA     => buffer_data(DECODE_BITS-1+8 downto 8),
                        COMPLETE => '1'
                    );
                    data_length  <= to_unsigned(size, LENGTH_BITS);
                    unpack_valid <= to_valid(size+1, buffer_valid);
                    buffer_shift <= to_shift(size+1);
                    next_state   <= FIRST_STATE;
                else
                    unpack_code  <= MsgPack_Object.New_Code_Vector(
                        LENGTH   => BUFFER_WORDS,
                        CLASS    => MsgPack_Object.CLASS_STRING_DATA,
                        STRB     => to_strb(DECODE_BYTES),
                        DATA     => buffer_data(DECODE_BITS-1+8 downto 8),
                        COMPLETE => '0'
                    );
                    data_length  <= to_unsigned(size-DECODE_BYTES, LENGTH_BITS);
                    unpack_valid <= to_valid(DECODE_BYTES+1, buffer_valid);
                    buffer_shift <= to_shift(DECODE_BYTES+1);
                    next_state   <= STR_DATA_STATE;
                end if;
            end procedure;
            -----------------------------------------------------------------------
            --
            -----------------------------------------------------------------------
            variable  fixstr_size          :  integer range 0 to 31;
            variable  size_zero            :  boolean;
            variable  dummy_data_length    :  unsigned(data_length'range);
            variable  dummy_object_length  :  unsigned(object_length'range);
        begin
            if  (buffer_data(0) = '0') then
                dummy_object_length := be_to_unsigned(buffer_data(23 downto 8), LENGTH_BITS);
            else
                dummy_object_length := be_to_unsigned(buffer_data(39 downto 8), LENGTH_BITS);
            end if;
            dummy_data_length := (others => '0');
            unpack_code       <= (others => MsgPack_Object.CODE_NULL);
            case curr_state is
                -------------------------------------------------------------------
                -- Decode First State
                -------------------------------------------------------------------
                when FIRST_STATE =>
                    ---------------------------------------------------------------
                    -- positive fixint 0xxxxxxxx
                    ---------------------------------------------------------------
                    if    (buffer_data(7) = '0') then
                        unpack_code(0) <= MsgPack_Object.New_Code_Unsigned(
                            DATA       => unsigned(buffer_data(6 downto 0))
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- fixmap   1000xxxx
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 4) = "000") then
                        unpack_code(0) <= MsgPack_Object.New_Code_MapSize(
                            SIZE       => unsigned(buffer_data(3 downto 0))
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= dummy_data_length;
                        object_length  <= be_to_unsigned(buffer_data(3 downto 0), LENGTH_BITS);
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- fixarray 1001xxxx
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 4) = "001") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ArraySize(
                            SIZE       => unsigned(buffer_data(3 downto 0))
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= dummy_data_length;
                        object_length  <= be_to_unsigned(buffer_data(3 downto 0), LENGTH_BITS);
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- fixstr   101xxxxx
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 5) = "01") then
                        fixstr_size    := to_integer(to_01(unsigned(buffer_data(4 downto 0))));
                        object_length  <= be_to_unsigned(buffer_data(3 downto 0), LENGTH_BITS);
                        if    (fixstr_size =  1 and SHORT_STR_SIZE >=  1) then
                            short_fixstr(1);
                        elsif (fixstr_size =  2 and SHORT_STR_SIZE >=  2) then
                            short_fixstr(2);
                        elsif (fixstr_size =  3 and SHORT_STR_SIZE >=  3) then
                            short_fixstr(3);
                        elsif (fixstr_size =  4 and SHORT_STR_SIZE >=  4) then
                            short_fixstr(4);
                        elsif (fixstr_size =  5 and SHORT_STR_SIZE >=  5) then
                            short_fixstr(5);
                        elsif (fixstr_size =  6 and SHORT_STR_SIZE >=  6) then
                            short_fixstr(6);
                        elsif (fixstr_size =  7 and SHORT_STR_SIZE >=  7) then
                            short_fixstr(7);
                        elsif (fixstr_size =  8 and SHORT_STR_SIZE >=  8) then
                            short_fixstr(8);
                        elsif (fixstr_size =  9 and SHORT_STR_SIZE >=  9) then
                            short_fixstr(9);
                        elsif (fixstr_size = 10 and SHORT_STR_SIZE >= 10) then
                            short_fixstr(10);
                        elsif (fixstr_size = 11 and SHORT_STR_SIZE >= 11) then
                            short_fixstr(11);
                        elsif (fixstr_size = 12 and SHORT_STR_SIZE >= 12) then
                            short_fixstr(12);
                        elsif (fixstr_size = 13 and SHORT_STR_SIZE >= 13) then
                            short_fixstr(13);
                        elsif (fixstr_size = 14 and SHORT_STR_SIZE >= 14) then
                            short_fixstr(14);
                        elsif (fixstr_size = 15 and SHORT_STR_SIZE >= 15) then
                            short_fixstr(15);
                        elsif (fixstr_size = 16 and SHORT_STR_SIZE >= 16) then
                            short_fixstr(16);
                        elsif (fixstr_size = 17 and SHORT_STR_SIZE >= 17) then
                            short_fixstr(17);
                        elsif (fixstr_size = 18 and SHORT_STR_SIZE >= 18) then
                            short_fixstr(18);
                        elsif (fixstr_size = 19 and SHORT_STR_SIZE >= 19) then
                            short_fixstr(19);
                        elsif (fixstr_size = 20 and SHORT_STR_SIZE >= 20) then
                            short_fixstr(20);
                        elsif (fixstr_size = 21 and SHORT_STR_SIZE >= 21) then
                            short_fixstr(21);
                        elsif (fixstr_size = 22 and SHORT_STR_SIZE >= 22) then
                            short_fixstr(22);
                        elsif (fixstr_size = 23 and SHORT_STR_SIZE >= 23) then
                            short_fixstr(23);
                        elsif (fixstr_size = 24 and SHORT_STR_SIZE >= 24) then
                            short_fixstr(24);
                        elsif (fixstr_size = 25 and SHORT_STR_SIZE >= 25) then
                            short_fixstr(25);
                        elsif (fixstr_size = 26 and SHORT_STR_SIZE >= 26) then
                            short_fixstr(26);
                        elsif (fixstr_size = 27 and SHORT_STR_SIZE >= 27) then
                            short_fixstr(27);
                        elsif (fixstr_size = 28 and SHORT_STR_SIZE >= 28) then
                            short_fixstr(28);
                        elsif (fixstr_size = 29 and SHORT_STR_SIZE >= 29) then
                            short_fixstr(29);
                        elsif (fixstr_size = 30 and SHORT_STR_SIZE >= 30) then
                            short_fixstr(30);
                        elsif (fixstr_size = 31 and SHORT_STR_SIZE >= 31) then
                            short_fixstr(31);
                        elsif (fixstr_size = 0) then
                            unpack_code(0) <= MsgPack_Object.New_Code_StringSize(
                                SIZE     => to_unsigned(fixstr_size, 8)
                            );
                            data_length  <= to_unsigned(fixstr_size, LENGTH_BITS);
                            unpack_valid <= to_valid(1, buffer_valid);
                            buffer_shift <= to_shift(1);
                            next_state   <= FIRST_STATE;
                        else
                            unpack_code(0) <= MsgPack_Object.New_Code_StringSize(
                                SIZE     => to_unsigned(fixstr_size, 8)
                            );
                            data_length  <= to_unsigned(fixstr_size, LENGTH_BITS);
                            unpack_valid <= to_valid(1, buffer_valid);
                            buffer_shift <= to_shift(1);
                            next_state   <= STR_DATA_STATE;
                        end if;
                    ---------------------------------------------------------------
                    -- nil     11000000
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1000000") then
                        unpack_code(0) <= MsgPack_Object.New_Code_Nil;
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- no used 11000001
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1000001") then
                        unpack_code(0) <= MsgPack_Object.New_Code_Reserve(0);
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- false   11000010
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1000010") then
                        unpack_code(0) <= MsgPack_Object.New_Code_False;
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- true    11000011
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1000011") then
                        unpack_code(0) <= MsgPack_Object.New_Code_True;
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- bin 8   11000100
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1000100") then
                        size_zero      := (to_01(unsigned(buffer_data(15 downto 8))) = 0);
                        unpack_code(0) <= MsgPack_Object.New_Code_BinarySize(
                            SIZE       => be_to_unsigned(buffer_data(15 downto 8), 8)
                        );
                        unpack_valid   <= to_valid(2, buffer_valid);
                        buffer_shift   <= to_shift(2);
                        data_length    <= be_to_unsigned(buffer_data(15 downto 8), LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        if (size_zero) then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= BIN_DATA_STATE;
                        end if;
                    ---------------------------------------------------------------
                    -- bin 16  11000101
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1000101") then
                        size_zero      := (to_01(unsigned(buffer_data(23 downto 8))) = 0);
                        unpack_code(0) <= MsgPack_Object.New_Code_BinarySize(
                            SIZE       => be_to_unsigned(buffer_data(23 downto 8), 16)
                        );
                        unpack_valid   <= to_valid(3, buffer_valid);
                        buffer_shift   <= to_shift(3);
                        data_length    <= be_to_unsigned(buffer_data(23 downto 8), LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        if (size_zero) then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= BIN_DATA_STATE;
                        end if;
                    ---------------------------------------------------------------
                    -- bin 32  11000110
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1000110") then
                        size_zero      := (to_01(unsigned(buffer_data(39 downto 8))) = 0);
                        unpack_code(0) <= MsgPack_Object.New_Code_BinarySize(
                            SIZE       => be_to_unsigned(buffer_data(39 downto 8), 32)
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= be_to_unsigned(buffer_data(39 downto 8), LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        if (size_zero) then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= BIN_DATA_STATE;
                        end if;
                    ---------------------------------------------------------------
                    -- ext 8   11000111
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1000111") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ExtSize(
                            SIZE       => be_to_unsigned(buffer_data(15 downto 8), 8)
                        );
                        unpack_valid   <= to_valid(2, buffer_valid);
                        buffer_shift   <= to_shift(2);
                        data_length    <= be_to_unsigned(buffer_data(15 downto 8), LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        next_state     <= EXT_TYPE_STATE;
                    ---------------------------------------------------------------
                    -- ext 16  11001000
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1001000") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ExtSize(
                            SIZE       => be_to_unsigned(buffer_data(23 downto 8), 16)
                        );
                        unpack_valid   <= to_valid(3, buffer_valid);
                        buffer_shift   <= to_shift(3);
                        data_length    <= be_to_unsigned(buffer_data(23 downto 8), LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        next_state     <= EXT_TYPE_STATE;
                    ---------------------------------------------------------------
                    -- ext 32  11001001
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1001001") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ExtSize(
                            SIZE       => be_to_unsigned(buffer_data(39 downto 8), 32)
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= be_to_unsigned(buffer_data(39 downto 8), LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        next_state     <= EXT_TYPE_STATE;
                    ---------------------------------------------------------------
                    -- float32 11001010
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1001010") then
                        unpack_code(0) <= MsgPack_Object.New_Code_Float(
                            DATA       => be_to_le(buffer_data(39 downto 8))
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- float64 11001011
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1001011" and DECODE_WORDS >= 2) then
                        unpack_code(0) <= MsgPack_Object.New_Code_Float(
                            DATA       => be_to_le(buffer_data(39 downto  8)),
                            COMPLETE   => '0'
                        );
                        unpack_code(1) <= MsgPack_Object.New_Code_Float(
                            DATA       => be_to_le(buffer_data(71 downto 40)),
                            COMPLETE   => '1'
                        );
                        unpack_valid   <= to_valid(9, buffer_valid);
                        buffer_shift   <= to_shift(9);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    elsif (buffer_data(6 downto 0) = "1001011" and DECODE_WORDS <  2) then
                        unpack_code(0) <= MsgPack_Object.New_Code_Float(
                            DATA       => be_to_le(buffer_data(39 downto  8)),
                            COMPLETE   => '0'
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FLOAT64_STATE;
                    ---------------------------------------------------------------
                    -- uint 8  11001100
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1001100") then
                        unpack_code(0) <= MsgPack_Object.New_Code_Unsigned(
                            DATA       => be_to_unsigned(buffer_data(15 downto 8), 8)
                        );
                        unpack_valid   <= to_valid(2, buffer_valid);
                        buffer_shift   <= to_shift(2);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- uint 16 11001101
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1001101") then
                        unpack_code(0) <= MsgPack_Object.New_Code_Unsigned(
                            DATA       => be_to_unsigned(buffer_data(23 downto 8), 16)
                        );
                        unpack_valid   <= to_valid(3, buffer_valid);
                        buffer_shift   <= to_shift(3);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- uint 32 11001110
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1001110") then
                        unpack_code(0) <= MsgPack_Object.New_Code_Unsigned(
                            DATA       => be_to_unsigned(buffer_data(39 downto 8), 32)
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- uint 64 11001111
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1001111" and DECODE_WORDS >= 2) then
                        unpack_code(0) <= MsgPack_Object.New_Code_Unsigned(
                            DATA       => be_to_unsigned(buffer_data(39 downto  8), 32),
                            COMPLETE   => '0'
                        );
                        unpack_code(1) <= MsgPack_Object.New_Code_Unsigned(
                            DATA       => be_to_unsigned(buffer_data(71 downto 40), 32),
                            COMPLETE   => '1'
                        );
                        unpack_valid   <= to_valid(9, buffer_valid);
                        buffer_shift   <= to_shift(9);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    elsif (buffer_data(6 downto 0) = "1001111" and DECODE_WORDS <  2) then
                        unpack_code(0) <= MsgPack_Object.New_Code_Unsigned(
                            DATA       => be_to_unsigned(buffer_data(39 downto  8), 32),
                            COMPLETE   => '0'
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= UINT64_STATE;
                    ---------------------------------------------------------------
                    -- int 8   11010000
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1010000") then
                        unpack_code(0) <= MsgPack_Object.New_Code_Signed(
                            DATA       => be_to_signed(buffer_data(15 downto 8), 8)
                        );
                        unpack_valid   <= to_valid(2, buffer_valid);
                        buffer_shift   <= to_shift(2);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- int 16  11010001
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1010001") then
                        unpack_code(0) <= MsgPack_Object.New_Code_Signed(
                            DATA       => be_to_signed(buffer_data(23 downto 8), 16)
                        );
                        unpack_valid   <= to_valid(3, buffer_valid);
                        buffer_shift   <= to_shift(3);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- int 32  11010010
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1010010") then
                        unpack_code(0) <= MsgPack_Object.New_Code_Signed(
                            DATA       => be_to_signed(buffer_data(39 downto 8), 32)
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- int 64  11010011
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1010011" and DECODE_WORDS >= 2) then
                        unpack_code(0) <= MsgPack_Object.New_Code_Signed(
                            DATA       => be_to_unsigned(buffer_data(39 downto  8),32),
                            COMPLETE   => '0'
                        );
                        unpack_code(1) <= MsgPack_Object.New_Code_Signed(
                            DATA       => be_to_unsigned(buffer_data(71 downto 40),32),
                            COMPLETE   => '1'
                        );
                        unpack_valid   <= to_valid(9, buffer_valid);
                        buffer_shift   <= to_shift(9);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    elsif (buffer_data(6 downto 0) = "1010011" and DECODE_WORDS <  2) then
                        unpack_code(0) <= MsgPack_Object.New_Code_Signed(
                            DATA       => be_to_unsigned(buffer_data(39 downto  8),32),
                            COMPLETE   => '0'
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= INT64_STATE;
                    ---------------------------------------------------------------
                    -- fixext 1  11010100
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1010100") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ExtSize(
                            SIZE       => to_unsigned(1, 8)
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= to_unsigned(1, LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        next_state     <= EXT_TYPE_STATE;
                    ---------------------------------------------------------------
                    -- fixext 2  11010101
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1010101") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ExtSize(
                            SIZE       => to_unsigned(2, 8)
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= to_unsigned(2, LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        next_state     <= EXT_TYPE_STATE;
                    ---------------------------------------------------------------
                    -- fixext 4  11010110
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1010110") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ExtSize(
                            SIZE       => to_unsigned(4, 8)
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= to_unsigned(4, LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        next_state     <= EXT_TYPE_STATE;
                    ---------------------------------------------------------------
                    -- fixext 8  11010111
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1010111") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ExtSize(
                            SIZE       => to_unsigned(8, 8)
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= to_unsigned(8, LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        next_state     <= EXT_TYPE_STATE;
                    ---------------------------------------------------------------
                    -- fixext 16 11011000
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1011000") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ExtSize(
                            SIZE       => to_unsigned(16, 8)
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= to_unsigned(16, LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        next_state     <= EXT_TYPE_STATE;
                    ---------------------------------------------------------------
                    -- str 8    11011001
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1011001") then
                        size_zero      := (to_01(unsigned(buffer_data(15 downto 8))) = 0);
                        unpack_code(0) <= MsgPack_Object.New_Code_StringSize(
                            SIZE       => be_to_unsigned(buffer_data(15 downto 8), 8)
                        );
                        unpack_valid   <= to_valid(2, buffer_valid);
                        buffer_shift   <= to_shift(2);
                        data_length    <= be_to_unsigned(buffer_data(15 downto 8), LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        if (size_zero) then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= STR_DATA_STATE;
                        end if;
                    ---------------------------------------------------------------
                    -- str 16   11011010
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1011010") then
                        size_zero      := (to_01(unsigned(buffer_data(23 downto 8))) = 0);
                        unpack_code(0) <= MsgPack_Object.New_Code_StringSize(
                            SIZE       => be_to_unsigned(buffer_data(23 downto 8), 16)
                        );
                        unpack_valid   <= to_valid(3, buffer_valid);
                        buffer_shift   <= to_shift(3);
                        data_length    <= be_to_unsigned(buffer_data(23 downto 8), LENGTH_BITS);
                        object_length  <= dummy_object_length;
                        if (size_zero) then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= STR_DATA_STATE;
                        end if;
                    ---------------------------------------------------------------
                    -- str 32   11011011
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1011011") then
                        size_zero      := (to_01(unsigned(buffer_data(39 downto 8))) = 0);
                        unpack_code(0) <= MsgPack_Object.New_Code_StringSize(
                            SIZE       => be_to_unsigned(buffer_data(39 downto 8), 32)
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= be_to_unsigned(buffer_data(39 downto 8), LENGTH_BITS);
                        next_state     <= STR_DATA_STATE;
                        object_length  <= dummy_object_length;
                        if (size_zero) then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= STR_DATA_STATE;
                        end if;
                    ---------------------------------------------------------------
                    -- array 16 11011100
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1011100") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ArraySize(
                            SIZE       => be_to_unsigned(buffer_data(23 downto 8), 16)
                        );
                        unpack_valid   <= to_valid(3, buffer_valid);
                        buffer_shift   <= to_shift(3);
                        data_length    <= be_to_unsigned(buffer_data(23 downto 8), LENGTH_BITS);
                        object_length  <= be_to_unsigned(buffer_data(23 downto 8), LENGTH_BITS);
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- array 32 11011101
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1011101") then
                        unpack_code(0) <= MsgPack_Object.New_Code_ArraySize(
                            SIZE       => be_to_unsigned(buffer_data(39 downto 8), 32)
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= be_to_unsigned(buffer_data(39 downto 8), LENGTH_BITS);
                        object_length  <= be_to_unsigned(buffer_data(39 downto 8), LENGTH_BITS);
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- map 16   11011110
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1011110") then
                        unpack_code(0) <= MsgPack_Object.New_Code_MapSize(
                            SIZE       => be_to_unsigned(buffer_data(23 downto 8), 16)
                        );
                        unpack_valid   <= to_valid(3, buffer_valid);
                        buffer_shift   <= to_shift(3);
                        data_length    <= be_to_unsigned(buffer_data(23 downto 8), LENGTH_BITS);
                        object_length  <= be_to_unsigned(buffer_data(23 downto 8), LENGTH_BITS);
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- map 32   11011111
                    ---------------------------------------------------------------
                    elsif (buffer_data(6 downto 0) = "1011111") then
                        unpack_code(0) <= MsgPack_Object.New_Code_MapSize(
                            SIZE       => be_to_unsigned(buffer_data(39 downto 8), 32)
                        );
                        unpack_valid   <= to_valid(5, buffer_valid);
                        buffer_shift   <= to_shift(5);
                        data_length    <= be_to_unsigned(buffer_data(39 downto 8), LENGTH_BITS);
                        object_length  <= be_to_unsigned(buffer_data(39 downto 8), LENGTH_BITS);
                        next_state     <= FIRST_STATE;
                    ---------------------------------------------------------------
                    -- negative fixint 111xxxxx
                    ---------------------------------------------------------------
                    else
                        unpack_code(0) <= MsgPack_Object.New_Code_Signed(
                            DATA       => be_to_signed(buffer_data(7 downto 0), 8)
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                    end if;
                -------------------------------------------------------------------
                -- Float64 Second State
                -------------------------------------------------------------------
                when FLOAT64_STATE =>
                        unpack_code(0) <= MsgPack_Object.New_Code_Float(
                            DATA       => be_to_le(buffer_data(31 downto  0)),
                            COMPLETE   => '1'
                        );
                        unpack_valid   <= to_valid(4, buffer_valid);
                        buffer_shift   <= to_shift(4);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                -------------------------------------------------------------------
                -- Unsinged Integer(64bit) Second State
                -------------------------------------------------------------------
                when UINT64_STATE =>
                        unpack_code(0) <= MsgPack_Object.New_Code_Unsigned(
                            DATA       => be_to_unsigned(buffer_data(31 downto 0), 32)
                        );
                        unpack_valid   <= to_valid(4, buffer_valid);
                        buffer_shift   <= to_shift(4);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                -------------------------------------------------------------------
                -- Signed Integer(64bit) Second State
                -------------------------------------------------------------------
                when INT64_STATE =>
                        unpack_code(0) <= MsgPack_Object.New_Code_Signed(
                            DATA       => be_to_unsigned(buffer_data(31 downto 0), 32)
                        );
                        unpack_valid   <= to_valid(4, buffer_valid);
                        buffer_shift   <= to_shift(4);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
                -------------------------------------------------------------------
                -- Ext Type State
                -------------------------------------------------------------------
                when EXT_TYPE_STATE =>
                        unpack_code(0) <= MsgPack_Object.New_Code_ExtType(
                            DATA       => buffer_data(7 downto 0),
                            COMPLETE   => data_none
                        );
                        unpack_valid   <= to_valid(1, buffer_valid);
                        buffer_shift   <= to_shift(1);
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        if (data_none = '1') then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= EXT_DATA_STATE;
                        end if;
                -------------------------------------------------------------------
                -- Ext Data State
                -------------------------------------------------------------------
                when EXT_DATA_STATE =>
                        unpack_code    <= MsgPack_Object.New_Code_Vector(
                            LENGTH     => BUFFER_WORDS,
                            CLASS      => MsgPack_Object.CLASS_EXT_DATA,
                            STRB       => data_valid,
                            DATA       => buffer_data(DECODE_BITS-1 downto 0),
                            COMPLETE   => data_none or data_last
                        );
                        unpack_valid   <= to_valid(data_valid, buffer_valid);
                        buffer_shift   <= std_logic_vector(resize(unsigned(data_valid), BUFFER_BYTES));
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        if (data_none = '1' or data_last = '1') then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= EXT_DATA_STATE;
                        end if;
                -------------------------------------------------------------------
                -- String Data State
                -------------------------------------------------------------------
                when STR_DATA_STATE =>
                        unpack_code    <= MsgPack_Object.New_Code_Vector(
                            LENGTH     => BUFFER_WORDS,
                            CLASS      => MsgPack_Object.CLASS_STRING_DATA,
                            STRB       => data_valid,
                            DATA       => buffer_data(DECODE_BITS-1 downto 0),
                            COMPLETE   => data_none or data_last
                        );
                        unpack_valid   <= to_valid(data_valid, buffer_valid);
                        buffer_shift   <= std_logic_vector(resize(unsigned(data_valid), BUFFER_BYTES));
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        if (data_none = '1' or data_last = '1') then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= STR_DATA_STATE;
                        end if;
                -------------------------------------------------------------------
                -- Binary Data State
                -------------------------------------------------------------------
                when BIN_DATA_STATE =>
                        unpack_code    <= MsgPack_Object.New_Code_Vector(
                            LENGTH     => BUFFER_WORDS,
                            CLASS      => MsgPack_Object.CLASS_BINARY_DATA,
                            STRB       => data_valid,
                            DATA       => buffer_data(DECODE_BITS-1 downto 0),
                            COMPLETE   => data_none or data_last
                        );
                        unpack_valid   <= to_valid(data_valid, buffer_valid);
                        buffer_shift   <= std_logic_vector(resize(unsigned(data_valid), BUFFER_BYTES));
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        if (data_none = '1' or data_last = '1') then
                            next_state <= FIRST_STATE;
                        else
                            next_state <= BIN_DATA_STATE;
                        end if;
                -------------------------------------------------------------------
                --
                -------------------------------------------------------------------
                when others =>
                        unpack_code    <= MsgPack_Object.New_Code_Vector(
                            LENGTH     => BUFFER_WORDS,
                            CLASS      => MsgPack_Object.CLASS_NONE,
                            STRB       => data_valid,
                            DATA       => buffer_data(DECODE_BITS-1 downto 0),
                            COMPLETE   => '1'
                        );
                        unpack_valid   <= to_valid(data_valid, buffer_valid);
                        buffer_shift   <= std_logic_vector(resize(unsigned(data_valid), BUFFER_BYTES));
                        data_length    <= dummy_data_length;
                        object_length  <= dummy_object_length;
                        next_state     <= FIRST_STATE;
            end case;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        unpack_complete <= '1' when (next_state = FIRST_STATE) else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (CLK, RST) begin
            if (RST = '1') then
                    curr_state        <= FIRST_STATE;
                    data_length_load  <= '1';
            elsif rising_edge(CLK) then
                if (CLR = '1') then
                    curr_state        <= FIRST_STATE;
                    data_length_load  <= '1';
                elsif (outlet_valid = '1' and outlet_ready = '1') then
                    curr_state        <= next_state;
                    if (next_state = FIRST_STATE) then
                        data_length_load <= '1';
                    else
                        data_length_load <= '0';
                    end if;
                end if;
            end if;
        end process;
        data_chop    <= '1' when (curr_state = STR_DATA_STATE and outlet_valid = '1' and outlet_ready = '1') or
                                 (curr_state = BIN_DATA_STATE and outlet_valid = '1' and outlet_ready = '1') or
                                 (curr_state = EXT_DATA_STATE and outlet_valid = '1' and outlet_ready = '1') else '0';
        buffer_ready <= '1' when (unpack_valid = '1' and outlet_ready = '1' and stack_ready = '1') else '0';
        outlet_valid <= '1' when (unpack_valid = '1' and stack_ready  = '1') else '0';
    end block;
    -------------------------------------------------------------------------------
    -- String/Binary/Ext Data Chopper
    -------------------------------------------------------------------------------
    CHOP: CHOPPER                                       -- 
        generic map (                                   -- 
            BURST           => 1                      , -- 
            MIN_PIECE       => DECODE_UNIT+2          , -- 
            MAX_PIECE       => DECODE_UNIT+2          , -- 
            MAX_SIZE        => LENGTH_BITS            , -- 
            ADDR_BITS       => 1                      , --
            SIZE_BITS       => LENGTH_BITS            , -- 
            COUNT_BITS      => LENGTH_BITS            , --
            PSIZE_BITS      => DECODE_UNIT+3          , -- 
            GEN_VALID       => 1                        -- 
        )                                               -- 
        port map(                                       -- 
        ---------------------------------------------------------------------------
        -- Clock and Reset Signals
        ---------------------------------------------------------------------------
            CLK             => CLK                    , -- In  :
            RST             => RST                    , -- In  :
            CLR             => CLR                    , -- In  :
        ---------------------------------------------------------------------------
        -- Initialize Address and Size
        ---------------------------------------------------------------------------
            ADDR            => "0"                    , -- In  :
            SIZE            => std_logic_vector(data_length) , -- In  :
            SEL             => "1"                    , -- In  :
            LOAD            => data_length_load       , -- In  :
        ---------------------------------------------------------------------------
        -- Control Signal
        ---------------------------------------------------------------------------
            CHOP            => data_chop              , -- In  :
        ---------------------------------------------------------------------------
        -- Piece Counter and Flags
        ---------------------------------------------------------------------------
            COUNT           => open                   , -- Out :
            NONE            => data_none              , -- Out :
            LAST            => data_last              , -- Out :
            NEXT_NONE       => open                   , -- Out :
            NEXT_LAST       => open                   , -- Out :
        ---------------------------------------------------------------------------
        -- Piece Size
        ---------------------------------------------------------------------------
            PSIZE           => open                   , -- Out :
            NEXT_PSIZE      => open                   , -- Out :
        ---------------------------------------------------------------------------
        -- Piece Valid Flag
        ---------------------------------------------------------------------------
            VALID           => data_valid             , -- Out :
            NEXT_VALID      => open                     -- Out :
        );                                              -- 
    -------------------------------------------------------------------------------
    -- Array or Map Stack
    -------------------------------------------------------------------------------
    object_valid <= '1' when (unpack_valid = '1' and outlet_ready = '1') else '0';
    object_map   <= '1' when (unpack_code(0).class = MsgPack_Object.CLASS_MAP  ) else '0';
    object_array <= '1' when (unpack_code(0).class = MsgPack_Object.CLASS_ARRAY) else '0';
    STACK: MsgPack_Structure_Stack                  -- 
        generic map (                               -- 
            DEPTH           => STACK_DEPTH          -- 
        )                                           -- 
        port map (                                  -- 
            CLK             => CLK                , -- In  :
            RST             => RST                , -- In  :
            CLR             => CLR                , -- In  :
            I_VALID         => object_valid       , -- In  :
            I_SIZE          => std_logic_vector(object_length), -- In  :
            I_MAP           => object_map         , -- In  :
            I_ARRAY         => object_array       , -- In  :
            I_COMPLETE      => unpack_complete    , -- In  :
            I_READY         => stack_ready        , -- In  :
            O_LAST          => unpack_last        , -- Out :
            O_NONE          => open               , -- Out :
            O_FULL          => open                 -- 
        );                                          --
    -------------------------------------------------------------------------------
    -- Output MsgPack_Object_Code Buffer
    -------------------------------------------------------------------------------
    OUTLET: MsgPack_Object_Code_Reducer             -- 
        generic map (                               -- 
            I_WIDTH         => DECODE_WORDS       , -- 
            O_WIDTH         => CODE_WIDTH         , -- Output Object Code Width
            O_VALID_SIZE    => O_VALID_SIZE       , -- 
            QUEUE_SIZE      => 0                    -- Queue size is auto
        )                                           -- 
        port map (                                  -- 
        ---------------------------------------------------------------------------
        -- Clock and Reset Signals
        ---------------------------------------------------------------------------
            CLK             => CLK                , -- In  :
            RST             => RST                , -- In  :
            CLR             => CLR                , -- In  :
        ---------------------------------------------------------------------------
        -- Control and Status Signals
        ---------------------------------------------------------------------------
            DONE            => '0'                , -- In  :
            BUSY            => open               , -- Out :
        ---------------------------------------------------------------------------
        -- Object Code Input Interface
        ---------------------------------------------------------------------------
            I_ENABLE        => '1'                , -- In  :
            I_CODE          => unpack_code(DECODE_WORDS-1 downto 0), -- In  :
            I_DONE          => unpack_last        , -- In  :
            I_VALID         => outlet_valid       , -- In  :
            I_READY         => outlet_ready       , -- Out :
        ---------------------------------------------------------------------------
        -- Object Code Output Interface
        ---------------------------------------------------------------------------
            O_ENABLE        => '1'                , -- In  :
            O_CODE          => O_CODE             , -- Out :
            O_DONE          => O_LAST             , -- Out :
            O_VALID         => O_VALID            , -- Out :
            O_READY         => O_READY            , -- In  :
            O_SHIFT         => O_SHIFT              -- In  :
    );                                              -- 
end RTL;
-----------------------------------------------------------------------------------
--!     @file    queue_arbiter.vhd
--!     @brief   QUEUE ARBITER MODULE :
--!              キュータイプの調停回路
--!     @version 1.0.0
--!     @date    2012/8/11
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012 Ichiro Kawazome
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
--! @brief   QUEUE ARBITER :
--!          キュー(ファーストインファーストアウト)方式の調停回路.
--!        * 要求を到着順に許可することを特徴とする調停回路.
--!        * キュー方式が他の一般的な固定優先順位方式やラウンドロビン方式に比べて
--!          有利な点は次の二つ.
--!          * 必ず要求はいつかは許可されることが保証されている.
--!            固定優先順位方式の場合、場合によっては永久に要求が許可されることが
--!            ないことが起り得るが、キュー方式はそれがない.
--!          * 要求された順番が変わることがない.
--!            用途によっては順番が変わることで誤動作する場合があるが、
--!            キュー方式ではそれに対応できる.
--!        * 一般的な固定優先順位方式やラウンドロビン方式の調停回路と異なり、
--!          要求が到着した順番を記録しているため、
--!          回路規模は他の方式に比べて大きい傾向がある.
-----------------------------------------------------------------------------------
entity  QUEUE_ARBITER is
    generic (
        MIN_NUM     : --! @brief REQUEST MINIMUM NUMBER :
                      --! リクエストの最小番号を指定する.
                      integer := 0;
        MAX_NUM     : --! @brief REQUEST MAXIMUM NUMBER :
                      --! リクエストの最大番号を指定する.
                      integer := 7
    );
    port (
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
        ENABLE      : --! @brief ARBITORATION ENABLE :
                      --! この調停回路を有効にするかどうかを指定する.
                      --! * 幾つかの調停回路を組み合わせて使う場合、設定によっては
                      --!  この調停回路の出力を無効にしたいことがある.
                      --!  その時はこの信号を'0'にすることで簡単に出来る.
                      --! * ENABLE='1'でこの回路は調停を行う.
                      --! * ENABLE='0'でこの回路は調停を行わない.
                      --!   この場合REQUEST信号に関係なREQUEST_OおよびGRANTは'0'になる.
                      --!   リクエストキューの中身は破棄される.
                      in  std_logic := '1';
        REQUEST     : --! @brief REQUEST INPUT :
                      --! リクエスト入力.
                      in  std_logic_vector(MIN_NUM to MAX_NUM);
        GRANT       : --! @brief GRANT OUTPUT :
                      --! 調停結果出力.
                      out std_logic_vector(MIN_NUM to MAX_NUM);
        GRANT_NUM   : --! @brief GRANT NUMBER :
                      --! 許可番号.
                      --! * ただしリクエストキューに次の要求が無い場合でも、
                      --!   なんらかの番号を出力してしまう.
                      out integer   range  MIN_NUM to MAX_NUM;
        REQUEST_O   : --! @brief REQUEST OUTOUT :
                      --! リクエストキューに次の要求があることを示す信号.
                      --! * VALIDと異なり、リクエストキューに次の要求があっても、
                      --!   対応するREQUEST信号が'0'の場合はアサートされない.
                      out std_logic;
        VALID       : --! @brief REQUEST QUEUE VALID :
                      --! リクエストキューに次の要求があることを示す信号.
                      --! * REQUEST_Oと異なり、リスエストキューに次の要求があると
                      --!   対応するREQUEST信号の状態に関わらずアサートされる.
                      out std_logic;
        SHIFT       : --! @brief REQUEST QUEUE SHIFT :
                      --! リクエストキューの先頭からリクエストを取り除く信号.
                      in  std_logic
    );
end     QUEUE_ARBITER;
-----------------------------------------------------------------------------------
--!     @file    queue_arbiter_one_hot_arch.vhd
--!     @brief   QUEUE ARBITER ONE HOT ARCHITECTURE :
--!              キュータイプの調停回路のアーキテクチャ(ワンホット)
--!     @version 1.0.0
--!     @date    2012/8/11
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012 Ichiro Kawazome
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
architecture ONE_HOT_ARCH of QUEUE_ARBITER is
    subtype  REQUEST_TYPE   is std_logic_vector(MIN_NUM to MAX_NUM);
    constant REQUEST_NULL   :  std_logic_vector(MIN_NUM to MAX_NUM) := (others => '0');
    type     REQUEST_VECTOR is array(integer range <>) of REQUEST_TYPE;
    constant QUEUE_TOP      :  integer := MIN_NUM;
    constant QUEUE_END      :  integer := MAX_NUM;
    signal   curr_queue     :  REQUEST_VECTOR  (QUEUE_TOP to QUEUE_END);
    signal   next_queue     :  REQUEST_VECTOR  (QUEUE_TOP to QUEUE_END);
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (ENABLE, REQUEST, curr_queue)
        variable req_enable :  REQUEST_TYPE;
        variable req_select :  REQUEST_TYPE;
        variable temp_queue :  REQUEST_VECTOR(QUEUE_TOP to QUEUE_END);
        variable temp_num   :  integer range MIN_NUM to MAX_NUM ;
    begin
        --------------------------------------------------------------------------
        -- ENABLE信号がネゲートされている場合.
        --------------------------------------------------------------------------
        if    (ENABLE /= '1') then
                next_queue <= (others => REQUEST_NULL);
                VALID      <= '0';
                REQUEST_O  <= '0';
                GRANT_NUM  <= MIN_NUM;
                GRANT      <= (others => '0');
        --------------------------------------------------------------------------
        -- リクエスト信号が一つしかない場合は話は簡単だ.
        --------------------------------------------------------------------------
        elsif (MIN_NUM >= MAX_NUM) then
            if (REQUEST(MIN_NUM) = '1') then 
                next_queue <= (others => REQUEST_NULL);
                VALID      <= '1';
                REQUEST_O  <= '1';
                GRANT_NUM  <= MIN_NUM;
                GRANT      <= (others => '1');
            else
                next_queue <= (others => REQUEST_NULL);
                VALID      <= '0';
                REQUEST_O  <= '0';
                GRANT_NUM  <= MIN_NUM;
                GRANT      <= (others => '0');
            end if;
        --------------------------------------------------------------------------
        -- 複数のリクエスト信号がある場合は調停しなければならない.
        -- あたりまえだ. それがこの回路の本来の仕事だ.
        --------------------------------------------------------------------------
        else
            req_enable := (others => '1');
            for i in QUEUE_TOP to QUEUE_END loop
                if (curr_queue(i) /= REQUEST_NULL) then
                    req_select := curr_queue(i);
                else
                    req_select := (others => '0');
                    for n in MIN_NUM to MAX_NUM loop
                        if (REQUEST(n) = '1' and req_enable(n) = '1') then
                            req_select(n) := '1';
                            exit;
                        end if;
                    end loop;
                end if;
                temp_queue(i) := req_select;
                req_enable    := req_enable and not req_select;
            end loop;
            if (temp_queue(QUEUE_TOP) /= REQUEST_NULL) then
                VALID <= '1';
            else
                VALID <= '0';
            end if;
            if ((temp_queue(QUEUE_TOP) and REQUEST) /= REQUEST_NULL) then
                REQUEST_O <= '1';
            else
                REQUEST_O <= '0';
            end if;
            GRANT      <= temp_queue(QUEUE_TOP) and REQUEST;
            next_queue <= temp_queue;
            temp_num   := MIN_NUM;
            for n in MIN_NUM to MAX_NUM loop
                if (temp_queue(QUEUE_TOP)(n) = '1') then
                    temp_num := n;
                    exit;
                end if;
            end loop;
            GRANT_NUM <= temp_num;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if     (RST = '1') then
                curr_queue <= (others => REQUEST_NULL);
        elsif  (CLK'event and CLK = '1') then
            if (CLR     = '1') or
               (ENABLE /= '1') then
                curr_queue <= (others => REQUEST_NULL);
            elsif (SHIFT = '1') then
                for i in QUEUE_TOP to QUEUE_END loop
                    if (i < QUEUE_END) then
                        curr_queue(i) <= next_queue(i+1);
                    else
                        curr_queue(i) <= REQUEST_NULL;
                    end if;
                end loop;
            else
                curr_queue <= next_queue;
            end if;
        end if;
    end process;
end ONE_HOT_ARCH;
-----------------------------------------------------------------------------------
--!     @file    queue_register.vhd
--!     @brief   QUEUE REGISTER MODULE :
--!              フリップフロップベースの比較的浅いキュー.
--!     @version 1.5.0
--!     @date    2013/4/2
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012,2013 Ichiro Kawazome
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
--! @brief   QUEUE REGISTER
--!          フリップフロップベースの比較的浅いキュー.
--!        * フリップフロップを使っているのでキューの段数が大きいと
--!          それなりに回路規模が大きくなることに注意.
-----------------------------------------------------------------------------------
entity  QUEUE_REGISTER is
    -------------------------------------------------------------------------------
    -- ジェネリック変数
    -------------------------------------------------------------------------------
    generic (
        QUEUE_SIZE  : --! @brief QUEUE SIZE :
                      --! キューの大きさをワード数で指定する.
                      integer := 1;
        DATA_BITS   : --! @brief DATA BITS :
                      --! データ(I_DATA/O_DATA/Q_DATA)のビット幅を指定する.
                      integer :=  32;
        LOWPOWER    : --! @brief LOW POWER MODE :
                      --! キューのレジスタに不必要なロードを行わないことにより、
                      --! レジスタが不必要にトグルすることを防いで消費電力を
                      --! 下げるようにする.
                      --! ただし、回路が若干増える.
                      integer range 0 to 1 := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- クロック&リセット信号
    -------------------------------------------------------------------------------
        CLK         : --! @brief CLOCK :
                      --! クロック信号
                      in  std_logic; 
        RST         : --! @brief ASYNCRONOUSE RESET :
                      --! 非同期リセット信号.アクティブハイ.
                      in  std_logic;
        CLR         : --! @brief SYNCRONOUSE RESET :
                      --! 同期リセット信号.アクティブハイ.
                      in  std_logic;
    -------------------------------------------------------------------------------
    -- 入力側
    -------------------------------------------------------------------------------
        I_DATA      : --! @brief INPUT DATA  :
                      --! 入力データ信号.
                      in  std_logic_vector(DATA_BITS-1 downto 0);
        I_VAL       : --! @brief INPUT DATA VALID :
                      --! 入力データ有効信号.
                      in  std_logic;
        I_RDY       : --! @brief INPUT READY :
                      --! 入力可能信号.
                      --! キューが空いていて、入力データを受け付けることが可能で
                      --! あることを示す信号.
                      out std_logic;
    -------------------------------------------------------------------------------
    -- 出力側
    -------------------------------------------------------------------------------
        O_DATA      : --! @brief OUTPUT DATA :
                      --! 出力データ.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        O_VAL       : --! @brief OUTPUT DATA VALID :
                      --! キューレジスタに有効なデータが入っている事を示すフラグ.
                      --! * キューレジスタは1〜QUEUE_SIZEまであるが、対応する位置の
                      --!   フラグが'1'ならば有効なデータが入っている事を示す.
                      --! * この出力信号の範囲が1からではなく0から始まっている事に
                      --!   注意. これはQUEUE_SIZE=0の場合に対応するため.
                      --!   QUEUE_SIZE>0の場合は、O_VAL(0)はO_VAL(1)と同じ.
                      out std_logic_vector(QUEUE_SIZE  downto 0);
        Q_DATA      : --! @brief OUTPUT REGISTERD DATA :
                      --! レジスタ出力の出力データ.
                      --! 出力データ(O_DATA)をクロックで叩いたもの.
                      out std_logic_vector(DATA_BITS-1 downto 0);
        Q_VAL       : --! @brief OUTPUT REGISTERD DATA VALID :
                      --! キューレジスタに有効なデータが入っている事を示すフラグ.
                      --! O_VALをクロックで叩いたもの.
                      --! * キューレジスタは1〜QUEUE_SIZEまであるが、対応する位置の
                      --!   フラグが'1'ならば有効なデータが入っている事を示す.
                      --! * この出力信号の範囲が1からではなく0から始まっている事に
                      --!   注意. これはQUEUE_SIZE=0の場合に対応するため.
                      --!   QUEUE_SIZE>0の場合は、Q_VAL(0)はQ_VAL(1)と同じ.
                      out std_logic_vector(QUEUE_SIZE  downto 0);
        Q_RDY       : --! @brief OUTPUT READY :
                      --! 出力可能信号.
                      in  std_logic
    );
end QUEUE_REGISTER;
-----------------------------------------------------------------------------------
-- アーキテクチャ本体
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
architecture RTL of QUEUE_REGISTER is
begin
    -------------------------------------------------------------------------------
    --  QUEUE_SIZE=0の場合はなにもしない
    -------------------------------------------------------------------------------
    QUEUE_SIZE_EQ_0: if (QUEUE_SIZE = 0) generate
        O_DATA   <= I_DATA;
        Q_DATA   <= I_DATA;
        O_VAL(0) <= I_VAL;
        Q_VAL(0) <= I_VAL;
        I_RDY    <= Q_RDY;
    end generate;
    -------------------------------------------------------------------------------
    -- QUEUE_SIZE>0の場合
    -------------------------------------------------------------------------------
    QUEUE_SIZE_GT_0: if (QUEUE_SIZE > 0) generate
        subtype  QUEUE_DATA_TYPE   is std_logic_vector(DATA_BITS-1 downto 0);
        constant QUEUE_DATA_NULL    : std_logic_vector(DATA_BITS-1 downto 0) := (others => '0');
        type     QUEUE_DATA_VECTOR is array (natural range <>) of QUEUE_DATA_TYPE;
        constant FIRST_OF_QUEUE     : integer := 1;
        constant LAST_OF_QUEUE      : integer := QUEUE_SIZE;
        signal   next_queue_data    : QUEUE_DATA_VECTOR(LAST_OF_QUEUE downto FIRST_OF_QUEUE);
        signal   curr_queue_data    : QUEUE_DATA_VECTOR(LAST_OF_QUEUE downto FIRST_OF_QUEUE);
        signal   queue_data_load    : std_logic_vector (LAST_OF_QUEUE downto FIRST_OF_QUEUE);
        signal   next_queue_valid   : std_logic_vector (LAST_OF_QUEUE downto FIRST_OF_QUEUE);
        signal   curr_queue_valid   : std_logic_vector (LAST_OF_QUEUE downto FIRST_OF_QUEUE);
    begin
        ---------------------------------------------------------------------------
        -- next_queue_valid : 次のクロックでのキューの状態を示すフラグ.
        -- queue_data_load  : 次のクロックでcurr_queue_dataにnext_queue_dataの値を
        --                    ロードすることを示すフラグ.
        ---------------------------------------------------------------------------
        process (I_VAL, Q_RDY, curr_queue_valid) begin
            for i in FIRST_OF_QUEUE to LAST_OF_QUEUE loop
                -------------------------------------------------------------------
                -- 自分のキューにデータが格納されている場合...
                -------------------------------------------------------------------
                if (curr_queue_valid(i) = '1') then
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されていて、
                    -- かつ自分がキューの最後ならば、
                    -- Q_RDY='1'で自分のキューをクリアする.
                    ---------------------------------------------------------------
                    if (i = LAST_OF_QUEUE) then
                        if (Q_RDY = '1') then
                            next_queue_valid(i) <= '0';
                        else
                            next_queue_valid(i) <= '1';
                        end if;
                        queue_data_load(i) <= '0';
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されていて、
                    -- かつ自分がキューの最後でなくて、
                    -- かつ後ろのキューにデータが入っているならば、
                    -- Q_RDY='1'で後ろのキューのデータを自分のキューに格納する.
                    ---------------------------------------------------------------
                    elsif (curr_queue_valid(i+1) = '1') then
                        next_queue_valid(i) <= '1';
                        if (Q_RDY = '1') then
                            queue_data_load(i) <= '1';
                        else
                            queue_data_load(i) <= '0';
                        end if;
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されていて、
                    -- かつ自分がキューの最後でなくて、
                    -- かつ後ろのキューにデータが入っていないならば、
                    -- I_VAL='0' かつ Q_RDY='1'ならば自分のキューをクリアする. 
                    -- I_VAL='1' かつ Q_RDY='1'ならばI_DATAを自分のキューに格納する.
                    ---------------------------------------------------------------
                    else
                        if (I_VAL = '0' and Q_RDY = '1') then
                            next_queue_valid(i) <= '0';
                        else
                            next_queue_valid(i) <= '1';
                        end if;
                        if (LOWPOWER > 0 and I_VAL = '1' and Q_RDY = '1') or
                           (LOWPOWER = 0                 and Q_RDY = '1') then
                            queue_data_load(i)  <= '1';
                        else
                            queue_data_load(i)  <= '0';
                        end if;
                    end if;
                -------------------------------------------------------------------
                -- 自分のところにデータが格納されていない場合...
                -------------------------------------------------------------------
                else -- if (curr_queue_valid(i) = '0') then
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されてなくて、
                    -- かつ自分がキューの先頭ならば、
                    -- I_VAL='1'で自分のキューにデータを格納する.
                    ---------------------------------------------------------------
                    if    (i = FIRST_OF_QUEUE) then
                        if (I_VAL = '1') then
                            next_queue_valid(i) <= '1';
                            queue_data_load(i)  <= '1';
                        else
                            next_queue_valid(i) <= '0';
                            queue_data_load(i)  <= '0';
                        end if;
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されてなくて、
                    -- かつ自分がキューの先頭なくて、
                    -- かつ前のキューにデータが格納されているならば、
                    -- I_VAL='1'かつQ_RDY='0'で自分のキューにデータを格納する.
                    ---------------------------------------------------------------
                    elsif (curr_queue_valid(i-1) = '1') then
                        if (I_VAL = '1' and Q_RDY = '0') then
                            next_queue_valid(i) <= '1';
                        else
                            next_queue_valid(i) <= '0';
                        end if;
                        if (LOWPOWER = 0) or
                           (LOWPOWER > 0 and I_VAL = '1' and Q_RDY = '0') then
                            queue_data_load(i)  <= '1';
                        else
                            queue_data_load(i)  <= '0';
                        end if;
                    ---------------------------------------------------------------
                    -- もし自分のキューにデータが格納されてなくて、
                    -- かつ自分がキューの先頭なくて、
                    -- かつ前のキューにデータが格納されていないならば、
                    -- キューは空のまま.
                    ---------------------------------------------------------------
                    else
                            next_queue_valid(i) <= '0';
                            queue_data_load(i)  <= '0';
                    end if;
                end if;
            end loop;
        end process;
        ---------------------------------------------------------------------------
        -- next_queue_data  : 次のクロックでキューに格納されるデータ.
        ---------------------------------------------------------------------------
        process (I_DATA, queue_data_load, curr_queue_data, curr_queue_valid) begin
            for i in FIRST_OF_QUEUE to LAST_OF_QUEUE loop
                if (queue_data_load(i) = '1') then
                    if    (i = LAST_OF_QUEUE) then
                        next_queue_data(i) <= I_DATA;
                    elsif (curr_queue_valid(i+1) = '1') then
                        next_queue_data(i) <= curr_queue_data(i+1);
                    else
                        next_queue_data(i) <= I_DATA;
                    end if;
                else
                        next_queue_data(i) <= curr_queue_data(i);
                end if;
            end loop;
        end process;
        ---------------------------------------------------------------------------
        -- curr_queue_data  : 現在、キューに格納されているデータ.
        -- curr_queue_valid : 現在、キューにデータが格納されていることを示すフラグ.
        -- I_RDY            : キューにデータが格納することが出来ることを示すフラグ.
        ---------------------------------------------------------------------------
        process (CLK, RST) begin
            if     (RST = '1') then
                   curr_queue_data  <= (others => QUEUE_DATA_NULL);
                   curr_queue_valid <= (others => '0');
                   I_RDY            <= '0';
            elsif  (CLK'event and CLK = '1') then
               if (CLR = '1') then
                   curr_queue_data  <= (others => QUEUE_DATA_NULL);
                   curr_queue_valid <= (others => '0');
                   I_RDY            <= '0';
               else
                   curr_queue_data  <= next_queue_data;
                   curr_queue_valid <= next_queue_valid;
                   I_RDY            <= not next_queue_valid(LAST_OF_QUEUE);
               end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        -- 各種出力信号
        ---------------------------------------------------------------------------
        O_DATA                     <= next_queue_data (FIRST_OF_QUEUE);
        Q_DATA                     <= curr_queue_data (FIRST_OF_QUEUE);
        O_VAL(0)                   <= next_queue_valid(FIRST_OF_QUEUE);
        O_VAL(QUEUE_SIZE downto 1) <= next_queue_valid;
        Q_VAL(0)                   <= curr_queue_valid(FIRST_OF_QUEUE);
        Q_VAL(QUEUE_SIZE downto 1) <= curr_queue_valid;
    end generate;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_rpc.vhd
--!     @brief   MessagePack-RPC(Remote Procedure Call) Package :
--!     @version 0.2.5
--!     @date    2017/3/14
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2015-2017 Ichiro Kawazome
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
use     MsgPack.MsgPack_Object;
package MsgPack_RPC is

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  Code_Length       :  integer := 1;

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    subtype   Code_Type         is MsgPack_Object.Code_Vector(Code_Length-1 downto 0);
    type      Code_Vector       is array (integer range <>) of Code_Type;
    constant  Code_Null         :  Code_Type  := (others => MsgPack_Object.CODE_NULL);

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    subtype   Shift_Type        is std_logic_vector(Code_Length-1 downto 0);
    type      Shift_Vector      is array (integer range <>) of Shift_Type;
    constant  Shift_Null        :  Shift_Type := (others => '0');
    function  To_Shift_Type(Num:integer) return Shift_Type;

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    subtype   MsgID_Type        is std_logic_vector(31 downto 0);
    type      MsgID_Vector      is array (integer range <>) of MsgID_Type;
    constant  MsgID_Null        :  MsgID_Type := (others => '0');
    
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  ERROR_CODE_PROC_BUSY       :  integer := 0;
    constant  ERROR_CODE_NO_METHOD       :  integer := 1;
    constant  ERROR_CODE_INVALID_ARGMENT :  integer := 2;
    constant  ERROR_CODE_INVALID_MESSAGE :  integer := 3;

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Error_Code(CODE:integer)   return MsgPack_Object.Code_Type;
    constant  New_Error_Code_Proc_Busy       : MsgPack_Object.Code_Type := New_Error_Code(ERROR_CODE_PROC_BUSY);
    constant  New_Error_Code_No_Method       : MsgPack_Object.Code_Type := New_Error_Code(ERROR_CODE_NO_METHOD);
    constant  New_Error_Code_Invalid_Argment : MsgPack_Object.Code_Type := New_Error_Code(ERROR_CODE_INVALID_ARGMENT);
    constant  New_Error_Code_Invalid_Message : MsgPack_Object.Code_Type := New_Error_Code(ERROR_CODE_INVALID_MESSAGE);

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Error_Code_Vector   (CODE:integer;LENGTH:integer) return MsgPack_Object.Code_Vector;
    function  New_Error_Code_Vector_Proc_Busy      (LENGTH:integer) return MsgPack_Object.Code_Vector;
    function  New_Error_Code_Vector_No_Method      (LENGTH:integer) return MsgPack_Object.Code_Vector;
    function  New_Error_Code_Vector_Invalid_Argment(LENGTH:integer) return MsgPack_Object.Code_Vector;
    function  New_Error_Code_Vector_Invalid_Message(LENGTH:integer) return MsgPack_Object.Code_Vector;

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  Is_Error_Code    (NUM:integer;CODE:MsgPack_Object.Code_Type) return boolean;
    function  Is_Error_Code_Proc_Busy      (CODE:MsgPack_Object.Code_Type) return boolean;
    function  Is_Error_Code_No_Method      (CODE:MsgPack_Object.Code_Type) return boolean;
    function  Is_Error_Code_Invalid_Argment(CODE:MsgPack_Object.Code_Type) return boolean;
    function  Is_Error_Code_Invalid_Message(CODE:MsgPack_Object.Code_Type) return boolean;

    
end MsgPack_RPC;
-----------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
package body MsgPack_RPC is

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  To_Shift_Type(Num:integer) return Shift_Type is
        variable shift :  Shift_Type;
    begin
        for i in shift'range loop
            if (i < Num) then
                shift(i) := '1';
            else
                shift(i) := '0';
            end if;
        end loop;
        return shift;
    end function;

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Error_Code(CODE:integer)   return MsgPack_Object.Code_Type is begin 
        return MsgPack_Object.New_Code_Reserve(CODE);
    end function;

    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  New_Error_Code_Vector   (CODE:integer;LENGTH:integer) return MsgPack_Object.Code_Vector is
    begin
        return MsgPack_Object.New_Code_Vector_Reserve(LENGTH,CODE);
    end function;

    function  New_Error_Code_Vector_Proc_Busy      (LENGTH:integer) return MsgPack_Object.Code_Vector is
    begin
        return New_Error_Code_Vector(ERROR_CODE_PROC_BUSY, LENGTH);
    end function;

    function  New_Error_Code_Vector_No_Method      (LENGTH:integer) return MsgPack_Object.Code_Vector is
    begin
        return New_Error_Code_Vector(ERROR_CODE_NO_METHOD, LENGTH);
    end function;
        
    function  New_Error_Code_Vector_Invalid_Argment(LENGTH:integer) return MsgPack_Object.Code_Vector is
    begin
        return New_Error_Code_Vector(ERROR_CODE_INVALID_ARGMENT, LENGTH);
    end function;
        
    function  New_Error_Code_Vector_Invalid_Message(LENGTH:integer) return MsgPack_Object.Code_Vector is
    begin
        return New_Error_Code_Vector(ERROR_CODE_INVALID_MESSAGE, LENGTH);
    end function;
        
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  Is_Error_Code    (NUM:integer;CODE:MsgPack_Object.Code_Type) return boolean is
    begin
        return ((CODE.class = MsgPack_Object.CLASS_RESERVE) and
                (CODE.valid = '1'                         ) and
                (CODE.data(3 downto 0) = std_logic_vector(to_unsigned(NUM, 4))));
    end function;

    function  Is_Error_Code_Proc_Busy      (CODE:MsgPack_Object.Code_Type) return boolean is
    begin
        return Is_Error_Code(ERROR_CODE_PROC_BUSY, CODE);
    end function;
        
    function  Is_Error_Code_No_Method      (CODE:MsgPack_Object.Code_Type) return boolean is
    begin
        return Is_Error_Code(ERROR_CODE_NO_METHOD, CODE);
    end function;
        
    function  Is_Error_Code_Invalid_Argment(CODE:MsgPack_Object.Code_Type) return boolean is
    begin
        return Is_Error_Code(ERROR_CODE_INVALID_ARGMENT, CODE);
    end function;

    function  Is_Error_Code_Invalid_Message(CODE:MsgPack_Object.Code_Type) return boolean is
    begin
        return Is_Error_Code(ERROR_CODE_INVALID_MESSAGE, CODE);
    end function;
    
end MsgPack_RPC;
-----------------------------------------------------------------------------------
--!     @file    msgpack_kvmap_key_compare.vhd
--!     @brief   MessagePack-KVMap(Key Value Map) Key Compare :
--!     @version 0.2.0
--!     @date    2016/6/24
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
library MsgPack;
use     MsgPack.MsgPack_Object;
entity  MsgPack_KVMap_Key_Compare is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      : positive := 1;
        I_MAX_PHASE     : positive := 1;
        KEYWORD         : string
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- Input Object Code Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_REQ_PHASE     : in  std_logic_vector(I_MAX_PHASE-1 downto 0);
    -------------------------------------------------------------------------------
    -- Compare Result Output
    -------------------------------------------------------------------------------
        MATCH           : out std_logic;
        MISMATCH        : out std_logic;
        SHIFT           : out std_logic_vector(CODE_WIDTH-1 downto 0)
    );
end MsgPack_KVMap_Key_Compare;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Code_Compare;
architecture RTL of MsgPack_KVMap_Key_Compare is
    constant  CODE_DATA_BYTES    :  integer := MsgPack_Object.CODE_DATA_BYTES;
    constant  STR_CODE_WIDTH     :  integer := (KEYWORD'length+CODE_DATA_BYTES-1)/CODE_DATA_BYTES + 1;
    constant  STR_CODE           :  MsgPack_Object.Code_Vector(STR_CODE_WIDTH-1 downto 0)
                                 := MsgPack_Object.New_Code_Vector_String(STR_CODE_WIDTH, KEYWORD);
begin
    COMP: MsgPack_Object_Code_Compare            -- 
        generic map (                            -- 
            C_WIDTH         => STR_CODE_WIDTH  , -- 
            I_WIDTH         => CODE_WIDTH      , -- 
            I_MAX_PHASE     => I_MAX_PHASE       -- 
        )                                        -- 
        port map (                               -- 
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
            I_CODE          => I_CODE          , -- In  :
            I_REQ_PHASE     => I_REQ_PHASE     , -- In  :
            C_CODE          => STR_CODE        , -- In  :
            MATCH           => MATCH           , -- Out :
            MISMATCH        => MISMATCH        , -- Out :
            SHIFT           => SHIFT             -- Out :
        );
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_object_decode_integer.vhd
--!     @brief   MessagePack Object decode to integer
--!     @version 0.2.0
--!     @date    2015/11/9
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
library MsgPack;
use     MsgPack.MsgPack_Object;
entity  MsgPack_Object_Decode_Integer is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        QUEUE_SIZE      :  integer  := 0;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE 
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Integer Value Output Interface
    -------------------------------------------------------------------------------
        O_VALUE         : out std_logic_vector(VALUE_BITS-1 downto 0);
        O_SIGN          : out std_logic;
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic
    );
end  MsgPack_Object_Decode_Integer;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.PipeWork_Components.QUEUE_REGISTER;
architecture RTL of MsgPack_Object_Decode_Integer is
    signal   ii_sign     :  std_logic;
    signal   ii_value    :  std_logic_vector(63 downto 0);
    signal   ii_valid    :  std_logic_vector( 1 downto 0);
    signal   ii_shift    :  std_logic_vector( 1 downto 0);
    signal   ii_ready    :  std_logic;
    signal   done        :  boolean;
    signal   type_error  :  boolean;
    signal   range_error :  boolean;
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    SHORT_VEC: if (CODE_WIDTH  < 2) generate
        type      STATE_TYPE    is (IDLE_STATE, INT64_STATE, UINT64_STATE);
        signal    curr_state    :  STATE_TYPE;
        signal    next_state    :  STATE_TYPE;
        signal    upper_value   :  std_logic_vector(31 downto 0);
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (I_VALID, I_CODE, curr_state, ii_ready) begin
            if (I_VALID = '1' and I_CODE(0).valid = '1' and ii_ready = '1') then
                if     (ENABLE64   = TRUE) and
                       (curr_state = INT64_STATE) then
                    if (I_CODE(0).complete = '1') and
                       (I_CODE(0).class    = MsgPack_Object.CLASS_INT ) then
                        type_error <= FALSE;
                        done       <= TRUE;
                        ii_valid   <= "11";
                        ii_shift   <= "01";
                        next_state <= IDLE_STATE;
                    else
                        type_error <= TRUE;
                        done       <= TRUE;
                        ii_valid   <= "00";
                        ii_shift   <= "00";
                        next_state <= IDLE_STATE;
                    end if;
                elsif  (ENABLE64   = TRUE) and
                       (curr_state = UINT64_STATE) then
                    if (I_CODE(0).complete = '1') and
                       (I_CODE(0).class    = MsgPack_Object.CLASS_UINT) then
                        type_error <= FALSE;
                        done       <= TRUE;
                        ii_valid   <= "11";
                        ii_shift   <= "01";
                        next_state <= IDLE_STATE;
                    else
                        type_error <= TRUE;
                        done       <= TRUE;
                        ii_valid   <= "00";
                        ii_shift   <= "00";
                        next_state <= IDLE_STATE;
                    end if;
                elsif (I_CODE(0).complete = '0') then
                    if    (ENABLE64 = TRUE) and
                          (I_CODE(0).class = MsgPack_Object.CLASS_INT) then
                        type_error <= FALSE;
                        done       <= FALSE;
                        ii_valid   <= "00";
                        ii_shift   <= "01";
                        next_state <= INT64_STATE;
                    elsif (ENABLE64 = TRUE) and
                          (I_CODE(0).class = MsgPack_Object.CLASS_UINT) then
                        type_error <= FALSE;
                        done       <= FALSE;
                        ii_valid   <= "00";
                        ii_shift   <= "01";
                        next_state <= UINT64_STATE;
                    else
                        type_error <= TRUE;
                        done       <= TRUE;
                        ii_valid   <= "00";
                        ii_shift   <= "00";
                        next_state <= IDLE_STATE;
                    end if;
                else
                    if    (I_CODE(0).class = MsgPack_Object.CLASS_INT ) or
                          (I_CODE(0).class = MsgPack_Object.CLASS_UINT) then
                        type_error <= FALSE;
                        done       <= TRUE;
                        ii_valid   <= "01";
                        ii_shift   <= "01";
                        next_state <= IDLE_STATE;
                    else
                        type_error <= TRUE;
                        done       <= TRUE;
                        ii_valid   <= "00";
                        ii_shift   <= "00";
                        next_state <= IDLE_STATE;
                    end if;
                end if;
            else
                        type_error <= FALSE;
                        done       <= FALSE;
                        ii_valid   <= "00";
                        ii_shift   <= "00";
                        next_state <= curr_state;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (curr_state, I_CODE, upper_value) begin
            if   (ENABLE64 = TRUE) and
                 ((curr_state = INT64_STATE ) or
                  (curr_state = UINT64_STATE)) then
                ii_value(31 downto  0) <= I_CODE(0).data;
                ii_value(63 downto 32) <= upper_value;
            elsif (I_CODE(0).class = MsgPack_Object.CLASS_INT) and
                  (I_CODE(0).data(31) = '1') then
                ii_value(31 downto  0) <= I_CODE(0).data;
                ii_value(63 downto 32) <= (63 downto 32 => '1');
            else
                ii_value(31 downto  0) <= I_CODE(0).data;
                ii_value(63 downto 32) <= (63 downto 32 => '0');
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (CLK, RST) begin
            if (RST = '1') then
                    curr_state  <= IDLE_STATE;
                    upper_value <= (others => '0');
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    curr_state  <= IDLE_STATE;
                    upper_value <= (others => '0');
                else
                    curr_state  <= next_state;
                    if (next_state /= IDLE_STATE) then
                        upper_value <= I_CODE(0).data;
                    end if;
                end if;
            end if;
        end process;
        ii_sign <= '1' when (curr_state = IDLE_STATE and I_CODE(0).class = MsgPack_Object.CLASS_INT) or
                            (curr_state = INT64_STATE) else '0';
    end generate;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    LONG_VEC:  if (CODE_WIDTH >= 2) generate
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (I_VALID, I_CODE) begin
            if (I_VALID = '1' and I_CODE(0).valid = '1') then
                if (I_CODE(0).class = MsgPack_Object.CLASS_INT ) or
                   (I_CODE(0).class = MsgPack_Object.CLASS_UINT) then
                    if (I_CODE(0).complete = '0') then
                        if    (ENABLE64 = FALSE) then
                            type_error <= TRUE;
                            done       <= TRUE;
                            ii_valid   <= "00";
                            ii_shift   <= "00";
                        elsif (I_CODE(1).valid = '0') then
                            type_error <= FALSE;
                            done       <= FALSE;
                            ii_valid   <= "00";
                            ii_shift   <= "00";
                        elsif (I_CODE(1).valid    = '1') and
                              (I_CODE(1).class    = I_CODE(0).class) and
                              (I_CODE(1).complete = '1') then
                            type_error <= FALSE;
                            done       <= TRUE;
                            ii_valid   <= "11";
                            ii_shift   <= "11";
                        else
                            type_error <= TRUE;
                            done       <= TRUE;
                            ii_valid   <= "00";
                            ii_shift   <= "00";
                        end if;
                    else
                            type_error <= FALSE;
                            done       <= TRUE;
                            ii_valid   <= "01";
                            ii_shift   <= "01";
                    end if;
                else
                            type_error <= TRUE;
                            done       <= TRUE;
                            ii_valid   <= "00";
                            ii_shift   <= "00";
                end if;
            else
                            type_error <= FALSE;
                            done       <= FALSE;
                            ii_valid   <= "00";
                            ii_shift   <= "00";
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (ii_valid, I_CODE) begin
            if    (ii_valid(1) = '1' and ENABLE64 = TRUE) then
                ii_value(31 downto  0) <= I_CODE(0).data;
                ii_value(63 downto 32) <= I_CODE(1).data;
            elsif (I_CODE(0).class = MsgPack_Object.CLASS_INT) and
                  (I_CODE(0).data(31) = '1') then
                ii_value(31 downto  0) <= I_CODE(0).data;
                ii_value(63 downto 32) <= (63 downto 32 => '1');
            else
                ii_value(31 downto  0) <= I_CODE(0).data;
                ii_value(63 downto 32) <= (63 downto 32 => '0');
            end if;
        end process;
        ii_sign <= '1' when (I_CODE(0).class = MsgPack_Object.CLASS_INT) else '0';
    end generate;
    -------------------------------------------------------------------------------
    -- range_error
    -------------------------------------------------------------------------------
    process (ii_value, ii_valid) begin
        range_error <= FALSE;
        if (CHECK_RANGE = TRUE and VALUE_BITS < 64 and ii_valid(0) = '1') then
            if (VALUE_SIGN) then
                for i in 63 downto VALUE_BITS loop
                    if (ii_value(i) /= ii_value(VALUE_BITS-1)) then
                        range_error <= TRUE;
                    end if;
                end loop;
            else
                for i in 63 downto VALUE_BITS loop
                    if (ii_value(i) /= '0') then
                        range_error <= TRUE;
                    end if;
                end loop;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    -- I_ERROR/I_DONE
    -------------------------------------------------------------------------------
    I_DONE  <= '1' when (done        = TRUE ) else '0';
    I_ERROR <= '1' when (type_error  = TRUE ) or
                        (range_error = TRUE ) else '0';
    -------------------------------------------------------------------------------
    -- I_SHIFT
    -------------------------------------------------------------------------------
    process (type_error, range_error, ii_shift) begin
        if (type_error = TRUE or range_error = TRUE) then
            I_SHIFT <= (others => '0');
        else
            for i in I_SHIFT'range loop
                if (i <= ii_shift'high) then
                    I_SHIFT(i) <= ii_shift(i);
                else
                    I_SHIFT(i) <= '0';
                end if;
            end loop;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    OUTLET: block
        constant  SIGN_POS  :  integer := VALUE_BITS + 0;
        constant  LAST_POS  :  integer := VALUE_BITS + 1;
        constant  DATA_BITS :  integer := VALUE_BITS + 2;
        signal    ii_data   :  std_logic_vector(DATA_BITS-1 downto 0);
        signal    oo_data   :  std_logic_vector(DATA_BITS-1 downto 0);
        signal    qq_valid  :  std_logic;
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        ii_data(VALUE_BITS-1 downto 0) <= ii_value(VALUE_BITS-1 downto 0);
        ii_data(SIGN_POS             ) <= ii_sign;
        ii_data(LAST_POS             ) <= I_LAST;
        qq_valid <= '1' when (type_error  = FALSE) and
                             (range_error = FALSE) and
                             (ii_valid(0) = '1'  ) else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        QUEUE: QUEUE_REGISTER                -- 
            generic map (                    -- 
                QUEUE_SIZE  => QUEUE_SIZE  , -- 
                DATA_BITS   => DATA_BITS   , -- 
                LOWPOWER    => 0             -- 
            )                                -- 
            port map (                       -- 
                CLK         => CLK         , -- In  :
                RST         => RST         , -- In  :
                CLR         => CLR         , -- In  :
                I_DATA      => ii_data     , -- In  :
                I_VAL       => qq_valid    , -- In  :
                I_RDY       => ii_ready    , -- Out :
                O_DATA      => open        , -- Out :
                O_VAL       => open        , -- Out :
                Q_DATA      => oo_data     , -- Out :
                Q_VAL(0)    => O_VALID     , -- Out :
                Q_RDY       => O_READY       -- In  :
            );                               --
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        O_VALUE <= oo_data(VALUE_BITS-1 downto 0);
        O_SIGN  <= oo_data(SIGN_POS);
        O_LAST  <= oo_data(LAST_POS);
    end block;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    rpc/msgpack_rpc_components.vhd                                  --
--!     @brief   MessagaPack Component Library Description                       --
--!     @version 0.2.5                                                           --
--!     @date    2017/03/14                                                      --
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>                     --
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--                                                                               --
--      Copyright (C) 2017 Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>           --
--      All rights reserved.                                                     --
--                                                                               --
--      Redistribution and use in source and binary forms, with or without       --
--      modification, are permitted provided that the following conditions       --
--      are met:                                                                 --
--                                                                               --
--        1. Redistributions of source code must retain the above copyright      --
--           notice, this list of conditions and the following disclaimer.       --
--                                                                               --
--        2. Redistributions in binary form must reproduce the above copyright   --
--           notice, this list of conditions and the following disclaimer in     --
--           the documentation and/or other materials provided with the          --
--           distribution.                                                       --
--                                                                               --
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    --
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    --
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT         --
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    --
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    --
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT      --
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    --
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     --
--                                                                               --
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
-----------------------------------------------------------------------------------
--! @brief MessagaPack Component Library Description                             --
-----------------------------------------------------------------------------------
package MsgPack_RPC_Components is
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Server                                                    --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Server
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        I_BYTES         : positive := 1;
        O_BYTES         : positive := 1;
        PROC_NUM        : positive := 1;
        MATCH_PHASE     : positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Data Stream Input Interface
    -------------------------------------------------------------------------------
        I_DATA          : in  std_logic_vector(8*I_BYTES-1 downto 0);
        I_STRB          : in  std_logic_vector(  I_BYTES-1 downto 0);
        I_LAST          : in  std_logic := '0';
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Data Stream Output Interface
    -------------------------------------------------------------------------------
        O_DATA          : out std_logic_vector(8*O_BYTES-1 downto 0);
        O_STRB          : out std_logic_vector(  O_BYTES-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector     (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : out MsgPack_RPC.Code_Type;
        MATCH_OK        : in  std_logic_vector        (PROC_NUM-1 downto 0);
        MATCH_NOT       : in  std_logic_vector        (PROC_NUM-1 downto 0);
        MATCH_SHIFT     : in  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Request Interface
    -------------------------------------------------------------------------------
        PROC_REQ_ID     : out MsgPack_RPC.MsgID_Type;
        PROC_REQ        : out std_logic_vector        (PROC_NUM-1 downto 0);
        PROC_BUSY       : in  std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_VALID     : out std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_CODE      : out MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
        PARAM_LAST      : out std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_SHIFT     : in  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Response Interface
    -------------------------------------------------------------------------------
        PROC_RES_ID     : in  MsgPack_RPC.MsgID_Vector(PROC_NUM-1 downto 0);
        PROC_RES_CODE   : in  MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
        PROC_RES_VALID  : in  std_logic_vector        (PROC_NUM-1 downto 0);
        PROC_RES_LAST   : in  std_logic_vector        (PROC_NUM-1 downto 0);
        PROC_RES_READY  : out std_logic_vector        (PROC_NUM-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Server_Requester                                          --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Server_Requester
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        I_BYTES         : integer range 1 to 32 := 1;
        PROC_NUM        : integer := 1;
        MATCH_PHASE     : integer := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Stream Input Interface
    -------------------------------------------------------------------------------
        I_DATA          : in  std_logic_vector(8*I_BYTES-1 downto 0);
        I_STRB          : in  std_logic_vector(  I_BYTES-1 downto 0);
        I_LAST          : in  std_logic := '0';
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Match I/F
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector     (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : out MsgPack_RPC.Code_Type;
        MATCH_OK        : in  std_logic_vector        (PROC_NUM-1 downto 0);
        MATCH_NOT       : in  std_logic_vector        (PROC_NUM-1 downto 0);
        MATCH_SHIFT     : in  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Request I/F
    -------------------------------------------------------------------------------
        PROC_REQ_ID     : out MsgPack_RPC.MsgID_Type;
        PROC_REQ        : out std_logic_vector        (PROC_NUM-1 downto 0);
        PROC_BUSY       : in  std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_VALID     : out std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_CODE      : out MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
        PARAM_LAST      : out std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_SHIFT     : in  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Error Response I/F
    -------------------------------------------------------------------------------
        ERROR_RES_ID    : out MsgPack_RPC.MsgID_Type;
        ERROR_RES_CODE  : out MsgPack_RPC.Code_Type;
        ERROR_RES_VALID : out std_logic;
        ERROR_RES_LAST  : out std_logic;
        ERROR_RES_READY : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Server_Responder                                          --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Server_Responder
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        O_BYTES         : integer range 1 to 32 := 1;
        RES_NUM         : integer := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Stream Output Interface
    -------------------------------------------------------------------------------
        O_DATA          : out std_logic_vector(8*O_BYTES-1 downto 0);
        O_STRB          : out std_logic_vector(  O_BYTES-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Response I/F
    -------------------------------------------------------------------------------
        RES_ID          : in  MsgPack_RPC.MsgID_Vector(RES_NUM-1 downto 0);
        RES_CODE        : in  MsgPack_RPC.Code_Vector (RES_NUM-1 downto 0);
        RES_VALID       : in  std_logic_vector        (RES_NUM-1 downto 0);
        RES_LAST        : in  std_logic_vector        (RES_NUM-1 downto 0);
        RES_READY       : out std_logic_vector        (RES_NUM-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Method_Main_with_Param                                    --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Method_Main_with_Param
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        NAME            : string;
        PARAM_NUM       : positive := 1;
        MATCH_PHASE     : positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_RPC.Code_Type;
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Call Request Interface
    -------------------------------------------------------------------------------
        PROC_REQ_ID     : in  MsgPack_RPC.MsgID_Type;
        PROC_REQ        : in  std_logic;
        PROC_BUSY       : out std_logic;
        PROC_START      : out std_logic;
        PARAM_CODE      : in  MsgPack_RPC.Code_Type;
        PARAM_VALID     : in  std_logic;
        PARAM_LAST      : in  std_logic;
        PARAM_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Set Parameter Interface
    -------------------------------------------------------------------------------
        SET_PARAM_CODE  : out MsgPack_RPC.Code_Type;
        SET_PARAM_LAST  : out std_logic;
        SET_PARAM_VALID : out std_logic_vector        (PARAM_NUM-1 downto 0);
        SET_PARAM_ERROR : in  std_logic_vector        (PARAM_NUM-1 downto 0);
        SET_PARAM_DONE  : in  std_logic_vector        (PARAM_NUM-1 downto 0);
        SET_PARAM_SHIFT : in  MsgPack_RPC.Shift_Vector(PARAM_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Request/Response/Running
    -------------------------------------------------------------------------------
        RUN_REQ_VAL     : out std_logic;
        RUN_REQ_RDY     : in  std_logic := '1';
        RUN_RES_VAL     : in  std_logic;
        RUN_RES_RDY     : out std_logic;
        RUNNING         : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Return Interface
    -------------------------------------------------------------------------------
        RET_ID          : out MsgPack_RPC.MsgID_Type;
        RET_ERROR       : out std_logic;
        RET_START       : out std_logic;
        RET_DONE        : out std_logic;
        RET_BUSY        : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Method_Main_No_Param                                      --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Method_Main_No_Param
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        NAME            : string;
        MATCH_PHASE     : positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector(MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_RPC.Code_Type;
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Call Request Interface
    -------------------------------------------------------------------------------
        PROC_REQ_ID     : in  MsgPack_RPC.MsgID_Type;
        PROC_REQ        : in  std_logic;
        PROC_BUSY       : out std_logic;
        PROC_START      : out std_logic;
        PARAM_CODE      : in  MsgPack_RPC.Code_Type;
        PARAM_VALID     : in  std_logic;
        PARAM_LAST      : in  std_logic;
        PARAM_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Request/Response/Running
    -------------------------------------------------------------------------------
        RUN_REQ_VAL     : out std_logic;
        RUN_REQ_RDY     : in  std_logic := '1';
        RUN_RES_VAL     : in  std_logic;
        RUN_RES_RDY     : out std_logic;
        RUNNING         : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Return Interface
    -------------------------------------------------------------------------------
        RET_ID          : out MsgPack_RPC.MsgID_Type;
        RET_ERROR       : out std_logic;
        RET_START       : out std_logic;
        RET_DONE        : out std_logic;
        RET_BUSY        : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Method_Set_Param_Integer                                  --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Method_Set_Param_Integer
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Set Parameter Interface
    -------------------------------------------------------------------------------
        SET_PARAM_CODE  : in  MsgPack_RPC.Code_Type;
        SET_PARAM_LAST  : in  std_logic;
        SET_PARAM_VALID : in  std_logic;
        SET_PARAM_ERROR : out std_logic;
        SET_PARAM_DONE  : out std_logic;
        SET_PARAM_SHIFT : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- Default Value Input Interface
    -------------------------------------------------------------------------------
        DEFAULT_VALUE   : in  std_logic_vector(VALUE_BITS-1 downto 0);
        DEFAULT_WE      : in  std_logic;
    -------------------------------------------------------------------------------
    -- Parameter Value Output Interface
    -------------------------------------------------------------------------------
        PARAM_VALUE     : out std_logic_vector(VALUE_BITS-1 downto 0);
        PARAM_WE        : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Method_Return_Integer                                     --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Method_Return_Integer
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        VALUE_WIDTH     :  positive := 32;
        RETURN_UINT     :  boolean  := TRUE;
        RETURN_INT      :  boolean  := TRUE;
        RETURN_FLOAT    :  boolean  := TRUE;
        RETURN_BOOLEAN  :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Return Interface
    -------------------------------------------------------------------------------
        RET_ERROR       : in  std_logic;
        RET_START       : in  std_logic;
        RET_DONE        : in  std_logic;
        RET_BUSY        : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Response Interface
    -------------------------------------------------------------------------------
        RES_CODE        : out MsgPack_RPC.Code_Type;
        RES_VALID       : out std_logic;
        RES_LAST        : out std_logic;
        RES_READY       : in  std_logic;
    -------------------------------------------------------------------------------
    -- Return Value
    -------------------------------------------------------------------------------
        VALUE           : in  std_logic_vector(VALUE_WIDTH-1 downto 0)
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Method_Return_Nil                                         --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Method_Return_Nil
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Return Interface
    -------------------------------------------------------------------------------
        RET_ERROR       : in  std_logic;
        RET_START       : in  std_logic;
        RET_DONE        : in  std_logic;
        RET_BUSY        : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Response Interface
    -------------------------------------------------------------------------------
        RES_CODE        : out MsgPack_RPC.Code_Type;
        RES_VALID       : out std_logic;
        RES_LAST        : out std_logic;
        RES_READY       : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Method_Return_Code                                        --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Method_Return_Code
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Return Interface
    -------------------------------------------------------------------------------
        RET_ERROR       : in  std_logic;
        RET_START       : in  std_logic;
        RET_DONE        : in  std_logic;
        RET_BUSY        : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Response Interface
    -------------------------------------------------------------------------------
        RES_CODE        : out MsgPack_RPC.Code_Type;
        RES_VALID       : out std_logic;
        RES_LAST        : out std_logic;
        RES_READY       : in  std_logic;
    -------------------------------------------------------------------------------
    -- Object Encode Input Interface
    -------------------------------------------------------------------------------
        I_VALID         : in  std_logic;
        I_CODE          : in  MsgPack_RPC.Code_Type;
        I_LAST          : in  std_logic;
        I_READY         : out std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Server_KVMap_Set_Value                                    --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Server_KVMap_Set_Value
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        NAME            : string;
        STORE_SIZE      : positive := 1;
        K_WIDTH         : positive := 1;
        MATCH_PHASE     : positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Match I/F
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_RPC.Code_Type;
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Call Request I/F
    -------------------------------------------------------------------------------
        PROC_REQ_ID     : in  MsgPack_RPC.MsgID_Type;
        PROC_REQ        : in  std_logic;
        PROC_BUSY       : out std_logic;
        PROC_START      : out std_logic;
        PARAM_CODE      : in  MsgPack_RPC.Code_Type;
        PARAM_VALID     : in  std_logic;
        PARAM_LAST      : in  std_logic;
        PARAM_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Map Key Match I/F
    -------------------------------------------------------------------------------
        MAP_MATCH_REQ   : out std_logic_vector       (MATCH_PHASE-1 downto 0);
        MAP_MATCH_CODE  : out MsgPack_RPC.Code_Type;
        MAP_MATCH_OK    : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_MATCH_NOT   : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_MATCH_SHIFT : in  MsgPack_RPC.Shift_Vector(STORE_SIZE-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Map Value Object Decode Output I/F
    -------------------------------------------------------------------------------
        MAP_VALUE_VALID : out std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_VALUE_CODE  : out MsgPack_RPC.Code_Type;
        MAP_VALUE_LAST  : out std_logic;
        MAP_VALUE_ERROR : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_VALUE_DONE  : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_VALUE_SHIFT : in  MsgPack_RPC.Shift_Vector(STORE_SIZE-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Return I/F
    -------------------------------------------------------------------------------
        RES_ID          : out MsgPack_RPC.MsgID_Type;
        RES_CODE        : out MsgPack_RPC.Code_Type;
        RES_VALID       : out std_logic;
        RES_LAST        : out std_logic;
        RES_READY       : in  std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief MsgPack_RPC_Server_KVMap_Get_Value                                    --
-----------------------------------------------------------------------------------
component MsgPack_RPC_Server_KVMap_Get_Value
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        NAME            : string;
        STORE_SIZE      : positive := 1;
        K_WIDTH         : positive := 1;
        MATCH_PHASE     : positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Match I/F
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_RPC.Code_Type;
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Call Request I/F
    -------------------------------------------------------------------------------
        PROC_REQ_ID     : in  MsgPack_RPC.MsgID_Type;
        PROC_REQ        : in  std_logic;
        PROC_BUSY       : out std_logic;
        PROC_START      : out std_logic;
        PARAM_CODE      : in  MsgPack_RPC.Code_Type;
        PARAM_VALID     : in  std_logic;
        PARAM_LAST      : in  std_logic;
        PARAM_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Map Key Match I/F
    -------------------------------------------------------------------------------
        MAP_MATCH_REQ   : out std_logic_vector       (MATCH_PHASE-1 downto 0);
        MAP_MATCH_CODE  : out MsgPack_RPC.Code_Type;
        MAP_MATCH_OK    : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_MATCH_NOT   : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_MATCH_SHIFT : in  MsgPack_RPC.Shift_Vector(STORE_SIZE-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Map Parameter Object Decode Output I/F
    -------------------------------------------------------------------------------
        MAP_PARAM_START : out std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_PARAM_VALID : out std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_PARAM_CODE  : out MsgPack_RPC.Code_Type;
        MAP_PARAM_LAST  : out std_logic;
        MAP_PARAM_ERROR : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_PARAM_DONE  : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_PARAM_SHIFT : in  MsgPack_RPC.Shift_Vector(STORE_SIZE-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Map Value Object Encode Input I/F
    -------------------------------------------------------------------------------
        MAP_VALUE_VALID : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_VALUE_CODE  : in  MsgPack_RPC.Code_Vector (STORE_SIZE-1 downto 0);
        MAP_VALUE_LAST  : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_VALUE_ERROR : in  std_logic_vector        (STORE_SIZE-1 downto 0);
        MAP_VALUE_READY : out std_logic_vector        (STORE_SIZE-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Return I/F
    -------------------------------------------------------------------------------
        RES_ID          : out MsgPack_RPC.MsgID_Type;
        RES_CODE        : out MsgPack_RPC.Code_Type;
        RES_VALID       : out std_logic;
        RES_LAST        : out std_logic;
        RES_READY       : in  std_logic
    );
end component;
end MsgPack_RPC_Components;
-----------------------------------------------------------------------------------
--!     @file    msgpack_rpc_server_requester.vhd
--!     @brief   MessagePack-RPC Server Requester Module :
--!     @version 0.2.0
--!     @date    2015/11/9
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
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
entity  MsgPack_RPC_Server_Requester is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        I_BYTES         : integer range 1 to 32 := 1;
        PROC_NUM        : integer := 1;
        MATCH_PHASE     : integer := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Stream Input Interface
    -------------------------------------------------------------------------------
        I_DATA          : in  std_logic_vector(8*I_BYTES-1 downto 0);
        I_STRB          : in  std_logic_vector(  I_BYTES-1 downto 0);
        I_LAST          : in  std_logic := '0';
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Match I/F
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector     (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : out MsgPack_RPC.Code_Type;
        MATCH_OK        : in  std_logic_vector        (PROC_NUM-1 downto 0);
        MATCH_NOT       : in  std_logic_vector        (PROC_NUM-1 downto 0);
        MATCH_SHIFT     : in  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Request I/F
    -------------------------------------------------------------------------------
        PROC_REQ_ID     : out MsgPack_RPC.MsgID_Type;
        PROC_REQ        : out std_logic_vector        (PROC_NUM-1 downto 0);
        PROC_BUSY       : in  std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_VALID     : out std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_CODE      : out MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
        PARAM_LAST      : out std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_SHIFT     : in  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Error Response I/F
    -------------------------------------------------------------------------------
        ERROR_RES_ID    : out MsgPack_RPC.MsgID_Type;
        ERROR_RES_CODE  : out MsgPack_RPC.Code_Type;
        ERROR_RES_VALID : out std_logic;
        ERROR_RES_LAST  : out std_logic;
        ERROR_RES_READY : in  std_logic
    );
end  MsgPack_RPC_Server_Requester;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Unpacker;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Match_Aggregator;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Code_Compare;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Code_Reducer;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Code_FIFO;
use     MsgPack.MsgPack_KVMap_Components .MsgPack_KVMap_Key_Match_Aggregator;
architecture RTL of MsgPack_RPC_Server_Requester is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  INTAKE_WIDTH      :  integer := MsgPack_RPC.Code_Length;
    constant  DECODE_UNIT       :  integer := 0;
    constant  SHORT_STR_SIZE    :  integer := 0;
    constant  STACK_DEPTH       :  integer := 4;
    constant  VALID_ALL_0       :  std_logic_vector(INTAKE_WIDTH-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    intake_code       :  MsgPack_Object.Code_Vector(INTAKE_WIDTH-1 downto 0);
    signal    intake_last       :  std_logic;
    signal    intake_ready      :  std_logic;
    signal    intake_valid      :  std_logic_vector(INTAKE_WIDTH-1 downto 0);
    signal    intake_shift      :  std_logic_vector(INTAKE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    type_match_run    :  std_logic;
    signal    type_match_state  :  MsgPack_Object.Match_State_Type;
    signal    type_match_shift  :  std_logic_vector(INTAKE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    proc_match_run    :  std_logic;
    signal    proc_match_state  :  MsgPack_Object.Match_State_Type;
    signal    proc_match_shift  :  std_logic_vector(INTAKE_WIDTH-1 downto 0);
    signal    proc_match_select :  std_logic_vector(PROC_NUM    -1 downto 0);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    msgid_match_run   :  std_logic;
    signal    msgid_match_state :  MsgPack_Object.Match_State_Type;
    signal    msgid_match_shift :  std_logic_vector(INTAKE_WIDTH-1 downto 0);
    signal    msgid_match_value :  MsgPack_RPC.MsgID_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type      STATE_TYPE        is (IDLE_STATE           ,
                                    SKIP_STATE           ,
                                    CHECK_MSGID_STATE    ,
                                    MATCH_PROC_STATE     ,
                                    CHECK_PROC_STATE     ,
                                    PROC_PARAM_STATE     ,
                                    WAIT_ERROR_DONE_STATE,
                                    DONE_STATE
                                   );
    signal    curr_state        :  STATE_TYPE;
    signal    skip_next_state   :  STATE_TYPE;
    signal    message_id        :  MsgPack_RPC.MsgID_Type;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    proc_check_select :  std_logic_vector(PROC_NUM-1 downto 0);
    signal    proc_req_start    :  std_logic_vector(PROC_NUM-1 downto 0);
    signal    proc_req_on       :  std_logic_vector(PROC_NUM-1 downto 0);
    signal    proc_param_select :  std_logic_vector(PROC_NUM-1 downto 0);
    constant  PROC_ALL_0        :  std_logic_vector(PROC_NUM-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    proc_name_code    :  MsgPack_Object.Code_Vector(INTAKE_WIDTH-1 downto 0);
    signal    proc_name_valid   :  std_logic;
    signal    proc_name_last    :  std_logic;
    signal    proc_name_ready   :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    skip_state_shift  :  std_logic_vector(INTAKE_WIDTH-1 downto 0);
    signal    skip_state_done   :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    proc_param_shift  :  std_logic_vector(INTAKE_WIDTH-1 downto 0);
    signal    proc_param_done   :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type      ERROR_REQ_TYPE    is (ERROR_REQ_NONE       ,
                                    ERROR_REQ_PROC_BUSY  ,
                                    ERROR_REQ_NO_METHOD  ,
                                    ERROR_REQ_INVALID_MSG);
    signal    error_request     :  ERROR_REQ_TYPE;
    signal    error_busy        :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  priority_selector(
                 Data    : std_logic_vector
    )            return    std_logic_vector
    is
        variable result  : std_logic_vector(Data'range);
    begin
        for i in Data'range loop
            if (i = Data'low) then
                result(i) := Data(i);
            else
                result(i) := Data(i) and (not Data(i-1));
            end if;
        end loop;
        return result;
    end function;
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    UNPACK: MsgPack_Object_Unpacker                  -- 
        generic map (                                -- 
            I_BYTES         => I_BYTES             , --
            CODE_WIDTH      => INTAKE_WIDTH        , -- 
            O_VALID_SIZE    => 1                   , -- 
            DECODE_UNIT     => DECODE_UNIT         , -- 
            SHORT_STR_SIZE  => SHORT_STR_SIZE      , -- 
            STACK_DEPTH     => STACK_DEPTH           -- 
        )                                            -- 
        port map (                                   -- 
            CLK             => CLK                 , -- In  :
            RST             => RST                 , -- In  :
            CLR             => CLR                 , -- In  :
            I_DATA          => I_DATA              , -- In  :
            I_STRB          => I_STRB              , -- In  :
            I_LAST          => I_LAST              , -- In  :
            I_VALID         => I_VALID             , -- In  :
            I_READY         => I_READY             , -- Out :
            O_CODE          => intake_code         , -- Out :
            O_LAST          => intake_last         , -- Out :
            O_VALID         => open                , -- Out :
            O_READY         => intake_ready        , -- In  :
            O_SHIFT         => intake_shift          -- In  :
        );                                           --
    process (intake_code) begin                      --
        for i in intake_valid'range loop             -- 
            intake_valid(i) <= intake_code(i).valid; -- 
        end loop;                                    --
    end process;                                     -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    TYPE_MATCH: block
        constant  Req_Type_Code :  MsgPack_Object.Code_Vector(1 downto 0) := (
                      0 => MsgPack_Object.New_Code_ArraySize(4),
                      1 => MsgPack_Object.New_Code_Unsigned(0)
                  );
        signal    match_req   :  std_logic_vector(1 downto 0);
        signal    match_ok    :  std_logic_vector(0 downto 0);
        signal    match_not   :  std_logic_vector(0 downto 0);
        signal    match_shift :  MsgPack_RPC.Shift_Vector(0 downto 0);
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        COMPARE: MsgPack_Object_Code_Compare             -- 
            generic map (                                -- 
                C_WIDTH       => Req_Type_Code'length  , -- 
                I_WIDTH       => INTAKE_WIDTH          , --
                I_MAX_PHASE   => match_req'length        -- 
            )                                            -- 
            port map (                                   -- 
                CLK           => CLK                   , -- In  :
                RST           => RST                   , -- In  :
                CLR           => CLR                   , -- In  :
                I_CODE        => intake_code           , -- In  :
                I_REQ_PHASE   => match_req             , -- In  :
                C_CODE        => Req_Type_Code         , -- In  :
                MATCH         => match_ok   (0)        , -- Out :
                MISMATCH      => match_not  (0)        , -- Out :
                SHIFT         => match_shift(0)          -- Out :
            );                                           --
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        AGGREGATE: MsgPack_Object_Match_Aggregator       -- 
            generic map (                                -- 
                CODE_WIDTH    => INTAKE_WIDTH          , --
                MATCH_NUM     => 1                     , -- 
                MATCH_PHASE   => match_req'length        -- 
            )                                            -- 
            port map (                                   -- 
                CLK           => CLK                   , -- In  :
                RST           => RST                   , -- In  :
                CLR           => CLR                   , -- In  :
                I_VALID       => type_match_run        , -- In  :
                I_CODE        => intake_code           , -- In  :
                I_LAST        => intake_last           , -- In  :
                I_SHIFT       => type_match_shift      , -- Out :
                PHASE_NEXT    => open                  , -- Out :
                PHASE_READY   => '1'                   , -- In  :
                MATCH_REQ     => match_req             , -- Out :
                MATCH_OK      => match_ok              , -- In  :
                MATCH_NOT     => match_not             , -- In  :
                MATCH_SHIFT   => match_shift(0)        , -- In  :
                MATCH_SEL     => open                  , -- Out :
                MATCH_STATE   => type_match_state        -- Out :
            );
    end block;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    PROC_MATCH: block
        signal    match_shift_vector :  std_logic_vector( PROC_NUM*INTAKE_WIDTH-1 downto 0);
        signal    fifo_clear         :  std_logic;
        signal    key_code           :  MsgPack_Object.Code_Vector(INTAKE_WIDTH-1 downto 0);
        signal    key_valid          :  std_logic;
        signal    key_ready          :  std_logic;
        signal    key_last           :  std_logic;
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (MATCH_SHIFT) begin
            for i in 0 to PROC_NUM-1 loop
                match_shift_vector(INTAKE_WIDTH*(i+1)-1 downto INTAKE_WIDTH*i) <= MATCH_SHIFT(i);
            end loop;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        AGGREGATE: MsgPack_KVMap_Key_Match_Aggregator    -- 
            generic map (                                -- 
                CODE_WIDTH    => INTAKE_WIDTH          , --
                MATCH_NUM     => PROC_NUM              , -- 
                MATCH_PHASE   => MATCH_REQ'length        -- 
            )                                            -- 
            port map (                                   -- 
                CLK           => CLK                   , -- In  :
                RST           => RST                   , -- In  :
                CLR           => CLR                   , -- In  :
                I_KEY_VALID   => proc_match_run        , -- In  :
                I_KEY_CODE    => intake_code           , -- In  :
                I_KEY_LAST    => intake_last           , -- In  :
                I_KEY_SHIFT   => proc_match_shift      , -- Out :
                O_KEY_VALID   => key_valid             , -- Out :
                O_KEY_CODE    => key_code              , -- Out :
                O_KEY_LAST    => key_last              , -- Out :
                O_KEY_READY   => key_ready             , -- In  :
                MATCH_REQ     => MATCH_REQ             , -- Out :
                MATCH_OK      => MATCH_OK              , -- In  :
                MATCH_NOT     => MATCH_NOT             , -- In  :
                MATCH_SHIFT   => match_shift_vector    , -- In  :
                MATCH_SEL     => proc_match_select     , -- Out :
                MATCH_STATE   => proc_match_state        -- Out :
            );                                           --
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        MATCH_CODE <= intake_code;
        fifo_clear <= '1' when (CLR = '1') or
                               (curr_state = IDLE_STATE) else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        FIFO: MsgPack_Object_Code_FIFO                   -- 
            generic map (                                -- 
                WIDTH         => INTAKE_WIDTH          , --
                DEPTH         => 4                       -- 
            )                                            -- 
            port map (                                   -- 
                CLK           => CLK                   , -- In  :
                RST           => RST                   , -- In  :
                CLR           => fifo_clear            , -- In  :
                I_VALID       => key_valid             , -- In  :
                I_CODE        => key_code              , -- In  :
                I_LAST        => key_last              , -- In  :
                I_READY       => key_ready             , -- Out :
                O_VALID       => proc_name_valid       , -- Out :
                O_CODE        => proc_name_code        , -- Out :
                O_LAST        => proc_name_last        , -- Out :
                O_READY       => proc_name_ready         -- In  :
            );                                           --
    end block;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    MSGID_MATCH: process (msgid_match_run, intake_code, intake_valid, intake_last)
        constant shift : std_logic_vector(INTAKE_WIDTH-1 downto 0) := (0 => '1', others => '0');
    begin
        if (msgid_match_run = '1') then
            if (intake_code(0).valid = '1') then
                if ((intake_code(0).class = MsgPack_Object.CLASS_UINT) or
                    (intake_code(0).class = MsgPack_Object.CLASS_INT )) and
                   (intake_code(0).complete  = '1') then
                    if ((intake_last = '1') and ((intake_valid and not shift) = VALID_ALL_0)) then
                        msgid_match_state <= MsgPack_Object.MATCH_DONE_FOUND_LAST_STATE;
                    else
                        msgid_match_state <= MsgPack_Object.MATCH_DONE_FOUND_CONT_STATE;
                    end if;
                    msgid_match_shift <= shift;
                else
                    msgid_match_state <= MsgPack_Object.MATCH_DONE_NOT_FOUND_CONT_STATE;
                    msgid_match_shift <= (others => '0');
                end if;
            else
                    msgid_match_state <= MsgPack_Object.MATCH_BUSY_STATE;
                    msgid_match_shift <= (others => '0');
            end if;
        else
                    msgid_match_state <= MsgPack_Object.MATCH_IDLE_STATE;
                    msgid_match_shift <= (others => '0');
        end if;
        msgid_match_value <= intake_code(0).data;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    proc_req_start <= priority_selector(proc_check_select and not PROC_BUSY);
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                curr_state        <= IDLE_STATE;
                skip_next_state   <= DONE_STATE;
                proc_check_select <= PROC_ALL_0;
                proc_param_select <= PROC_ALL_0;
                message_id        <= MsgPack_RPC.MsgID_Null;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_state        <= IDLE_STATE;
                skip_next_state   <= DONE_STATE;
                proc_check_select <= PROC_ALL_0;
                proc_param_select <= PROC_ALL_0;
                message_id        <= MsgPack_RPC.MsgID_Null;
            else
                case curr_state is
                    when IDLE_STATE =>
                        case type_match_state is
                            when MsgPack_Object.MATCH_DONE_FOUND_CONT_STATE     =>
                                curr_state      <= CHECK_MSGID_STATE;
                            when MsgPack_Object.MATCH_DONE_FOUND_LAST_STATE     =>
                                curr_state      <= DONE_STATE;
                            when MsgPack_Object.MATCH_DONE_NOT_FOUND_CONT_STATE |
                                 MsgPack_Object.MATCH_DONE_NOT_FOUND_LAST_STATE =>
                                curr_state      <= SKIP_STATE;
                                skip_next_state <= DONE_STATE;
                            when others =>
                                curr_state      <= IDLE_STATE;
                        end case;
                        proc_check_select <= PROC_ALL_0;
                        proc_param_select <= PROC_ALL_0;
                    when CHECK_MSGID_STATE =>
                        case msgid_match_state is
                            when MsgPack_Object.MATCH_DONE_FOUND_CONT_STATE     =>
                                curr_state      <= MATCH_PROC_STATE;
                            when MsgPack_Object.MATCH_DONE_FOUND_LAST_STATE     =>
                                curr_state      <= WAIT_ERROR_DONE_STATE;
                            when MsgPack_Object.MATCH_DONE_NOT_FOUND_CONT_STATE |
                                 MsgPack_Object.MATCH_DONE_NOT_FOUND_LAST_STATE =>
                                curr_state      <= SKIP_STATE;
                                skip_next_state <= WAIT_ERROR_DONE_STATE;
                            when others =>
                                curr_state      <= CHECK_MSGID_STATE;
                        end case;
                        message_id        <= msgid_match_value;
                        proc_check_select <= PROC_ALL_0;
                        proc_param_select <= PROC_ALL_0;
                    when MATCH_PROC_STATE =>
                        case proc_match_state is
                            when MsgPack_Object.MATCH_DONE_FOUND_CONT_STATE     =>
                                curr_state      <= CHECK_PROC_STATE;
                            when MsgPack_Object.MATCH_DONE_FOUND_LAST_STATE     =>
                                curr_state      <= WAIT_ERROR_DONE_STATE;
                            when MsgPack_Object.MATCH_DONE_NOT_FOUND_CONT_STATE =>
                                curr_state      <= SKIP_STATE;
                                skip_next_state <= WAIT_ERROR_DONE_STATE;
                            when MsgPack_Object.MATCH_DONE_NOT_FOUND_LAST_STATE =>
                                curr_state      <= WAIT_ERROR_DONE_STATE;
                            when others =>
                                curr_state      <= MATCH_PROC_STATE;
                        end case;
                        proc_check_select <= proc_match_select;
                        proc_param_select <= PROC_ALL_0;
                    when CHECK_PROC_STATE =>
                        if (proc_req_start /= PROC_ALL_0) then
                            curr_state <= PROC_PARAM_STATE;
                        else
                            curr_state <= WAIT_ERROR_DONE_STATE;
                        end if;
                        proc_param_select <= proc_req_start;
                    when PROC_PARAM_STATE =>
                        if (proc_param_done = '1') then
                            curr_state        <= DONE_STATE;
                            proc_param_select <= (others => '0');
                        else
                            curr_state        <= PROC_PARAM_STATE;
                        end if;
                    when SKIP_STATE  =>
                        if (skip_state_done = '1') then
                            curr_state <= skip_next_state;
                        else
                            curr_state <= SKIP_STATE;
                        end if;
                    when WAIT_ERROR_DONE_STATE =>
                        if (error_busy = '0') then
                            curr_state <= DONE_STATE;
                        else
                            curr_state <= WAIT_ERROR_DONE_STATE;
                        end if;
                    when DONE_STATE =>
                        curr_state        <= IDLE_STATE;
                        proc_check_select <= (others => '0');
                        proc_param_select <= (others => '0');
                    when others =>
                        curr_state        <= IDLE_STATE;
                        proc_check_select <= (others => '0');
                        proc_param_select <= (others => '0');
                end case;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process(curr_state, msgid_match_state, proc_match_state, proc_req_start) begin
        case curr_state is
            when CHECK_MSGID_STATE =>
                case msgid_match_state is
                    when MsgPack_Object.MATCH_DONE_FOUND_LAST_STATE     |
                         MsgPack_Object.MATCH_DONE_NOT_FOUND_CONT_STATE |
                         MsgPack_Object.MATCH_DONE_NOT_FOUND_LAST_STATE =>
                        error_request <= ERROR_REQ_INVALID_MSG;
                    when others =>
                        error_request <= ERROR_REQ_NONE;
                end case;
            when MATCH_PROC_STATE =>
                case proc_match_state is
                    when MsgPack_Object.MATCH_DONE_FOUND_LAST_STATE     =>
                        error_request <= ERROR_REQ_INVALID_MSG;
                    when MsgPack_Object.MATCH_BUSY_NOT_FOUND_STATE      |
                         MsgPack_Object.MATCH_DONE_NOT_FOUND_CONT_STATE |
                         MsgPack_Object.MATCH_DONE_NOT_FOUND_LAST_STATE =>
                        error_request <= ERROR_REQ_NO_METHOD;
                    when others =>
                        error_request <= ERROR_REQ_NONE;
                end case;
            when CHECK_PROC_STATE =>
                if (proc_req_start = PROC_ALL_0) then
                        error_request <= ERROR_REQ_PROC_BUSY;
                else
                        error_request <= ERROR_REQ_NONE;
                end if;
            when others =>
                        error_request <= ERROR_REQ_NONE;
        end case;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type_match_run   <= '1' when (curr_state = IDLE_STATE  and intake_valid(0) = '1') else '0';
    msgid_match_run  <= '1' when (curr_state = CHECK_MSGID_STATE     ) else '0';
    proc_match_run   <= '1' when (curr_state = MATCH_PROC_STATE) else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    skip_state_shift <= intake_valid when (curr_state = SKIP_STATE) else (others => '0');
    skip_state_done  <= '1' when (intake_valid(0) = '1' and intake_last = '1') else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    intake_shift     <= type_match_shift  or
                        msgid_match_shift or
                        proc_match_shift  or
                        skip_state_shift  or
                        proc_param_shift;
    intake_ready     <= '1' when (curr_state = IDLE_STATE       ) or
                                 (curr_state = CHECK_MSGID_STATE) or
                                 (curr_state = MATCH_PROC_STATE ) or
                                 (curr_state = PROC_PARAM_STATE ) or
                                 (curr_state = SKIP_STATE       ) else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                proc_req_on <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                proc_req_on <= (others => '0');
            elsif (curr_state = CHECK_PROC_STATE) then
                proc_req_on <= proc_req_start;
            else
                for i in 0 to PROC_NUM-1 loop
                    if (proc_req_on(i) = '1' and PROC_BUSY(i) = '1') then
                        proc_req_on(i) <= '0';
                    end if;
                end loop;
            end if;
        end if;
    end process;
    PROC_REQ    <= proc_req_on;
    PROC_REQ_ID <= message_id;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    PARAM_GEN: for i in 0 to PROC_NUM-1 generate
        PARAM_CODE(i)  <= intake_code;
        PARAM_LAST(i)  <= intake_last;
        PARAM_VALID(i) <= proc_param_select(i);
    end generate;
    process (PARAM_SHIFT, proc_param_select, curr_state)
        variable shift : MsgPack_RPC.Shift_Type;
    begin
        shift := (others => '0');
        for i in 0 to PROC_NUM-1 loop
            if (curr_state = PROC_PARAM_STATE) and
               (proc_param_select(i) = '1'   ) then
                shift := shift or PARAM_SHIFT(i);
            end if;
        end loop;
        proc_param_shift <= shift;
    end process;
    proc_param_done <= '1' when (intake_valid(0) = '1') and
                                (intake_last     = '1') and
                                ((intake_valid and not proc_param_shift) = VALID_ALL_0) else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    ERROR_GEN: block
        constant  proc_busy_code     :  MsgPack_Object.Code_Vector(INTAKE_WIDTH-1 downto 0)
                                     := MsgPack_RPC.New_Error_Code_Vector_Proc_Busy(INTAKE_WIDTH);
        constant  no_method_code     :  MsgPack_Object.Code_Vector(INTAKE_WIDTH-1 downto 0)
                                     := MsgPack_RPC.New_Error_Code_Vector_No_Method(INTAKE_WIDTH);
        constant  msg_error_code     :  MsgPack_Object.Code_Vector(INTAKE_WIDTH-1 downto 0)
                                     := MsgPack_RPC.New_Error_Code_Vector_Invalid_Message(INTAKE_WIDTH);
        signal    send_error_code    :  MsgPack_Object.Code_Vector(INTAKE_WIDTH-1 downto 0);
        signal    send_error_last    :  std_logic;
        signal    send_error_valid   :  std_logic;
        signal    send_error_ready   :  std_logic;
        signal    send_error_busy    :  std_logic;
        constant  error_shift        :  MsgPack_RPC.Shift_Type := (others => '1');
        constant  result_nil_code    :  MsgPack_Object.Code_Vector(INTAKE_WIDTH-1 downto 0)
                                     := MsgPack_Object.New_Code_Vector_Nil(INTAKE_WIDTH);
        type      ERROR_STATE_TYPE  is (IDLE_STATE, DONE_STATE ,
                                        NO_METHOD_ERROR_STATE  , NO_METHOD_RESULT_STATE  ,
                                        MSG_ERROR_ERROR_STATE  , MSG_ERROR_RESULT_STATE  ,
                                        METHOD_BUSY_ERROR_STATE, METHOD_BUSY_RESULT_STATE);
        signal    error_state        :  ERROR_STATE_TYPE;
    begin  
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (CLK, RST) begin
            if (RST = '1') then
                    error_state <= IDLE_STATE;
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    error_state <= IDLE_STATE;
                else
                    case error_state is
                        when IDLE_STATE =>
                            case error_request is
                                when ERROR_REQ_NO_METHOD   =>
                                    error_state <= NO_METHOD_ERROR_STATE;
                                when ERROR_REQ_INVALID_MSG =>
                                    error_state <= MSG_ERROR_ERROR_STATE;
                                when ERROR_REQ_PROC_BUSY   =>
                                    error_state <= METHOD_BUSY_ERROR_STATE;
                                when others => 
                                    error_state <= IDLE_STATE;
                            end case;
                        when NO_METHOD_ERROR_STATE =>
                            if (send_error_ready = '1') then
                                error_state <= NO_METHOD_RESULT_STATE;
                            else
                                error_state <= NO_METHOD_ERROR_STATE;
                            end if;
                        when NO_METHOD_RESULT_STATE =>
                            if (proc_name_valid = '1' and proc_name_ready = '1' and proc_name_last = '1') then
                                error_state <= DONE_STATE;
                            else
                                error_state <= NO_METHOD_RESULT_STATE;
                            end if;
                        when METHOD_BUSY_ERROR_STATE =>
                            if (send_error_ready = '1') then
                                error_state <= METHOD_BUSY_RESULT_STATE;
                            else
                                error_state <= METHOD_BUSY_ERROR_STATE;
                            end if;
                        when METHOD_BUSY_RESULT_STATE =>
                            if (send_error_ready = '1') then
                                error_state <= DONE_STATE;
                            else
                                error_state <= METHOD_BUSY_RESULT_STATE;
                            end if;
                        when MSG_ERROR_ERROR_STATE =>
                            if (send_error_ready = '1') then
                                error_state <= MSG_ERROR_RESULT_STATE;
                            else
                                error_state <= MSG_ERROR_ERROR_STATE;
                            end if;
                        when MSG_ERROR_RESULT_STATE =>
                            if (send_error_ready = '1') then
                                error_state <= DONE_STATE;
                            else
                                error_state <= MSG_ERROR_RESULT_STATE;
                            end if;
                        when DONE_STATE =>
                            if (send_error_busy = '0') then
                                error_state <= IDLE_STATE;
                            else
                                error_state <= DONE_STATE;
                            end if;
                        when others =>
                                error_state <= IDLE_STATE;
                    end case;
                end if;
            end if;
        end process;
        error_busy <= '1' when (error_state /= IDLE_STATE) else '0';
        ---------------------------------------------------------------------------
        -- 
        ---------------------------------------------------------------------------
        send_error_valid <= '1' when (error_state = NO_METHOD_ERROR_STATE                              ) or
                                     (error_state = NO_METHOD_RESULT_STATE  and proc_name_valid   = '1') or
                                     (error_state = MSG_ERROR_ERROR_STATE                              ) or
                                     (error_state = MSG_ERROR_RESULT_STATE                             ) or
                                     (error_state = METHOD_BUSY_ERROR_STATE                            ) or
                                     (error_state = METHOD_BUSY_RESULT_STATE                           ) else '0';
        send_error_last  <= '1' when (error_state = NO_METHOD_RESULT_STATE  and proc_name_last    = '1') or
                                     (error_state = MSG_ERROR_RESULT_STATE                             ) or
                                     (error_state = METHOD_BUSY_RESULT_STATE                           ) else '0';
        send_error_code  <= no_method_code when (error_state = NO_METHOD_ERROR_STATE  ) else
                            proc_name_code when (error_state = NO_METHOD_RESULT_STATE ) else
                            msg_error_code when (error_state = MSG_ERROR_ERROR_STATE  ) else
                            proc_busy_code when (error_state = METHOD_BUSY_ERROR_STATE) else
                            result_nil_code;
        proc_name_ready  <= '1' when (error_state = NO_METHOD_RESULT_STATE   and send_error_ready  = '1') else '0';
        ERROR_RES_ID     <= message_id;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        OUTLET: MsgPack_Object_Code_Reducer                  -- 
            generic map (                                    -- 
                I_WIDTH         => INTAKE_WIDTH            , -- 
                O_WIDTH         => MsgPack_RPC.Code_Length , --
                O_VALID_SIZE    => MsgPack_RPC.Code_Length , -- 
                QUEUE_SIZE      => 0                         -- 
            )                                                -- 
            port map (                                       -- 
                CLK             => CLK                     , -- In  :
                RST             => RST                     , -- In  :
                CLR             => CLR                     , -- In  :
                DONE            => '0'                     , -- In  :
                BUSY            => send_error_busy         , -- Out :
                I_ENABLE        => '1'                     , -- In  :
                I_CODE          => send_error_code         , -- In  :
                I_DONE          => send_error_last         , -- In  :
                I_VALID         => send_error_valid        , -- In  :
                I_READY         => send_error_ready        , -- Out :
                O_ENABLE        => '1'                     , -- In  :
                O_CODE          => ERROR_RES_CODE          , -- Out :
                O_DONE          => ERROR_RES_LAST          , -- Out :
                O_VALID         => ERROR_RES_VALID         , -- Out :
                O_READY         => ERROR_RES_READY         , -- In  :
                O_SHIFT         => error_shift               -- In  :
            );                                               --
    end block;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_rpc_server_responder.vhd
--!     @brief   MessagePack-RPC Server Responder Module :
--!     @version 0.2.0
--!     @date    2015/11/9
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
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
entity  MsgPack_RPC_Server_Responder is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        O_BYTES         : integer range 1 to 32 := 1;
        RES_NUM         : integer := 1
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Stream Output Interface
    -------------------------------------------------------------------------------
        O_DATA          : out std_logic_vector(8*O_BYTES-1 downto 0);
        O_STRB          : out std_logic_vector(  O_BYTES-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Response I/F
    -------------------------------------------------------------------------------
        RES_ID          : in  MsgPack_RPC.MsgID_Vector(RES_NUM-1 downto 0);
        RES_CODE        : in  MsgPack_RPC.Code_Vector (RES_NUM-1 downto 0);
        RES_VALID       : in  std_logic_vector        (RES_NUM-1 downto 0);
        RES_LAST        : in  std_logic_vector        (RES_NUM-1 downto 0);
        RES_READY       : out std_logic_vector        (RES_NUM-1 downto 0)
    );
end  MsgPack_RPC_Server_Responder;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Packer;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Code_Reducer;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Encode_String_Constant;
use     MsgPack.PipeWork_Components.QUEUE_ARBITER;
architecture RTL of MsgPack_RPC_Server_Responder is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  OUTLET_WIDTH      :  integer := MsgPack_RPC.Code_Length;
    constant  PACK_WIDTH        :  integer := MsgPack_RPC.Code_Length;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    outlet_code       :  MsgPack_Object.Code_Vector(OUTLET_WIDTH-1 downto 0);
    signal    outlet_last       :  std_logic;
    signal    outlet_valid      :  std_logic;
    signal    outlet_ready      :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    pack_code         :  MsgPack_Object.Code_Vector(PACK_WIDTH-1 downto 0);
    signal    pack_shift        :  std_logic_vector          (PACK_WIDTH-1 downto 0);
    signal    pack_last         :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    resp_req          :  std_logic;
    signal    resp_shift        :  std_logic;
    signal    resp_select       :  std_logic_vector(RES_NUM-1 downto 0);
    signal    resp_select_req   :  std_logic_vector(RES_NUM-1 downto 0);
    constant  SEL_ALL_0         :  std_logic_vector(RES_NUM-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    response_code     :  MsgPack_Object.Code_Vector(OUTLET_WIDTH-1 downto 0);
    signal    response_last     :  std_logic;
    signal    response_valid    :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    resv_err_code     :  MsgPack_Object.Code_Vector(OUTLET_WIDTH-1 downto 0);
    signal    resv_err_last     :  std_logic;
    signal    resv_err_check    :  std_logic;
    signal    resv_err_valid    :  std_logic;
    signal    resv_err_ready    :  std_logic;
    signal    resv_err_busy     :  std_logic;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type      STATE_TYPE        is (IDLE_STATE    ,
                                    TYPE_STATE    ,
                                    MSGID_STATE   ,
                                    RESV_ERR_STATE,
                                    CHK_RESV_STATE,
                                    RESPONSE_STATE
                                );
    signal    curr_state        :  STATE_TYPE;
    signal    next_state        :  STATE_TYPE;
begin 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    ARB: QUEUE_ARBITER                           -- 
        generic map (                            -- 
            MIN_NUM         => 0               , -- 
            MAX_NUM         => RES_NUM-1         -- 
        )                                        -- 
        port map (                               -- 
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
            ENABLE          => '1'             , -- In  :
            REQUEST         => RES_VALID       , -- In  :
            GRANT           => resp_select_req , -- Out :
            GRANT_NUM       => open            , -- Out :
            REQUEST_O       => resp_req        , -- Out :
            VALID           => open            , -- Out :
            SHIFT           => resp_shift        -- In  :
        );                                       -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                curr_state <= IDLE_STATE;
                resp_select <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_state <= IDLE_STATE;
                resp_select <= (others => '0');
            else
                case curr_state is
                    when IDLE_STATE =>
                        if (outlet_ready = '1' and resp_req = '1') then
                            if (OUTLET_WIDTH > 1) then
                                curr_state <= MSGID_STATE;
                            else
                                curr_state <= TYPE_STATE;
                            end if;
                        else
                                curr_state <= IDLE_STATE;
                        end if;
                        resp_select <= resp_select_req;
                    when TYPE_STATE =>
                        if (outlet_ready = '1') then
                            curr_state <= MSGID_STATE;
                        else
                            curr_state <= TYPE_STATE;
                        end if;
                    when MSGID_STATE =>
                        if    (outlet_ready   = '0') then
                            curr_state <= MSGID_STATE;
                        elsif (resv_err_check = '1') then
                            curr_state <= CHK_RESV_STATE;
                        elsif (resv_err_busy  = '1') then
                            curr_state <= RESV_ERR_STATE;
                        else
                            curr_state <= RESPONSE_STATE;
                        end if;
                    when CHK_RESV_STATE =>
                        if    (resv_err_check = '1') then
                            curr_state <= CHK_RESV_STATE;
                        elsif (resv_err_busy  = '1') then
                            curr_state <= RESV_ERR_STATE;
                        else
                            curr_state <= RESPONSE_STATE;
                        end if;
                    when RESV_ERR_STATE =>
                        if (resv_err_busy = '0') then
                            curr_state <= RESPONSE_STATE;
                        else
                            curr_state <= RESV_ERR_STATE;
                        end if;
                    when RESPONSE_STATE  =>
                        if (outlet_ready = '1' and outlet_valid = '1' and outlet_last = '1') then
                            curr_state <= IDLE_STATE;
                        else
                            curr_state <= RESPONSE_STATE;
                        end if;
                    when others =>
                            curr_state <= IDLE_STATE;
                end case;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    ERROR_BLOCK: block
        signal    no_method_code     :  MsgPack_Object.Code_Vector(OUTLET_WIDTH-1 downto 0);
        signal    no_method_last     :  std_logic;
        signal    no_method_start    :  std_logic;
        signal    no_method_valid    :  std_logic;
        signal    no_method_ready    :  std_logic;
        signal    arg_error_code     :  MsgPack_Object.Code_Vector(OUTLET_WIDTH-1 downto 0);
        signal    arg_error_last     :  std_logic;
        signal    arg_error_start    :  std_logic;
        signal    arg_error_valid    :  std_logic;
        signal    arg_error_ready    :  std_logic;
        signal    msg_error_code     :  MsgPack_Object.Code_Vector(OUTLET_WIDTH-1 downto 0);
        signal    msg_error_last     :  std_logic;
        signal    msg_error_start    :  std_logic;
        signal    msg_error_valid    :  std_logic;
        signal    msg_error_ready    :  std_logic;
        signal    proc_busy_code     :  MsgPack_Object.Code_Vector(OUTLET_WIDTH-1 downto 0);
        signal    proc_busy_last     :  std_logic;
        signal    proc_busy_start    :  std_logic;
        signal    proc_busy_valid    :  std_logic;
        signal    proc_busy_ready    :  std_logic;
        constant  result_nil_code    :  MsgPack_Object.Code_Vector(OUTLET_WIDTH-1 downto 0)
                                     := MsgPack_Object.New_Code_Vector_Nil(OUTLET_WIDTH);
        type      ERROR_STATE_TYPE  is (ERROR_IDLE_STATE     ,
                                        ERROR_CHECK_STATE    ,
                                        ERROR_NO_METHOD_STATE,
                                        ERROR_ARG_ERROR_STATE,
                                        ERROR_MSG_ERROR_STATE,
                                        ERROR_PROC_BUSY_STATE
                                       );
        signal    error_state        :  ERROR_STATE_TYPE;
    begin
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        NO_METHOD: MsgPack_Object_Encode_String_Constant     --
            generic map (                                    -- 
                VALUE           => string'("NoMethodError"), --
                CODE_WIDTH      => OUTLET_WIDTH              --
            )                                                -- 
            port map (                                       -- 
                CLK             => CLK                     , -- In  :
                RST             => RST                     , -- In  :
                CLR             => CLR                     , -- In  :
                START           => no_method_start         , -- In  :
                BUSY            => open                    , -- Out :
                O_CODE          => no_method_code          , -- Out :
                O_LAST          => no_method_last          , -- Out :
                O_ERROR         => open                    , -- Out :
                O_VALID         => no_method_valid         , -- Out :
                O_READY         => no_method_ready           -- In  :
            );                                               --
        no_method_start <= '1' when (error_state = ERROR_CHECK_STATE) and
                                    (response_code(0).valid = '1') and
                                    (MsgPack_RPC.Is_Error_Code_No_Method(response_code(0))) else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        ARG_ERROR: MsgPack_Object_Encode_String_Constant     --
            generic map (                                    -- 
                VALUE           => string'("ArgumentError"), --
                CODE_WIDTH      => OUTLET_WIDTH              --
            )                                                -- 
            port map (                                       -- 
                CLK             => CLK                     , -- In  :
                RST             => RST                     , -- In  :
                CLR             => CLR                     , -- In  :
                START           => arg_error_start         , -- In  :
                BUSY            => open                    , -- Out :
                O_CODE          => arg_error_code          , -- Out :
                O_LAST          => arg_error_last          , -- Out :
                O_ERROR         => open                    , -- Out :
                O_VALID         => arg_error_valid         , -- Out :
                O_READY         => arg_error_ready           -- In  :
            );                                               --
        arg_error_start <= '1' when (error_state = ERROR_CHECK_STATE) and
                                    (response_code(0).valid = '1') and
                                    (MsgPack_RPC.Is_Error_Code_Invalid_Argment(response_code(0))) else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        PROC_BUSY: MsgPack_Object_Encode_String_Constant     --
            generic map (                                    -- 
                VALUE           => string'("MethodBusy")   , --
                CODE_WIDTH      => OUTLET_WIDTH              --
            )                                                -- 
            port map (                                       -- 
                CLK             => CLK                     , -- In  :
                RST             => RST                     , -- In  :
                CLR             => CLR                     , -- In  :
                START           => proc_busy_start         , -- In  :
                BUSY            => open                    , -- Out :
                O_CODE          => proc_busy_code          , -- Out :
                O_LAST          => proc_busy_last          , -- Out :
                O_ERROR         => open                    , -- Out :
                O_VALID         => proc_busy_valid         , -- Out :
                O_READY         => proc_busy_ready           -- In  :
            );
        proc_busy_start <= '1' when (error_state = ERROR_CHECK_STATE) and
                                    (response_code(0).valid = '1') and
                                    (MsgPack_RPC.Is_Error_Code_Proc_Busy(response_code(0))) else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        MSG_ERROR: MsgPack_Object_Encode_String_Constant     --
            generic map (                                    -- 
                VALUE           => string'("MessageError") , --
                CODE_WIDTH      => OUTLET_WIDTH              --
            )                                                -- 
            port map (                                       -- 
                CLK             => CLK                     , -- In  :
                RST             => RST                     , -- In  :
                CLR             => CLR                     , -- In  :
                START           => msg_error_start         , -- In  :
                BUSY            => open                    , -- Out :
                O_CODE          => msg_error_code          , -- Out :
                O_LAST          => msg_error_last          , -- Out :
                O_ERROR         => open                    , -- Out :
                O_VALID         => msg_error_valid         , -- Out :
                O_READY         => msg_error_ready           -- In  :
            );
        msg_error_start <= '1' when (error_state = ERROR_CHECK_STATE) and
                                    (response_code(0).valid = '1') and
                                    (MsgPack_RPC.Is_Error_Code_Invalid_Message(response_code(0))) else '0';
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        process (CLK, RST) begin
            if (RST = '1') then
                    error_state <= ERROR_IDLE_STATE;
            elsif (CLK'event and CLK = '1') then
                if (CLR = '1') then
                    error_state <= ERROR_IDLE_STATE;
                else
                    case error_state is
                        when ERROR_IDLE_STATE =>
                            if (curr_state = IDLE_STATE) and
                               (outlet_ready = '1' and resp_req = '1') then
                                error_state <= ERROR_CHECK_STATE;
                            else
                                error_state <= ERROR_IDLE_STATE;
                            end if;
                        when ERROR_CHECK_STATE =>
                            if (response_code(0).valid = '0') then
                                error_state <= ERROR_CHECK_STATE;
                            elsif    (no_method_start = '1') then
                                error_state <= ERROR_NO_METHOD_STATE;
                            elsif (arg_error_start = '1') then
                                error_state <= ERROR_ARG_ERROR_STATE;
                            elsif (msg_error_start = '1') then
                                error_state <= ERROR_MSG_ERROR_STATE;
                            elsif (proc_busy_start = '1') then
                                error_state <= ERROR_PROC_BUSY_STATE;
                            else
                                error_state <= ERROR_IDLE_STATE;
                            end if;
                        when ERROR_NO_METHOD_STATE =>
                            if (no_method_valid = '1' and no_method_ready = '1' and no_method_last = '1') then
                                error_state <= ERROR_IDLE_STATE;
                            else
                                error_state <= ERROR_NO_METHOD_STATE;
                            end if;
                        when ERROR_ARG_ERROR_STATE =>
                            if (arg_error_valid = '1' and arg_error_ready = '1' and arg_error_last = '1') then
                                error_state <= ERROR_IDLE_STATE;
                            else
                                error_state <= ERROR_ARG_ERROR_STATE;
                            end if;
                        when ERROR_MSG_ERROR_STATE =>
                            if (msg_error_valid = '1' and msg_error_ready = '1' and msg_error_last = '1') then
                                error_state <= ERROR_IDLE_STATE;
                            else
                                error_state <= ERROR_MSG_ERROR_STATE;
                            end if;
                        when ERROR_PROC_BUSY_STATE =>
                            if (proc_busy_valid = '1' and proc_busy_ready = '1' and proc_busy_last = '1') then
                                error_state <= ERROR_IDLE_STATE;
                            else
                                error_state <= ERROR_PROC_BUSY_STATE;
                            end if;
                        when others =>
                                error_state <= ERROR_IDLE_STATE;
                    end case;
                end if;
            end if;
        end process;
        ---------------------------------------------------------------------------
        --
        ---------------------------------------------------------------------------
        resv_err_busy   <= '1' when (error_state /= ERROR_IDLE_STATE) else '0';
        resv_err_check  <= '1' when (error_state = ERROR_CHECK_STATE) else '0';
        resv_err_valid  <= '1' when (error_state = ERROR_PROC_BUSY_STATE and proc_busy_valid = '1') or
                                    (error_state = ERROR_NO_METHOD_STATE and no_method_valid = '1') or
                                    (error_state = ERROR_ARG_ERROR_STATE and arg_error_valid = '1') or
                                    (error_state = ERROR_MSG_ERROR_STATE and msg_error_valid = '1') else '0';
        resv_err_last   <= '0';
        resv_err_code   <= proc_busy_code when (error_state = ERROR_PROC_BUSY_STATE) else
                           no_method_code when (error_state = ERROR_NO_METHOD_STATE) else
                           arg_error_code when (error_state = ERROR_ARG_ERROR_STATE) else
                           msg_error_code when (error_state = ERROR_MSG_ERROR_STATE) else
                           result_nil_code;
        proc_busy_ready <= '1' when (error_state = ERROR_PROC_BUSY_STATE and resv_err_ready = '1') else '0';
        no_method_ready <= '1' when (error_state = ERROR_NO_METHOD_STATE and resv_err_ready = '1') else '0';
        arg_error_ready <= '1' when (error_state = ERROR_ARG_ERROR_STATE and resv_err_ready = '1') else '0';
        msg_error_ready <= '1' when (error_state = ERROR_MSG_ERROR_STATE and resv_err_ready = '1') else '0';
    end block;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (resp_select, RES_CODE, RES_VALID, RES_LAST)
        variable  code      :  MsgPack_Object.Code_Vector(OUTLET_WIDTH-1 downto 0);
    begin
        if ((RES_VALID and resp_select) /= SEL_ALL_0) then
            response_valid <= '1';
        else
            response_valid <= '0';
        end if;
        if ((RES_LAST  and resp_select) /= SEL_ALL_0) then
            response_last  <= '1';
        else
            response_last  <= '0';
        end if;
        code := (others => MsgPack_Object.CODE_NULL);
        for i in 0 to RES_NUM-1 loop
            for pos in code'range loop
                if (resp_select(i) = '1') then
                    code(pos).data     := code(pos).data     or RES_CODE(i)(pos).data;
                    code(pos).strb     := code(pos).strb     or RES_CODE(i)(pos).strb;
                    code(pos).class    := code(pos).class    or RES_CODE(i)(pos).class;
                    code(pos).complete := code(pos).complete or RES_CODE(i)(pos).complete;
                    code(pos).valid    := code(pos).valid    or RES_CODE(i)(pos).valid;
                end if;
            end loop;
        end loop;
        response_code <= code;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (curr_state, resp_req, resp_select, RES_ID,
             response_code, response_valid, response_last,
             resv_err_code, resv_err_valid, resv_err_last)
        function  max(A,B:integer) return integer is begin
            if (A>B) then return A;
            else          return B;
            end if;
        end function;
        constant  max_width :  integer := max(3, OUTLET_WIDTH);
        variable  code      :  MsgPack_Object.Code_Vector(max_width-1 downto 0);
        variable  msgid     :  std_logic_vector(31 downto 0);
    begin
        case curr_state is
            when IDLE_STATE  =>
                outlet_valid   <= resp_req;
                outlet_last    <= '0';
                code(0) := MsgPack_Object.New_Code_ArraySize(4);
                code(1) := MsgPack_Object.New_Code_Unsigned (1);
                code(code'high downto 2) := (code'high downto 2 => MsgPack_Object.CODE_NULL);
                outlet_code <= code(outlet_code'range);
            when TYPE_STATE  =>
                outlet_valid <= '1';
                outlet_last  <= '0';
                code(0) := MsgPack_Object.New_Code_Unsigned (1);
                code(code'high downto 1) := (code'high downto 1 => MsgPack_Object.CODE_NULL);
                outlet_code <= code(outlet_code'range);
            when MSGID_STATE =>
                outlet_valid <= '1';
                outlet_last  <= '0';
                msgid := (others => '0');
                for i in 0 to RES_NUM-1 loop
                    if (resp_select(i) = '1') then
                        msgid := msgid or RES_ID(i);
                    end if;
                end loop;
                code(0) := MsgPack_Object.New_Code_Unsigned (msgid);
                code(code'high downto 1) := (code'high downto 1 => MsgPack_Object.CODE_NULL);
                outlet_code <= code(outlet_code'range);
            when RESV_ERR_STATE =>
                outlet_valid <= resv_err_valid;
                outlet_last  <= resv_err_last;
                outlet_code  <= resv_err_code;
            when RESPONSE_STATE  =>
                outlet_valid <= response_valid;
                outlet_last  <= response_last;
                outlet_code  <= response_code;
            when others =>
                outlet_valid <= '0';
                outlet_last  <= '0';
                outlet_code  <= (others => MsgPack_Object.CODE_NULL);
        end case;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    resv_err_ready <=    '1' when (curr_state = RESV_ERR_STATE and outlet_ready = '1') else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    RES_READY <= resp_select when (curr_state = RESPONSE_STATE and outlet_ready = '1') else (others => '0');
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    resp_shift <= '1' when (outlet_valid = '1' and outlet_ready = '1' and outlet_last = '1') else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    PACK_BUFFER: MsgPack_Object_Code_Reducer     -- 
        generic map (                            -- 
            I_WIDTH         => OUTLET_WIDTH    , -- 
            O_WIDTH         => PACK_WIDTH      , -- 
            O_VALID_SIZE    => PACK_WIDTH      , -- 
            QUEUE_SIZE      => 0                 -- 
        )                                        -- 
        port map (                               -- 
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
            DONE            => '0'             , -- In  :
            BUSY            => open            , -- Out :
            I_ENABLE        => '1'             , -- In  :
            I_CODE          => outlet_code     , -- In  :
            I_DONE          => outlet_last     , -- In  :
            I_VALID         => outlet_valid    , -- In  :
            I_READY         => outlet_ready    , -- Out :
            O_ENABLE        => '1'             , -- In  :
            O_CODE          => pack_code       , -- Out :
            O_DONE          => pack_last       , -- Out :
            O_VALID         => open            , -- Out :
            O_READY         => '1'             , -- In  :
            O_SHIFT         => pack_shift        -- In  :
        );                                       -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    PACK: MsgPack_Object_Packer                  -- 
        generic map (                            -- 
            CODE_WIDTH      => PACK_WIDTH      , --
            O_BYTES         => O_BYTES           --
        )                                        -- 
        port map (                               -- 
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
            I_CODE          => pack_code       , -- In  :
            I_LAST          => pack_last       , -- In  :
            I_SHIFT         => pack_shift      , -- Out :
            O_DATA          => O_DATA          , -- Out :
            O_STRB          => O_STRB          , -- Out :
            O_LAST          => O_LAST          , -- Out :
            O_VALID         => O_VALID         , -- Out :
            O_READY         => O_READY           -- In  :
        );                                       -- 
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_object_store_integer_register.vhd
--!     @brief   MessagePack Object Store Integer Register Module :
--!     @version 0.2.0
--!     @date    2016/6/7
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2015-2016 Ichiro Kawazome
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
use     MsgPack.MsgPack_Object;
entity  MsgPack_Object_Store_Integer_Register is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        CODE_WIDTH      :  positive := 1;
        VALUE_BITS      :  integer range 1 to 64;
        VALUE_SIGN      :  boolean  := FALSE;
        CHECK_RANGE     :  boolean  := TRUE ;
        ENABLE64        :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack Object Code Input Interface
    -------------------------------------------------------------------------------
        I_CODE          : in  MsgPack_Object.Code_Vector(CODE_WIDTH-1 downto 0);
        I_LAST          : in  std_logic;
        I_VALID         : in  std_logic;
        I_ERROR         : out std_logic;
        I_DONE          : out std_logic;
        I_SHIFT         : out std_logic_vector(CODE_WIDTH-1 downto 0);
    -------------------------------------------------------------------------------
    -- Value Output Interface
    -------------------------------------------------------------------------------
        VALUE           : out std_logic_vector(VALUE_BITS-1 downto 0);
        SIGN            : out std_logic;
        LAST            : out std_logic;
        VALID           : out std_logic;
        READY           : in  std_logic
    );
end  MsgPack_Object_Store_Integer_Register;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Decode_Integer;
architecture RTL of MsgPack_Object_Store_Integer_Register is
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    DECODE: MsgPack_Object_Decode_Integer        -- 
        generic map (                            -- 
            CODE_WIDTH      => CODE_WIDTH      , --
            VALUE_BITS      => VALUE_BITS      , --
            VALUE_SIGN      => VALUE_SIGN      , --
            CHECK_RANGE     => CHECK_RANGE     , --
            ENABLE64        => ENABLE64          --
        )                                        -- 
        port map (                               -- 
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
            I_CODE          => I_CODE          , -- In  :
            I_LAST          => I_LAST          , -- In  :
            I_VALID         => I_VALID         , -- In  :
            I_ERROR         => I_ERROR         , -- Out :
            I_DONE          => I_DONE          , -- Out :
            I_SHIFT         => I_SHIFT         , -- Out :
            O_VALUE         => VALUE           , -- Out :
            O_SIGN          => SIGN            , -- Out :
            O_LAST          => LAST            , -- Out :
            O_VALID         => VALID           , -- Out :
            O_READY         => READY             -- In  :
        );                                       --
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_rpc_method_main_with_param.vhd
--!     @brief   MessagePack-RPC Method Main Module with Parameter :
--!     @version 0.2.5
--!     @date    2017/3/14
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2015-2017 Ichiro Kawazome
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
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
entity  MsgPack_RPC_Method_Main_with_Param is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        NAME            : string;
        PARAM_NUM       : positive := 1;
        MATCH_PHASE     : positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : in  std_logic_vector        (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : in  MsgPack_RPC.Code_Type;
        MATCH_OK        : out std_logic;
        MATCH_NOT       : out std_logic;
        MATCH_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Call Request Interface
    -------------------------------------------------------------------------------
        PROC_REQ_ID     : in  MsgPack_RPC.MsgID_Type;
        PROC_REQ        : in  std_logic;
        PROC_BUSY       : out std_logic;
        PROC_START      : out std_logic;
        PARAM_CODE      : in  MsgPack_RPC.Code_Type;
        PARAM_VALID     : in  std_logic;
        PARAM_LAST      : in  std_logic;
        PARAM_SHIFT     : out MsgPack_RPC.Shift_Type;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Set Parameter Interface
    -------------------------------------------------------------------------------
        SET_PARAM_CODE  : out MsgPack_RPC.Code_Type;
        SET_PARAM_LAST  : out std_logic;
        SET_PARAM_VALID : out std_logic_vector        (PARAM_NUM-1 downto 0);
        SET_PARAM_ERROR : in  std_logic_vector        (PARAM_NUM-1 downto 0);
        SET_PARAM_DONE  : in  std_logic_vector        (PARAM_NUM-1 downto 0);
        SET_PARAM_SHIFT : in  MsgPack_RPC.Shift_Vector(PARAM_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Request/Response/Running
    -------------------------------------------------------------------------------
        RUN_REQ_VAL     : out std_logic;
        RUN_REQ_RDY     : in  std_logic := '1';
        RUN_RES_VAL     : in  std_logic;
        RUN_RES_RDY     : out std_logic;
        RUNNING         : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Return Interface
    -------------------------------------------------------------------------------
        RET_ID          : out MsgPack_RPC.MsgID_Type;
        RET_ERROR       : out std_logic;
        RET_START       : out std_logic;
        RET_DONE        : out std_logic;
        RET_BUSY        : in  std_logic
    );
end  MsgPack_RPC_Method_Main_with_Param;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Code_Reducer;
use     MsgPack.MsgPack_KVMap_Components.MsgPack_KVMap_Key_Compare;
architecture RTL of MsgPack_RPC_Method_Main_with_Param is
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    signal    param_ready       :  std_logic;
    signal    param_select      :  std_logic_vector(PARAM_NUM    -1 downto 0);
    constant  PARAM_SEL_ALL_0   :  std_logic_vector(PARAM_NUM    -1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    constant  I_PARAM_WIDTH     :  integer := MsgPack_RPC.Code_Length;
    signal    i_param_code      :  MsgPack_Object.Code_Vector(I_PARAM_WIDTH-1 downto 0);
    signal    i_param_enable    :  std_logic;
    signal    i_param_last      :  std_logic;
    signal    i_param_nomore    :  std_logic;
    signal    i_param_ready     :  std_logic;
    signal    i_param_valid     :  std_logic_vector(I_PARAM_WIDTH-1 downto 0);
    signal    i_param_shift     :  std_logic_vector(I_PARAM_WIDTH-1 downto 0);
    constant  I_PARAM_ALL_0     :  std_logic_vector(I_PARAM_WIDTH-1 downto 0) := (others => '0');
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    function  to_i_param_shift(Num: integer) return std_logic_vector is
        variable param_shift    :  std_logic_vector(I_PARAM_WIDTH-1 downto 0);
    begin
        for i in param_shift'range loop
            if (i < Num) then
                param_shift(i) := '1';
            else
                param_shift(i) := '0';
            end if;
        end loop;
        return param_shift;
    end function;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    type      STATE_TYPE        is (IDLE_STATE        ,
                                    PARAM_BEGIN_STATE ,
                                    PARAM_SET_STATE   ,
                                    ERROR_SKIP_STATE  ,
                                    ERROR_RETURN_STATE,
                                    ERROR_END_STATE   ,
                                    PROC_BEGIN_STATE  ,
                                    PROC_BUSY_STATE   ,
                                    PROC_END_STATE
                                   );
    signal    curr_state        :  STATE_TYPE;
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    MATCH: MsgPack_KVMap_Key_Compare                     -- 
        generic map (                                    -- 
            CODE_WIDTH      => MsgPack_RPC.Code_Length , -- 
            I_MAX_PHASE     => MATCH_PHASE             , --
            KEYWORD         => NAME                      --
        )                                                -- 
        port map (                                       -- 
            CLK             => CLK                     , -- 
            RST             => RST                     , -- 
            CLR             => CLR                     , -- 
            I_CODE          => MATCH_CODE              , -- 
            I_REQ_PHASE     => MATCH_REQ               , -- 
            MATCH           => MATCH_OK                , -- 
            MISMATCH        => MATCH_NOT               , -- 
            SHIFT           => MATCH_SHIFT               -- 
        );                                               -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    I_PARAM: MsgPack_Object_Code_Reducer                 --
        generic map (                                    -- 
            I_WIDTH         => MsgPack_RPC.Code_Length , -- 
            O_WIDTH         => I_PARAM_WIDTH           , -- 
            O_VALID_SIZE    => 1                       , -- 
            QUEUE_SIZE      => 0                         -- 
        )                                                -- 
        port map (                                       -- 
            CLK             => CLK                     , -- In  :
            RST             => RST                     , -- In  :
            CLR             => CLR                     , -- In  :
            DONE            => '0'                     , -- In  :
            BUSY            => open                    , -- Out :
            I_ENABLE        => i_param_enable          , -- In  :
            I_CODE          => PARAM_CODE              , -- In  :
            I_DONE          => PARAM_LAST              , -- In  :
            I_VALID         => PARAM_VALID             , -- In  :
            I_READY         => param_ready             , -- Out :
            O_ENABLE        => '1'                     , -- In  :
            O_CODE          => i_param_code            , -- Out :
            O_DONE          => i_param_last            , -- Out :
            O_VALID         => open                    , -- Out :
            O_READY         => i_param_ready           , -- In  :
            O_SHIFT         => i_param_shift             -- In  :
        );                                               --
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (PARAM_CODE, param_ready)
        variable valid :  std_logic_vector(PARAM_CODE'range);
    begin
        for i in valid'range loop
            valid(i) := PARAM_CODE(i).valid;
        end loop;
        if (param_ready = '1') then
            PARAM_SHIFT <= valid;
        else
            PARAM_SHIFT <= (others => '0');
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (i_param_code) begin
        for i in i_param_valid'range loop
            i_param_valid(i) <= i_param_code(i).valid;
        end loop;
    end process;
    i_param_nomore <= '1' when (i_param_last = '1') and
                               ((i_param_valid and not i_param_shift) = I_PARAM_ALL_0) else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                curr_state   <= IDLE_STATE;
                param_select <= (others => '0');
                PROC_START   <= '0';
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                curr_state   <= IDLE_STATE;
                param_select <= (others => '0');
                PROC_START   <= '0';
            else
                case curr_state is
                    when IDLE_STATE =>
                        if (PROC_REQ = '1') then
                            curr_state <= PARAM_BEGIN_STATE;
                        else
                            curr_state <= IDLE_STATE;
                        end if;
                        param_select <= (others => '0');
                    when PARAM_BEGIN_STATE =>
                        if (i_param_code(0).valid = '1') then
                            if (i_param_code(0).class = MsgPack_Object.CLASS_ARRAY) and
                               (i_param_code(0).data  = std_logic_vector(to_unsigned(PARAM_NUM, 32))) then
                                curr_state   <= PARAM_SET_STATE;
                                param_select <= (0 => '1', others => '0');
                            elsif (i_param_nomore = '1') then
                                curr_state   <= ERROR_RETURN_STATE;
                                param_select <= (others => '0');
                            else
                                curr_state   <= ERROR_SKIP_STATE;
                                param_select <= (others => '0');
                            end if;
                        else
                                curr_state   <= PARAM_BEGIN_STATE;
                                param_select <= (others => '0');
                        end if;
                    when PARAM_SET_STATE =>
                        if ((SET_PARAM_DONE and param_select) /= PARAM_SEL_ALL_0) then
                            if    ((SET_PARAM_ERROR and param_select) /= PARAM_SEL_ALL_0) then
                                if (i_param_nomore = '1') then
                                    curr_state   <= ERROR_RETURN_STATE;
                                    param_select <= (others => '0');
                                else
                                    curr_state   <= ERROR_SKIP_STATE;
                                    param_select <= (others => '0');
                                end if;
                            elsif (param_select(param_select'high) = '1') then
                                if (i_param_nomore = '0') then
                                    curr_state   <= ERROR_SKIP_STATE;
                                    param_select <= (others => '0');
                                else
                                    curr_state   <= PROC_BEGIN_STATE;
                                    param_select <= (others => '0');
                                end if;
                            else
                                curr_state   <= PARAM_SET_STATE;
                                for i in param_select'range loop
                                    if (i > 0) then
                                        param_select(i) <= param_select(i-1);
                                    else
                                        param_select(i) <= '0';
                                    end if;
                                end loop;
                            end if;
                        else
                                curr_state <= PARAM_SET_STATE;
                        end if;
                    when ERROR_SKIP_STATE =>
                        if (i_param_nomore = '1') then
                            curr_state <= ERROR_RETURN_STATE;
                        else
                            curr_state <= ERROR_SKIP_STATE;
                        end if;
                    when ERROR_RETURN_STATE =>
                            curr_state <= ERROR_END_STATE;
                    when ERROR_END_STATE =>
                        if (RET_BUSY = '0') then
                            curr_state <= IDLE_STATE;
                        else
                            curr_state <= ERROR_END_STATE;
                        end if;
                    when PROC_BEGIN_STATE =>
                        if    (RUN_RES_VAL = '1') then
                            curr_state <= PROC_END_STATE;
                        elsif (RUN_REQ_RDY = '1') then
                            curr_state <= PROC_BUSY_STATE;
                        else
                            curr_state <= PROC_BEGIN_STATE;
                        end if;
                    when PROC_BUSY_STATE  =>
                        if (RUN_RES_VAL = '1') then
                            curr_state <= PROC_END_STATE;
                        else
                            curr_state <= PROC_BUSY_STATE;
                        end if;
                    when PROC_END_STATE =>
                        if (RET_BUSY = '0') then
                            curr_state <= IDLE_STATE;
                        else
                            curr_state <= PROC_END_STATE;
                        end if;
                    when others =>
                        curr_state   <= IDLE_STATE;
                        param_select <= (others => '0');
                end case;
                if (curr_state = IDLE_STATE and PROC_REQ = '1') then
                    PROC_START <= '1';
                else
                    PROC_START <= '0';
                end if;
            end if;
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    PROC_BUSY   <= '1' when (curr_state /= IDLE_STATE        ) else '0';
    RUN_REQ_VAL <= '1' when (curr_state  = PROC_BEGIN_STATE  ) else '0';
    RUN_RES_RDY <= '1' when (curr_state  = PROC_BEGIN_STATE  ) or
                            (curr_state  = PROC_BUSY_STATE   ) else '0';
    RUNNING     <= '1' when (curr_state  = PROC_BEGIN_STATE  ) or
                            (curr_state  = PROC_BUSY_STATE   ) else '0';
    RET_ERROR   <= '1' when (curr_state  = ERROR_RETURN_STATE) else '0';
    RET_START   <= '1' when (curr_state  = ERROR_RETURN_STATE) or
                            (curr_state  = PROC_BEGIN_STATE and RUN_RES_VAL = '1') or
                            (curr_state  = PROC_BEGIN_STATE and RUN_REQ_RDY = '1') else '0';
    RET_DONE    <= '1' when (curr_state  = ERROR_RETURN_STATE) or
                            (curr_state  = PROC_BEGIN_STATE and RUN_RES_VAL = '1') or
                            (curr_state  = PROC_BUSY_STATE  and RUN_RES_VAL = '1') else '0';
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (curr_state, param_select, PROC_REQ, SET_PARAM_SHIFT)
        variable shift : MsgPack_RPC.Shift_Type;
    begin
        case curr_state is
            when IDLE_STATE =>
                i_param_enable <= PROC_REQ;
                i_param_ready  <= '0';
                i_param_shift  <= to_i_param_shift(0);
            when PARAM_BEGIN_STATE =>
                i_param_enable <= '1';
                i_param_ready  <= '1';
                i_param_shift  <= to_i_param_shift(1);
            when PARAM_SET_STATE   =>
                shift := (others => '0');
                for i in 0 to PARAM_NUM-1 loop
                    if (param_select(i) = '1') then
                        shift := shift or SET_PARAM_SHIFT(i);
                    end if;
                end loop;
                i_param_enable <= '1';
                i_param_ready  <= '1';
                i_param_shift  <= shift;
            when ERROR_SKIP_STATE =>
                i_param_enable <= '1';
                i_param_ready  <= '1';
                i_param_shift  <= to_i_param_shift(I_PARAM_WIDTH);
            when others =>
                i_param_enable <= '0';
                i_param_ready  <= '0';
                i_param_shift  <= to_i_param_shift(0);
        end case;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    SET_PARAM_CODE  <= i_param_code;
    SET_PARAM_LAST  <= i_param_last;
    SET_PARAM_VALID <= param_select;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (CLK, RST) begin
        if (RST = '1') then
                RET_ID <= MsgPack_RPC.MsgID_Null;
        elsif (CLK'event and CLK = '1') then
            if (CLR = '1') then
                RET_ID <= MsgPack_RPC.MsgID_Null;
            elsif (curr_state = IDLE_STATE and PROC_REQ = '1') then
                RET_ID <= PROC_REQ_ID;
            end if;
        end if;
    end process;
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_rpc_method_return_integer.vhd
--!     @brief   MessagePack-RPC Method Return (Integer Type) Module :
--!     @version 0.2.0
--!     @date    2016/5/20
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2015-2016 Ichiro Kawazome
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
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
entity  MsgPack_RPC_Method_Return_Integer is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        VALUE_WIDTH     :  positive := 32;
        RETURN_UINT     :  boolean  := TRUE;
        RETURN_INT      :  boolean  := TRUE;
        RETURN_FLOAT    :  boolean  := TRUE;
        RETURN_BOOLEAN  :  boolean  := TRUE
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Return Interface
    -------------------------------------------------------------------------------
        RET_ERROR       : in  std_logic;
        RET_START       : in  std_logic;
        RET_DONE        : in  std_logic;
        RET_BUSY        : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Method Response Interface
    -------------------------------------------------------------------------------
        RES_CODE        : out MsgPack_RPC.Code_Type;
        RES_VALID       : out std_logic;
        RES_LAST        : out std_logic;
        RES_READY       : in  std_logic;
    -------------------------------------------------------------------------------
    -- Return Value
    -------------------------------------------------------------------------------
        VALUE           : in  std_logic_vector(VALUE_WIDTH-1 downto 0)
    );
end MsgPack_RPC_Method_Return_Integer;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Code_Reducer;
architecture RTL of MsgPack_RPC_Method_Return_Integer is
    constant  RESULT_WIDTH  :  integer := (VALUE'length+MsgPack_Object.CODE_DATA_BITS-1)/MsgPack_Object.CODE_DATA_BITS;
    signal    return_code   :  MsgPack_Object.Code_Vector(RESULT_WIDTH downto 0);
    constant  res_shift     :  MsgPack_RPC.Shift_Type := (others => '1');
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    process (RET_ERROR, VALUE) begin
        if    (RET_ERROR = '1') then
            return_code(0)                     <= MsgPack_RPC.New_Error_Code_Invalid_Argment;
            return_code(RESULT_WIDTH downto 1) <= MsgPack_Object.New_Code_Vector_Nil    (RESULT_WIDTH);
        elsif (RETURN_INT) then
            return_code(0)                     <= MsgPack_Object.New_Code_Nil;
            return_code(RESULT_WIDTH downto 1) <= MsgPack_Object.New_Code_Vector_Integer(RESULT_WIDTH, signed(VALUE));
        elsif (RETURN_FLOAT) then
            return_code(0)                     <= MsgPack_Object.New_Code_Nil;
            return_code(RESULT_WIDTH downto 1) <= MsgPack_Object.New_Code_Vector_Float  (RESULT_WIDTH, VALUE);
        elsif (RETURN_BOOLEAN and VALUE(0) = '1') then
            return_code(0)                     <= MsgPack_Object.New_Code_Nil;
            return_code(RESULT_WIDTH downto 1) <= MsgPack_Object.New_Code_Vector_True   (RESULT_WIDTH);
        elsif (RETURN_BOOLEAN and VALUE(0) = '0') then
            return_code(0)                     <= MsgPack_Object.New_Code_Nil;
            return_code(RESULT_WIDTH downto 1) <= MsgPack_Object.New_Code_Vector_False  (RESULT_WIDTH);
        else
            return_code(0)                     <= MsgPack_Object.New_Code_Nil;
            return_code(RESULT_WIDTH downto 1) <= MsgPack_Object.New_Code_Vector_Integer(RESULT_WIDTH, unsigned(VALUE));
        end if;
    end process;
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    RES_BUF: MsgPack_Object_Code_Reducer                 -- 
        generic map (                                    -- 
            I_WIDTH         => return_code'length      , -- 
            O_WIDTH         => MsgPack_RPC.Code_Length , --
            O_VALID_SIZE    => MsgPack_RPC.Code_Length , -- 
            QUEUE_SIZE      => MsgPack_RPC.Code_Length + return_code'length - 1
        )                                                -- 
        port map (                                       -- 
            CLK             => CLK                     , -- In  :
            RST             => RST                     , -- In  :
            CLR             => CLR                     , -- In  :
            DONE            => '0'                     , -- In  :
            BUSY            => RET_BUSY                , -- Out :
            I_ENABLE        => '1'                     , -- In  :
            I_CODE          => return_code             , -- In  :
            I_DONE          => '1'                     , -- In  :
            I_VALID         => RET_DONE                , -- In  :
            I_READY         => open                    , -- Out :
            O_ENABLE        => '1'                     , -- In  :
            O_CODE          => RES_CODE                , -- Out :
            O_DONE          => RES_LAST                , -- Out :
            O_VALID         => RES_VALID               , -- Out :
            O_READY         => RES_READY               , -- In  :
            O_SHIFT         => res_shift                 -- In  :
        );                                               --
end RTL;
-----------------------------------------------------------------------------------
--!     @file    msgpack_rpc_server.vhd
--!     @brief   MessagePack-RPC Server Module :
--!     @version 0.2.0
--!     @date    2016/5/20
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2015-2016 Ichiro Kawazome
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
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
entity  MsgPack_RPC_Server is
    -------------------------------------------------------------------------------
    -- Generic Parameters
    -------------------------------------------------------------------------------
    generic (
        I_BYTES         : positive := 1;
        O_BYTES         : positive := 1;
        PROC_NUM        : positive := 1;
        MATCH_PHASE     : positive := 8
    );
    port (
    -------------------------------------------------------------------------------
    -- Clock and Reset Signals
    -------------------------------------------------------------------------------
        CLK             : in  std_logic; 
        RST             : in  std_logic;
        CLR             : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Data Stream Input Interface
    -------------------------------------------------------------------------------
        I_DATA          : in  std_logic_vector(8*I_BYTES-1 downto 0);
        I_STRB          : in  std_logic_vector(  I_BYTES-1 downto 0);
        I_LAST          : in  std_logic := '0';
        I_VALID         : in  std_logic;
        I_READY         : out std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPC Byte Data Stream Output Interface
    -------------------------------------------------------------------------------
        O_DATA          : out std_logic_vector(8*O_BYTES-1 downto 0);
        O_STRB          : out std_logic_vector(  O_BYTES-1 downto 0);
        O_LAST          : out std_logic;
        O_VALID         : out std_logic;
        O_READY         : in  std_logic;
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Match Interface
    -------------------------------------------------------------------------------
        MATCH_REQ       : out std_logic_vector     (MATCH_PHASE-1 downto 0);
        MATCH_CODE      : out MsgPack_RPC.Code_Type;
        MATCH_OK        : in  std_logic_vector        (PROC_NUM-1 downto 0);
        MATCH_NOT       : in  std_logic_vector        (PROC_NUM-1 downto 0);
        MATCH_SHIFT     : in  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Request Interface
    -------------------------------------------------------------------------------
        PROC_REQ_ID     : out MsgPack_RPC.MsgID_Type;
        PROC_REQ        : out std_logic_vector        (PROC_NUM-1 downto 0);
        PROC_BUSY       : in  std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_VALID     : out std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_CODE      : out MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
        PARAM_LAST      : out std_logic_vector        (PROC_NUM-1 downto 0);
        PARAM_SHIFT     : in  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    -------------------------------------------------------------------------------
    -- MessagePack-RPCs Method Call Response Interface
    -------------------------------------------------------------------------------
        PROC_RES_ID     : in  MsgPack_RPC.MsgID_Vector(PROC_NUM-1 downto 0);
        PROC_RES_CODE   : in  MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
        PROC_RES_VALID  : in  std_logic_vector        (PROC_NUM-1 downto 0);
        PROC_RES_LAST   : in  std_logic_vector        (PROC_NUM-1 downto 0);
        PROC_RES_READY  : out std_logic_vector        (PROC_NUM-1 downto 0)
    );
end  MsgPack_RPC_Server;
-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Server_Requester;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Server_Responder;
architecture RTL of MsgPack_RPC_Server is
    signal    res_id            :  MsgPack_RPC.MsgID_Vector(PROC_NUM downto 0);
    signal    res_code          :  MsgPack_RPC.Code_Vector (PROC_NUM downto 0);
    signal    res_valid         :  std_logic_vector        (PROC_NUM downto 0);
    signal    res_last          :  std_logic_vector        (PROC_NUM downto 0);
    signal    res_ready         :  std_logic_vector        (PROC_NUM downto 0);
begin
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    REQ: MsgPack_RPC_Server_Requester            -- 
        generic map (                            -- 
            I_BYTES         => I_BYTES         , --
            PROC_NUM        => PROC_NUM        , --
            MATCH_PHASE     => MATCH_PHASE       --
        )                                        -- 
        port map (                               -- 
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
            I_DATA          => I_DATA          , -- In  :
            I_STRB          => I_STRB          , -- In  :
            I_LAST          => I_LAST          , -- In  :
            I_VALID         => I_VALID         , -- In  :
            I_READY         => I_READY         , -- Out :
            MATCH_REQ       => MATCH_REQ       , -- Out :
            MATCH_CODE      => MATCH_CODE      , -- Out :
            MATCH_OK        => MATCH_OK        , -- In  :
            MATCH_NOT       => MATCH_NOT       , -- In  :
            MATCH_SHIFT     => MATCH_SHIFT     , -- In  :
            PROC_REQ_ID     => PROC_REQ_ID     , -- Out :
            PROC_REQ        => PROC_REQ        , -- Out :
            PROC_BUSY       => PROC_BUSY       , -- In  :
            PARAM_VALID     => PARAM_VALID     , -- Out :
            PARAM_CODE      => PARAM_CODE      , -- Out :
            PARAM_LAST      => PARAM_LAST      , -- Out :
            PARAM_SHIFT     => PARAM_SHIFT     , -- In  :
            ERROR_RES_ID    => res_id(0)       , -- Out :
            ERROR_RES_CODE  => res_code(0)     , -- Out :
            ERROR_RES_VALID => res_valid(0)    , -- Out :
            ERROR_RES_LAST  => res_last(0)     , -- Out :
            ERROR_RES_READY => res_ready(0)      -- In  :
        );                                       -- 
    -------------------------------------------------------------------------------
    --
    -------------------------------------------------------------------------------
    RES: MsgPack_RPC_Server_Responder            -- 
        generic map (                            -- 
            O_BYTES         => O_BYTES         , --
            RES_NUM         => PROC_NUM+1        --
        )                                        -- 
        port map (                               -- 
            CLK             => CLK             , -- In  :
            RST             => RST             , -- In  :
            CLR             => CLR             , -- In  :
            O_DATA          => O_DATA          , -- Out :
            O_STRB          => O_STRB          , -- Out :
            O_LAST          => O_LAST          , -- Out :
            O_VALID         => O_VALID         , -- Out :
            O_READY         => O_READY         , -- In  :
            RES_ID          => res_id          , -- In  :
            RES_CODE        => res_code        , -- In  :
            RES_VALID       => res_valid       , -- In  :
            RES_LAST        => res_last        , -- In  :
            RES_READY       => res_ready         -- Out :
        );
    RES_GEN: for i in 0 to PROC_NUM-1 generate
        res_id   (i+1) <= PROC_RES_ID   (i);
        res_code (i+1) <= PROC_RES_CODE (i);
        res_valid(i+1) <= PROC_RES_VALID(i);
        res_last (i+1) <= PROC_RES_LAST (i);
        PROC_RES_READY(i) <= res_ready(i+1);
    end generate;
end RTL;
