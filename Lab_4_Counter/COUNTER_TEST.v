//===============================================================
// ENGI 4054: Digital VLSI Design
// Date: Nov 10, 2022
// Description: Top-level file including the instantiated blocks
//              and net connections.
//===============================================================

module COUNTER_TEST(

	//////////// CLOCK //////////

	input 		          		CLOCK2_50,  //sh change the name here according to system builder ADDTEST version


	//////////// SEG7 //////////
	output		     [6:0]		HEX0,  //sh chenged to 6:0
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,


	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [6:0]		LEDR, 

	//////////// SW //////////
	input 		     [6:0]		SW  
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
// temp signal to connect synchronizer output to the input of the counter
	wire en_d, TGL_d, PL0_d, PL1_d, PL2_d,PL3_d, PL4_d, PL5_d; 



//=======================================================
//  Structural coding
//=======================================================
// instantiated module
// synchronizer
sync u_sync1(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[0]),
	.out(en_d)
) ; 	
sync u_sync2(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[1]),
	.out(PL0_d)
) ; 	
sync u_sync3(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[2]),
	.out(PL1_d)
) ; 
sync u_sync4(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[3]),
	.out(PL2_d)
) ; 	
sync u_sync5(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[4]),
	.out(PL3_d)
) ; 

sync u_sync6(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[5]),
	.out(PL4_d)
) ; 

sync u_sync7(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[6]),
	.out(PL5_d)
) ; 
sync u_syn8(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(KEY[1]),
	.out(TGL_d)
) ; 	
	
// COUNTER
adder u_counter(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.toggle(TGL_d),
	.en(en_d),
	.preload({PL5_d,PL4_d,PL3_d,PL2_d,PL1_d,PL0_d}),
	.DISP1_preload(HEX3),
	.DISP0_preload(HEX2),
	.DISP1(HEX1),
	.DISP0(HEX0)
);

// control signal
sw u_sw(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.ctrl({PL5_d,PL4_d,PL3_d,PL2_d,PL1_d,PL0_d,en_d}),
	//.led(LEDR[6:0])
    	.led(LEDR)
);




endmodule
