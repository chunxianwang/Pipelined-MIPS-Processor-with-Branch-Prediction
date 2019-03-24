# Pipelined-MIPS-Processor-with-Branch-Prediction
dynamic branch prediction -- 2-bit predictor

Pipelined MIPS Processor with Branch Prediction (2-bit branch predictor)
Introduction: To break the processing limitation from pipelined processor’s control hazard, carry out the dynamic predicting strategy, 2-bit branch prediction, to realize the branch predicting function. At last, verify the predictor with a parallel two-loop program.
Pre Read: 
1.	Based on the Pipelined MIPS Processor Version with forwarding bypass (FU.vhd) and  branch execution taking place in EX cycle, not the optimized version which put branch execution in ID cycle.
2.	Only work effectively with the parallel branch, such as branches in one loop followed by another loop, not work for nested loops.
3.	Maximum support branch number 64, limited by row number of branch target buffer.
4.	Modifiy the basic pipelined MIPS processor version 

Key files:
PredBTB.vhd – Predictors’ branch target buffer
PredC.vhd – Predictors’ controller
PredEvalu.vhd – Predictors’ evaluation
pipelined_prediction.do – the verifying program

How to use:
Create a new working project integrated with all .vhd files.
Compile the project.
Test the project with the pipelined_prediction.do file.

# More detailed branch prediction background knowledge and test analyzing can be found in the "Project Report for Computer Arithmetic Course CE622.pdf"
