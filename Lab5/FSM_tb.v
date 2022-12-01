
`timescale 1ns/1ns

module testbench_FSMMealy();
	reg CLK;
	reg RESET;
	reg INPUT;
	wire [2:0] CURRENT_STATE, NEXT_STATE;
	wire S_OUT;
	wire [5:0] COUNT_Z;
	



FSM uut(.clock(CLK),
		.reset(RESET),
		.sequential_input(INPUT),
		.current_state(CURRENT_STATE),
		.next_state(NEXT_STATE),
		.success_output(S_OUT),
		.count_z(COUNT_Z),
		);


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
			#5 CLK <= ~CLK;
		end


	//INPUT Commands
	initial begin
		RESET <= 1; 

		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 1; #10; //
		INPUT <= 1; #10; //
		INPUT <= 1; #10; //
		INPUT <= 0; #10;
		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //
		INPUT <= 0; #10;
		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //

		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //

		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 


		INPUT <= 0; #10; 
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //	
		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //	
		INPUT <= 0; #10;				
		INPUT <= 1; #10; //
		INPUT <= 1; #10; //
		INPUT <= 0; #10;				
		INPUT <= 1; #10; //
		INPUT <= 1; #10; //
		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 1; #10; //


		end

	endmodule















`timescale 1ns/1ns

module testbench_FSMMealy();
	reg CLK;
	reg RESET;
	reg INPUT;
	wire [2:0] CURRENT_STATE, NEXT_STATE;
	wire S_OUT;
	wire [5:0] COUNT_Z;
	



FSM uut(.clock(CLK),
		.reset(RESET),
		.sequential_input(INPUT),
		.current_state(CURRENT_STATE),
		.next_state(NEXT_STATE),
		.success_output(S_OUT),
		.count_z(COUNT_Z)
		);


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
			#5 CLK <= ~CLK;
		end


	//INPUT Commands
	initial begin
		RESET <= 1; 

		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 1; #10; //
		INPUT <= 1; #10; //
		INPUT <= 1; #10; //
		INPUT <= 0; #10;
		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //
		INPUT <= 0; #10;
		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //

		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //

		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 


		INPUT <= 0; #10; 
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //	
		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 1; #10; //
		INPUT <= 1; #10; // 
		INPUT <= 1; #10; //	
		INPUT <= 0; #10;				
		INPUT <= 1; #10; //
		INPUT <= 1; #10; //
		INPUT <= 0; #10;				
		INPUT <= 1; #10; //
		INPUT <= 1; #10; //
		INPUT <= 0; #10;
		INPUT <= 0; #10;
		INPUT <= 1; #10; //


		end

	endmodule
















