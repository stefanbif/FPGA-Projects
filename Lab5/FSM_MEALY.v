module FSM(  input clock, 
             input reset, 
             //input sequential_input, 
             
             input key1,
             input switch0, 
             
             output reg success_output, 
             output reg [5:0] count_z,   
             output reg [2:0] current_state,next_state,
             output reg [7:0] DISP0,
             output reg [7:0] DISP1
             );

parameter start    = 3'b000,
          first    = 3'b001,
          second   = 3'b011,
          third    = 3'b010,
          delay    = 3'b110,
          successD = 3'b111,
          success  = 3'b101;


integer count_value_number = 0;
integer sequential_inputD = 0;




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
  always @(*) 
    begin 
      if(!reset)             
        count_value_number <= 6'b0; 
      
      else if (current_state == successD | current_state == success) 
        count_value_number <= count_value_number + 1; 
		count_z = count_value_number;
		
    success_output <= (current_state == successD) | (current_state == success); 
    end





  always @(*) 
    begin 
      if(reset == 1'b0)          
             DISP1 = 7'b0111111; 
      else                       
        begin 
          case(success_output) 
            0: DISP1 = 7'b1000000; 
            1: DISP1 = 7'b1111001; 
            default: DISP0 = 7'b0111111; 
            endcase
          end
        end







  always @(*) 
    begin 
      if(reset == 1'b0)          
             DISP0 = 7'b0111111; 
      else                       
        begin 
          case(count_z) 
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
        end
    end 





endmodule 

