-- 32-bit Adder
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity add is
    
    port (a,b : in bit_vector(31 downto 0);
	  sum : out bit_vector(31 downto 0));

end add;

architecture behave of add is
begin  -- behave
    sum <= to_bitvector(to_stdlogicvector(a) + to_stdlogicvector(b))
	   after 5 ns;  		
end behave;

