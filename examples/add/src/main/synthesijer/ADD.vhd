library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ADD is
  port (
    clk : in std_logic;
    reset : in std_logic;
    add_a : in signed(32-1 downto 0);
    add_b : in signed(32-1 downto 0);
    add_return : out signed(32-1 downto 0);
    add_busy : out std_logic;
    add_req : in std_logic
  );
end ADD;

architecture RTL of ADD is

  attribute mark_debug : string;
  attribute keep : string;


  signal clk_sig : std_logic;
  signal reset_sig : std_logic;
  signal add_a_sig : signed(32-1 downto 0);
  signal add_b_sig : signed(32-1 downto 0);
  signal add_return_sig : signed(32-1 downto 0) := (others => '0');
  signal add_busy_sig : std_logic := '1';
  signal add_req_sig : std_logic;

  signal add_a_0000 : signed(32-1 downto 0) := (others => '0');
  signal add_a_local : signed(32-1 downto 0) := (others => '0');
  signal add_b_0001 : signed(32-1 downto 0) := (others => '0');
  signal add_b_local : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00002 : signed(32-1 downto 0) := (others => '0');
  signal add_req_flag : std_logic;
  signal add_req_local : std_logic := '0';
  signal tmp_0001 : std_logic;
  type Type_add_method is (
    add_method_IDLE,
    add_method_S_0000,
    add_method_S_0001,
    add_method_S_0002,
    add_method_S_0003,
    add_method_S_0004  
  );
  signal add_method : Type_add_method := add_method_IDLE;
  signal add_method_delay : signed(32-1 downto 0) := (others => '0');
  signal add_req_flag_d : std_logic := '0';
  signal add_req_flag_edge : std_logic;
  signal tmp_0002 : std_logic;
  signal tmp_0003 : std_logic;
  signal tmp_0004 : std_logic;
  signal tmp_0005 : std_logic;
  signal tmp_0006 : std_logic;
  signal tmp_0007 : std_logic;
  signal tmp_0008 : std_logic;
  signal tmp_0009 : std_logic;
  signal tmp_0010 : signed(32-1 downto 0);
  signal tmp_0011 : signed(32-1 downto 0);
  signal tmp_0012 : signed(32-1 downto 0);

begin

  clk_sig <= clk;
  reset_sig <= reset;
  add_a_sig <= add_a;
  add_b_sig <= add_b;
  add_return <= add_return_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        add_return_sig <= (others => '0');
      else
        if add_method = add_method_S_0003 then
          add_return_sig <= binary_expr_00002;
        end if;
      end if;
    end if;
  end process;

  add_busy <= add_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        add_busy_sig <= '1';
      else
        if add_method = add_method_S_0000 then
          add_busy_sig <= '0';
        elsif add_method = add_method_S_0001 then
          add_busy_sig <= tmp_0005;
        end if;
      end if;
    end if;
  end process;

  add_req_sig <= add_req;

  -- expressions
  tmp_0001 <= add_req_local or add_req_sig;
  tmp_0002 <= not add_req_flag_d;
  tmp_0003 <= add_req_flag and tmp_0002;
  tmp_0004 <= add_req_flag or add_req_flag_d;
  tmp_0005 <= add_req_flag or add_req_flag_d;
  tmp_0006 <= '1' when add_method /= add_method_S_0000 else '0';
  tmp_0007 <= '1' when add_method /= add_method_S_0001 else '0';
  tmp_0008 <= tmp_0007 and add_req_flag_edge;
  tmp_0009 <= tmp_0006 and tmp_0008;
  tmp_0010 <= add_a_sig when add_req_sig = '1' else add_a_local;
  tmp_0011 <= add_b_sig when add_req_sig = '1' else add_b_local;
  tmp_0012 <= add_a_0000 + add_b_0001;

  -- sequencers
  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        add_method <= add_method_IDLE;
        add_method_delay <= (others => '0');
      else
        case (add_method) is
          when add_method_IDLE => 
            add_method <= add_method_S_0000;
          when add_method_S_0000 => 
            add_method <= add_method_S_0001;
          when add_method_S_0001 => 
            if tmp_0004 = '1' then
              add_method <= add_method_S_0002;
            end if;
          when add_method_S_0002 => 
            add_method <= add_method_S_0003;
          when add_method_S_0003 => 
            add_method <= add_method_S_0000;
          when add_method_S_0004 => 
            add_method <= add_method_S_0000;
          when others => null;
        end case;
        add_req_flag_d <= add_req_flag;
        if (tmp_0006 and tmp_0008) = '1' then
          add_method <= add_method_S_0001;
        end if;
      end if;
    end if;
  end process;


  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        add_a_0000 <= (others => '0');
      else
        if add_method = add_method_S_0001 then
          add_a_0000 <= tmp_0010;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        add_b_0001 <= (others => '0');
      else
        if add_method = add_method_S_0001 then
          add_b_0001 <= tmp_0011;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00002 <= (others => '0');
      else
        if add_method = add_method_S_0002 then
          binary_expr_00002 <= tmp_0012;
        end if;
      end if;
    end if;
  end process;

  add_req_flag <= tmp_0001;

  add_req_flag_edge <= tmp_0003;



end RTL;
