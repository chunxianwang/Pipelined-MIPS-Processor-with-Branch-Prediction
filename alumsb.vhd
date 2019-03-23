-- ALU bit slice for MSB 
entity alumsb is
port (a,b,CarryIn,Less,Binvert : in bit;
      Operation : in bit_vector(1 downto 0);
      Result,Set,Overflow : out bit);
end alumsb;

architecture behavioral of alumsb is
    signal adderb : bit;  		-- b or not(b)
    signal V : bit;  			-- internal Overflow
    signal sum : bit;  			-- sum bit of adder
begin  -- behavioral
    adderb <= b xor Binvert after 1 ns;
    sum <= a xor adderb xor CarryIn after 1 ns;
    -- V = carryin xor carryout
    V <= CarryIn xor
		((a and adderb) or
		(a and CarryIn) or
		(adderb and CarryIn)) after 2 ns;
    -- Copy V to Overflow output
    Overflow <= V;
    -- Set is Sum xor V
    Set <= Sum xor V after 1 ns;
    with Operation select
	Result <= 
	a and adderb after 1 ns when "00",
	a or adderb after 1 ns when "01",
	Sum after 1 ns when "10",
	Less after 1 ns when "11";

end behavioral;
