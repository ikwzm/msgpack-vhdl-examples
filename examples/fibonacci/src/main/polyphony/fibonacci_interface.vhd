library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
entity  Fibonacci_Interface is
    generic(
        I_BYTES              : integer := 1;
        O_BYTES              : integer := 1
    );
    port(
        CLK                  : in  std_logic;
        RST                  : in  std_logic;
        CLR                  : in  std_logic;
        I_DATA               : in  std_logic_vector(8*I_BYTES-1 downto 0);
        I_STRB               : in  std_logic_vector(  I_BYTES-1 downto 0);
        I_LAST               : in  std_logic;
        I_VALID              : in  std_logic;
        I_READY              : out std_logic;
        O_DATA               : out std_logic_vector(8*O_BYTES-1 downto 0);
        O_STRB               : out std_logic_vector(  O_BYTES-1 downto 0);
        O_LAST               : out std_logic;
        O_VALID              : out std_logic;
        O_READY              : in  std_logic;
        fib_ready            : out std_logic;
        fib_accept           : out std_logic;
        fib_valid            : in  std_logic;
        fib_in_n             : out signed(32-1 downto 0);
        fib_out_0            : in  signed(32-1 downto 0)
    );
end     Fibonacci_Interface;
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
library MsgPack;
use     MsgPack.MsgPack_Object;
use     MsgPack.MsgPack_RPC;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Server;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Method_Main_with_Param;
use     MsgPack.MsgPack_Object_Components.MsgPack_Object_Store_Integer_Register;
use     MsgPack.MsgPack_RPC_Components.MsgPack_RPC_Method_Return_Integer;
architecture RTL of Fibonacci_Interface is
    constant  PROC_NUM          :  integer := 1;
    signal    proc_match_req    :  std_logic_vector        (8-1 downto 0);
    signal    proc_match_code   :  MsgPack_RPC.Code_Type;
    signal    proc_match_ok     :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal    proc_match_not    :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal    proc_match_shift  :  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    signal    proc_req_id       :  MsgPack_RPC.MsgID_Type;
    signal    proc_req          :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal    proc_busy         :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal    proc_param_code   :  MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
    signal    proc_param_valid  :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal    proc_param_last   :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal    proc_param_shift  :  MsgPack_RPC.Shift_Vector(PROC_NUM-1 downto 0);
    signal    proc_res_id       :  MsgPack_RPC.MsgID_Vector(PROC_NUM-1 downto 0);
    signal    proc_res_code     :  MsgPack_RPC.Code_Vector (PROC_NUM-1 downto 0);
    signal    proc_res_valid    :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal    proc_res_last     :  std_logic_vector        (PROC_NUM-1 downto 0);
    signal    proc_res_ready    :  std_logic_vector        (PROC_NUM-1 downto 0);
begin
    PROC_SERVER: MsgPack_RPC_Server                   -- 
        generic map (                                             -- 
            I_BYTES             => I_BYTES                      , --
            O_BYTES             => O_BYTES                      , --
            PROC_NUM            => PROC_NUM                     , --
            MATCH_PHASE         => 8                              --
        )                                                         -- 
        port map (                                                -- 
            CLK                 => CLK                          , -- In  :
            RST                 => RST                          , -- in  :
            CLR                 => CLR                          , -- in  :
            I_DATA              => I_DATA                       , -- In  :
            I_STRB              => I_STRB                       , -- In  :
            I_LAST              => I_LAST                       , -- In  :
            I_VALID             => I_VALID                      , -- In  :
            I_READY             => I_READY                      , -- Out :
            O_DATA              => O_DATA                       , -- Out :
            O_STRB              => O_STRB                       , -- Out :
            O_LAST              => O_LAST                       , -- Out :
            O_VALID             => O_VALID                      , -- Out :
            O_READY             => O_READY                      , -- In  :
            MATCH_REQ           => proc_match_req               , -- Out :
            MATCH_CODE          => proc_match_code              , -- Out :
            MATCH_OK            => proc_match_ok                , -- In  :
            MATCH_NOT           => proc_match_not               , -- In  :
            MATCH_SHIFT         => proc_match_shift             , -- In  :
            PROC_REQ_ID         => proc_req_id                  , -- Out :
            PROC_REQ            => proc_req                     , -- Out :
            PROC_BUSY           => proc_busy                    , -- In  :
            PARAM_VALID         => proc_param_valid             , -- Out :
            PARAM_CODE          => proc_param_code              , -- Out :
            PARAM_LAST          => proc_param_last              , -- Out :
            PARAM_SHIFT         => proc_param_shift             , -- In  :
            PROC_RES_ID         => proc_res_id                  , -- In  :
            PROC_RES_CODE       => proc_res_code                , -- In  :
            PROC_RES_VALID      => proc_res_valid               , -- In  :
            PROC_RES_LAST       => proc_res_last                , -- In  :
            PROC_RES_READY      => proc_res_ready                 -- Out :
        );                                                        -- 
    PROC_FIB: block
        constant  PROC_PARAM_NUM        :  integer := 1;
        signal    proc_set_param_code   :  MsgPack_RPC.Code_Type;
        signal    proc_set_param_last   :  std_logic;
        signal    proc_set_param_valid  :  std_logic_vector        (PROC_PARAM_NUM-1 downto 0);
        signal    proc_set_param_error  :  std_logic_vector        (PROC_PARAM_NUM-1 downto 0);
        signal    proc_set_param_done   :  std_logic_vector        (PROC_PARAM_NUM-1 downto 0);
        signal    proc_set_param_shift  :  MsgPack_RPC.Shift_Vector(PROC_PARAM_NUM-1 downto 0);
        signal    proc_return_start     :  std_logic;
        signal    proc_return_error     :  std_logic;
        signal    proc_return_done      :  std_logic;
        signal    proc_return_busy      :  std_logic;
        signal    proc_start            :  std_logic;
        signal    proc_run_req_valid    :  std_logic;
        signal    proc_run_res_valid    :  std_logic;
        signal    proc_run_busy         :  std_logic;
    begin
        PROC_MAIN: MsgPack_RPC_Method_Main_with_Param         -- 
            generic map (                                                 -- 
                NAME                    => STRING'("fib")               , --
                PARAM_NUM               => PROC_PARAM_NUM               , --
                MATCH_PHASE             => 8                              --
            )                                                             -- 
            port map (                                                    -- 
                CLK                     => CLK                          , -- In  :
                RST                     => RST                          , -- in  :
                CLR                     => CLR                          , -- in  :
                MATCH_REQ               => proc_match_req               , -- In  :
                MATCH_CODE              => proc_match_code              , -- In  :
                MATCH_OK                => proc_match_ok   (0)          , -- Out :
                MATCH_NOT               => proc_match_not  (0)          , -- Out :
                MATCH_SHIFT             => proc_match_shift(0)          , -- Out :
                PROC_REQ_ID             => proc_req_id                  , -- In  :
                PROC_REQ                => proc_req        (0)          , -- In  :
                PROC_BUSY               => proc_busy       (0)          , -- Out :
                PROC_START              => proc_start                   , -- Out :
                PARAM_CODE              => proc_param_code (0)          , -- In  :
                PARAM_VALID             => proc_param_valid(0)          , -- In  :
                PARAM_LAST              => proc_param_last (0)          , -- In  :
                PARAM_SHIFT             => proc_param_shift(0)          , -- Out :
                SET_PARAM_CODE          => proc_set_param_code          , -- Out :
                SET_PARAM_LAST          => proc_set_param_last          , -- Out :
                SET_PARAM_VALID         => proc_set_param_valid         , -- Out :
                SET_PARAM_ERROR         => proc_set_param_error         , -- In  :
                SET_PARAM_DONE          => proc_set_param_done          , -- In  :
                SET_PARAM_SHIFT         => proc_set_param_shift         , -- In  :
                RUN_REQ_VAL             => proc_run_req_valid           , -- Out :
                RUN_REQ_RDY             => '1'                          , -- In  :
                RUN_RES_VAL             => proc_run_res_valid           , -- In  :
                RUN_RES_RDY             => open                         , -- Out :
                RUNNING                 => open                         , -- Out :
                RET_ID                  => proc_res_id     (0)          , -- Out :
                RET_START               => proc_return_start            , -- Out :
                RET_DONE                => proc_return_done             , -- Out :
                RET_ERROR               => proc_return_error            , -- Out :
                RET_BUSY                => proc_return_busy               -- In  :
            );                                                            -- 
        process(CLK, RST) begin
            if (RST = '1') then
                    proc_run_busy <= '0';
            elsif (CLK'event and CLK = '1') then
                if    (CLR = '1') then
                    proc_run_busy <= '0';
                elsif (proc_run_busy = '0' and proc_run_req_valid = '1') or
                      (proc_run_busy = '1' and fib_valid = '0') then
                    proc_run_busy <= '1';
                else
                    proc_run_busy <= '0';
                end if;
            end if;
        end process;
        fib_ready <= proc_run_req_valid;
        fib_accept <= proc_run_busy;
        proc_run_res_valid <= '1' when (proc_run_busy = '1' and fib_valid = '1') else '0';
        PROC_0_N: block
            signal    proc_0_value :  std_logic_vector(32-1 downto 0);
            signal    proc_0_valid :  std_logic;
        begin
            process(CLK, RST) begin
                if (RST = '1') then
                         fib_in_n <= (others => '0');
                elsif (CLK'event and CLK = '1') then
                    if    (CLR = '1') then
                         fib_in_n <= (others => '0');
                    elsif (proc_0_valid = '1') then
                         fib_in_n <= signed(proc_0_value);
                    end if;
                end if;
            end process;
            PROC_STORE_N : MsgPack_Object_Store_Integer_Register                      -- 
                generic map (                                             -- 
                    CODE_WIDTH          => MsgPack_RPC.Code_Length      , --
                    VALUE_BITS          => 32                           , --
                    VALUE_SIGN          => true                         , --
                    CHECK_RANGE         => TRUE                         , --
                    ENABLE64            => TRUE                           --
                )                                                         -- 
                port map (                                                -- 
                    CLK                 => CLK                          , -- In  :
                    RST                 => RST                          , -- in  :
                    CLR                 => CLR                          , -- in  :
                    I_CODE              => proc_set_param_code          , -- In  :
                    I_LAST              => proc_set_param_last          , -- In  :
                    I_VALID             => proc_set_param_valid(0)      , -- In  :
                    I_ERROR             => proc_set_param_error(0)      , -- Out :
                    I_DONE              => proc_set_param_done (0)      , -- Out :
                    I_SHIFT             => proc_set_param_shift(0)      , -- Out :
                    VALUE               => proc_0_value                 , -- Out :
                    SIGN                => open                         , -- Out :
                    LAST                => open                         , -- Out :
                    VALID               => proc_0_valid                 , -- Out :
                    READY               => '1'                            -- In  :
                );                                                        -- 
        end block;
        PROC_RETURN : block
            signal proc_return_value : std_logic_vector(32-1 downto 0);
        begin
            RET: MsgPack_RPC_Method_Return_Integer  -- 
                generic map (                                                 -- 
                    VALUE_WIDTH             => 32                           , --
                    RETURN_UINT             => FALSE                        , --
                    RETURN_INT              => TRUE                         , --
                    RETURN_FLOAT            => FALSE                        , --
                    RETURN_BOOLEAN          => FALSE                          --
                )                                                             -- 
                port map (                                                    -- 
                    CLK                     => CLK                          , -- In  :
                    RST                     => RST                          , -- in  :
                    CLR                     => CLR                          , -- in  :
                    RET_ERROR               => proc_return_error            , -- In  :
                    RET_START               => proc_return_start            , -- In  :
                    RET_DONE                => proc_return_done             , -- In  :
                    RET_BUSY                => proc_return_busy             , -- Out :
                    RES_CODE                => proc_res_code   (0)          , -- Out :
                    RES_VALID               => proc_res_valid  (0)          , -- Out :
                    RES_LAST                => proc_res_last   (0)          , -- Out :
                    RES_READY               => proc_res_ready  (0)          , -- In  :
                    VALUE                   => proc_return_value              -- In  :
                );
            proc_return_value <= std_logic_vector(fib_out_0);
        end block;
    end block;
end RTL;
