-- 5-bit 3-to-1 MUX 
entity mux3 is
    port (Sel : in bit_vector(1 downto 0); 			  -- select input
	  Din0,Din1,Din2 : in bit_vector(31 downto 0);  -- data inputs
	  Dout : out bit_vector(31 downto 0));	  -- data output
end mux3;

architecture dataflow of mux3 is
    
begin  -- dataflow
	Dout <= Din0 after 1 ns when Sel="00" else
	        Din1 after 1 ns when Sel="01" else
	        Din2 after 1 ns when Sel="10"; 
end dataflow;

