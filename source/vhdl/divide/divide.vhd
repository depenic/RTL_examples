library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity divide_test is
  port (
    clk_in : in  std_logic;
    rst_n  : in  std_logic;
    inp_1  : in  std_logic_vector(15 downto 0);
    inp_2  : in  std_logic_vector(15 downto 0);
    kq_out : out std_logic_vector(15 downto 0)
    ) ;
end entity;  -- divide

architecture arch_behav of divide_test is

  function divide (a : unsigned; b : unsigned) return unsigned is
    variable a1 : unsigned(a'length-1 downto 0) := a;
    variable b1 : unsigned(b'length-1 downto 0) := b;
    variable p1 : unsigned(b'length downto 0)   := (others => '0');
    variable i  : integer                       := 0;

  begin
    for i in 0 to b'length-1 loop
      p1(b'length-1 downto 1) := p1(b'length-2 downto 0);
      p1(0)                   := a1(a'length-1);
      a1(a'length-1 downto 1) := a1(a'length-2 downto 0);
      p1                      := p1-b1;
      if(p1(b'length-1) = '1') then
        a1(0) := '0';
        p1    := p1+b1;
      else
        a1(0) := '1';
      end if;
    end loop;
    return a1;

  end divide;
begin

  divice_prc : process(clk_in, rst_n)
    variable a, b : unsigned(15 downto 0);
  begin
    if rst_n = '0' then
      kq_out <= x"0000";
    elsif clk_in'event and clk_in = '1' then
      a      := unsigned(inp_1);
      b      := unsigned(inp_2);
      kq_out <= std_logic_vector(divide(b, a));
    end if;
  end process;  -- divice_prc
end architecture;  -- arch_behav
