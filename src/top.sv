module top
(
  input CLK, //FPGA's clock

	output logic LCD_CLK, //LCD clock
	output logic LCD_DEN,
	output logic [4:0] LCD_R,
	output logic [5:0] LCD_G,
	output logic [4:0] LCD_B
);

/*
Notes from Marios (IIRC)
	- You can pass the clock straight through. You don't need to slow it down to 8 MHz. Later on, even 8 MHz will be too fast.
	- You can treat the buffer as being on the right and bottom, for the sake of your code and when to set the DE pin. Technically it's on all four sides
*/

assign LCD_CLK = CLK;

lcd theBestLCD (
	.pclk(CLK), 
	.LCD_DE(LCD_DEN), 
	.LCD_B(LCD_B), 
	.LCD_G(LCD_G), 
	.LCD_R(LCD_R)
);

/*
We need to send our own clock to the LCD. It will update based on the clock we send it (8 MHz, 25MHz, etc). On every clock cycle, it will increment the pixel internally and output the value from the RGB pins. 
The x and y variables are just for our own internal bounds-checking to make sure we output the correct colors at the right times, but they don't correspond to physical pixels unless we program it just right
We should take the FPGA's clock and passthrough to the LCD, so while our FPGA updates color values internally, the LCD updates pixels at the same clock speed. We could update pixels on the FPGA at a different speed than the LCD updates them (due to the LCD getting a slower/faster clock than the FPGA internally updates color value at), but that would cause tearing 

ecppll 25 -o 65 generates a verilog file that takes your 25 MHz clock (for iceSugar Pro) and outputs a 65 MHz clock. You can also output a slower clock
*/


endmodule