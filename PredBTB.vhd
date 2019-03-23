-- Pre-Registers element 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PredBTB is 
    port (clk,RegWrite : in bit;        --regrite, the port used to triger to update predictor
    IndexRead : in bit_vector(5 downto 0);  --support 64 branch in table
    IndexWrite : in bit_vector(5 downto 0); 
	  WriteData : in bit_vector(58 downto 0); --to update table
	  ReadData : out bit_vector(58 downto 0)); --to predict controller);
end PredBTB;

architecture behave of PredBTB is
    
    signal intRR,intWR : natural;            -- unsigned integer reg addresses
    --signal Index1 : bit_vector(5 downto 0);  --support 16 branch in table
    -- Type for registers
    type registersType is array (0 to 63) of bit_vector(58 downto 0);
    -- Instance Registers object
    signal preregister : registersType;
    
begin  -- behave
    -- convert all addresses to integers
    intRR <= conv_integer(to_stdlogicvector(IndexRead));   
    intWR <= conv_integer(to_stdlogicvector(IndexWrite));
    
    -- read registers
    ReadData <= preregister(intRR) after 2 ns;   -- the real code --

    -- write registers 
    process (clk)
    begin
	-- if rising edge of clock and RegWrite, then write register
	-- (unless trying to write $zero)
	if clk = '0' and RegWrite = '1' then
	    preregister(intWR) <= WriteData;
	end if;
    end process;
end behave;


