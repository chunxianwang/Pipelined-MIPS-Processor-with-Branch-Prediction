-- 32-bit 2-to-1 MUX 
entity mux32 is
    port (Sel : in bit; 			   -- select input
	  Din0,Din1 : in bit_vector(31 downto 0);  -- data inputs
	  Dout : out bit_vector(31 downto 0));	   -- data output
end mux32;

architecture dataflow of mux32 is
    
begin  -- dataflow

    with Sel select
	Dout <= 
	Din0 after 1 ns when '0',
	Din1 after 1 ns when '1';

end dataflow;
