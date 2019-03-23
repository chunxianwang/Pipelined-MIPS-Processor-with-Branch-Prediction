-- Instruction memory
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity imem is
    
    port (ReadAddress : in bit_vector(31 downto 0);
          Instruction : out bit_vector(31 downto 0));

end imem;

architecture behave of imem is

    signal intAddress : natural;  -- unsigned integer address
    -- Type for memory (only 256+3 bytes implemented)
    --  (extra bytes needed in case of word accesses to last 3 bytes)
    type memoryType is array (0 to 258) of bit_vector(7 downto 0);
    -- Memory itself
    signal memory : memoryType;

begin  -- array
    intAddress <= conv_integer(to_stdlogicvector(ReadAddress(7 downto 0)));
    Instruction <=
	memory(intAddress) &
	memory(intAddress+1) &
	memory(intAddress+2) &
	memory(intAddress+3)
	after 5 ns;
end behave;
