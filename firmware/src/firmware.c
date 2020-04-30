
#include <stdint.h>
#include <stdbool.h>

#include "peripherals.h"

/*
firmware for PowerSoC V0.1
6 clock cycles per CPU cycle
160MHz clock frequency
*/
//extern uint32_t sram;


#define GPIO_ADC_MUX 0x01
#define GPIO_GATE_CHARGE  0x02
#define GPIO_LED1 0x04
#define GPIO_LED2 0x08 

#define OCD_LIMIT 300
#define BUS_VOLTAGE_TARGET 440 //Vout is 0.112V/bit



volatile uint32_t recv_val; 
volatile uint32_t foo;

void putchar(char c)
{
	if (c == '\n')
		putchar('\r');
	reg_uart_data = c;
}

void print(const char *p)
{
	while (*p)
		putchar(*(p++));
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
	while(0x01 & reg_qcw_ramp_status){
		reg_qcw_ramp_fifo_read = 0;
	}
}

void init_boost_converter(){
	uint32_t old_gpio;
	old_gpio = reg_gpio_out;

	//enable boost converter ADC MUX 
	reg_gpio_out = old_gpio & (~GPIO_ADC_MUX);

	reg_boost_init = 1;

	while(0x01 & (~reg_boost_status)){
		asm ("nop");
	}

	reg_gpio_out = old_gpio;

	reg_boost_vout_set = BUS_VOLTAGE_TARGET;
}


void main()
{	
	//init uart at 38400 baud rate
	//reg_uart_clkdiv = 2084;
	reg_uart_clkdiv = 104;
	reg_gpio_out = GPIO_LED2 | GPIO_ADC_MUX;

	init_boost_converter();
	reg_boost_enable = 1;




	/*
	reg_gpio_out = GPIO_ADC_MUX; //connect ADC to OCD

	reg_qcw_ocd_limit = OCD_LIMIT;

	reg_qcw_driver_cycle_limit = 100; 

	for (int i=0; i < 150; i++ ){
		reg_qcw_ramp_fifo_write = i + 100;
	}




	*/


	while (1)
	{	

		print("Running\n");
		
		
	}
}