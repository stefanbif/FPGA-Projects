module FSM(  input clock, 
             input reset, 
             //input sequential_input, 
             
             input key1,
             input switch0, 
             
             output reg success_output, 
             output reg [5:0] count_z,   
             output reg [2:0] current_state,next_state,
             output reg [7:0] DISP0,
	     output reg [7:0] DISP1,

             output reg [7:0] DISP3
             );

parameter start    = 3'b000,
          first    = 3'b001,
          second   = 3'b011,
          third    = 3'b010,
          delay    = 3'b110,
          successD = 3'b111,
          success  = 3'b101;


integer count_value_number = 0;
integer count_value_max = 99;
integer sequential_inputD = 0;

integer count_digit0 = 0;
integer count_digit1 = 0;




// Check reset, hold at start, or move to next state

  always @(posedge key1) 
    begin 
      if(!reset)   
        current_state <= start; 
      else         
        current_state <= next_state; 
    end  

    



always @(*)
  begin
    if(switch0)
      sequential_inputD <= 1'b1;
    else if(!switch0)
      sequential_inputD <= 1'b0;
  end



  always @(*) 
    begin

      if (!reset) //If reset is equal to 0, program returns to start
        next_state = start; 

    else  
    
  	 success_output <= (current_state == successD) | (current_state == success);
    begin 
      case(current_state) 
      
      start: begin 
             
              if (sequential_inputD==1)
                next_state = start;     
              else                      
                next_state = first;           
             end  
               
      first: begin 
             
              if (sequential_inputD==1)
                next_state = second;     
              else                      
                next_state = first;               
             end 
      
      second: begin

              if (sequential_inputD==1)                              
                next_state = third;
              else                 
                next_state = first;                     
             end 
      
      third: begin

              if (sequential_inputD==1)                              
                next_state = success;
              else                 
                next_state = delay;                     
             end 

      delay: begin 
             
              if (sequential_inputD==1)               
                next_state = successD; 
              else                  
                next_state = delay;           
             end 
      
      successD: begin 
             
              if (sequential_inputD==1)               
                next_state = third; 
              else                  
                next_state = first;           
             end              

      success: begin 
             
              if (sequential_inputD==1)               
                next_state = start; 
              else                     
                next_state = first;           
             end 

      default: begin 
                next_state = start; 
               end 
      
      endcase 
    
    end
   end 




   
  // COUNT count_z, z
  always @(posedge success_output) 
    begin 

      if(!reset) begin            
        count_value_number <= 0; 
      end
	if(count_value_number==count_value_max)
		count_value_number<=0;

      else if (current_state == successD | current_state == success) 
        count_value_number <= count_value_number + 1; 
		count_z <= count_value_number;
		
    
    end





  always @(*) 
    begin 
      if(reset == 1'b0)          
             DISP3 = 7'b0111111; 
      else                       
        begin 
          case(success_output) 
            0: DISP3 = 7'b1000000; 
            1: DISP3 = 7'b1111001; 
            default: DISP0 = 7'b0111111; 
            endcase
          end
        end







  always @(*) 
    begin 
      if(!reset) begin    
             DISP0 = 7'b0111111; 
	     DISP1 = 7'b0111111;
	end

      else                       
        begin 
	count_digit0 <= count_value_number%10;
	
          case(count_digit0) 
            0: DISP0 = 7'b1000000; 
            1: DISP0 = 7'b1111001; 
            2: DISP0 = 7'b0100100; 
            3: DISP0 = 7'b0110000; 
            4: DISP0 = 7'b0011001; 
            5: DISP0 = 7'b0010010; 
            6: DISP0 = 7'b0000010; 
            7: DISP0 = 7'b1111000; 
            8: DISP0 = 7'b0000000; 
            9: DISP0 = 7'b0011000; 
            default: DISP0 = 7'b0111111;
		endcase
	

	count_digit1 <= count_value_number/10; 
          case(count_digit1) 
            0: DISP1 = 7'b1000000; 
            1: DISP1 = 7'b1111001; 
            2: DISP1 = 7'b0100100; 
            3: DISP1 = 7'b0110000; 
            4: DISP1 = 7'b0011001; 
            5: DISP1 = 7'b0010010; 
            6: DISP1 = 7'b0000010; 
            7: DISP1 = 7'b1111000; 
            8: DISP1 = 7'b0000000; 
            9: DISP1 = 7'b0011000; 
            default: DISP1 = 7'b0111111;


          endcase 
        end
    end 





endmodule 

