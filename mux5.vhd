-- 5-bit 2-to-1 MUX 
entity mux5 is
    port (Sel : in bit; 			  -- select input
	  Din0,Din1 : in bit_vector(4 downto 0);  -- data inputs
	  Dout : out bit_vector(4 downto 0));	  -- data output
end mux5;

architecture dataflow of mux5 is
    
begin  -- dataflow

    with Sel select
	Dout <= 
	Din0 after 1 ns when '0',
	Din1 after 1 ns when '1';

end dataflow;
