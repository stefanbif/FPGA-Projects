
// Top-level file including the instantiated blocks and net connections.


module ADDTEST(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,  

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,  
	output		     [6:0]		HEX1,
//	output		     [7:0]		HEX2,
//	output		     [7:0]		HEX3,
//	output		     [7:0]		HEX4,
//	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [5:0]		LEDR, 

	//////////// SW //////////
	input 		     [2:0]		SW  
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
wire A_d, B_d, C_d; // temp signal to connect synchronizer 
					// output to the input of the adder
wire sum_temp, carry_temp; // temp signal to connect output
							// of the adder to the 7-segment


//=======================================================
//  Structural coding
//=======================================================
// instantiated module
// synchronizer
sync u_sync1(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[0]),
	.out(A_d)
) ; 	
sync u_sync2(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[1]),
	.out(B_d)
) ; 	
sync u_sync3(
	.rst_n(KEY[0]),
	.clk(CLOCK2_50),
	.in(SW[2]),
	.out(C_d)
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
