// simple control of Arduino & powerSTEP Stepper Motor Controller
module fpga_control(
	input kfwd,				//push button for forward
	input krev,				//push button for reverse
	input [1:0] switch,	//switch configuration for motor select
	input CS,				//CS input from SPI host source
	output gpiofwd,		//forward signal output
	output gpiorev,		//reverse signal output
	output [1:0] LED,		//motor select LED in binary
	output CS_LED,			//LED that responds to CS input from SPI source
	output gpio_motor_1, //output pin for motor 1 CS
	output gpio_motor_2, //output pin for motor 2 CS
	output gpio_motor_3, //output pin for motor 3 CS
	CS_out
);

assign gpiofwd = !kfwd; //assigning forward pin to when the forward push button is pulled low
assign gpiorev = !krev; //assigning reverse pin to when the reverse push button is pulled low
assign LED = switch;		//assignment for LED 
assign gpio_motor_1 = (!switch[0] & !switch[1]) & CS; //outputs the CS signal to motor 1 when both switches are "out"
assign gpio_motor_2 = (switch[0] & !switch[1]) & CS;	//outputs the CS signal to motor 2 when top switch "out" and bottom switch "in"
assign gpio_motor_3 = (switch[0] & switch[1]) & CS;	//outputs the CS signal to motor 3 when both switches are "in"
assign CS_LED = CS; //assignment for the CS LED to flash with CS source input activity
assign CS_out = CS; //a test pin for routing back out the CS input
endmodule