
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h> 

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

#define OCD_LIMIT 420 //50A limit
#define BUS_VOLTAGE_TARGET 280 //Vout is 0.112V/bit

#define PRECHARGE_DELAY 10000

#define PHASE_START 100 //phase shit, 0 to 255 
#define PHASE_MAX 254 
#define CYCLE_LIMIT 4000

#define PHASE_DELTA (((PHASE_MAX-PHASE_START)<<16)/CYCLE_LIMIT)

#define RX_BUFFER_SIZE 64

#define VIN_VOLTS_BIT 0.0728
#define VOUT_VOLTS_BIT 0.145
#define QCW_AMPS_BIT 0.118

#define VBOOST_OUT_MIN 275 //40V output
#define VBOOST_OUT_MAX 2068 //300V output 



volatile uint32_t recv_val; 
volatile uint32_t foo;

char rx_buffer [RX_BUFFER_SIZE];


static int
simple_putc(char c, FILE *file)
{
	(void) file;	
	reg_uart_data = c;	
	return c;
}

static int
simple_getc(FILE *file)
{	
	int32_t c = -1;
	while (c == -1){ c = reg_uart_data;}
	(void) file;		/* Not used in this function */
	return c;
}


static FILE __stdio = FDEV_SETUP_STREAM(simple_putc,
					simple_getc,
					NULL,
					_FDEV_SETUP_RW);

FILE *const __iob[3] = { &__stdio, &__stdio, &__stdio };


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


	delay_ms(250);

	reg_qcw_driver_cycle_limit = CYCLE_LIMIT;
	reg_qcw_ocd_limit = OCD_LIMIT; 
	reg_boost_vout_set = BUS_VOLTAGE_TARGET;


	printf("Precharging DC Bus Capacitor\r\n");
	delay_ms(250);
	while( ((VOUT_VOLTS_BIT*(float)reg_boost_vout)+3) <  (VIN_VOLTS_BIT*(float)reg_boost_vin) ){
		delay_ms(250);
		printf("Vin: %.2f \r\n", VIN_VOLTS_BIT*(float)reg_boost_vin);
		printf("Vbus: %.2f \r\n", VOUT_VOLTS_BIT*(float)reg_boost_vout);
	}

	printf("Done Charging\r\n");
	printf("Vin: %.2f \r\n", VIN_VOLTS_BIT*(float)reg_boost_vin);
	printf("Vbus: %.2f \r\n", VOUT_VOLTS_BIT*(float)reg_boost_vout);

	reg_gpio_out = reg_gpio_out | GPIO_GATE_CHARGE;
	
	printf("Init Boost Converter\r\n");
	init_boost_converter();
	printf("System Ready\r\n");
}

void run_pulse(){
	printf("Loading FIFO\r\n");
	reg_boost_enable = 0;
	reg_gpio_out = reg_gpio_out | GPIO_ADC_MUX; //connect ADC to current sense
	reg_qcw_ocd_reset = 1;

	flush_fifo();
	load_fifo(PHASE_START, PHASE_DELTA, CYCLE_LIMIT);

	reg_qcw_driver_run = 1;

	while (reg_qcw_driver_run == 0) {
	}

	printf("Pulse Finished\r\n");
	if(reg_qcw_ocd_status){
		printf("OCD Triggered\r\n");
	}

	printf("Max Current: %.2f \r\n", QCW_AMPS_BIT*(float)reg_qcw_ocd_meas);

	printf("Number of Cycles: %u \r\n", reg_qcw_ramp_cycle_count);
}

void charge_bus(){
	uint32_t i;
	reg_gpio_out = reg_gpio_out & (~GPIO_ADC_MUX);
	reg_boost_enable = 1;

	while((reg_boost_status & 0x02) == 0){ //check if vout is not good 
		i++;
		if (i>250000) {
			printf("Charging....\r\n");
			i=0;
		}
	}
	reg_boost_enable = 0;
	reg_gpio_out = reg_gpio_out | GPIO_ADC_MUX; //connect ADC to current sense

	printf("Charged. Vout: %u \r\n", reg_boost_vout);
	
}

int parse_cmd(char *command){

	char * token;
	char * token_cmd;
	uint32_t val = 0;

	printf("Input String _%s_ \r\n", command);
	token = strtok(command, " ");
	token_cmd = token;

	if (token == NULL) {return -1;} //check if we have a command 
	printf("Parsed String _%s_ \r\n", token);

	token = strtok(NULL, " ");
	if (token != NULL) {
		printf("Parsed Number _%s_ \r\n", token);
		val = atoi(token);
		printf("Converter Number _%u_ \r\n",val);
	}



	if(strcmp(token_cmd, "IDN?") == 0){
		printf("QCW V0.2\r\n");
	}
	else if (strcmp(token_cmd, "BOOST:VSET")==0){
		if ((val<= VBOOST_OUT_MAX) && (val>=VBOOST_OUT_MIN)){
			printf("BOOST Set Voltage to %u \r\n", val);
			reg_boost_vout_set = val;
		}
	}
	else if (strcmp(token_cmd, "BOOST:VIN")==0){
		printf("Boost Vin: %.2f \r\n", VIN_VOLTS_BIT*(float)reg_boost_vin);
	}
	else if (strcmp(token_cmd, "BOOST:VOUT")==0){
		printf("Boost Vout: %.2f \r\n", VOUT_VOLTS_BIT*(float)reg_boost_vout);
	}
	else if (strcmp(token_cmd, "BOOST:CHARGE")==0){
		printf("Charging Bus Capacitor\r\n");
		charge_bus();
	}
	else if (strcmp(token_cmd, "QCW:FIRE")==0){
		run_pulse();
	}
	else {
		printf("Not a valid command\r\n");
	}
	return 1;
}

void main()
{	

	char * command_pointer = rx_buffer;

	//reg_uart_clkdiv = 104;
	reg_uart_clkdiv = 2084;
	uint32_t loop_counter = 0;
	uint32_t recv_val;

	//init uart at 38400 baud rate
	//reg_uart_clkdiv = 2084;
	//reg_uart_clkdiv = 104;
	reg_gpio_out = GPIO_LED2 | GPIO_ADC_MUX;
	delay_ms(100);

	
	printf("Booting. Hello World\r\n");
	init_system();


	
	


	while (1)
	{	
		loop_counter++;
		recv_val = reg_uart_data;

		if(recv_val == -1) {} // no data, ignore

		else if(recv_val == '\r'){ //line is done, process command
			printf("\r\n");
			*command_pointer = 0; //null terminate
			parse_cmd(rx_buffer);
			command_pointer = rx_buffer; 
		}
		else if ((32<=recv_val)&&(recv_val<=126)){	//valid char, process
			simple_putc(recv_val, NULL);
			*command_pointer = recv_val;
			command_pointer++;
		}


		if ((command_pointer-rx_buffer)>= RX_BUFFER_SIZE){
			printf("Command Buffer Overflow\r\n");
			command_pointer = rx_buffer;
		}

	}
}