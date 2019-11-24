
#include <stdint.h>
#include <stdbool.h>

/*
firmware for PowerSoC V0.1
6 clock cycles per CPU cycle
160MHz clock frequency
*/
//extern uint32_t sram;

#define reg_uart_clkdiv (*(volatile uint32_t*)0x02000004)
#define reg_uart_data (*(volatile uint32_t*)0x02000008)

#define reg_gpio_cfg (*(volatile uint32_t*) 0x02100000)
#define reg_gpio_out (*(volatile uint32_t*) 0x02100004)
#define reg_gpio_in (*(volatile uint32_t*) 0x02100008)

#define reg_spi_clkdiv (*(volatile uint32_t*) 0x02200000)
#define reg_spi_out (*(volatile uint32_t*) 0x02200004)
#define reg_spi_in (*(volatile uint32_t*) 0x02200008)
#define reg_spi_status (*(volatile uint32_t*) 0x0220000C)

#define reg_qcw_phase_start (*(volatile uint32_t*) 0x03000000)
#define reg_qcw_phase_step (*(volatile uint32_t*) 0x03000004)
#define reg_qcw_cycle_limit (*(volatile uint32_t*) 0x03000008)
#define reg_qcw_start  (*(volatile uint32_t*) 0x0300000C)
#define reg_qcw_status (*(volatile uint32_t*) 0x03000010)
#define reg_qcw_max_current  (*(volatile uint32_t*) 0x03000014)

#define GPIO_CHARGE 0x01
#define GPIO_LED_2  0x02
#define GPIO_LED_1 0x04
#define GPIO_ADC_CS 0x08 


volatile uint32_t recv_val; 


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

void send_bytes(uint8_t *data, uint8_t data_len){
	uint8_t i;
	for (i=0; i<data_len; i++){
		reg_spi_out = (uint32_t) data[i];
		while(reg_spi_status == 0){

		}
	}
}

void adc_configure(void){
	uint8_t config_data[3];
}

void main()
{
	//configure for 38400 baud 
	//uart is 8N1
	reg_uart_clkdiv = 4168;
	//SPI is 1 Mhz
	reg_spi_clkdiv = 50;
	reg_gpio_out = 0;

	print("Firmware Loaded\n");
	print("\n");

	reg_gpio_out = GPIO_LED_1; 


	while (1)
	{

		print("Hello Wold\n");
		print("Made to think and not to feeel\n");
		print("Not even sure if this is realll\n");
		print("doo dooo do dooo dooooo\n");
		//flush buffer 
		reg_gpio_out = (reg_gpio_out & (~GPIO_LED_1)); 
		reg_gpio_out = (reg_gpio_out & (~GPIO_CHARGE));

		delay_ms(1000); 
		reg_gpio_out = (reg_gpio_out | GPIO_LED_1);
		reg_gpio_out = (reg_gpio_out | GPIO_CHARGE);
		delay_ms(1000); 
	}
}
