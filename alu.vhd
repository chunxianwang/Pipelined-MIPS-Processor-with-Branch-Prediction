-- 32-bit MIPS ALU

entity alu is
    port (a,b : in bit_vector(31 downto 0);	   -- operands
	  ALUoperation : in bit_vector(2 downto 0);  -- operation code
	  Result : inout bit_vector(31 downto 0);  -- result
	  Zero : out bit);			   -- zero-result flag
end alu;

-- purpose: Structural model of 32-bit ALU
architecture struct of alu is
    
    signal c : bit_vector(31 downto 1);	-- internal carries
    signal Set : bit;			-- for slt
    signal Overflow : bit;		-- to catch Overflow from MSB
    signal Less : bit := '0';  		-- constant 0
    
    -- non-MSB bit of ALU
    component alubit
	port (a,b,CarryIn,Less,Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result,CarryOut : out bit);
    end component;
    
    -- MSB bit of ALU
    component alumsb
	port (a,b,CarryIn,Less,Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result,Set,Overflow : out bit);
    end component;

begin  -- struct
    
    bit0 : alubit
	port map (a(0),b(0),ALUoperation(2),
		  Set,ALUoperation(2),ALUoperation(1 downto 0),
		  Result(0),c(1));
    
    bits : for i in 1 to 30 generate
	biti : alubit
	    port map (a(i),b(i),c(i),
		      Less,ALUoperation(2),ALUoperation(1 downto 0),
		      Result(i),c(i+1));
    end generate bits;
    
    bit31 : alumsb
	port map (a(31),b(31),c(31),
		  Less,ALUoperation(2),ALUoperation(1 downto 0),
		  Result(31),Set,Overflow);
    
    with Result select
	Zero <= 
	'1' after 1 ns when X"00000000",
	'0' after 1 ns when others;
end struct;
