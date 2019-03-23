-- ALU control unit
entity ALUcontrol is
    port (funct : in bit_vector(5 downto 0);  -- funct field of instruction (6 LSbs)
	  ALUOp : in bit_vector(1 downto 0);  -- ALUOp from control logic
	  Operation : out bit_vector(2 downto 0));  -- ALU operation code (driven by ALUfunc)
end ALUcontrol;

architecture dataflow of ALUcontrol is
    
begin  -- dataflow

    -- ALUOp ="11" isn't used, so not specified
    Operation <= "010" after 1 ns when
		 ALUOp = "00" or
		 (ALUOp = "10" and funct(3 downto 0) = "0000")
		 else
		 "110" after 1 ns when
		 ALUOp = "01" or
		 (ALUOp = "10" and funct(3 downto 0) = "0010")
		 else
		 "000" after 1 ns when
		 ALUOp = "10" and funct(3 downto 0) = "0100"
		 else
		 "001" after 1 ns when
		 ALUOp = "10" and funct(3 downto 0) = "0101"
		 else
		 "111" after 1 ns when
		 ALUOp = "10" and funct(3 downto 0) = "1010"
		 else
		 "000" after 1 ns;
    
end dataflow;
