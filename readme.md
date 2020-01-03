# High-speed Hardware Integer Multiplier Implementations

### Goal
The purpose of this project is to design high speed hardware integer multipliers and implement them in Verilog. 

### Background
During 2nd half of 2017-18, a 16-bit fully pipelined processor based on MIPS-I ISA was designed and 
implemented by a team of four students. However, the multiplication operation in their implementation was done via 
the ‘*’ operator. This is not an efficient implementation. Therefore, the goal of my project was to understand different 
existing methodologies for implementing the integer multipliers from existing literature and subsequently implement them. 



### Implementation
For the purpose of this project, I have implemented 6 different multipliers as follows:

1. 8-bit signed (2’s complement) multiplier using radix-4 modified booth algorithm and two 4-bit Carry-Lookahead-Adders.
2. 8-bit unsigned multiplier using radix-4 modified booth algorithm and three 4-bit Carry-Lookahead-Adders.
3. 8-bit unsigned multiplier using four 8-bit unsigned multiplier modules and a 1 level CSA-based Wallace tree and a 
16-bit 2-level CLA. 
4. 16-bit (2’s complement) multiplier using four 8-bit multiplier modules and a 1 level CSA-based Wallace tree and a 
16-bit 2-level CLA. The 8-bit multiplier modules used are unsigned, signed, signed-unsigned multipliers.
5. 16-bit booth algorithm array multiplier for 2’s complement numbers
6. 16-bit array multiplier for unsigned numbers.

### Code
Each multiplier has a single folder devoted for it and all the required Verilog files are self-contained within the 
respective multiplier folders. Every Verilog file begins with a few lines of comments describing the purpose of that 
particular module. In addition to the design implementation, I have also tested the working of all multipliers 
successfully and extensively using testbenches. All the Verilog modules themselves also contain their individual 
test-benches. 

### Reference
My main reference for this project is ‘Computer Arithmetic Algorithms’ by Israel Koren. After thoroughly understanding 
the theory behind the working multipliers I proceeded to implementing them in Verilog.

To understand the implementations fully, it is recommended to go through the hardware architectures from the 
included pdfs and refer Chap 6(fully) & Chap 5 (section 5.6) of the reference book. After doing that, it is advised to 
go through the Verilog code and subsequently run the test-bench of each multiplier and observe their waveforms. 

Since I have followed a structural Verilog modelling methodology, the existing designs can be easily extended to many 
different multiplier designs. Synthesis of all Verilog designs has been done and their 
hardware usage has been calculated. 

### Next Steps

With different multipliers already implemented in Verilog, the subsequent goal is successfully integrating these 
multipliers into the existing 16-bit MIPS-I processor.