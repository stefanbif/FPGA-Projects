//===============================================================
// ENGI 4054: Digital VLSI Design
// Author: Shafiqul Hai
// Date: Aug. 01, 2022
// Description: Top-level file including the instantiated blocks
//              and net connections.
//===============================================================

module ADDTEST(

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
	wire en_d, PL0_d, PL1_d, PL2_d,PL3_d, PL4_d, PL5_d; 
// temp signal to connect output of the counter to the 7-segment
	wire preload0_temp, preload1_temp, disp0_temp, disp1_temp;
 // temp signal to connect output of the counter to the 7-segment
	wire preload0_temp, preload1_temp, disp0_temp, disp1_temp;

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
	
	
// full adder
adder u_adder(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in_x(A_d),
	.in_y(B_d),
	.cin(C_d),
	.sum_out(sum_temp),
	.cout(carry_temp)
);
// control signal
sw u_sw(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.ctrl({C_d,B_d,A_d}),
	//.led(LEDR[2:0])
    .led(LEDR)
);
// 7-segments display
disp u_disp(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.sum_in(sum_temp),
	.carry_in(carry_temp),
	.d0(HEX0),
	.d1(HEX1)
);


endmodule
