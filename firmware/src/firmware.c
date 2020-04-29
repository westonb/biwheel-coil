
#include <stdint.h>
#include <stdbool.h>

/*
firmware for PowerSoC V0.1
6 clock cycles per CPU cycle
160MHz clock frequency
*/
//extern uint32_t sram;


#define GPIO_CHARGE 0x01
#define GPIO_LED_2  0x02
#define GPIO_LED_1 0x04
#define GPIO_ADC_CS 0x08 



volatile uint32_t recv_val; 
volatile uint32_t foo;



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
	

	while (1)
	{

		foo++;

	}
}