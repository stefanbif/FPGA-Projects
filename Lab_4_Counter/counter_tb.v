`timescale 1ns/1ns
 
module counter_tb; 
//declaring all necessary registers and wires 
  reg clk_50;
  reg updown;
  reg ena; 
  reg reset; 
  reg [5:0] pre_load; 
  wire [7:0] disp1_pre; 
  wire [7:0] disp0_pre; 
  wire [7:0] disp1; 
  wire [7:0] disp0;
  wire [5:0] count_value_show; 
  wire count_clk_show; 
 
  counter uut(.clk(clk_50), 
              .rst(reset), 
              .toggle(updown), 
              .en(ena), 
              .preload(pre_load), 
              .DISP1_preload(disp1_pre), 
              .DISP0_preload(disp0_pre), 
              .DISP1(disp1), 
              .DISP0(disp0), 
              .count_value_show(count_value_show), 
              .count_clk_show(count_clk_show)); 
 
  initial 
  begin 
    clk_50 = 1'b0; //set initial value of clock as 0 
  end 
 
  always //creates system clock that is 50MHz, so it switches every 20ns
    begin 
         #20 clk_50 = ~clk_50; 
    end 
 
  initial 
    begin //initial conditions are reset is 1 (so no reset), toggle is not activated, and enable is 1 so that the counter is active                 
      
      reset  = 1'b1; 
      updown = 1'b0; 
      ena    = 1'b1; 
      pre_load <= 6'b100011; //preload value is set as given by lab expectations 
           
 
      //first test: test the reset function 
      //we test this function by waiting for the counter to count for 500ns and then set reset to 0. 500ns later we set reset back to 1 to test if it worked 
      //reset = 0 means that reset is activated so that the counter goes back to 0 (this can only happen because enable is still high)        
      #500;
      reset = 1'b0; 
      updown = 1'b0;
      ena = 1'b1;  
      
 
      #500;         
      reset = 1'b1;
      updown = 1'b0; 
      ena = 1'b1;  
      
      //second test: test the toggle function  
      //we test this function by waiting for the counter to count 2800ns to show that it is capable of counting to 12 and then make toggle=1 (with enable = 1 of course)
      //if toggle works, then the counter would begin counting down from the value its at (decimal value 12) to 0 
      #2800; //wait this long so that the disp1 can be seen changing to 1 from, so that we can see count to 12 (i.e. past 10) 
      reset = 1'b1;
      updown = 1'b1; //we can see whether or not toggle switch works  
      ena = 1'b1; 
 
      //third test: test enable function 
      //we do this by setting enable = 0 for 1500ns, during which time the counter should halt entirely, meaning no change in LED displays either 
      //after 1500ns we set enable back to 1 and counter should resume counting where it left off  
      #1000; 
      reset = 1'b1; 
       
      ena = 1'b0; 
      
      #1000; ////wait 1500ns then set enable = 1 to test if enable works
      ena = 1'b1; 
  
      #900
      updown = 1'b0;
            
      #500; 
 
   end 
 
endmodule 
