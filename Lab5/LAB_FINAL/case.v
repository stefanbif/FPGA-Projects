case(current_state) 
	3'b000: begin
			HEX0 = 7'b1000000; //0 
			HEX1 = 7'b1000000; //0
			HEX2 = 7'b1000000; //0
			end

	3'b001: begin
			HEX0 = 7'b1111001;
			HEX1 = 7'b1000000;
			HEX2 = 7'b1000000;
			end

	3'b011: begin
			HEX0 = 7'b1111001;
			HEX1 = 7'b1111001;
			HEX2 = 7'b1000000;
			end

	3'b010: begin
			HEX0 = 7'b1000000;
			HEX1 = 7'b1111001;
			HEX2 = 7'b1000000;
			end

	3'b110: begin
			HEX0 = 7'b1000000;
			HEX1 = 7'b1111001;
			HEX2 = 7'b1111001;
			end

	3'b111: begin
			HEX0 = 7'b1111001;
			HEX1 = 7'b1111001;
			HEX2 = 7'b1111001;
			end

	3'b101: begin
			HEX0 = 7'b1111001;
			HEX1 = 7'b1000000; 
			HEX2 = 7'b1111001; 
			end

	endcase
		 
		
