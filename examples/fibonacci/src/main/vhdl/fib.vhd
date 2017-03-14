library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
entity  FIB is
    port (
        CLK    : in  std_logic;
        RST    : in  std_logic;
        REQ_VAL: in  std_logic;
        REQ_RDY: out std_logic;
        N      : in  std_logic_vector( 7 downto 0);
        RES_VAL: out std_logic;
        RES_RDY: in  std_logic;
        O      : out std_logic_vector(63 downto 0)
    );
end     FIB;
architecture RTL of FIB is
    signal    curr_count  :  unsigned(N'length-1 downto 0);
    signal    last_count  :  unsigned(N'length-1 downto 0);
    signal    curr_value  :  unsigned(O'length-1 downto 0);
    signal    prev_value  :  unsigned(O'length-1 downto 0);
    signal    run         :  boolean;
begin
    process (CLK, RST) begin
        if (RST = '1') then
            run        <= FALSE;
            curr_count <= (others => '0');
            last_count <= (others => '0');
            curr_value <= (others => '0');
            prev_value <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            if (run = FALSE) then
                if (REQ_VAL = '1') then
                    run <= TRUE;
                    last_count <= unsigned(N);
                    curr_count <= to_unsigned(1, curr_count'length);
                    prev_value <= to_unsigned(0, curr_value'length);
                    if (unsigned(N) > 0) then
                        curr_value <= to_unsigned(1, curr_value'length);
                    else
                        curr_value <= to_unsigned(0, curr_value'length);
                    end if;
                end if;
            else
                if (curr_count < last_count) then
                    curr_count <= curr_count + 1;
                    prev_value <= curr_value;
                    curr_value <= curr_value + prev_value;
                elsif (RES_RDY = '1') then
                    run <= FALSE;
                end if;
            end if;
        end if;
    end process;
    REQ_RDY <= '1' when (run = FALSE) else '0';
    RES_VAL <= '1' when (run = TRUE and curr_count >= last_count) else '0';
    O    <= std_logic_vector(curr_value);
end RTL;

