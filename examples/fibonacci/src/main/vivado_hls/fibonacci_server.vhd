library ieee;
use     ieee.std_logic_1164.all;
entity  Fibonacci_Server is
    generic(
        I_BYTES              : integer := 1;
        O_BYTES              : integer := 1
    );
    port(
        CLK                  : in  std_logic;
        ARESETn              : in  std_logic;
        I_TDATA              : in  std_logic_vector(8*I_BYTES-1 downto 0);
        I_TKEEP              : in  std_logic_vector(  I_BYTES-1 downto 0);
        I_TLAST              : in  std_logic;
        I_TVALID             : in  std_logic;
        I_TREADY             : out std_logic;
        O_TDATA              : out std_logic_vector(8*O_BYTES-1 downto 0);
        O_TKEEP              : out std_logic_vector(  O_BYTES-1 downto 0);
        O_TLAST              : out std_logic;
        O_TVALID             : out std_logic;
        O_TREADY             : in  std_logic
    );
end     Fibonacci_Server;
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
architecture RTL of Fibonacci_Server is
    signal    reset            :  std_logic;
    signal    reset_n          :  std_logic;
    signal    ap_start         :  std_logic;
    signal    ap_idle          :  std_logic;
    signal    ap_ready         :  std_logic;
    signal    ap_done          :  std_logic;
    signal    n                :  std_logic_vector(32-1 downto 0);
    signal    ap_return        :  std_logic_vector(64-1 downto 0);
    component Fibonacci_Interface is
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
            ap_start             : out std_logic;
            ap_idle              : in  std_logic;
            ap_ready             : in  std_logic;
            ap_done              : in  std_logic;
            n                    : out std_logic_vector(32-1 downto 0);
            ap_return            : in  std_logic_vector(64-1 downto 0)
        );
    end component;
    component FIB is
        port(
            ap_clk               : in  std_logic;
            ap_rst               : in  std_logic;
            ap_start             : in  std_logic;
            ap_idle              : out std_logic;
            ap_ready             : out std_logic;
            ap_done              : out std_logic;
            n                    : in  std_logic_vector(32-1 downto 0);
            ap_return            : out std_logic_vector(64-1 downto 0)
        );
    end component;
begin
    reset      <= not ARESETn;
    reset_n    <=     ARESETn;
    U : Fibonacci_Interface
        generic map(
            I_BYTES              => I_BYTES             ,
            O_BYTES              => O_BYTES             
        )
        port map(
            CLK                  => CLK                 ,
            RST                  => reset               ,
            CLR                  => '0'                 ,
            I_DATA               => I_TDATA             ,
            I_STRB               => I_TKEEP             ,
            I_LAST               => I_TLAST             ,
            I_VALID              => I_TVALID            ,
            I_READY              => I_TREADY            ,
            O_DATA               => O_TDATA             ,
            O_STRB               => O_TKEEP             ,
            O_LAST               => O_TLAST             ,
            O_VALID              => O_TVALID            ,
            O_READY              => O_TREADY            ,
            ap_start             => ap_start            ,
            ap_idle              => ap_idle             ,
            ap_ready             => ap_ready            ,
            ap_done              => ap_done             ,
            n                    => n                   ,
            ap_return            => ap_return           
        );
    T : FIB
        port map(
            ap_clk               => CLK                 ,
            ap_rst               => reset               ,
            ap_start             => ap_start            ,
            ap_idle              => ap_idle             ,
            ap_ready             => ap_ready            ,
            ap_done              => ap_done             ,
            n                    => n                   ,
            ap_return            => ap_return           
        );
end RTL;
