
#include <stdint.h>
#include <stdbool.h>

#include "peripherals.h"

/*
firmware for PowerSoC V0.1
6 clock cycles per CPU cycle
80MHz clock frequency
*/
//extern uint32_t sram;


#define GPIO_ADC_MUX 0x01
#define GPIO_GATE_CHARGE  0x02
#define GPIO_LED1 0x04
#define GPIO_LED2 0x08 

#define OCD_LIMIT 420
#define BUS_VOLTAGE_TARGET 240 //Vout is 0.112V/bit

#define PRECHARGE_DELAY 10000

#define PHASE_START 100 //phase shit, 0 to 255 
#define PHASE_MAX 254 
#define CYCLE_LIMIT 2500

#define PHASE_DELTA (((PHASE_MAX-PHASE_START)<<16)/CYCLE_LIMIT)



volatile uint32_t recv_val; 
volatile uint32_t foo;

char buffer [128];

void putchar(char c)
{	if (c == '\n')
		putchar('\r');
	reg_uart_data = c;
}

void print(const char *p)
{
	while (*p)
		putchar(*(p++));
}

void print_dec(uint32_t v)
{
	if (v >= 2000) {
		print(">=2000");
		return;
	}

	if 		(v >= 1000){ putchar('1'); v -= 1000; }

	if      (v >= 900) { putchar('9'); v -= 900; }
	else if (v >= 800) { putchar('8'); v -= 800; }
	else if (v >= 700) { putchar('7'); v -= 700; }
	else if (v >= 600) { putchar('6'); v -= 600; }
	else if (v >= 500) { putchar('5'); v -= 500; }
	else if (v >= 400) { putchar('4'); v -= 400; }
	else if (v >= 300) { putchar('3'); v -= 300; }
	else if (v >= 200) { putchar('2'); v -= 200; }
	else if (v >= 100) { putchar('1'); v -= 100; }
	else putchar('0');

	if      (v >= 90) { putchar('9'); v -= 90; }
	else if (v >= 80) { putchar('8'); v -= 80; }
	else if (v >= 70) { putchar('7'); v -= 70; }
	else if (v >= 60) { putchar('6'); v -= 60; }
	else if (v >= 50) { putchar('5'); v -= 50; }
	else if (v >= 40) { putchar('4'); v -= 40; }
	else if (v >= 30) { putchar('3'); v -= 30; }
	else if (v >= 20) { putchar('2'); v -= 20; }
	else if (v >= 10) { putchar('1'); v -= 10; }
	else putchar('0');

	if      (v >= 9) { putchar('9'); v -= 9; }
	else if (v >= 8) { putchar('8'); v -= 8; }
	else if (v >= 7) { putchar('7'); v -= 7; }
	else if (v >= 6) { putchar('6'); v -= 6; }
	else if (v >= 5) { putchar('5'); v -= 5; }
	else if (v >= 4) { putchar('4'); v -= 4; }
	else if (v >= 3) { putchar('3'); v -= 3; }
	else if (v >= 2) { putchar('2'); v -= 2; }
	else if (v >= 1) { putchar('1'); v -= 1; }
	else putchar('0');
}

void delay_ms(uint32_t ms){

	uint32_t count;
	uint32_t i;
	for(count=0; count<ms; count++){

		//based on simulation below on cycle of loop takes 64 cycles.
		for(i=0; i < (2500); i++){
			asm ("nop");
		}
	}
}

void flush_fifo(){
	while((0x01 & reg_qcw_ramp_status)==0){
		reg_qcw_ramp_fifo_read = 0;
	}
}

void load_fifo(uint32_t start_val, uint32_t delta, uint32_t burst_length){
	uint32_t next_val = 0;

	next_val = (start_val << 16);
	for (uint32_t i=0; i < burst_length; i++){
		reg_qcw_ramp_fifo_write = next_val>>16;
		next_val = next_val + delta;
	}
}

void init_boost_converter(){
	uint32_t old_gpio;
	old_gpio = reg_gpio_out;

	//enable boost converter ADC MUX 
	reg_gpio_out = old_gpio & (~GPIO_ADC_MUX);

	reg_boost_init = 1;

	while((0x01 & reg_boost_status)==0){
		asm ("nop");
	}

	reg_gpio_out = old_gpio;
}

void init_system(){

	print("QCW Coil Driver V0.1\n Booting...\n");

	init_boost_converter();

	reg_qcw_driver_cycle_limit = CYCLE_LIMIT;
	reg_qcw_ocd_limit = OCD_LIMIT; 
	reg_boost_vout_set = BUS_VOLTAGE_TARGET;

	print("Precharging DC Bus Capacitor\n");
	delay_ms(PRECHARGE_DELAY); 
	reg_gpio_out = reg_gpio_out | GPIO_GATE_CHARGE;
	print("Input Voltage: ");
	print_dec(reg_boost_vin);
	print("\n\n");
	print("System Ready\n");
}

void run_pulse(){
	print("Loading FIFO\n\n");
	reg_boost_enable = 0;
	reg_gpio_out = reg_gpio_out | GPIO_ADC_MUX; //connect ADC to current sense
	reg_qcw_ocd_reset = 1;

	flush_fifo();
	load_fifo(PHASE_START, PHASE_DELTA, CYCLE_LIMIT);
	reg_qcw_driver_run = 1;

	while (reg_qcw_driver_run == 0) {
	}

	print("Pulse Finished\n\n");
	if(reg_qcw_ocd_status){
		print("OCD Triggered\n\n");
	}

	print("Max Current: ");
	print_dec(reg_qcw_ocd_meas);
	print("\n\n");

	print("Number of Cycles: ");
	print_dec(reg_qcw_ramp_cycle_count);
	print("\n\n");
}

void charge_bus(){
	uint32_t i;
	print("Charging Bus Capacitor\n");
	reg_gpio_out = reg_gpio_out & (~GPIO_ADC_MUX);
	reg_boost_enable = 1;

	while((reg_boost_status & 0x02) == 0){ //check if vout is not good 
		i++;
		if (i>250000) {
			print("Charging....\n");
			i=0;
		}
	}
	reg_boost_enable = 0;
	reg_gpio_out = reg_gpio_out | GPIO_ADC_MUX; //connect ADC to current sense

	print("Charged. Vout: ");
	print_dec(reg_boost_vout);
	print("\n\n");

}

void main()
{	
	uint32_t loop_counter = 0;
	//init uart at 38400 baud rate
	reg_uart_clkdiv = 2084;
	//reg_uart_clkdiv = 104;
	reg_gpio_out = GPIO_LED2 | GPIO_ADC_MUX;

	init_system();

	
	


	while (1)
	{	
		loop_counter++;
		recv_val = reg_uart_data;

		if(recv_val== 0x63){ // 'c': charge DC bus capacitor
			recv_val = 0xFFFFFFFF;
			charge_bus();
		} 

		if(recv_val== 0x66){ // 'f': fire pulse
			recv_val = 0xFFFFFFFF;
			run_pulse();
		} 

		delay_ms(10);
		if (loop_counter>100){
			print("Running\n");
			loop_counter = 0;
		}

		
	}
}