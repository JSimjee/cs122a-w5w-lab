module lcd
(
	// input  rst, // How do we use this reset pin?
	input  pclk,        

	output logic LCD_DE,      // Display Enable

	output logic [4:0] LCD_B, // 5-bit blue color data
	output logic [5:0] LCD_G, // 6-bit green color data
	output logic [4:0] LCD_R  // 5-bit red color data
);
// "logic" in SV will become a wire or reg
// Just use "logic", SV will set it to whatever will compile
// wires are connected to registers. You can set the values of registers, but not wires. 

int x = 0;
int y = 0;

/** Logic */
always @(posedge pclk) begin

	// Increment x to 525, then y=y+1
	// Increment y to 285, then x=y=0

	if (x == 525) begin
		x <= 0;
		if (y == 285) begin
			y <= 0;
		end else begin
			y <= y+1;
		end
	end else begin
		x <= x+1;
	end

	if (x < 160) begin
		LCD_R <= 5'b11111;
		LCD_G <= 6'b000000;
		LCD_B <= 5'b00000;
	end else if (x < 320) begin
		LCD_R <= 5'b00000;
		LCD_G <= 6'b111111;
		LCD_B <= 5'b00000;
	end else begin
		LCD_R <= 5'b00000;
		LCD_G <= 6'b000000;
		LCD_B <= 5'b11111;
	end
	
end

	assign LCD_DE = (x < 480) && (y < 272);

// Output red at pixels 0-160
//        green at pixels 161-320
//        blue at pixels 321-480

endmodule