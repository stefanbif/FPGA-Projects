module counter(
    input clk, 
    input rst, 
    input toggle, 
    input en, 
    input [5:0] preload, 
    output reg [7:0] DISP1_preload, 
    output reg [7:0] DISP0_preload, 
    output reg [7:0] DISP1, 
    output reg [7:0] DISP0, 
    output reg [5:0] count_value_show, 
    output reg count_clk_show); 
    
    integer preload_decimal = 0; 
    integer countvalue = 0; //set the counter to 0 initially
    reg count_up = 1'b1; //
    
    integer countfrequency = 0; //for dividing clock 
    integer div_value = 2; //124999999 would be value if implementing on FPGA 
    reg count_clk = 1'b1; //new clock at lower frequency  
    
    integer digit_1 = 0; //lower digit on LED
    integer digit_2 = 0; //upper digit (10th) on LED
  
  always @(posedge clk)
  begin 
    if(!rst) 
      begin 
           DISP1 <= 7'b0111111; //set disp1 to 0 
           DISP0 <= 7'b0111111; //set disp0 to 0 
      end 
    else if(en) 
      begin 
        preload_decimal <= preload[5]*32 + preload[4]*16 + preload[3]*8 + preload[2]*4 + preload[1]*2 + preload[0]*1; // convert binary to decimal
        case(preload_decimal % 10)        //Divide the decimal value of preload by 10,                                                  
          0: DISP0_preload <= 7'b1000000; //the remainder will be displayed in the 1's place on the display
          1: DISP0_preload <= 7'b1111001; // Ex. 23%10 = 3
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
        
         case(preload_decimal / 10)        //Divide the decimal value of preload by 10,   
          0: DISP1_preload <= 7'b1000000;  // since the variable type is an integer, the remainder will not be stored.  
          1: DISP1_preload <= 7'b1111001;  // The result will by the digit in the 10's place, which will be shown in the 10's place on the display.
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
 
  always @(posedge clk)                     //Programs toggle function, so that the count is inverted when toggle 
    begin                                   // is triggered (i.e. if counting up, will switch to counting down and vice versa
      if(toggle) 
        begin
             count_up <= ~count_up;
        end
    end 
    
//50MHz to 2Hz(0.5s): (50M/2*2)-1 = 12,500,000-1 = 124999999 (so need this many iterations of time)
//In model sim for checking, we chose low value of 2 
 
  always @(posedge clk) 
    begin 
      if(countfrequency == div_value)
        countfrequency <= 0; 
      else 
        countfrequency <= countfrequency + 1; 
     end 
       
  always @(posedge clk) 
   begin   
     if (countfrequency == div_value)   //so whenever if it is lower than div value (2) the clock will toggle 
       count_clk <= ~count_clk;
     else
      count_clk <= count_clk; 
       
   
    count_clk_show = count_clk;   //end of generating reduced clock for counter that will be used in next always block 
  //assign count_clk_show = count_clk; 
   end                                     //this increments the counter at the positive edge of the count clock created that    
   always @(posedge count_clk)          //has a frequency of 100ns (five times greater than the initial value of 20ns)
   begin 
     if (!rst)                          //set the counter to 0 if reset is 0000 
       countvalue <= 0; 
    else                                //if reset is 1111 then count
      if(en)                            //if en=1 then count normally 
        begin 
          if(count_up)                  //if counting upward then increment count by 1 each posedge of count clock, unless the counter reaches 35 then set it   back to 0  
            begin 
              if(countvalue == preload_decimal) 
                countvalue <= 0; 
              else 
                countvalue <= countvalue + 1; 
            end
          else                          //if counting downward then decrement count by 1 each posedge of count clock, unless the counter reaches 0 then set it back to 35  
            begin 
              if(countvalue == 0) 
                countvalue <= preload_decimal; 
              else 
                countvalue <= countvalue - 1; 
            end
            
        end  
    else //if en=0 then halt the counter and keep current value 
      countvalue <= countvalue; 
    
   count_value_show = countvalue;
   // **assign count_value_show = countvalue; 
  end
//when count value is equal to 5 then count clock remains the same (0 
 
  always @(posedge clk) //at posedge of 50MHz clock, transfer the value of the counter to the LED display 
  begin 
    if(!rst) //
      begin 
           DISP1 <= 7'b0111111; //set disp1 to 0 
           DISP0 <= 7'b0111111; //set disp0 to 0 
      end 
    else
      begin 
 
        digit_1 <= countvalue%10; 
        case(digit_1) 
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
        
        digit_2 <= countvalue/10;  
         case(digit_2) 
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
                
endmodule  
