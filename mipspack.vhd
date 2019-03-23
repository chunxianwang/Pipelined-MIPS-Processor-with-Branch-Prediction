package mipspack is
    -- 32-bit MIPS ALU
    component alu
	port (a,b : in bit_vector(31 downto 0);	   -- operands
	      ALUoperation : in bit_vector(2 downto 0);  -- operation code
	      Result : inout bit_vector(31 downto 0);  -- result
	      Zero : out bit);			   -- zero-result flag
    end component;

    -- 32-bit MIPS carry-lookahead ALU
    component alucl
	port (a,b : in bit_vector(31 downto 0);	   -- operands
	      ALUoperation : in bit_vector(2 downto 0);  -- operation code
	      Result : inout bit_vector(31 downto 0);  -- result
	      Zero : out bit);			   -- zero-result flag
    end component;

    -- Program counter (PC) element 
    component pc
	port (clk : in bit;                     -- clock
	      d : in bit_vector(31 downto 0);   -- data in
	      q : out bit_vector(31 downto 0)); -- data out
    end component;

    -- Add component 
    component add
	port (a,b : in bit_vector(31 downto 0);
	      sum : out bit_vector(31 downto 0));
    end component;
    
    -- Sub component 
    --component pc_sub
	--port (a,b : in bit_vector(31 downto 0);
	      --reult : out bit_vector(31 downto 0));
    --end component;    

    -- Instruction memory element 
    component imem
	port (ReadAddress : in bit_vector(31 downto 0);
	      Instruction : out bit_vector(31 downto 0));
    end component;

    -- Registers element 
    component registers
	port (clk,RegWrite : in bit;
	      ReadRegister1,ReadRegister2,WriteRegister : in bit_vector(4 downto 0);
	      WriteData : in bit_vector(31 downto 0);
	      ReadData1,ReadData2 : out bit_vector(31 downto 0));
    end component;
    
        --Prediction controller
    component PredC
  port (clk : in bit; 
	  ReadData : in bit_vector(58 downto 0); 
	  PC_current : in bit_vector(31 downto 0);
	  Index : out bit_vector(5 downto 0); 
	  PC_target : out bit_vector(31 downto 0);
	  predirection : out bit;
	  Miss : out bit);
	  end component;
	  
	      --Prediction controller
    component PredBTB
  port (clk,RegWrite : in bit;        
    IndexRead : in bit_vector(5 downto 0); 
    IndexWrite : in bit_vector(5 downto 0);
	  WriteData : in bit_vector(58 downto 0); 
	  ReadData : out bit_vector(58 downto 0));
	  end component;
	  
	  

    -- Data memory unit 
    component dmem
	port (clk,MemWrite,MemRead : in bit;
	      Address,WriteData : in bit_vector(31 downto 0);
	      ReadData : out bit_vector(31 downto 0));
    end component;

    -- Sign-extension unit 
    component signext
	port (din : in bit_vector(15 downto 0);
	      dout : out bit_vector(31 downto 0));
    end component;

    -- Control function for single-cycle MIPS implementation
    -- 
    component control
	port (Op : in bit_vector(5 downto 0);  -- instruction Op field
	      RegDst,ALUSrc,MemtoReg,RegWrite : out bit;
	      MemRead,MemWrite,Branch : out bit;
	      ALUOp : out bit_vector(1 downto 0));
    end component;

    -- ALU control unit
    component ALUcontrol
	port (funct : in bit_vector(5 downto 0);  -- funct field of instruction
	      ALUOp : in bit_vector(1 downto 0);  -- ALUOp from control logic
	      Operation : out bit_vector(2 downto 0));  -- ALU operation code
    end component;

    -- 32-bit 2-to-1 MUX 
    component mux32
	port (Sel : in bit; 			       -- select input
	      Din0,Din1 : in bit_vector(31 downto 0);  -- data inputs
	      Dout : out bit_vector(31 downto 0));     -- data output
    end component;
    -- 32-bit 3-to-1 MUX 
    component mux3
	port (Sel : in bit_vector(1 downto 0); 			     -- select input
	      Din0,Din1,Din2 : in bit_vector(31 downto 0);  -- data inputs
	      Dout : out bit_vector(31 downto 0));     -- data output
    end component;
    -- Forward unit
    component FU
	port (EX_MEM,MEM_WB,ID_EX_rs,ID_EX_rt : in bit_vector(4 downto 0);--data inputs
	      Regwrite_EX_MEM, Regwrite_MEM_WB : in bit; --data input
	      ForwardA,ForwardB : out bit_vector(1 downto 0)); -- data outputs
    end component;  
    -- 5-bit 2-to-1 MUX 
    component mux5
	port (Sel : in bit; 			      -- select input
	      Din0,Din1 : in bit_vector(4 downto 0);  -- data inputs
	      Dout : out bit_vector(4 downto 0));     -- data output
    end component;

    -- Shift left 2 block 
    component sl2
	port (din : in bit_vector(31 downto 0);
	      dout : out bit_vector(31 downto 0));
    end component;
    
    -- Jump address construction block 
    component jaddr
	port (pcMS4 : in bit_vector(3 downto 0);         -- most significant 4 bits
	                                                 -- of PC
	      jumpField : in bit_vector(25 downto 0);    -- 26-bit jump address
	                                                 -- field
	      jumpTarget : out bit_vector(31 downto 0)); -- full 32-bit jump
                                                         -- target address
    end component;

    -- 3-input AND gate
    component and3
	port (a,b,c : in bit;
	      d : out bit);
    end component;
    
    -- 32-bit 4-to-1 MUX 
    component mux4x32
	port (Sel : in bit_vector(1 downto 0);		        -- select input
	      Din0,Din1,Din2,Din3 : in bit_vector(31 downto 0); -- data inputs
	      Dout : out bit_vector(31 downto 0));		-- data output
    end component;
    
    -- 32-bit register element (no load control)
    component reg32
	port (clk : in bit;                     -- clock
	      d : in bit_vector(31 downto 0);   -- data in
	      q : out bit_vector(31 downto 0)); -- data out
    end component;

    -- 32-bit register element (with load control)
    component regld32
	port (clk,load : in bit;                -- clock, load control
	      d : in bit_vector(31 downto 0);   -- data in
	      q : out bit_vector(31 downto 0)); -- data out
    end component;

    -- 2-input OR gate
    component or2
	port (a,b : in bit;
	      c : out bit);
    end component;

    -- Microprogrammed MIPS control unit 
    component ucontrol
	port (clock : in bit;
	      Opcode : in bit_vector(5 downto 0);         -- instruction opcode
	      Controls : inout bit_vector(17 downto 0));  -- control signals
    end component;

    -- uprogram ROM for ucode sequencer 
    component rom16x18
	port (Address : in bit_vector(3 downto 0);
	      Data : out bit_vector(17 downto 0));
    end component;

    -- Dispatch table for ucode sequencer 
    component rom64x4
	port (Address : in bit_vector(5 downto 0);
	      Data : out bit_vector(3 downto 0));
    end component;

    -- 4-bit add element for ucode sequencer
    component add4
	port (a,b : in bit_vector(3 downto 0);
	      sum : out bit_vector(3 downto 0));
    end component;

    -- 4-bit register element for ucode sequencer PC 
    component reg4
	port (clk : in bit;           -- clock
	      d : in bit_vector(3 downto 0);  -- data in
	      q : out bit_vector(3 downto 0)); -- data out
    end component;

    -- 4-bit 4-to-1 MUX for ucode sequencer 
    component mux4x4
	port (Sel : in bit_vector(1 downto 0);		       -- select input
	      Din0,Din1,Din2,Din3 : in bit_vector(3 downto 0); -- data inputs
	      Dout : out bit_vector(3 downto 0));	       -- data output
    end component;

    -- ALU components follow
    --
    -- non-MSB bit of ALU 
    component alubit
	port (a,b,CarryIn,Less,Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result,CarryOut : out bit);
    end component;
    
    --Predicting validation
    component PredEvalu
  port(clk : in bit; 
    Branch : in bit;
    IncrPC : in bit_vector(31 downto 0);  
    PredInfo_IF : in bit_vector(60 downto 0); 
	  BranchInfo_virtual : in bit_vector(32 downto 0);
	  WriteData : out bit_vector(58 downto 0);
	  WriteEnable : out bit;    
	  Reset : out bit;      
	  PredIndexWrite : out bit_vector(5 downto 0));
    end component;
    
    -- MSB bit of ALU 
    component alumsb
	port (a,b,CarryIn,Less,Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result,Set,Overflow : out bit);
    end component;

    -- ALU bit slice for non-MSB with carry lookahead
    component alubitcl
	port (a,b,CarryIn,Less,Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result,G,P,CarryOut : out bit);
    end component;

    -- 4-bit ALU slice for non-MSB with carry lookahead
    component alu4bitcl
	port (a,b : in bit_vector(3 downto 0);
	      CarryIn : in bit;
	      Less : in bit_vector(3 downto 0);
	      Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result : out bit_vector(3 downto 0);
	      gg,gp,CarryOut : out bit);
    end component;

    -- 16-bit ALU slice for non-MSB with carry lookahead
    component alu16bitcl
	port (a,b : in bit_vector(15 downto 0);
	      CarryIn : in bit;
	      Less : in bit_vector(15 downto 0);
	      Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result : out bit_vector(15 downto 0);
	      gg,gp,CarryOut : out bit);
    end component;

    -- ALU bit slice for MSB with carry lookahead
    component alumsbcl
	port (a,b,CarryIn,Less,Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result,G,P,Set,Overflow : out bit);
    end component;

    -- 4-bit ALU slice for MSB with carry lookahead
    component alu4msbcl
	port (a,b : in bit_vector(3 downto 0);
	      CarryIn : in bit;
	      Less : in bit_vector(3 downto 0);
	      Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result : out bit_vector(3 downto 0);
	      gg,gp,Set,Overflow : out bit);
    end component;

    -- 16-bit ALU slice for MSB with carry lookahead
    component alu16msbcl
	port (a,b : in bit_vector(15 downto 0);
	      CarryIn : in bit;
	      Less : in bit_vector(15 downto 0);
	      Binvert : in bit;
	      Operation : in bit_vector(1 downto 0);
	      Result : out bit_vector(15 downto 0);
	      gg,gp,Set,Overflow : out bit);
    end component;

    -- Lookahead-carry generator
    component lcg
	port (c0 : in bit;  		        -- carry in
	      g,p : in bit_vector(3 downto 0);  -- generate and propagate inputs
	      c : out bit_vector(3 downto 1);   -- intermediate carry outputs
	      c4 : out bit;  		        -- overall carry out
	      gout,pout : out bit);  	        -- group generate and propagate
    end component;

end mipspack;
