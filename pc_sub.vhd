

-- 32-bit Adder
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc_sub is
    
    port (a,b : in bit_vector(31 downto 0);
	  result : out bit_vector(31 downto 0));

end pc_sub;

architecture behave of pc_sub is
begin  -- behave
    result <= to_bitvector(to_stdlogicvector(a) - to_stdlogicvector(b))
	   after 5 ns;  		
end behave;



