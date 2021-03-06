EESchema Schematic File Version 4
LIBS:integrated-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 8 14
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
L Device:C C?
U 1 1 5D688D57
P 2450 2300
AR Path="/5D33C751/5D688D57" Ref="C?"  Part="1" 
AR Path="/5D688380/5D688D57" Ref="C8002"  Part="1" 
F 0 "C8002" H 2565 2346 50  0000 L CNN
F 1 "B32922C3224M189" H 2565 2255 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L18.0mm_W7.0mm_P15.00mm_FKS3_FKP3" H 2488 2150 50  0001 C CNN
F 3 "~" H 2450 2300 50  0001 C CNN
	1    2450 2300
	1    0    0    -1  
$EndComp
$Comp
L Device:Fuse F?
U 1 1 5D688D7A
P 1550 2100
AR Path="/5D33C751/5D688D7A" Ref="F?"  Part="1" 
AR Path="/5D688380/5D688D7A" Ref="F8001"  Part="1" 
F 0 "F8001" V 1353 2100 50  0000 C CNN
F 1 "Fuse" V 1444 2100 50  0000 C CNN
F 2 "Fuse:Fuseholder_Cylinder-5x20mm_Schurter_0031_8201_Horizontal_Open" V 1480 2100 50  0001 C CNN
F 3 "~" H 1550 2100 50  0001 C CNN
	1    1550 2100
	0    1    1    0   
$EndComp
Wire Wire Line
	1150 2100 1400 2100
Wire Wire Line
	2450 2100 2450 2150
Wire Wire Line
	1950 2950 2450 2950
$Comp
L Device:C C?
U 1 1 5D688D9E
P 5100 2500
AR Path="/5D33C751/5D688D9E" Ref="C?"  Part="1" 
AR Path="/5D688380/5D688D9E" Ref="C8008"  Part="1" 
F 0 "C8008" H 5215 2546 50  0000 L CNN
F 1 "C4AQLBU5100A1XK" H 5100 2800 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L33.0mm_W13.0mm_P27.50mm_MKS4" H 5138 2350 50  0001 C CNN
F 3 "~" H 5100 2500 50  0001 C CNN
	1    5100 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 2100 5100 2350
$Comp
L power:GNDPWR #PWR?
U 1 1 5D688DA9
P 5100 3050
AR Path="/5D33C751/5D688DA9" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5D688DA9" Ref="#PWR08010"  Part="1" 
F 0 "#PWR08010" H 5100 2850 50  0001 C CNN
F 1 "GNDPWR" H 5104 2896 50  0000 C CNN
F 2 "" H 5100 3000 50  0001 C CNN
F 3 "" H 5100 3000 50  0001 C CNN
	1    5100 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 2650 5100 3050
Text GLabel 1450 4750 0    50   Input ~ 0
CHARGE_SW
$Comp
L Device:R R?
U 1 1 5D8E4443
P 9700 2750
AR Path="/5D68A538/5D8E4443" Ref="R?"  Part="1" 
AR Path="/5D688380/5D8E4443" Ref="R8007"  Part="1" 
F 0 "R8007" H 9770 2796 50  0000 L CNN
F 1 "470k" H 9770 2705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9630 2750 50  0001 C CNN
F 3 "~" H 9700 2750 50  0001 C CNN
	1    9700 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5D8E4458
P 9700 3150
AR Path="/5D68A538/5D8E4458" Ref="R?"  Part="1" 
AR Path="/5D688380/5D8E4458" Ref="R8010"  Part="1" 
F 0 "R8010" H 9770 3196 50  0000 L CNN
F 1 "470k" H 9770 3105 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9630 3150 50  0001 C CNN
F 3 "~" H 9700 3150 50  0001 C CNN
	1    9700 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5D8E446D
P 9700 3750
AR Path="/5D68A538/5D8E446D" Ref="R?"  Part="1" 
AR Path="/5D688380/5D8E446D" Ref="R8011"  Part="1" 
F 0 "R8011" H 9770 3796 50  0000 L CNN
F 1 "3.16k" H 9770 3705 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 9630 3750 50  0001 C CNN
F 3 "~" H 9700 3750 50  0001 C CNN
	1    9700 3750
	1    0    0    -1  
$EndComp
Connection ~ 9700 3500
Wire Wire Line
	9700 3500 9700 3600
$Comp
L power:GNDPWR #PWR?
U 1 1 5D8E448F
P 9700 4150
AR Path="/5D68A538/5D8E448F" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5D8E448F" Ref="#PWR08013"  Part="1" 
F 0 "#PWR08013" H 9700 3950 50  0001 C CNN
F 1 "GNDPWR" H 9704 3996 50  0000 C CNN
F 2 "" H 9700 4100 50  0001 C CNN
F 3 "" H 9700 4100 50  0001 C CNN
	1    9700 4150
	1    0    0    -1  
$EndComp
Text Label 9700 2500 0    50   ~ 0
VIN
Wire Wire Line
	9700 2500 9700 2600
Text GLabel 10150 3500 2    50   Input ~ 0
VIN_SENSE
Wire Wire Line
	9700 3300 9700 3500
$Comp
L Device:Q_NMOS_GDS Q8001
U 1 1 5D7881AC
P 3550 2450
F 0 "Q8001" H 3755 2496 50  0000 L CNN
F 1 "STW40N65M2" H 3755 2405 50  0000 L CNN
F 2 "wbraun_smd:TO-247_3_horizontal_under" H 3750 2550 50  0001 C CNN
F 3 "~" H 3550 2450 50  0001 C CNN
	1    3550 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8014
U 1 1 5D791AF7
P 4400 2350
F 0 "R8014" H 4470 2396 50  0000 L CNN
F 1 "470" H 4470 2305 50  0000 L CNN
F 2 "wbraun_smd:TO-247_2_horizontal_under" V 4330 2350 50  0001 C CNN
F 3 "~" H 4400 2350 50  0001 C CNN
	1    4400 2350
	-1   0    0    1   
$EndComp
Wire Wire Line
	4400 2100 4400 2200
Wire Wire Line
	3650 2100 4400 2100
Wire Wire Line
	3650 2100 3650 2250
Wire Wire Line
	3650 2650 3650 2750
Wire Wire Line
	3650 2750 4400 2750
Wire Wire Line
	4400 2750 4400 2500
Wire Wire Line
	9700 3900 9700 4150
Text GLabel 5100 1950 1    50   Input ~ 0
VIN
$Comp
L Device:D IDWD10G120C5XKSA1
U 1 1 5DB78EFD
P 8050 2100
F 0 "IDWD10G120C5XKSA1" H 7650 1900 50  0000 L CNN
F 1 "D" H 8150 2200 50  0000 L CNN
F 2 "wbraun_smd:TO-247_2_horizontal_under" H 8050 2100 50  0001 C CNN
F 3 "~" H 8050 2100 50  0001 C CNN
	1    8050 2100
	-1   0    0    1   
$EndComp
$Comp
L Device:Q_NMOS_GDS Q8003
U 1 1 5DB8754A
P 7350 2650
F 0 "Q8003" H 7555 2696 50  0000 L CNN
F 1 "STW40N65M2" H 7555 2605 50  0000 L CNN
F 2 "wbraun_smd:TO-247_3_horizontal_under" H 7550 2750 50  0001 C CNN
F 3 "~" H 7350 2650 50  0001 C CNN
	1    7350 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR?
U 1 1 5DB87DF6
P 2450 3000
AR Path="/5D33C751/5DB87DF6" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DB87DF6" Ref="#PWR0180"  Part="1" 
F 0 "#PWR0180" H 2450 2800 50  0001 C CNN
F 1 "GNDPWR" H 2454 2846 50  0000 C CNN
F 2 "" H 2450 2950 50  0001 C CNN
F 3 "" H 2450 2950 50  0001 C CNN
	1    2450 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR?
U 1 1 5DB9E014
P 7450 3050
AR Path="/5D33C751/5DB9E014" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DB9E014" Ref="#PWR0181"  Part="1" 
F 0 "#PWR0181" H 7450 2850 50  0001 C CNN
F 1 "GNDPWR" H 7454 2896 50  0000 C CNN
F 2 "" H 7450 3000 50  0001 C CNN
F 3 "" H 7450 3000 50  0001 C CNN
	1    7450 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 1950 5100 2100
Connection ~ 2450 2100
Wire Wire Line
	4400 2750 4700 2750
Wire Wire Line
	4700 2750 4700 2100
Wire Wire Line
	4700 2100 5100 2100
Connection ~ 4400 2750
Wire Wire Line
	1700 2100 2450 2100
Text GLabel 6150 3200 3    50   Input ~ 0
IL_ZERO
Text GLabel 6050 3200 3    50   Input ~ 0
IL_SENSE
$Comp
L power:GND #PWR08012
U 1 1 5D81BE69
P 6550 3200
F 0 "#PWR08012" H 6550 2950 50  0001 C CNN
F 1 "GND" H 6555 3027 50  0000 C CNN
F 2 "" H 6550 3200 50  0001 C CNN
F 3 "" H 6550 3200 50  0001 C CNN
	1    6550 3200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6350 3100 6350 3300
Wire Wire Line
	6450 3200 6550 3200
Wire Wire Line
	6450 3100 6450 3200
Wire Wire Line
	6150 3100 6150 3200
Wire Wire Line
	6050 3100 6050 3200
Connection ~ 6350 2250
Wire Wire Line
	6350 2250 6350 2100
Wire Wire Line
	6450 2250 6450 2300
Wire Wire Line
	6350 2250 6450 2250
Wire Wire Line
	6350 2300 6350 2250
Wire Wire Line
	6150 2250 6150 2300
Wire Wire Line
	6050 2250 6150 2250
Wire Wire Line
	6050 2250 6050 2300
$Comp
L wbraun_ic_lib:ACS730 U8003
U 1 1 5D7E3008
P 6250 2700
F 0 "U8003" H 6250 3165 50  0000 C CNN
F 1 "ACS730KLCTR-20AB-T" H 6250 3074 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 5950 2800 50  0001 C CNN
F 3 "" H 5950 2800 50  0001 C CNN
	1    6250 2700
	0    -1   1    0   
$EndComp
$Comp
L Device:L L?
U 1 1 5D688D6C
P 6750 2100
AR Path="/5D33C751/5D688D6C" Ref="L?"  Part="1" 
AR Path="/5D688380/5D688D6C" Ref="L8002"  Part="1" 
F 0 "L8002" V 6940 2100 50  0000 C CNN
F 1 "L" V 6849 2100 50  0000 C CNN
F 2 "wbraun_smd:T157-Vertical" H 6750 2100 50  0001 C CNN
F 3 "~" H 6750 2100 50  0001 C CNN
	1    6750 2100
	0    -1   -1   0   
$EndComp
$Comp
L wbraun_ic_lib:UCC5350SB U?
U 1 1 5DC0C4B1
P 4350 6050
AR Path="/5D68A538/5DC0C4B1" Ref="U?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC0C4B1" Ref="U?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC0C4B1" Ref="U?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC0C4B1" Ref="U?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC0C4B1" Ref="U?"  Part="1" 
AR Path="/5D688380/5DC0C4B1" Ref="U8002"  Part="1" 
F 0 "U8002" H 4350 6465 50  0000 C CNN
F 1 "UCC5390SC" H 4350 6374 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 4000 6100 50  0001 C CNN
F 3 "" H 4000 6100 50  0001 C CNN
	1    4350 6050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5DC0C4C3
P 5300 6000
AR Path="/5D68A538/5DC0C4C3" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC0C4C3" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC0C4C3" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC0C4C3" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC0C4C3" Ref="R?"  Part="1" 
AR Path="/5D688380/5DC0C4C3" Ref="R8005"  Part="1" 
F 0 "R8005" V 5093 6000 50  0000 C CNN
F 1 "4.7" V 5184 6000 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5230 6000 50  0001 C CNN
F 3 "~" H 5300 6000 50  0001 C CNN
	1    5300 6000
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5DC0C4C9
P 5300 6150
AR Path="/5D68A538/5DC0C4C9" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC0C4C9" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC0C4C9" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC0C4C9" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC0C4C9" Ref="R?"  Part="1" 
AR Path="/5D688380/5DC0C4C9" Ref="R8006"  Part="1" 
F 0 "R8006" V 5500 6250 50  0000 C CNN
F 1 "4.7" V 5400 6150 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 5230 6150 50  0001 C CNN
F 3 "~" H 5300 6150 50  0001 C CNN
	1    5300 6150
	0    1    1    0   
$EndComp
Wire Wire Line
	4800 5900 4900 5900
Wire Wire Line
	4900 5900 4900 5750
Wire Wire Line
	4800 6000 5150 6000
Wire Wire Line
	4800 6100 5100 6100
Wire Wire Line
	5100 6100 5100 6150
Wire Wire Line
	5100 6150 5150 6150
Wire Wire Line
	4800 6200 4900 6200
Wire Wire Line
	4900 6200 4900 6300
Wire Wire Line
	3900 5900 3800 5900
Wire Wire Line
	3800 5900 3800 5800
Wire Wire Line
	3900 6200 3800 6200
Wire Wire Line
	3800 6200 3800 6300
$Comp
L power:GND #PWR?
U 1 1 5DC0C4DB
P 3800 6300
AR Path="/5D68A538/5DC0C4DB" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC0C4DB" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC0C4DB" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC0C4DB" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC0C4DB" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DC0C4DB" Ref="#PWR0182"  Part="1" 
F 0 "#PWR0182" H 3800 6050 50  0001 C CNN
F 1 "GND" H 3805 6127 50  0000 C CNN
F 2 "" H 3800 6300 50  0001 C CNN
F 3 "" H 3800 6300 50  0001 C CNN
	1    3800 6300
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5DC0C4E1
P 3800 5800
AR Path="/5D68A538/5DC0C4E1" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC0C4E1" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC0C4E1" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC0C4E1" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC0C4E1" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DC0C4E1" Ref="#PWR0183"  Part="1" 
F 0 "#PWR0183" H 3800 5650 50  0001 C CNN
F 1 "+3V3" H 3815 5973 50  0000 C CNN
F 2 "" H 3800 5800 50  0001 C CNN
F 3 "" H 3800 5800 50  0001 C CNN
	1    3800 5800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5DC0C4E7
P 3550 6200
AR Path="/5D68A538/5DC0C4E7" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC0C4E7" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC0C4E7" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC0C4E7" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC0C4E7" Ref="R?"  Part="1" 
AR Path="/5D688380/5DC0C4E7" Ref="R8004"  Part="1" 
F 0 "R8004" H 3750 6150 50  0000 R CNN
F 1 "4.7K" H 3800 6250 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 3480 6200 50  0001 C CNN
F 3 "~" H 3550 6200 50  0001 C CNN
	1    3550 6200
	-1   0    0    1   
$EndComp
Wire Wire Line
	3900 6100 3800 6100
Wire Wire Line
	3800 6100 3800 6200
Connection ~ 3800 6200
$Comp
L power:GND #PWR?
U 1 1 5DC0C4F0
P 3550 6450
AR Path="/5D68A538/5DC0C4F0" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC0C4F0" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC0C4F0" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC0C4F0" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC0C4F0" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DC0C4F0" Ref="#PWR0184"  Part="1" 
F 0 "#PWR0184" H 3550 6200 50  0001 C CNN
F 1 "GND" H 3555 6277 50  0000 C CNN
F 2 "" H 3550 6450 50  0001 C CNN
F 3 "" H 3550 6450 50  0001 C CNN
	1    3550 6450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 6000 3550 6000
Wire Wire Line
	3550 6000 3550 6050
Wire Wire Line
	3550 6350 3550 6450
Wire Wire Line
	3550 6000 3400 6000
Connection ~ 3550 6000
Wire Wire Line
	5450 6000 5550 6000
Wire Wire Line
	5550 6000 5550 6150
Wire Wire Line
	5550 6150 5450 6150
Wire Wire Line
	5550 6000 5750 6000
Connection ~ 5550 6000
$Comp
L Device:Ferrite_Bead_Small FB?
U 1 1 5DC0C50B
P 5850 6000
AR Path="/5D68A538/5D62FC9C/5DC0C50B" Ref="FB?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC0C50B" Ref="FB?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC0C50B" Ref="FB?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC0C50B" Ref="FB?"  Part="1" 
AR Path="/5D688380/5DC0C50B" Ref="FB8001"  Part="1" 
F 0 "FB8001" V 5613 6000 50  0000 C CNN
F 1 "Ferrite_Bead_Small" V 5704 6000 50  0000 C CNN
F 2 "Inductor_SMD:L_0805_2012Metric" V 5780 6000 50  0001 C CNN
F 3 "~" H 5850 6000 50  0001 C CNN
	1    5850 6000
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5DC0C511
P 6100 6200
AR Path="/5D68A538/5DC0C511" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC0C511" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC0C511" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC0C511" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC0C511" Ref="R?"  Part="1" 
AR Path="/5D688380/5DC0C511" Ref="R8013"  Part="1" 
F 0 "R8013" H 6300 6150 50  0000 R CNN
F 1 "4.7K" H 6350 6250 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 6030 6200 50  0001 C CNN
F 3 "~" H 6100 6200 50  0001 C CNN
	1    6100 6200
	-1   0    0    1   
$EndComp
Wire Wire Line
	5950 6000 6100 6000
Wire Wire Line
	6100 6000 6100 6050
Wire Wire Line
	2450 2100 3650 2100
Connection ~ 3650 2100
Wire Wire Line
	3350 2450 3250 2450
Wire Wire Line
	3650 2750 3250 2750
Connection ~ 3650 2750
Wire Wire Line
	5100 2100 6050 2100
Wire Wire Line
	6050 2100 6050 2250
Connection ~ 5100 2100
Connection ~ 6050 2250
Wire Wire Line
	7450 2100 7450 2450
Wire Wire Line
	7150 2650 7050 2650
Wire Wire Line
	7450 2850 7450 3050
Wire Wire Line
	7450 2100 7900 2100
Connection ~ 7450 2100
Wire Wire Line
	6900 2100 7450 2100
Wire Wire Line
	6350 2100 6600 2100
Wire Wire Line
	2450 2950 2450 3000
$Comp
L wbraun_ic_lib:VOM1271 U8001
U 1 1 5DC55095
P 3100 4300
F 0 "U8001" H 3100 4665 50  0000 C CNN
F 1 "VOM1271" H 3100 4574 50  0000 C CNN
F 2 "Package_SO:SO-4_4.4x4.3mm_P2.54mm" H 2800 4400 50  0001 C CNN
F 3 "" H 2800 4400 50  0001 C CNN
	1    3100 4300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DC55C93
P 2550 5250
AR Path="/5D68A538/5DC55C93" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC55C93" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC55C93" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC55C93" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC55C93" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DC55C93" Ref="#PWR0185"  Part="1" 
F 0 "#PWR0185" H 2550 5000 50  0001 C CNN
F 1 "GND" H 2555 5077 50  0000 C CNN
F 2 "" H 2550 5250 50  0001 C CNN
F 3 "" H 2550 5250 50  0001 C CNN
	1    2550 5250
	1    0    0    -1  
$EndComp
$Comp
L Transistor_FET:2N7002 Q8002
U 1 1 5DC56CB5
P 2450 4750
F 0 "Q8002" H 2656 4796 50  0000 L CNN
F 1 "FDV301N" H 2656 4705 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2650 4675 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N7002.pdf" H 2450 4750 50  0001 L CNN
	1    2450 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5DC60F3D
P 2050 5000
AR Path="/5D68A538/5DC60F3D" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC60F3D" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC60F3D" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC60F3D" Ref="R?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC60F3D" Ref="R?"  Part="1" 
AR Path="/5D688380/5DC60F3D" Ref="R8002"  Part="1" 
F 0 "R8002" H 2250 4950 50  0000 R CNN
F 1 "4.7K" H 2300 5050 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 1980 5000 50  0001 C CNN
F 3 "~" H 2050 5000 50  0001 C CNN
	1    2050 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8001
U 1 1 5DC62268
P 1750 4750
F 0 "R8001" V 1543 4750 50  0000 C CNN
F 1 "100" V 1634 4750 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 1680 4750 50  0001 C CNN
F 3 "~" H 1750 4750 50  0001 C CNN
	1    1750 4750
	0    1    1    0   
$EndComp
$Comp
L Device:R R8003
U 1 1 5DC62868
P 2400 4200
F 0 "R8003" V 2193 4200 50  0000 C CNN
F 1 "100" V 2284 4200 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2330 4200 50  0001 C CNN
F 3 "~" H 2400 4200 50  0001 C CNN
	1    2400 4200
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DC6369B
P 2050 5250
AR Path="/5D68A538/5DC6369B" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC6369B" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC6369B" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC6369B" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC6369B" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DC6369B" Ref="#PWR0186"  Part="1" 
F 0 "#PWR0186" H 2050 5000 50  0001 C CNN
F 1 "GND" H 2055 5077 50  0000 C CNN
F 2 "" H 2050 5250 50  0001 C CNN
F 3 "" H 2050 5250 50  0001 C CNN
	1    2050 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 4200 2700 4200
Wire Wire Line
	2700 4400 2550 4400
Wire Wire Line
	2550 4400 2550 4550
Wire Wire Line
	2250 4750 2050 4750
Wire Wire Line
	2050 4750 2050 4850
Connection ~ 2050 4750
Wire Wire Line
	2050 4750 1900 4750
Wire Wire Line
	2050 5150 2050 5250
Wire Wire Line
	2550 4950 2550 5250
Wire Wire Line
	1600 4750 1450 4750
$Comp
L power:+3V3 #PWR?
U 1 1 5DC773C7
P 2150 4100
AR Path="/5D68A538/5DC773C7" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DC773C7" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640666/5DC773C7" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640674/5DC773C7" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640682/5DC773C7" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DC773C7" Ref="#PWR0187"  Part="1" 
F 0 "#PWR0187" H 2150 3950 50  0001 C CNN
F 1 "+3V3" H 2165 4273 50  0000 C CNN
F 2 "" H 2150 4100 50  0001 C CNN
F 3 "" H 2150 4100 50  0001 C CNN
	1    2150 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2150 4100 2150 4200
Wire Wire Line
	2150 4200 2250 4200
Wire Wire Line
	3500 4400 3600 4400
Wire Wire Line
	3500 4200 3600 4200
Text Label 3250 2450 2    50   ~ 0
G1
Text Label 3250 2750 2    50   ~ 0
S1
$Comp
L power:GNDPWR #PWR?
U 1 1 5DC82725
P 6100 6550
AR Path="/5D33C751/5DC82725" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DC82725" Ref="#PWR0188"  Part="1" 
F 0 "#PWR0188" H 6100 6350 50  0001 C CNN
F 1 "GNDPWR" H 6104 6396 50  0000 C CNN
F 2 "" H 6100 6500 50  0001 C CNN
F 3 "" H 6100 6500 50  0001 C CNN
	1    6100 6550
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR?
U 1 1 5DC830C9
P 4900 6300
AR Path="/5D33C751/5DC830C9" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DC830C9" Ref="#PWR0189"  Part="1" 
F 0 "#PWR0189" H 4900 6100 50  0001 C CNN
F 1 "GNDPWR" H 4904 6146 50  0000 C CNN
F 2 "" H 4900 6250 50  0001 C CNN
F 3 "" H 4900 6250 50  0001 C CNN
	1    4900 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 6350 6100 6550
Wire Wire Line
	6100 6000 6300 6000
Connection ~ 6100 6000
Text Label 6300 6000 0    50   ~ 0
G2
Text Label 7050 2650 2    50   ~ 0
G2
Text GLabel 4700 4800 0    50   Input ~ 0
DRIVE_AUX+
$Comp
L Device:C C8001
U 1 1 5DCB7F60
P 5000 5000
F 0 "C8001" H 5115 5046 50  0000 L CNN
F 1 "4.7u" H 5115 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 5038 4850 50  0001 C CNN
F 3 "~" H 5000 5000 50  0001 C CNN
	1    5000 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8004
U 1 1 5DCB8D08
P 5450 5000
F 0 "C8004" H 5565 5046 50  0000 L CNN
F 1 "0.47u" H 5565 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 5488 4850 50  0001 C CNN
F 3 "~" H 5450 5000 50  0001 C CNN
	1    5450 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 5200 5000 5200
Wire Wire Line
	5000 5200 5000 5150
Wire Wire Line
	5000 5200 5450 5200
Wire Wire Line
	5450 5200 5450 5150
Connection ~ 5000 5200
Wire Wire Line
	4700 4800 5000 4800
Wire Wire Line
	5000 4800 5000 4850
Wire Wire Line
	5000 4800 5450 4800
Wire Wire Line
	5450 4800 5450 4850
Connection ~ 5000 4800
Wire Wire Line
	5450 4800 5450 4700
Connection ~ 5450 4800
Wire Wire Line
	5450 5200 5450 5300
Connection ~ 5450 5200
$Comp
L power:GNDPWR #PWR?
U 1 1 5DCD45A6
P 5450 5300
AR Path="/5D33C751/5DCD45A6" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DCD45A6" Ref="#PWR0190"  Part="1" 
F 0 "#PWR0190" H 5450 5100 50  0001 C CNN
F 1 "GNDPWR" H 5454 5146 50  0000 C CNN
F 2 "" H 5450 5250 50  0001 C CNN
F 3 "" H 5450 5250 50  0001 C CNN
	1    5450 5300
	1    0    0    -1  
$EndComp
Text Label 5450 4700 0    50   ~ 0
Vgd
Text Label 4900 5750 0    50   ~ 0
Vgd
Text Label 3600 4200 0    50   ~ 0
G1
Text Label 3600 4400 0    50   ~ 0
S1
Text GLabel 8450 2100 2    50   Input ~ 0
VBUS
Wire Wire Line
	8200 2100 8450 2100
Text GLabel 4700 5200 0    50   Input ~ 0
PWRGND
Wire Wire Line
	2450 2450 2450 2950
Connection ~ 2450 2950
$Comp
L Device:C C8003
U 1 1 5DD6FE1D
P 3350 5350
F 0 "C8003" H 3465 5396 50  0000 L CNN
F 1 "0.47u" H 3465 5305 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3388 5200 50  0001 C CNN
F 3 "~" H 3350 5350 50  0001 C CNN
	1    3350 5350
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5DD7BF85
P 3350 5100
AR Path="/5D68A538/5DD7BF85" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DD7BF85" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640666/5DD7BF85" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640674/5DD7BF85" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640682/5DD7BF85" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DD7BF85" Ref="#PWR0101"  Part="1" 
F 0 "#PWR0101" H 3350 4950 50  0001 C CNN
F 1 "+3V3" H 3365 5273 50  0000 C CNN
F 2 "" H 3350 5100 50  0001 C CNN
F 3 "" H 3350 5100 50  0001 C CNN
	1    3350 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DD7C802
P 3350 5600
AR Path="/5D68A538/5DD7C802" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DD7C802" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640666/5DD7C802" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640674/5DD7C802" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640682/5DD7C802" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DD7C802" Ref="#PWR0191"  Part="1" 
F 0 "#PWR0191" H 3350 5350 50  0001 C CNN
F 1 "GND" H 3355 5427 50  0000 C CNN
F 2 "" H 3350 5600 50  0001 C CNN
F 3 "" H 3350 5600 50  0001 C CNN
	1    3350 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 5500 3350 5600
Wire Wire Line
	3350 5100 3350 5200
Wire Wire Line
	9700 2900 9700 3000
Wire Wire Line
	9700 3500 10150 3500
$Comp
L Device:C C8005
U 1 1 5DDD7615
P 6750 3900
F 0 "C8005" H 6865 3946 50  0000 L CNN
F 1 "0.47u" H 6865 3855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6788 3750 50  0001 C CNN
F 3 "~" H 6750 3900 50  0001 C CNN
	1    6750 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DDD7621
P 6750 4150
AR Path="/5D68A538/5DDD7621" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D62FC9C/5DDD7621" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640666/5DDD7621" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640674/5DDD7621" Ref="#PWR?"  Part="1" 
AR Path="/5D68A538/5D640682/5DDD7621" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DDD7621" Ref="#PWR0192"  Part="1" 
F 0 "#PWR0192" H 6750 3900 50  0001 C CNN
F 1 "GND" H 6755 3977 50  0000 C CNN
F 2 "" H 6750 4150 50  0001 C CNN
F 3 "" H 6750 4150 50  0001 C CNN
	1    6750 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 4050 6750 4150
Wire Wire Line
	6750 3650 6750 3750
$Comp
L power:+5V #PWR08011
U 1 1 5D81BD93
P 6350 3300
F 0 "#PWR08011" H 6350 3150 50  0001 C CNN
F 1 "+5V" V 6365 3428 50  0000 L CNN
F 2 "" H 6350 3300 50  0001 C CNN
F 3 "" H 6350 3300 50  0001 C CNN
	1    6350 3300
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR0193
U 1 1 5DDDAA7B
P 6750 3650
F 0 "#PWR0193" H 6750 3500 50  0001 C CNN
F 1 "+5V" V 6765 3778 50  0000 L CNN
F 2 "" H 6750 3650 50  0001 C CNN
F 3 "" H 6750 3650 50  0001 C CNN
	1    6750 3650
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Female J8001
U 1 1 5DBE4336
P 950 2200
F 0 "J8001" H 842 2485 50  0000 C CNN
F 1 "Conn_01x03_Female" H 842 2394 50  0000 C CNN
F 2 "wbraun_smd:Terminal-block-plug_3x1_5mm-pitch" H 950 2200 50  0001 C CNN
F 3 "~" H 950 2200 50  0001 C CNN
	1    950  2200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1150 2200 1950 2200
Wire Wire Line
	1950 2200 1950 2950
Wire Wire Line
	1150 2300 1150 2500
$Comp
L power:Earth #PWR?
U 1 1 5DBEA1A2
P 1150 2500
AR Path="/5DBEA1A2" Ref="#PWR?"  Part="1" 
AR Path="/5D688380/5DBEA1A2" Ref="#PWR0129"  Part="1" 
F 0 "#PWR0129" H 1150 2250 50  0001 C CNN
F 1 "Earth" H 1150 2350 50  0001 C CNN
F 2 "" H 1150 2500 50  0001 C CNN
F 3 "~" H 1150 2500 50  0001 C CNN
	1    1150 2500
	1    0    0    -1  
$EndComp
Text GLabel 2450 2100 1    50   Input ~ 0
VLINK
Text GLabel 3400 6000 0    50   Input ~ 0
BOOST_SW
$EndSCHEMATC
