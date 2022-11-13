
module sw(
	input 	clk,
	input 	rst_n,
	output	reg     [9:0]	led,
	input 		[6:0]	ctrl
);


// connect SW to LED
always @(posedge clk)
	begin
		if (!rst_n)
                        led <= 9'h1FF ;
		else 
		        led <= {7'b0000000, ctrl} ;
	end
endmodule
