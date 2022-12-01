module FSM(  input CLOCK_50, 
             input [2:0] KEY,  // [0]reset, [1]sequential_input1, [2]sequential_input2 

             output reg success_output, 
             output reg [5:0] count_z,   
             output reg [2:0] current_state,next_state;
             output reg [7:0] DISP0
             output reg [7:0] DISP1
             );

parameter start    = 3'b000,
          first    = 3'b001,
          second   = 3'b011,
          third    = 3'b010,
          delay    = 3'b110,
          successD = 3'b111,
          success  = 3'b101;








  always @(*) 
    begin 
      if(KEY[0] == 1'b0)          
              = 7'b0111111; 
      else                       
        begin 
          case(success_output) 
            0: DISP1 = 7'b1000000; 
            1: DISP1 = 7'b1111001; 
            default: DISP0 = 7'b0111111; 
            endcase
      end
    end





// Check KEY[0], hold at start, or move to next state


  always @(posedge CLOCK_50) 
    begin 
      if(!KEY[0])   
        current_state <= start; 

      else         
        current_state <= next_state; 
    end  

    




  always @(*) //Program only runs this block when either sequential_input, KEY[0], or state is changed
    begin

      if (!KEY[0]) //If KEY[0] is equal to 0, program returns to start
        next_state = start; 

    else  

    begin 
      case(current_state) 
      
      start: begin 
             
              if (KEY[1]==0)
                next_state = first;     
              else                      
                next_state = start;           
             end  
               
      first: begin 
             
              if (KEY[1]==0)
                next_state = first;     
              else                      
                next_state = second;               
             end 
      
      second: begin

              if (KEY[1]==0)                              
                next_state = first;
              else                 
                next_state = third;                     
             end 
      
      third: begin

              if (KEY[1]==0)                              
                next_state = delay;
              else                 
                next_state = success;                     
             end 

      delay: begin 
             
              if (KEY[1]==0)               
                next_state = delay; 
              else                  
                next_state = successD;           
             end 
      
      successD: begin 
             
              if (KEY[1]==0)               
                next_state = first; 
              else                  
                next_state = third;           
             end              

      success: begin 
             
              if (KEY[1]==0)               
                next_state = first; 
              else                     
                next_state = start;           
             end 

      default: begin 
                next_state = start; 
               end 
      
      endcase 
    
    end
   end 




   
  // COUNT count_z, z
  always @(posedge CLOCK_50) 
    begin 
      if(!KEY[0])             
        count_z <= 6'b0; 
      
      else if (current_state == successD | current_state == success) 
        count_z <= count_z + 1; 
    end  
   



   assign success_output = (current_state == successD) | (current_state == success); 




// Show when at Success state or SuccessD state
  always @(*) 
    begin 
      if(KEY[0] == 1'b0)          
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
      if(KEY[0] == 1'b0)          
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
