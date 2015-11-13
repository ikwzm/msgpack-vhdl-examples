library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Fib is
  port (
    clk : in std_logic;
    reset : in std_logic;
    fib_n : in signed(32-1 downto 0);
    fib_return : out signed(64-1 downto 0);
    fib_busy : out std_logic;
    fib_req : in std_logic
  );
end Fib;

architecture RTL of Fib is

  attribute mark_debug : string;
  attribute keep : string;
  attribute S : string;


  signal clk_sig : std_logic;
  signal reset_sig : std_logic;
  signal fib_n_sig : signed(32-1 downto 0);
  signal fib_return_sig : signed(64-1 downto 0) := (others => '0');
  signal fib_busy_sig : std_logic := '1';
  signal fib_req_sig : std_logic;

  signal fib_n_0000 : signed(32-1 downto 0) := (others => '0');
  signal fib_n_local : signed(32-1 downto 0) := (others => '0');
  signal fib_cur_0001 : signed(64-1 downto 0) := X"0000000000000000";
  signal fib_next_0005 : signed(64-1 downto 0) := X"0000000000000001";
  signal fib_i_0009 : signed(32-1 downto 0) := X"00000000";
  signal binary_expr_00012 : std_logic := '0';
  signal unary_expr_00015 : signed(32-1 downto 0) := (others => '0');
  signal fib_tmp_0016 : signed(64-1 downto 0) := (others => '0');
  signal binary_expr_00017 : signed(64-1 downto 0) := (others => '0');
  signal fib_req_flag : std_logic;
  signal fib_req_local : std_logic := '0';
  signal tmp_0001 : std_logic;
  type Type_fib_method is (
    fib_method_IDLE,
    fib_method_S_0000,
    fib_method_S_0001,
    fib_method_S_0002,
    fib_method_S_0005,
    fib_method_S_0006,
    fib_method_S_0007,
    fib_method_S_0008,
    fib_method_S_0009,
    fib_method_S_0010,
    fib_method_S_0011,
    fib_method_S_0012,
    fib_method_S_0014,
    fib_method_S_0015,
    fib_method_S_0016,
    fib_method_S_0017  
  );
  signal fib_method : Type_fib_method := fib_method_IDLE;
  signal fib_method_delay : signed(32-1 downto 0) := (others => '0');
  signal fib_req_flag_d : std_logic := '0';
  signal fib_req_flag_edge : std_logic;
  signal tmp_0002 : std_logic;
  signal tmp_0003 : std_logic;
  signal tmp_0004 : std_logic;
  signal tmp_0005 : std_logic;
  signal tmp_0006 : std_logic;
  signal tmp_0007 : std_logic;
  signal tmp_0008 : std_logic;
  signal tmp_0009 : std_logic;
  signal tmp_0010 : std_logic;
  signal tmp_0011 : std_logic;
  signal tmp_0012 : signed(32-1 downto 0);
  signal tmp_0013 : std_logic;
  signal tmp_0014 : signed(32-1 downto 0);
  signal tmp_0015 : signed(64-1 downto 0);

begin

  clk_sig <= clk;
  reset_sig <= reset;
  fib_n_sig <= fib_n;
  fib_return <= fib_return_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fib_return_sig <= (others => '0');
      else
        if fib_method = fib_method_S_0016 then
          fib_return_sig <= fib_cur_0001;
        end if;
      end if;
    end if;
  end process;

  fib_busy <= fib_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fib_busy_sig <= '1';
      else
        if fib_method = fib_method_S_0000 then
          fib_busy_sig <= '0';
        elsif fib_method = fib_method_S_0001 then
          fib_busy_sig <= tmp_0005;
        end if;
      end if;
    end if;
  end process;

  fib_req_sig <= fib_req;

  -- expressions
  tmp_0001 <= fib_req_local or fib_req_sig;
  tmp_0002 <= not fib_req_flag_d;
  tmp_0003 <= fib_req_flag and tmp_0002;
  tmp_0004 <= fib_req_flag or fib_req_flag_d;
  tmp_0005 <= fib_req_flag or fib_req_flag_d;
  tmp_0006 <= '1' when binary_expr_00012 = '1' else '0';
  tmp_0007 <= '1' when binary_expr_00012 = '0' else '0';
  tmp_0008 <= '1' when fib_method /= fib_method_S_0000 else '0';
  tmp_0009 <= '1' when fib_method /= fib_method_S_0001 else '0';
  tmp_0010 <= tmp_0009 and fib_req_flag_edge;
  tmp_0011 <= tmp_0008 and tmp_0010;
  tmp_0012 <= fib_n_sig when fib_req_sig = '1' else fib_n_local;
  tmp_0013 <= '1' when fib_i_0009 < fib_n_0000 else '0';
  tmp_0014 <= fib_i_0009 + X"00000001";
  tmp_0015 <= fib_next_0005 + fib_tmp_0016;

  -- sequencers
  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fib_method <= fib_method_IDLE;
        fib_method_delay <= (others => '0');
      else
        case (fib_method) is
          when fib_method_IDLE => 
            fib_method <= fib_method_S_0000;
          when fib_method_S_0000 => 
            fib_method <= fib_method_S_0001;
          when fib_method_S_0001 => 
            if tmp_0004 = '1' then
              fib_method <= fib_method_S_0002;
            end if;
          when fib_method_S_0002 => 
            fib_method <= fib_method_S_0005;
          when fib_method_S_0005 => 
            fib_method <= fib_method_S_0006;
          when fib_method_S_0006 => 
            if tmp_0006 = '1' then
              fib_method <= fib_method_S_0011;
            elsif tmp_0007 = '1' then
              fib_method <= fib_method_S_0007;
            end if;
          when fib_method_S_0007 => 
            fib_method <= fib_method_S_0016;
          when fib_method_S_0008 => 
            fib_method <= fib_method_S_0009;
          when fib_method_S_0009 => 
            fib_method <= fib_method_S_0010;
          when fib_method_S_0010 => 
            fib_method <= fib_method_S_0005;
          when fib_method_S_0011 => 
            fib_method <= fib_method_S_0012;
          when fib_method_S_0012 => 
            fib_method <= fib_method_S_0014;
          when fib_method_S_0014 => 
            fib_method <= fib_method_S_0015;
          when fib_method_S_0015 => 
            fib_method <= fib_method_S_0008;
          when fib_method_S_0016 => 
            fib_method <= fib_method_S_0000;
          when fib_method_S_0017 => 
            fib_method <= fib_method_S_0000;
          when others => null;
        end case;
        fib_req_flag_d <= fib_req_flag;
        if (tmp_0008 and tmp_0010) = '1' then
          fib_method <= fib_method_S_0001;
        end if;
      end if;
    end if;
  end process;


  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fib_n_0000 <= (others => '0');
      else
        if fib_method = fib_method_S_0001 then
          fib_n_0000 <= tmp_0012;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fib_cur_0001 <= X"0000000000000000";
      else
        if fib_method = fib_method_S_0002 then
          fib_cur_0001 <= X"0000000000000000";
        elsif fib_method = fib_method_S_0012 then
          fib_cur_0001 <= fib_next_0005;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fib_next_0005 <= X"0000000000000001";
      else
        if fib_method = fib_method_S_0002 then
          fib_next_0005 <= X"0000000000000001";
        elsif fib_method = fib_method_S_0014 then
          fib_next_0005 <= binary_expr_00017;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fib_i_0009 <= X"00000000";
      else
        if fib_method = fib_method_S_0002 then
          fib_i_0009 <= X"00000000";
        elsif fib_method = fib_method_S_0009 then
          fib_i_0009 <= unary_expr_00015;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00012 <= '0';
      else
        if fib_method = fib_method_S_0005 then
          binary_expr_00012 <= tmp_0013;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        unary_expr_00015 <= (others => '0');
      else
        if fib_method = fib_method_S_0008 then
          unary_expr_00015 <= tmp_0014;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fib_tmp_0016 <= (others => '0');
      else
        if fib_method = fib_method_S_0011 then
          fib_tmp_0016 <= fib_cur_0001;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00017 <= (others => '0');
      else
        if fib_method = fib_method_S_0012 then
          binary_expr_00017 <= tmp_0015;
        end if;
      end if;
    end if;
  end process;

  fib_req_flag <= tmp_0001;

  fib_req_flag_edge <= tmp_0003;



end RTL;
