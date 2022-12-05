`timescale 1ns/1ns
//Declaration of all registers and wires 
module testbench_FSMMealy();
	reg CLK;
	reg RESET;
	reg INPUT;
	reg KEY1;
	reg SWITCH0; 
	wire [2:0] CURRENT_STATE, NEXT_STATE;
	wire S_OUT;
	wire [5:0] COUNT_Z;
	



FSM uut(.clock(CLK),
		.reset(RESET),
		.key1(KEY1),
		.switch0(SWITCH0),
		//.sequential_input(INPUT),
		.current_state(CURRENT_STATE),
		.next_state(NEXT_STATE),
		.success_output(S_OUT),
		.count_z(COUNT_Z)
		);

//Declaring each state as a constant
parameter start    = 3'b000,
          first    = 3'b001,
          second   = 3'b011,
          third    = 3'b010,
          delay    = 3'b110,
          successD = 3'b111,
          success  = 3'b101;


// Simulation commands
		// initialize clk to 1'b0

	initial begin
	 
		CLK = 0;

		end


	//Toggle CLK
	always 
		begin 			
			#1 CLK <= ~CLK;
		end


	//Input set to 010101001111011011110110001
	initial begin
		RESET <= 1; 
		
	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 	
		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
	  
	  
    //00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
   
   	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10;   
	  
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10;  
		
	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10;   
	  		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10;   
	  		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10;   
	  		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10;   
	  		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 
		
	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10;  
		
	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10;  

	//00000000000
		SWITCH0 <= 0; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10;   

	//111111111
		SWITCH0 <= 1; #10;
		KEY1    <= 0; #10;
		KEY1    <= 1; #10;
		KEY1    <= 0; #10; 	
		end

	endmodule
