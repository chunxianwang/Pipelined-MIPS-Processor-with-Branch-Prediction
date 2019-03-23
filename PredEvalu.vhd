
-- Pre-Registers element 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity PredEvalu is 
    port (clk : in bit; 
    Branch : in bit;
    IncrPC : in bit_vector(31 downto 0);  -- write into updating table
    PredInfo_IF : in bit_vector(60 downto 0); --data form IF phase about prediction
	  BranchInfo_virtual : in bit_vector(32 downto 0);
	  WriteData : out bit_vector(58 downto 0); --write data used to update predict table
	  WriteEnable : out bit;     --enable signal to update predict table
	  Reset : out bit;      -- to reset fetched instruction for faultly predicting
	  PredIndexWrite : out bit_vector(5 downto 0));  
end PredEvalu;

architecture behave of PredEvalu is
  signal PC_current : bit_vector(31 downto 0);
  signal Four : bit_vector(31 downto 0) := X"00000004";  -- constant
  signal Predirection : bit; -- predicted direction;
	signal ReadTableData : bit_vector(58 downto 0); -- data from prediction alement
	signal Miss : bit;
	signal Direction_virtual : bit;
	signal Target_virtual : bit_vector(31 downto 0);
	
begin  -- behave
    
    Miss <= PredInfo_IF(60);
    Predirection <= PredInfo_IF(59);
    ReadTableData <= PredInfo_IF(58 downto 0);
    WriteData(55 downto 24) <= Target_virtual after 41 ns;
    WriteData(23 downto 0) <= PC_current(31 downto 8) after 41 ns;
    PC_current <= to_bitvector(to_stdlogicvector(IncrPC) - to_stdlogicvector(Four)) after 41 ns;
    PredIndexWrite <= PC_current(7 downto 2) after 41 ns;
    Direction_virtual <= BranchInfo_virtual(32);
	  Target_virtual <= BranchInfo_virtual(31 downto 0);
    
    process (Predirection, PC_current)  
    begin  -- process 
      
      -- Hit
      if Branch = '1' and Miss = '0' then  --did predict --hit                 
        if Predirection /= Direction_virtual and Predirection = '0' then  -- faultly predict as not taken
           Reset <= '1' after 42 ns; 
           WriteEnable <= '1' after 42 ns;
           --WriteData(58) <= '1' after 42 ns;
           WriteData(57 downto 56) <= To_BitVector(std_logic_vector(to_unsigned(to_integer(unsigned( To_StdLogicVector(ReadTableData(57 downto 56)))) + 1, 2))) after 42 ns;
        elsif Predirection /= Direction_virtual and Predirection = '1' then -- faultly predict as taken
           Reset <= '1' after 42 ns; 
           WriteEnable <= '1' after 42 ns;
           --WriteData(58) <= '1' after 42 ns;
           WriteData(57 downto 56) <= To_BitVector(std_logic_vector(to_unsigned(to_integer(unsigned( To_StdLogicVector(ReadTableData(57 downto 56)))) - 1, 2))) after 42 ns;
        elsif Predirection = Direction_virtual and Predirection = '1' then -- correctly predict
           WriteEnable <= '1' after 42 ns;
           Reset <= '0' after 42 ns;
           WriteData(57 downto 56) <= "11" after 42 ns;
        elsif Predirection = Direction_virtual and Predirection = '0' then -- correctly predict
           Reset <= '0' after 42 ns;
           WriteEnable <= '1' after 42 ns;
           WriteData(57 downto 56) <= "00" after 42 ns;   
        end if;
      end if;

      --Miss
      if Branch = '1' and Miss = '1' then  -- not do predict  --miss
        if Predirection /= Direction_virtual and Direction_virtual = '1' then  -- faultly predict as notaken, in fact taken 
           Reset <= '1' after 42 ns; 
           WriteEnable <= '1' after 42 ns;
           WriteData(58) <= '1' after 42 ns;
           WriteData(57 downto 56) <= "10" after 42 ns;  -- initial as taken
         elsif Predirection /= Direction_virtual and Direction_virtual = '0' then    -- faultly predict as taken, in fact notaken
           Reset <= '1' after 42 ns; 
           WriteEnable <= '1' after 42 ns;
           WriteData(58) <= '1' after 42 ns;
           WriteData(57 downto 56) <= "01" after 2 ns;  -- initial as not taken
         elsif Predirection = Direction_virtual and Direction_virtual = '0' then --correctly predict as notaken
           Reset <= '0' after 42 ns; 
           WriteEnable <= '1' after 42 ns;
           WriteData(58) <= '1' after 42 ns;
           WriteData(57 downto 56) <= "01" after 2 ns;  -- initial as not taken
         elsif Predirection = Direction_virtual and Direction_virtual = '1' then --correctly predict as notaken
           Reset <= '0' after 42 ns; 
           WriteEnable <= '1' after 42 ns;
           WriteData(58) <= '1' after 42 ns;  -- initial as taken
           WriteData(57 downto 56) <= "10" after 2 ns;  
        end if;
      end if;
      
      if Branch = '0' then
        Reset <= '0' after 42 ns;
        WriteEnable <= '0' after 42 ns;
      end if;
    end process;
end behave;




