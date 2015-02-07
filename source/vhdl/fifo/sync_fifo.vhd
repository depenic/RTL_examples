-------------------------------------------------------------------------------
-- @File name    : sync_fifo.vhd
-- @Project      : TITAN
-- @Module       : sync_fifo
-- @Revision     : 1.0
-- @Author       : Khanh Dang <dnk0904[at]gmail[dot]com>
-- @Created Date : 11 Apr 2014
-- @Description  : Synchronous FIFO
--
-- @Roadmap      :
-------------------------------------------------------------------------------
--  Modification History :
--  Date         Author         Revision    Comments
--  27 Apr 2014  Khanh Dang     Rev 1.0     Initial version
-------------------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.std_logic_unsigned.all;

entity sync_fifo is
  generic (
    REG_INFER  : boolean := true;                           -- Optional register/RAM infer
    OUTPUT_REG : boolean := false;                          -- Optional output register
    DATA_WIDTH : integer := 8;                              -- Data's width
    FIFO_DEPTH : integer := 8                               -- Depth of FIFO
   );
  port (
    clk      : in  std_logic;                                -- Clock input
    rst_n    : in  std_logic;                                -- Active low reset
    clear    : in  std_logic;                                -- Clear
    push     : in  std_logic;                                -- Write
    pop      : in  std_logic;                                -- Read
    data_in  : in  std_logic_vector (DATA_WIDTH-1 downto 0); -- Data input
    data_out : out std_logic_vector (DATA_WIDTH-1 downto 0); -- Data Output
    empty    : out std_logic;                                -- FIFO empty
    full     : out std_logic                                 -- FIFO full
  );
end entity;
architecture rtl of sync_fifo is
  -------------Internal variables-------------------
  constant ADDR_WIDTH : natural := clog2(FIFO_DEPTH);

  signal wr_pointer   :std_logic_vector (ADDR_WIDTH-1 downto 0);
  signal rd_pointer   :std_logic_vector (ADDR_WIDTH-1 downto 0);
  signal status_cnt   :std_logic_vector (ADDR_WIDTH   downto 0);
  signal data_push_in :std_logic_vector (DATA_WIDTH-1 downto 0);
  signal data_pop_out :std_logic_vector (DATA_WIDTH-1 downto 0);

begin
  -------------Code Start---------------------------
  full  <= '1' when (status_cnt = (FIFO_DEPTH-1)) else '0';
  empty <= '1' when (status_cnt = 0) else '0';

  WRITE_POINTER : process (clk, rst_n) begin
    if (rst_n = '0') then
      wr_pointer <= (others => '0');
    elsif (rising_edge(clk)) then
      if clear = '1' then
        wr_pointer <= (others => '0');
      elsif push = '1' then
        wr_pointer <= wr_pointer + 1;
      end if;
    end if;
  end process;


  READ_POINTER : process (clk, rst_n) begin
    if (rst_n  = '0') then
      rd_pointer <= (others=>'0');
    elsif (rising_edge(clk)) then
      if clear = '1' then
        rd_pointer <= (others => '0');
      elsif pop = '1' then
        rd_pointer <= rd_pointer + 1;
      end if;
    end if;
  end process;

  GEN_OUTPUT_REG: if OUTPUT_REG generate
    READ_DATA : process (clk, rst_n) begin
      if (rst_n = '0') then
        data_out <= (others=>'0');
      elsif (rising_edge(clk)) then
        if clear = '1' then
          data_out <= (others=>'0');
        elsif pop = '1' then
          data_out <= data_pop_out;
        end if;
      end if;
    end process;
  end generate GEN_OUTPUT_REG;

  NOT_GEN_OUTPUT_REG: if NOT OUTPUT_REG generate
    data_out <= data_pop_out when pop = '1' else (others => '0');
  end generate NOT_GEN_OUTPUT_REG;

  STATUS_COUNTER : process (clk, rst_n) begin
    if (rst_n = '0') then
      status_cnt <= (others=>'0');
    elsif (rising_edge(clk)) then
      if clear = '1' then
        status_cnt <= (others=>'0');
      elsif ((push = '0') and (pop = '1') and (status_cnt /= 0)) then -- Pop out not push
        status_cnt <= status_cnt - 1;
      elsif ((push = '1') and (pop = '0') and (status_cnt /= FIFO_DEPTH)) then -- Push in not pop
        status_cnt <= status_cnt + 1;
      end if;
    end if;
  end process;

  data_push_in <= data_in;

  GEN_REG_INFER: if REG_INFER generate
    type type_fifo is array(natural range <>) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal fifo_reg : type_fifo(FIFO_DEPTH-1 downto 0);
  begin

    PROC_FIFO: process(clk, rst_n)
    begin
      if rst_n = '0' then
        fifo_reg <= (others => (others => '0'));
      elsif rising_edge(clk) then
        if clear = '1' then
          fifo_reg <= (others => (others => '0'));
        elsif push = '1' and (status_cnt /= FIFO_DEPTH) then
          fifo_reg(to_integer(unsigned(wr_pointer))) <= data_push_in;
        end if;
      end if;
    end process;
    data_pop_out <= fifo_reg(to_integer(unsigned(rd_pointer)));
  end generate GEN_REG_INFER;

-- pragma synthesis_off
  GEN_RAM_INFER: if NOT REG_INFER generate
    X: process begin
      report "This architecture didn't support infer to RAM"
      severity failure;
      wait;
    end process;
    --DP_RAM : ram_dp_ar_aw
    --generic map (
        --DATA_WIDTH => DATA_WIDTH,
        --ADDR_WIDTH => ADDR_WIDTH
    --)
    --port map (
        --address_0 => wr_pointer,    -- address_0 input
        --data_0    => data_push_in,   -- data_0 bi-directional
        --cs_0      => wr_cs,         -- chip select
        --we_0      => wr_en,         -- write enable
        --oe_0      => '0',           -- output enable
        --address_1 => rd_pointer,    -- address_q input
        --data_1    => data_pop_out,  -- data_1 bi-directional
        --cs_1      => rd_cs,         -- chip select
        --we_1      => '0',           -- Read enable
        --oe_1      => rd_en          -- output enable
    --);
  end generate GEN_RAM_INFER;

-- pragma synthesis_on

end architecture;
