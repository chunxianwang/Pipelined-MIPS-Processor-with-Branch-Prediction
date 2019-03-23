-- PC, Program counter (a basic register) 
library ieee;
use ieee.std_logic_1164.all;

entity pc is
    port (clk : in bit;           -- clock
          d : in bit_vector(31 downto 0);  -- data in
          q : out bit_vector(31 downto 0)); -- data out

end pc;

architecture proc of pc is
begin  -- proc
    process (clk)  
    begin  -- process
        if clk='1' then q <= d after 1 ns;
	      end if;
    end process;
end proc;
