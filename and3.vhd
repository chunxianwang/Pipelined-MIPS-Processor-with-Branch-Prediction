
-- 2-input AND gate
entity and3 is
    port (a,b,c : in bit;
	  d : out bit);
end and3;

architecture dataflow of and3 is
    
begin  -- dataflow

    d <= a and b and c after 1 ns;
    
end dataflow;