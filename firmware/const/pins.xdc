set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#ADC data bus
set_property PACKAGE_PIN D13 [get_ports ADC_DATA[0]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[0]]
set_property PACKAGE_PIN D14 [get_ports ADC_DATA[1]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[1]]
set_property PACKAGE_PIN E12 [get_ports ADC_DATA[2]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[2]]
set_property PACKAGE_PIN E13 [get_ports ADC_DATA[3]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[3]]
set_property PACKAGE_PIN F12 [get_ports ADC_DATA[4]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[4]]
set_property PACKAGE_PIN F13 [get_ports ADC_DATA[5]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[5]]
set_property PACKAGE_PIN F14 [get_ports ADC_DATA[6]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[6]]
set_property PACKAGE_PIN G14 [get_ports ADC_DATA[7]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[7]]
set_property PACKAGE_PIN H14 [get_ports ADC_DATA[8]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[8]]
set_property PACKAGE_PIN H13 [get_ports ADC_DATA[9]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DATA[9]]

#ADC other signals
set_property PACKAGE_PIN H11 [get_ports ADC_DCO]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_DCO]
set_property PACKAGE_PIN J14 [get_ports ADC_MODE]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_MODE]
set_property PACKAGE_PIN C14 [get_ports ADC_SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_SCLK]
set_property PACKAGE_PIN D12 [get_ports ADC_SDIO]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_SDIO]
set_property PACKAGE_PIN B14 [get_ports ADC_CS]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_CS]

#ADC_MUX
set_property PACKAGE_PIN J13 [get_ports ADC_MUX]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_MUX]

#XADC input pins
set_property PACKAGE_PIN G8 [get_ports VP_0]
set_property PACKAGE_PIN H7 [get_ports VN_0]

#XADC mux 
set_property PACKAGE_PIN A13 [get_ports XADC_MUX]
set_property IOSTANDARD LVCMOS33 [get_ports XADC_MUX]

#debug / status 
set_property PACKAGE_PIN P3 [get_ports LED1]
set_property IOSTANDARD LVCMOS33 [get_ports LED1]
set_property PACKAGE_PIN N4 [get_ports LED2]
set_property IOSTANDARD LVCMOS33 [get_ports LED2]
set_property PACKAGE_PIN N14 [get_ports DEBUG_TX]
set_property IOSTANDARD LVCMOS33 [get_ports DEBUG_TX]
set_property PACKAGE_PIN M14 [get_ports DEBUG_RX]
set_property IOSTANDARD LVCMOS33 [get_ports DEBUG_RX]

#interface
set_property PACKAGE_PIN P2 [get_ports FIBER_TX]
set_property IOSTANDARD LVCMOS33 [get_ports FIBER_TX]
set_property PACKAGE_PIN P4 [get_ports FIBER_RX]
set_property IOSTANDARD LVCMOS33 [get_ports FIBER_RX]

#comparators 
set_property PACKAGE_PIN L14 [get_ports ZCS]
set_property IOSTANDARD LVCMOS33 [get_ports ZCS]
set_property PACKAGE_PIN A12 [get_ports OVER_TEMP]
set_property IOSTANDARD LVCMOS33 [get_ports OVER_TEMP]


# bridge gate drive
set_property PACKAGE_PIN B3 [get_ports GATE1]
set_property IOSTANDARD LVCMOS33 [get_ports GATE1]
set_property PACKAGE_PIN A3 [get_ports GATE2]
set_property IOSTANDARD LVCMOS33 [get_ports GATE2]
set_property PACKAGE_PIN A2 [get_ports GATE3]
set_property IOSTANDARD LVCMOS33 [get_ports GATE3]
set_property PACKAGE_PIN B2 [get_ports GATE4]
set_property IOSTANDARD LVCMOS33 [get_ports GATE4]

#aux gate drive
set_property PACKAGE_PIN A5 [get_ports GATE_CHARGE]
set_property IOSTANDARD LVCMOS33 [get_ports GATE_CHARGE]
set_property PACKAGE_PIN A4 [get_ports GATE_BOOST]
set_property IOSTANDARD LVCMOS33 [get_ports GATE_BOOST]

#enable pullup on debug RX
set_property PULLUP TRUE [get_ports DEBUG_RX]