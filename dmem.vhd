-- Data Memory
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity dmem is
    port (clk,MemWrite,MemRead : in bit;
	  Address,WriteData : in bit_vector(31 downto 0);
	  ReadData : out bit_vector(31 downto 0));
end dmem;

architecture behave of dmem is
    
    signal intAddress : natural;  -- unsigned integer address
    -- Type for memory (only 256+3 bytes implemented)
    --  (extra bytes needed in case of word accesses to last 3 bytes)
    type memoryType is array (0 to 258) of bit_vector(7 downto 0);
    -- Memory itself
    signal memory : memoryType;

begin  -- behave

     -- convert address to integer
    intAddress <= conv_integer(to_stdlogicvector(Address(7 downto 0)));

    -- Read out data regardless of MemRead
    -- (not well thought out in COD2e?)
    ReadData <= memory(intAddress) &
		memory(intAddress+1) &
		memory(intAddress+2) &
		memory(intAddress+3)
		after 10 ns;

    process (clk)
    begin
        -- if rising edge of clock and MemWrite, then write locations
        if clk = '1' and MemWrite = '1' then
            memory(intAddress)   <= WriteData(31 downto 24);
            memory(intAddress+1) <= WriteData(23 downto 16);
            memory(intAddress+2) <= WriteData(15 downto  8);
            memory(intAddress+3) <= WriteData( 7 downto  0);	    
        end if;
    end process;
		
end behave;
