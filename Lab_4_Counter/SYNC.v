//===============================================================
// ENGI 4054: Digital VLSI Design
// Author: Shafiqul Hai
// Date: Aug. 01, 2022
// Description: 2 DFF synchronizer
//              
//===============================================================
// 

module sync(rst_n, clk, in, out);
input rst_n, clk, in ;
output out ;

reg d1, out; //output of DFF1/2
always @(posedge clk)
	begin 
	   if (!rst_n)
		begin
			d1 <= 1'b0 ;
			out <= 1'b0;
		end
	   else
		begin
			d1 <= in ; // sync 1
			out <= d1 ;
		end
	end
endmodule
