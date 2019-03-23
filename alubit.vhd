-- ALU bit slice for non-MSB
entity alubit is
port (a,b,CarryIn,Less,Binvert : in bit;
      Operation : in bit_vector(1 downto 0);
      Result,CarryOut : out bit);
end alubit;

architecture behavioral of alubit is
    signal adderb : bit;  		-- b or not(b)
begin  -- behavioral
    adderb <= b xor Binvert after 1 ns;
    CarryOut <= (a and adderb) or
		(a and CarryIn) or
		(adderb and CarryIn) after 1 ns;
    with Operation select
	Result <= 
	a and adderb after 1 ns when "00",
	a or adderb after 1 ns when "01",
	a xor adderb xor CarryIn after 2 ns when "10",
	Less after 1 ns when "11";

end behavioral;
