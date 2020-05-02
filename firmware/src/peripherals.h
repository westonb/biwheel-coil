

#define UART_BASE_ADDR 			0x01000000
#define GPIO_BASE_ADDR 			0x10000000 
#define QCW_RAMP_BASE_ADDR 		0x11000000 
#define QCW_DRIVER_BASE_ADDR 	0x12000000
#define QCW_OCD_BASE_ADDR 		0x13000000 
#define BOOST_BASE_ADDR 		0x14000000 


#define UART_CLKDIV_OFFSET 0
#define UART_DATA_REG_OFFSET 4

#define GPIO_OUT_OFFSET 0
#define GPIO_IN_OFFSET 4

#define QCW_RAMP_STATUS_OFFSET 0
#define QCW_RAMP_FIFO_WRITE_OFFSET 4
#define QCW_RAMP_FIFO_READ_OFFSET 8
#define QCW_RAMP_CYCLE_COUNT_OFFSET 12

#define QCW_DRIVER_RUN_OFFSET 0
#define QCW_DRIVER_CYCLE_LIMIT_OFFSET 4
#define QCW_DRIVER_HALT_OFFSET 8

#define QCW_OCD_LIMIT_OFFSET 0
#define QCW_OCD_MEAS_OFFSET 4
#define QCW_OCD_STATUS_OFFSET 8
#define QCW_OCD_ADC_OFFSET 12
#define QCW_OCD_RESET_OFFSET 16

#define BOOST_ENABLE_OFFSET 0
#define BOOST_INIT_OFFSET 4
#define BOOST_STATUS_OFFSET 8
#define BOOST_VIN_OFFSET 12
#define BOOST_VOUT_OFFSET 16
#define BOOST_VOUT_SET_OFFSET 20


#define reg_uart_clkdiv (*(volatile uint32_t*)(UART_BASE_ADDR+UART_CLKDIV_OFFSET))
#define reg_uart_data (*(volatile uint32_t*)(UART_BASE_ADDR+UART_DATA_REG_OFFSET))

#define reg_gpio_in (*(volatile uint32_t*)(GPIO_BASE_ADDR+GPIO_IN_OFFSET))
#define reg_gpio_out (*(volatile uint32_t*)(GPIO_BASE_ADDR+GPIO_OUT_OFFSET))

#define reg_qcw_ramp_status (*(volatile uint32_t*)(QCW_RAMP_BASE_ADDR+QCW_RAMP_STATUS_OFFSET))
#define reg_qcw_ramp_fifo_write (*(volatile uint32_t*)(QCW_RAMP_BASE_ADDR+QCW_RAMP_FIFO_WRITE_OFFSET))
#define reg_qcw_ramp_fifo_read (*(volatile uint32_t*)(QCW_RAMP_BASE_ADDR+QCW_RAMP_FIFO_READ_OFFSET))
#define reg_qcw_ramp_cycle_count (*(volatile uint32_t*)(QCW_RAMP_BASE_ADDR+QCW_RAMP_CYCLE_COUNT_OFFSET))

#define reg_qcw_driver_run (*(volatile uint32_t*)(QCW_DRIVER_BASE_ADDR+QCW_DRIVER_RUN_OFFSET))
#define reg_qcw_driver_cycle_limit (*(volatile uint32_t*)(QCW_DRIVER_BASE_ADDR+QCW_DRIVER_CYCLE_LIMIT_OFFSET))
#define reg_qcw_driver_halt (*(volatile uint32_t*)(QCW_DRIVER_BASE_ADDR+QCW_DRIVER_HALT_OFFSET))

#define reg_qcw_ocd_limit (*(volatile uint32_t*)(QCW_OCD_BASE_ADDR+QCW_OCD_LIMIT_OFFSET))
#define reg_qcw_ocd_meas (*(volatile uint32_t*)(QCW_OCD_BASE_ADDR+QCW_OCD_MEAS_OFFSET))
#define reg_qcw_ocd_status (*(volatile uint32_t*)(QCW_OCD_BASE_ADDR+QCW_OCD_STATUS_OFFSET))
#define reg_qcw_ocd_adc (*(volatile uint32_t*)(QCW_OCD_BASE_ADDR+QCW_OCD_ADC_OFFSET))
#define reg_qcw_ocd_reset (*(volatile uint32_t*)(QCW_OCD_BASE_ADDR+QCW_OCD_RESET_OFFSET))

#define reg_boost_enable (*(volatile uint32_t*)(BOOST_BASE_ADDR+BOOST_ENABLE_OFFSET))
#define reg_boost_init (*(volatile uint32_t*)(BOOST_BASE_ADDR+BOOST_INIT_OFFSET))
#define reg_boost_status (*(volatile uint32_t*)(BOOST_BASE_ADDR+BOOST_STATUS_OFFSET))
#define reg_boost_vin (*(volatile uint32_t*)(BOOST_BASE_ADDR+BOOST_VIN_OFFSET))
#define reg_boost_vout (*(volatile uint32_t*)(BOOST_BASE_ADDR+BOOST_VOUT_OFFSET))
#define reg_boost_vout_set (*(volatile uint32_t*)(BOOST_BASE_ADDR+BOOST_VOUT_SET_OFFSET))

