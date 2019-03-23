
-- FU control
entity FU is
    port (EX_MEM,MEM_WB,ID_EX_rs,ID_EX_rt : in bit_vector(4 downto 0);--data inputs
    Regwrite_EX_MEM, Regwrite_MEM_WB : in bit; --data input
    ForwardA,ForwardB : out bit_vector(1 downto 0)); -- data outputs
end FU;

architecture dataflow of FU is
    
begin  -- dataflow 
  
  ForwardA <= "10" after 1 ns when 
   (Regwrite_EX_MEM = '1' and EX_MEM/="00000" and EX_MEM=ID_EX_rs)
   else
   "01" after 1 ns when
   (Regwrite_MEM_WB ='1' and MEM_WB /="00000" and MEM_WB=ID_EX_rs)
   else 
   "00" after 1 ns;

  ForwardB <= "10" after 1 ns when
   (Regwrite_EX_MEM='1' and EX_MEM /="00000" and EX_MEM=ID_EX_rt)
   else
   "01" after 1 ns when 
   (Regwrite_MEM_WB='1' and MEM_WB /="00000" and MEM_WB=ID_EX_rt)
   else
   "00" after 1 ns;
end dataflow;