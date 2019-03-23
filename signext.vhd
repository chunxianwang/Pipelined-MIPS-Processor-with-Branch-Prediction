-- Sign-extension unit 

entity signext is
    port (din : in bit_vector(15 downto 0);
	  dout : out bit_vector(31 downto 0));
end signext;

architecture dataflow of signext is
    
begin  -- dataflow
    
    dout <= (din(15),din(15),din(15),din(15),
	     din(15),din(15),din(15),din(15),
	     din(15),din(15),din(15),din(15),
	     din(15),din(15),din(15),din(15)) & din
	    after 1 ns;
    
end dataflow;
