-- Control unit for pipelined MIPS 
-- 
entity control is
    port (Op : in bit_vector(5 downto 0);  -- instruction Op field
	  RegDst,ALUSrc,MemtoReg,RegWrite : out bit;
	  MemRead,MemWrite,Branch : out bit;
	  ALUOp : out bit_vector(1 downto 0));
end control;

architecture behave of control is
    
begin  -- behave

    with Op select
	RegDst <= 
	'1' after 1 ns when "000000",
	'0' after 1 ns when others;

    with Op select
	ALUSrc <= 
	'1' after 1 ns when "100011" | "101011",
	'0' after 1 ns when others;

    with Op select
	MemtoReg <= 
	'1' after 1 ns when "100011",
	'0' after 1 ns when others;

    with Op select
	RegWrite <= 
	'1' after 1 ns when "000000" | "100011",
	'0' after 1 ns when others;

    with Op select
	MemRead <= 
	'1' after 1 ns when "100011",
	'0' after 1 ns when others;

    with Op select
	MemWrite <= 
	'1' after 1 ns when "101011",
	'0' after 1 ns when others;

    with Op select
	Branch <= 
	'1' after 1 ns when "000100",
	'0' after 1 ns when others;

    with Op select
	ALUOp <= 
	"10" after 1 ns when "000000",
	"01" after 1 ns when "000100",	
	"00" after 1 ns when others;

end behave;
