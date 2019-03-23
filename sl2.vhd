-- Shift left 2 bits 

entity sl2 is
    port (din : in bit_vector(31 downto 0);
	  dout : out bit_vector(31 downto 0));
end sl2;

architecture dataflow of sl2 is
    
begin  -- dataflow

    dout <= din(29 downto 0) & "00" after 1 ns;
    
end dataflow;
