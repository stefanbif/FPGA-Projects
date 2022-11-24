module counter(
   	input clk, // 50Mhz clock
    input rst_n, // active-low reset
    input toggle, // toggle for counting direction
    input en, 		// enable
    input [5:0] preload, // 6-bit preload
    output reg [7:0] DISP1_preload, // reg for 7-seg display value for preload
    output reg [7:0] DISP0_preload, 
    output reg [7:0] DISP1, // reg for 7-seg display value for count_value_number
    output reg [7:0] DISP0, 
		output reg [5:0] count_value_disp, // 6 bit register to store the current count value, used for modelsim
    output reg count_clk_disp		 //  1 bit which is used to display the slow clock in modelsim
    
);
// 
	// Variables
		integer load_value = 0; // initialize the decimal loaded value to 0
		integer load_digit0 =0; // initialize the 0th digit to 0
		integer load_digit1 =0; // initialize the 10's digit to 0
		reg count_up = 1'b1; // Initialize count_up with b'1 to start the program counting up

		integer count_value_frequency = 0;	//used to store the # of counted impulses from the 50MHz clock input
		localparam div_value = 12499999;		//SET to '12499999' for FPGA implementation , use '2' for modelsim 
																				//50MHz to 2Hz(0.5s): (50M/2*2)-1 = 12,500,000-1 = 12499999 

		reg count_clk = 1'b1; //value of slow clock, sent to count_value_disp to be shown in modelsim  

		integer count_value_number = 0; //set the counter to 0 initially
		integer up_end = 0;							// initialice the counting ceiling, assiged the calue from 
		integer down_end = 0;						// count floor value

		integer count_digit0 = 0; //lower digit on LED
		integer count_digit1 = 0; //upper digit (10th) on LED

	// SETUP FOR PRELOAD VALUE AND CONFIGURE PRELOAD DISPLAYS
	 always @(posedge clk) 	
	  begin 						
	    
		 if(!rst_n) // RESET = 0, Reset is active
	      begin 
	           DISP1_preload <= 7'b0111111; //set disp1 to 0 
	           DISP0_preload <= 7'b0111111; //set disp0 to 0 
	      end   
		 
		 else if(en) // RESET = 1 AND EN = 1
	      begin 
	      // load value is obtained from switches in binary, this binary value is converted to decimal to simplify the case statement
	        load_value <= preload[5]*32 + preload[4]*16 + preload[3]*8 + preload[2]*4 + preload[1]*2 + preload[0]*1; 
	        up_end = load_value; // update the count ceiling with the loaded value so the counter stops here
	        load_digit0 <= load_value % 10;	// modulus 10 extracts the 1's digit from the 2 digit decimal number
			case(load_digit0)        	                                               
			  0: DISP0_preload <= 7'b1000000; 		//the remainder will be displayed in the 1's place on the display
			  1: DISP0_preload <= 7'b1111001; 		// Ex. 13%10 = 3
			  2: DISP0_preload <= 7'b0100100; 
			  3: DISP0_preload <= 7'b0110000; 
			  4: DISP0_preload <= 7'b0011001; 
			  5: DISP0_preload <= 7'b0010010; 
			  6: DISP0_preload <= 7'b0000010; 
			  7: DISP0_preload <= 7'b1111000; 
			  8: DISP0_preload <= 7'b0000000; 
			  9: DISP0_preload <= 7'b0011000; 
			  default: DISP0_preload <= 7'b0000111; 
			endcase 
		  load_digit1 <= load_value / 10; // divding by 10, then updating load_digit1 will extract the 10's digit from the load value
			case(load_digit1)        	   
			  0: DISP1_preload <= 7'b1000000;		// the variable type is an integer, the remainder will not be stored.  
			  1: DISP1_preload <= 7'b1111001;		
			  2: DISP1_preload <= 7'b0100100; 
			  3: DISP1_preload <= 7'b0110000; 
			  4: DISP1_preload <= 7'b0011001; 
			  5: DISP1_preload <= 7'b0010010; 
			  6: DISP1_preload <= 7'b0000010; 
			  7: DISP1_preload <= 7'b1111000; 
			  8: DISP1_preload <= 7'b0000000; 
			  9: DISP1_preload <= 7'b0011000; 
			  default: DISP1_preload <= 7'b0000111; 
			endcase       
	      
			end      
	  
	  end 
	//
	//
	//
	//
	// TOGGLE FUNCTION, relate count_up/down to toggle key   
	  always @(posedge clk)                
	    begin                                   
	      
			if(toggle) // toggle = 1, count direction is changed
	        begin
	        	count_up <= ~count_up;
	        
			 end
	    
		 end
	//
	//
	//
	//
	//50MHz to 2Hz(0.5s): (50M/2*2)-1 = 12,500,000-1 = 12499999 
	// COUNTING FOR SLOW CLOCK ---> count_value_frequency
	  always @(posedge clk) 
	    begin 
	      
			if(count_value_frequency == div_value) 
				count_value_frequency <= 0; // once the clock has reached the division value to give 2Hz, reset the counter
			  
			  else 
				count_value_frequency <= count_value_frequency + 1; 
		end 
	//
	//
	//
	//
	//
	// SLOW CLOCK GENERATION ---> count_clk
	  always @(posedge clk) 
	   begin   
	     if (count_value_frequency == div_value)     
	       count_clk <= ~count_clk;			// Once countfequency reaches div_value (12499999), count_clk gets toggled
	     else
	      count_clk <= count_clk; 			// count_clk remains constant otherwise
	       
	   
	       count_clk_disp = count_clk;  // display the clock for modelsim
		
	   end         
	//
	//
	//
	//
	//
	// COUNTING FUNCTION ----> count_value_number
		// covers reset, up/down, and toggle conditions
	   always @(posedge count_clk)          
	   begin 
	    
		if (!rst_n)    //CONDITION 1: RESET=0, DISABLE OUTPUT
	       count_value_number <= 0; 
		//    
		else 									//CONDITION 2.1: RESET=1, ENABLE OUTPUT
			if(en)							//CONDITION 2.2: EN=1, ENABLE COUNTER
			begin 
			  
			  if(count_up)					//CONDITION 2.2.1: COUNT_UP=1, COUNT UP                  
				begin 
				  
				  if(count_value_number == load_value) 	//CONDITION 2.2.1.1: count_value_number=up_end(preload), SET count_value_number=0
					count_value_number <= 0; 

				  else 																	//CONDITION 2.2.1.2: count_value_number != up_end(preload), INCREMENT count_value_number
					count_value_number <= count_value_number + 1; 
				end
			  

		//
			else 										//CONDITION 2.2.2: COUNT_UP=0, COUNT DOWN
				begin 
				
				  if(count_value_number == down_end) 		//CONDITION 2.2.2.1: count_value_number=down_end(0), SET count_value_number=load_value
					count_value_number <= load_value; 

				  else 																	//CONDITION 2.2.2.2: count_value_number != 0, DECREMENT count_value_number
					count_value_number <= count_value_number - 1; 
				end
				
			end  
		
		else 								//CONDITION 2.3: EN=0: DISABLE COUNTER (HOLD CURRENT VALUE) 
			count_value_number <= count_value_number; 
	    
	  count_value_disp = count_value_number;

	  end
	//
	//
	//
	//
	//
	// DISPLAY count_value_number ON 7-SEGMENT DISPLAY
	 always @(posedge clk) //at posedge of 50MHz clock,
	  begin 
	    if(!rst_n) //
	      begin 
	           DISP1 <= 7'b0111111; //set disp1 to 0 
	           DISP0 <= 7'b0111111; //set disp0 to 0 
	      end 
	    
		else
	      begin 
	 
	        count_digit0 <= count_value_number%10; 
		      case(count_digit0) 
			  0: DISP0 <= 7'b1000000; 
			  1: DISP0 <= 7'b1111001; 
			  2: DISP0 <= 7'b0100100; 
			  3: DISP0 <= 7'b0110000; 
			  4: DISP0 <= 7'b0011001; 
			  5: DISP0 <= 7'b0010010; 
			  6: DISP0 <= 7'b0000010; 
			  7: DISP0 <= 7'b1111000; 
			  8: DISP0 <= 7'b0000000; 
			  9: DISP0 <= 7'b0011000; 
	          default: DISP0 <= 7'b0000111; 
	        endcase 
	        
	        count_digit1 <= count_value_number/10;  
		      case(count_digit1) 
			  0: DISP1 <= 7'b1000000; 
			  1: DISP1 <= 7'b1111001; 
			  2: DISP1 <= 7'b0100100; 
			  3: DISP1 <= 7'b0110000; 
			  4: DISP1 <= 7'b0011001; 
			  5: DISP1 <= 7'b0010010; 
			  6: DISP1 <= 7'b0000010; 
			  7: DISP1 <= 7'b1111000; 
			  8: DISP1 <= 7'b0000000; 
			  9: DISP1 <= 7'b0011000; 
	          default: DISP1 <= 7'b0000111; 
	        endcase 
	      end
	 end 
	//
	//
	//
	//
	//
endmodule 
