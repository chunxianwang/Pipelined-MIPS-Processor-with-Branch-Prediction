-- Pre-Registers element 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PredC is 
    port (clk : in bit; --regrite, the port used to triger to update predictor
	  ReadData : in bit_vector(58 downto 0); --From BTB
	  PC_current : in bit_vector(31 downto 0);
	  Index : out bit_vector(5 downto 0);  -- index to look up BTB
	  PC_target : out bit_vector(31 downto 0); --Target address
	  predirection : out bit;  --predicted direction: taken(1) or not taken(0)
	  Miss : out bit);  
end PredC;

architecture behave of PredC is

begin  -- behave
    Index <= PC_current(7 downto 2) after 1 ns;  --set as the first table element for debugging
    process (ReadData(31 downto 0), PC_current)  
    begin  -- process                  
        if ReadData(23 downto 0) = PC_current(31 downto 8) and ReadData(58) >= '1'  then  --hit
           miss <= '0' after 5 ns;
           if ReadData(57 downto 56) >= "10" then
             predirection <= '1' after 5 ns;  --taken
             PC_target <= ReadData(55 downto 24) after 5 ns;
           else
             predirection <= '0' after 5 ns;  --not taken
           end if;
        else  --miss
          miss <= '1' after 5 ns;  
          predirection <= '0' after 5 ns; --set default predict direction as not taken
        end if;
    end process;  
end behave;



