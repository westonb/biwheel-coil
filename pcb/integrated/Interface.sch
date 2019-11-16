EESchema Schematic File Version 4
LIBS:integrated-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 7 14
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L wbraun_ic_lib:AFBR-1624Z U7001
U 1 1 5C589FD7
P 3250 2650
F 0 "U7001" H 3250 3115 50  0000 C CNN
F 1 "AFBR-1624Z" H 3250 3024 50  0000 C CNN
F 2 "wbraun_smd:versatile-link_horizontal" H 4550 3650 50  0001 C CNN
F 3 "" H 4550 3650 50  0001 C CNN
	1    3250 2650
	-1   0    0    -1  
$EndComp
$Comp
L wbraun_ic_lib:AFBR-2624Z U7002
U 1 1 5C58A312
P 3250 3950
F 0 "U7002" H 3250 4415 50  0000 C CNN
F 1 "AFBR-2624Z" H 3250 4324 50  0000 C CNN
F 2 "wbraun_smd:versatile-link_horizontal" H 3950 4450 50  0001 C CNN
F 3 "" H 3950 4450 50  0001 C CNN
	1    3250 3950
	-1   0    0    -1  
$EndComp
Text GLabel 2550 2650 0    50   Input ~ 0
FIBER_TX
Text GLabel 2600 3950 0    50   Input ~ 0
FIBER_RX
$Comp
L Device:C C7001
U 1 1 5C598AC4
P 4100 2700
F 0 "C7001" H 4215 2746 50  0000 L CNN
F 1 "0.47u" H 4215 2655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4138 2550 50  0001 C CNN
F 3 "~" H 4100 2700 50  0001 C CNN
	1    4100 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:Ferrite_Bead FB7001
U 1 1 5C598F19
P 5050 2450
F 0 "FB7001" V 4776 2450 50  0000 C CNN
F 1 "Ferrite_Bead" V 4867 2450 50  0000 C CNN
F 2 "Inductor_SMD:L_0402_1005Metric" V 4980 2450 50  0001 C CNN
F 3 "~" H 5050 2450 50  0001 C CNN
	1    5050 2450
	0    1    1    0   
$EndComp
$Comp
L Device:C C7003
U 1 1 5C59D1AE
P 4600 2700
F 0 "C7003" H 4715 2746 50  0000 L CNN
F 1 "4.7u" H 4715 2655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4638 2550 50  0001 C CNN
F 3 "~" H 4600 2700 50  0001 C CNN
	1    4600 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7005
U 1 1 5C59D385
P 5500 2700
F 0 "C7005" H 5615 2746 50  0000 L CNN
F 1 "4.7u" H 5615 2655 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5538 2550 50  0001 C CNN
F 3 "~" H 5500 2700 50  0001 C CNN
	1    5500 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 2450 4100 2450
Wire Wire Line
	4100 2450 4100 2550
Wire Wire Line
	4600 2450 4600 2550
Wire Wire Line
	4600 2450 4900 2450
Wire Wire Line
	5200 2450 5500 2450
Wire Wire Line
	5500 2450 5500 2550
Wire Wire Line
	5500 2450 5500 2350
Connection ~ 5500 2450
Wire Wire Line
	4100 2450 4600 2450
Connection ~ 4100 2450
Connection ~ 4600 2450
$Comp
L power:GND #PWR07003
U 1 1 5C5D1CCA
P 4100 3050
F 0 "#PWR07003" H 4100 2800 50  0001 C CNN
F 1 "GND" H 4105 2877 50  0000 C CNN
F 2 "" H 4100 3050 50  0001 C CNN
F 3 "" H 4100 3050 50  0001 C CNN
	1    4100 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07005
U 1 1 5C5D1E96
P 4600 3050
F 0 "#PWR07005" H 4600 2800 50  0001 C CNN
F 1 "GND" H 4605 2877 50  0000 C CNN
F 2 "" H 4600 3050 50  0001 C CNN
F 3 "" H 4600 3050 50  0001 C CNN
	1    4600 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07007
U 1 1 5C5D1F57
P 5500 3050
F 0 "#PWR07007" H 5500 2800 50  0001 C CNN
F 1 "GND" H 5505 2877 50  0000 C CNN
F 2 "" H 5500 3050 50  0001 C CNN
F 3 "" H 5500 3050 50  0001 C CNN
	1    5500 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07001
U 1 1 5C5D25AE
P 3800 3050
F 0 "#PWR07001" H 3800 2800 50  0001 C CNN
F 1 "GND" H 3805 2877 50  0000 C CNN
F 2 "" H 3800 3050 50  0001 C CNN
F 3 "" H 3800 3050 50  0001 C CNN
	1    3800 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 2650 3800 2650
Wire Wire Line
	3800 2650 3800 2750
Wire Wire Line
	3700 2750 3800 2750
Connection ~ 3800 2750
Wire Wire Line
	3800 2750 3800 2850
Wire Wire Line
	3700 2850 3800 2850
Connection ~ 3800 2850
Wire Wire Line
	3800 2850 3800 3050
Wire Wire Line
	4100 2850 4100 3050
Wire Wire Line
	4600 2850 4600 3050
Wire Wire Line
	5500 2850 5500 3050
Wire Wire Line
	2800 2650 2550 2650
Wire Wire Line
	2800 3950 2600 3950
$Comp
L Device:C C7002
U 1 1 5C606F07
P 4100 4000
F 0 "C7002" H 4215 4046 50  0000 L CNN
F 1 "0.47u" H 4215 3955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4138 3850 50  0001 C CNN
F 3 "~" H 4100 4000 50  0001 C CNN
	1    4100 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7004
U 1 1 5C606F13
P 4600 4000
F 0 "C7004" H 4715 4046 50  0000 L CNN
F 1 "4.7u" H 4715 3955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4638 3850 50  0001 C CNN
F 3 "~" H 4600 4000 50  0001 C CNN
	1    4600 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7006
U 1 1 5C606F19
P 5500 4000
F 0 "C7006" H 5615 4046 50  0000 L CNN
F 1 "4.7u" H 5615 3955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5538 3850 50  0001 C CNN
F 3 "~" H 5500 4000 50  0001 C CNN
	1    5500 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 3750 4100 3750
Wire Wire Line
	4100 3750 4100 3850
Wire Wire Line
	4600 3750 4600 3850
Wire Wire Line
	4600 3750 4900 3750
Wire Wire Line
	5200 3750 5500 3750
Wire Wire Line
	5500 3750 5500 3850
Wire Wire Line
	5500 3750 5500 3650
Connection ~ 5500 3750
Wire Wire Line
	4100 3750 4600 3750
Connection ~ 4100 3750
Connection ~ 4600 3750
$Comp
L power:GND #PWR07004
U 1 1 5C606F2A
P 4100 4350
F 0 "#PWR07004" H 4100 4100 50  0001 C CNN
F 1 "GND" H 4105 4177 50  0000 C CNN
F 2 "" H 4100 4350 50  0001 C CNN
F 3 "" H 4100 4350 50  0001 C CNN
	1    4100 4350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07006
U 1 1 5C606F30
P 4600 4350
F 0 "#PWR07006" H 4600 4100 50  0001 C CNN
F 1 "GND" H 4605 4177 50  0000 C CNN
F 2 "" H 4600 4350 50  0001 C CNN
F 3 "" H 4600 4350 50  0001 C CNN
	1    4600 4350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07008
U 1 1 5C606F36
P 5500 4350
F 0 "#PWR07008" H 5500 4100 50  0001 C CNN
F 1 "GND" H 5505 4177 50  0000 C CNN
F 2 "" H 5500 4350 50  0001 C CNN
F 3 "" H 5500 4350 50  0001 C CNN
	1    5500 4350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07002
U 1 1 5C606F3C
P 3800 4350
F 0 "#PWR07002" H 3800 4100 50  0001 C CNN
F 1 "GND" H 3805 4177 50  0000 C CNN
F 2 "" H 3800 4350 50  0001 C CNN
F 3 "" H 3800 4350 50  0001 C CNN
	1    3800 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 3950 3800 3950
Wire Wire Line
	3800 3950 3800 4050
Wire Wire Line
	3700 4050 3800 4050
Connection ~ 3800 4050
Wire Wire Line
	3800 4050 3800 4150
Wire Wire Line
	3700 4150 3800 4150
Connection ~ 3800 4150
Wire Wire Line
	3800 4150 3800 4350
Wire Wire Line
	4100 4150 4100 4350
Wire Wire Line
	4600 4150 4600 4350
Wire Wire Line
	5500 4150 5500 4350
Wire Wire Line
	3700 3850 3800 3850
Wire Wire Line
	3800 3850 3800 3950
Connection ~ 3800 3950
$Comp
L power:+3V3 #PWR0175
U 1 1 5D8191B5
P 5500 2350
F 0 "#PWR0175" H 5500 2200 50  0001 C CNN
F 1 "+3V3" H 5515 2523 50  0000 C CNN
F 2 "" H 5500 2350 50  0001 C CNN
F 3 "" H 5500 2350 50  0001 C CNN
	1    5500 2350
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0176
U 1 1 5D819925
P 5500 3650
F 0 "#PWR0176" H 5500 3500 50  0001 C CNN
F 1 "+3V3" H 5515 3823 50  0000 C CNN
F 2 "" H 5500 3650 50  0001 C CNN
F 3 "" H 5500 3650 50  0001 C CNN
	1    5500 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:Ferrite_Bead FB7002
U 1 1 5C606F0D
P 5050 3750
F 0 "FB7002" V 4776 3750 50  0000 C CNN
F 1 "Ferrite_Bead" V 4867 3750 50  0000 C CNN
F 2 "Inductor_SMD:L_0402_1005Metric" V 4980 3750 50  0001 C CNN
F 3 "~" H 5050 3750 50  0001 C CNN
	1    5050 3750
	0    1    1    0   
$EndComp
$EndSCHEMATC
