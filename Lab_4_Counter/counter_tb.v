`timescale 1ns/1ns
 
module counter_tb; 
//declaring all necessary registers and wires 
  reg clk;
  reg rst_n;   
  reg toggle;
  reg en; 

  reg  [5:0] preload; 
  wire [7:0] DISP1_preload; 
  wire [7:0] DISP0_preload; 
  wire [7:0] DISP1; 
  wire [7:0] DISP0;
 wire [5:0] count_value_disp; 
  wire count_clk_disp; 
 
  counter uut(.clk(clk), 
              .rst_n(rst_n), 
              .toggle(toggle), 
              .en(en), 
              .preload(preload), 
              .DISP1_preload(DISP1_preload), 
              .DISP0_preload(DISP0_preload), 
              .DISP1(DISP1), 
              .DISP0(DISP0), 
              .count_value_disp(count_value_disp), 
              .count_clk_disp(count_clk_disp)
             ); 
 
  initial 
  begin 
    clk = 1'b0; 
  end 
 
  always //creates system clock at 50MHz, so it switches every 20ns
    begin 
         #20 clk = ~clk; 
    end 
 
  initial 
    begin              
      
      rst_n  = 1'b1; 
      toggle = 1'b1; 
      en    = 1'b1; 
      preload <= 6'b000101; // 5'd
           
 
      //first test: test the reset function  
      #500;
      rst_n = 1'b0;   
      
 
      #1000;         
      rst_n = 1'b1; 
  
      
      //second test: test the toggle function  
      #500; 

      toggle = 1'b1;   
 
  
      #1000; 
      toggle = 1'b0;   
 
      #4000; 
      toggle = 1'b1;   
 
      
      #2000; 
      toggle = 1'b0;   
      
	  #2000; 
      toggle = 1'b1;            
      
 
      //third test: test enable function 
      #1000; 
       
      en = 1'b0; 
      
      #2000;
      en = 1'b1; 
  
      #900
      toggle = 1'b0;
            
      #3000; 
	  toggle = 1'b1;
 
   end 
 
endmodule 

