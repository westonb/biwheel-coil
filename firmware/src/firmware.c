
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


void main()
{	
	//init uart at 38400 baud rate
	//reg_uart_clkdiv = 2084;
	reg_uart_clkdiv = 104;

	while (1)
	{	
		print("Hello World \n");

		delay_ms(200);
		reg_gpio_out = GPIO_LED1;
		delay_ms(400); 
		reg_gpio_out = GPIO_LED2;
	}
}