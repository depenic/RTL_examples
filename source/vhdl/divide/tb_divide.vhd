library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- entity declaration for your testbench.Dont declare any ports here
entity tb_divide is
end tb_divide;

architecture behavior of tb_divide is
  -- Component Declaration for the Unit Under Test (UUT)
  component divide_test  -- name of the module needed to be tested.
    --just copy and paste the input and output ports of your module as such.
  port (
    clk_in : in  std_logic;
    rst_n  : in  std_logic;
    inp_1  : in  std_logic_vector(15 downto 0);
    inp_2  : in  std_logic_vector(15 downto 0);
    kq_out : out std_logic_vector(15 downto 0)
    ) ;
  end component;

  --declare inputs and initialize them
  signal clk_in: std_logic                    := '0';
  signal rst_n : std_logic                    := '0';
  signal inp_2 : std_logic_vector(15 downto 0) := x"0000";
  signal inp_1 : std_logic_vector(15 downto 0) := x"0000";

  --declare outputs and initialize them
  signal kq_out : std_logic_vector(15 downto 0);

  -- Clock period definitions
  constant clk_period : time := 100 ns;

begin
  -- Instantiate the Unit Under Test (UUT)
  uut : divide_test port map (
    clk_in   => clk_in,
    rst_n => rst_n,
    inp_1 => inp_1,
    inp_2 => inp_2,
    kq_out => kq_out
    );      

  -- Clock process definitions (clock with 50% duty cycle is generated here).
  clk_process : process
  begin
    clk_in <= '0';
    wait for clk_period/2;              --for 0.5 ns signal is '0'.
    clk_in <= '1';
    wait for clk_period/2;              --for next 0.5 ns signal is '1'.
  end process;
  -- Stimulus process
  stim_proc : process
  variable i: integer;
  begin
    wait for 4 ns;
    rst_n <= '0';
    wait for 10 ns;
    rst_n <= '1';
    inp_2 <= x"5CA0";
    inp_1 <= x"0120";
    wait;
  end process;

end;
