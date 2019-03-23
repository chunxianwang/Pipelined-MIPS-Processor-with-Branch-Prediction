## Re-initialize simulation   
restart -nowave

## Set up wave window
add wave clock

## IF Stage
add wave -hex Instruction_IM
add wave -hex CurrentPC IncrPC BranchPC NextPC
add wave -hex  instruction_memory/memory

## ID Stage
add wave -hex Instruction
add wave -hex ReadAdrs1 ReadData1  ReadAdrs2 ReadData2
add wave -hex ExtOffset


## EX Stage
add wave ALUOp_ID_EX ALUSrc_ID_EX RegDst_ID_EX
add wave ALUfunc
add wave -hex ALUa ALUb ALUresult WriteRegister 


## MEM Stage
add wave MemWrite_EX_MEM MemRead_EX_MEM  Branch_EX_MEM 
add wave -hex  ALUResult_EX_MEM WriteRegister_EX_MEM data_to_mem
add wave -hex  data_memory/memory
    

## WB Stage
add wave MemtoReg_MEM_WB RegWrite_MEM_WB
add wave -hex ALUResult_MEM_WB WriteRegister_MEM_WB RegWriteData
add wave -hex the_registers/registers


## Forward Unit
add wave MemtoReg_MEM_WB RegWrite_MEM_WB
add wave -hex ForwardA ForwardB

## Branch Prediction 
add wave PredDirection Reset Branch_EX Zero Miss WriteBTBEnable
add wave -hex PC_target PredReadData WriteBTBData IncrPC_EX 
add wave -hex IF_ID ID_EX EX_MEM MEM_WB PredIndexWrite PredIndexRead


# 300-ns, 50% duty cycle clock
force clock 1 0, 0 150 ns -repeat 300 ns
##########
# Put constants needed by program into RF
# "deposit" option lets you overwrite register contents

force -deposit the_registers/registers(1) 16#00000000
force -deposit the_registers/registers(2) 16#00000000
force -deposit the_registers/registers(3) 16#00000000
force -deposit the_registers/registers(4) 16#00000000
force -deposit the_registers/registers(5) 16#00000000

force -deposit the_registers/registers(6) 16#00000000
force -deposit the_registers/registers(8) 16#00000000
force -deposit the_registers/registers(9) 16#00000000

force -deposit the_registers/registers(11) 16#00000000
force -deposit the_registers/registers(12) 16#00000000
force -deposit the_registers/registers(14) 16#00000000

force -deposit the_registers/registers(15) 16#00000000
force -deposit the_registers/registers(17) 16#00000000
force -deposit the_registers/registers(18) 16#00000000

force -deposit the_registers/registers(20) 16#00000000
force -deposit the_registers/registers(21) 16#00000000
force -deposit the_registers/registers(23) 16#00000000

####################################

#force -deposit predictor_register/registers(0) 16#0000001C
#force -deposit predictor_register/registers(2) 16#00000000
#force -deposit predictor_register/registers(3) 16#00000000
#force -deposit predictor_register/registers(4) 16#00000000
#force -deposit predictor_register/registers(5) 16#00000000

####################################
# Put constant needed by program into data memory
# put 0xe000a003 at address 0x00000008:
#
force data_memory/memory(0) 16#00
force data_memory/memory(7) 16#01
force data_memory/memory(11) 16#02
force data_memory/memory(15) 16#40
#force data_memory/memory(16) 16#00
#force data_memory/memory(20) 16#00

# ********** Put program-1 into instruction memory ***********
#
# start: lw $a0,12($zero)   --get accumulate number 10 
#                 
force instruction_memory/memory(0) 16#8C
force instruction_memory/memory(1) 16#04
force instruction_memory/memory(2) 16#00
force instruction_memory/memory(3) 16#0C
#
# lw $t0,00($zero)   --initiallize SUM 
#               
force instruction_memory/memory(4) 16#8C
force instruction_memory/memory(5) 16#08
force instruction_memory/memory(6) 16#00
force instruction_memory/memory(7) 16#00

#
# lw $t1,04($zero)   --get first odd number 1  
#                  
force instruction_memory/memory(8) 16#8C
force instruction_memory/memory(9) 16#09
force instruction_memory/memory(10) 16#00
force instruction_memory/memory(11) 16#04

#
# lw $t2,08($zero)   --
#                 
force instruction_memory/memory(12) 16#8C
force instruction_memory/memory(13) 16#0A
force instruction_memory/memory(14) 16#00
force instruction_memory/memory(15) 16#08

#
# loop: slt $t3,$t1,$a0 
#                  
force instruction_memory/memory(16) 16#01
force instruction_memory/memory(17) 16#24
force instruction_memory/memory(18) 16#58
force instruction_memory/memory(19) 16#2A
#
# beq $t3,$zero,finish 
#                  
force instruction_memory/memory(20) 16#11
force instruction_memory/memory(21) 16#60
force instruction_memory/memory(22) 16#00
force instruction_memory/memory(23) 16#03
#
# add $t0,$t0,$t1 
#                 
force instruction_memory/memory(24) 16#01
force instruction_memory/memory(25) 16#09
force instruction_memory/memory(26) 16#40
force instruction_memory/memory(27) 16#20
#
# add $t1,$t1,$t2   
#                      
force instruction_memory/memory(28) 16#01
force instruction_memory/memory(29) 16#2A
force instruction_memory/memory(30) 16#48
force instruction_memory/memory(31) 16#20
#
# beq $zero $zero loop
#                      
force instruction_memory/memory(32) 16#10
force instruction_memory/memory(33) 16#00
force instruction_memory/memory(34) 16#FF
force instruction_memory/memory(35) 16#FB
#
# sw $t0,16($zero)
#                      
force instruction_memory/memory(36) 16#AC
force instruction_memory/memory(37) 16#08
force instruction_memory/memory(38) 16#00
force instruction_memory/memory(39) 16#10



# ********** Put program into instruction memory ***********
#
# start: lw $a0,12($zero)   --get accumulate number 10 
#                 
force instruction_memory/memory(40) 16#8C
force instruction_memory/memory(41) 16#04
force instruction_memory/memory(42) 16#00
force instruction_memory/memory(43) 16#0C
#
# lw $t4,00($zero)   --initiallize SUM 
#               
force instruction_memory/memory(44) 16#8C
force instruction_memory/memory(45) 16#0C
force instruction_memory/memory(46) 16#00
force instruction_memory/memory(47) 16#00

#
# lw $t5,04($zero)   --get first odd number 1  
#                  
force instruction_memory/memory(48) 16#8C
force instruction_memory/memory(49) 16#0D
force instruction_memory/memory(50) 16#00
force instruction_memory/memory(51) 16#04

#
# lw $t6,08($zero)   --
#                 
force instruction_memory/memory(52) 16#8C
force instruction_memory/memory(53) 16#0E
force instruction_memory/memory(54) 16#00
force instruction_memory/memory(55) 16#08

#
# loop: slt $t7,$t5,$a0 
#                  
force instruction_memory/memory(56) 16#01
force instruction_memory/memory(57) 16#A4
force instruction_memory/memory(58) 16#78
force instruction_memory/memory(59) 16#2A
#
# beq $t7,$zero,finish 
#                  
force instruction_memory/memory(60) 16#11
force instruction_memory/memory(61) 16#E0
force instruction_memory/memory(62) 16#00
force instruction_memory/memory(63) 16#03
#
# add $t4,$t4,$t5 
#                 
force instruction_memory/memory(64) 16#01
force instruction_memory/memory(65) 16#8D
force instruction_memory/memory(66) 16#60
force instruction_memory/memory(67) 16#20
#
# add $t5,$t5,$t6   
#                      
force instruction_memory/memory(68) 16#01
force instruction_memory/memory(69) 16#AE
force instruction_memory/memory(70) 16#68
force instruction_memory/memory(71) 16#20
#
# beq $zero $zero loop
#                      
force instruction_memory/memory(72) 16#10
force instruction_memory/memory(73) 16#00
force instruction_memory/memory(74) 16#FF
force instruction_memory/memory(75) 16#FB
#
# sw $t4,20($zero)
#                      
force instruction_memory/memory(76) 16#AC
force instruction_memory/memory(77) 16#0C
force instruction_memory/memory(78) 16#00
force instruction_memory/memory(79) 16#14

##########
# ********** Put constants needed by program into memory
##########
# constant 0
force instruction_memory/memory(80) 16#00
force instruction_memory/memory(81) 16#00
force instruction_memory/memory(82) 16#00
force instruction_memory/memory(83) 16#00

