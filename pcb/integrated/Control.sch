EESchema Schematic File Version 4
LIBS:integrated-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 14
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 1000 1350 1000 1000
U 5D33CBE2
F0 "FPGA" 50
F1 "FPGA.sch" 50
$EndSheet
$Sheet
S 1000 3000 1000 1000
U 5D33CBF6
F0 "Analog" 50
F1 "Analog.sch" 50
F2 "ADC_P" I R 2000 3350 50 
F3 "ADC_N" I R 2000 3450 50 
$EndSheet
$Sheet
S 1000 4650 1000 1000
U 5D63A69A
F0 "ADC" 50
F1 "ADC.sch" 50
F2 "ADC_P" I R 2000 4900 50 
F3 "ADC_N" I R 2000 5000 50 
$EndSheet
$Sheet
S 2750 4650 1000 1000
U 5D7BA340
F0 "Interface" 50
F1 "Interface.sch" 50
$EndSheet
Wire Wire Line
	2000 3350 2150 3350
Wire Wire Line
	2150 3350 2150 4900
Wire Wire Line
	2150 4900 2000 4900
Wire Wire Line
	2000 3450 2250 3450
Wire Wire Line
	2250 3450 2250 5000
Wire Wire Line
	2250 5000 2000 5000
$EndSCHEMATC
