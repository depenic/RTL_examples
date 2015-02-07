-------------------------------------------------------------------------------
-- @File name    : sync_sp_ram.vhd
-- @Project      : TITAN
-- @Module       : sync_sp_ram
-- @Revision     : 1.0
-- @Author       : Khanh Dang <dnk0904[at]gmail[dot]com>
-- @Created Date : 11 Apr 2014
-- @Description  : Synchronous Single Port RAM (Inferred)
--
-- @Roadmap      :
-------------------------------------------------------------------------------
--  Modification History :
--  Date         Author         Revision    Comments
--  11 Apr 2014  Khanh Dang     Rev 1.0     Initial version
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-- ADD declaration for new mem libraries here;


entity sync_sp_ram is
  generic (
    memtech : memtech_type := inferred;
    abits   : integer := 6;
    dbits   : integer := 24 );
  port (
    clk   : in  std_logic;
    cen   : in  std_logic;
    wen   : in  std_logic;
    a     : in  std_logic_vector(abits-1 downto 0);
    d     : in  std_logic_vector(dbits-1 downto 0);
    q     : out std_logic_vector(dbits-1 downto 0)
  );
end;

architecture infer of sync_sp_ram is
begin
  INF_SPR: if memtech = inferred generate
    type spram_type is array (2**abits - 1 downto 0) of std_logic_vector(dbits-1 downto 0);
    signal spr_cell : spram_type;
  begin
    X1: process (clk)
    begin
      if rising_edge(clk) then
        if cen = '0' then
          if wen = '0' then -- Write enabled
            spr_cell( conv_integer(a) ) <= d;
          else        -- Read enabled
            q <= spr_cell( conv_integer(a) );
          end if;
        end if;
      end if;
    end process;
  end generate;

end;
