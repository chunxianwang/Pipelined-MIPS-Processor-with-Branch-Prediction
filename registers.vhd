-- Registers element 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity registers is
    
    port (clk,RegWrite : in bit;
	  ReadRegister1,ReadRegister2,WriteRegister : in bit_vector(4 downto 0);
	  WriteData : in bit_vector(31 downto 0);
	  ReadData1,ReadData2 : out bit_vector(31 downto 0));

end registers;

architecture behave of registers is
    
    signal intRR1,intRR2,intWR : natural;  -- unsigned integer reg addresses
    -- Type for registers
    type registersType is array (0 to 31) of bit_vector(31 downto 0);
    -- Registers themselves
    signal registers : registersType;
    
begin  -- behave
    
    -- convert all addresses to integers
    intRR1 <= conv_integer(to_stdlogicvector(ReadRegister1));
    intRR2 <= conv_integer(to_stdlogicvector(ReadRegister2));
    intWR  <= conv_integer(to_stdlogicvector(WriteRegister));

    -- read registers
    ReadData1 <= registers(intRR1) after 3 ns;
    ReadData2 <= registers(intRR2) after 3 ns;

    process (clk)
    begin
	-- if rising edge of clock and RegWrite, then write register
	-- (unless trying to write $zero)
	if clk = '0' and RegWrite = '1' and intWR /= 0 then
	    registers(intWR) <= WriteData;
	end if;
    end process;
end behave;
