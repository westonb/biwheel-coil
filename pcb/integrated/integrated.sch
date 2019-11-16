EESchema Schematic File Version 4
LIBS:integrated-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 14
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
S 950  3900 1000 1000
U 5D33C768
F0 "Control" 50
F1 "Control.sch" 50
$EndSheet
$Sheet
S 950  5500 1000 1000
U 5D688380
F0 "Power Input" 50
F1 "PoweInput.sch" 50
$EndSheet
$Sheet
S 950  2400 1000 1000
U 5D68A501
F0 "Power Rails" 50
F1 "PowerRails.sch" 50
$EndSheet
$Sheet
S 950  950  1000 1000
U 5D68A538
F0 "Inverter" 50
F1 "Inverter.sch" 50
$EndSheet
$Comp
L wbraun_ic_lib:mounting-hole-grounded J1001
U 1 1 5D77E7D7
P 6900 3600
F 0 "J1001" H 7178 3547 60  0000 L CNN
F 1 "mounting-hole-grounded" H 7178 3441 60  0000 L CNN
F 2 "wbraun_smd:M3-tight-fit-pan-head" H 6900 3600 60  0001 C CNN
F 3 "" H 6900 3600 60  0001 C CNN
	1    6900 3600
	1    0    0    -1  
$EndComp
$Comp
L wbraun_ic_lib:mounting-hole-grounded J1002
U 1 1 5D77E85E
P 5950 2100
F 0 "J1002" H 6228 2047 60  0000 L CNN
F 1 "mounting-hole-grounded" H 6228 1941 60  0000 L CNN
F 2 "wbraun_smd:M3-tight-fit-pan-head" H 5950 2100 60  0001 C CNN
F 3 "" H 5950 2100 60  0001 C CNN
	1    5950 2100
	1    0    0    -1  
$EndComp
$Comp
L wbraun_ic_lib:mounting-hole-grounded J1003
U 1 1 5D77E922
P 8450 3050
F 0 "J1003" H 8728 2997 60  0000 L CNN
F 1 "mounting-hole-grounded" H 8728 2891 60  0000 L CNN
F 2 "wbraun_smd:M3-tight-fit-pan-head" H 8450 3050 60  0001 C CNN
F 3 "" H 8450 3050 60  0001 C CNN
	1    8450 3050
	1    0    0    -1  
$EndComp
$Comp
L wbraun_ic_lib:mounting-hole-grounded J1004
U 1 1 5D77E956
P 7250 2100
F 0 "J1004" H 7528 2047 60  0000 L CNN
F 1 "mounting-hole-grounded" H 7528 1941 60  0000 L CNN
F 2 "wbraun_smd:M3-tight-fit-pan-head" H 7250 2100 60  0001 C CNN
F 3 "" H 7250 2100 60  0001 C CNN
	1    7250 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 2550 5300 2750
Wire Wire Line
	5300 2750 5950 2750
Wire Wire Line
	7250 2750 7250 2550
Wire Wire Line
	6600 2550 6600 2750
Connection ~ 6600 2750
Wire Wire Line
	6600 2750 7250 2750
Wire Wire Line
	5950 2550 5950 2750
Connection ~ 5950 2750
Wire Wire Line
	5950 2750 6600 2750
Wire Wire Line
	5300 2750 5300 2950
Connection ~ 5300 2750
$Comp
L power:Earth #PWR0105
U 1 1 5D77EA18
P 5300 2950
F 0 "#PWR0105" H 5300 2700 50  0001 C CNN
F 1 "Earth" H 5300 2800 50  0001 C CNN
F 2 "" H 5300 2950 50  0001 C CNN
F 3 "~" H 5300 2950 50  0001 C CNN
	1    5300 2950
	1    0    0    -1  
$EndComp
$Comp
L wbraun_ic_lib:mounting-hole-grounded J1005
U 1 1 5D8938B4
P 7900 2100
F 0 "J1005" H 8178 2047 60  0000 L CNN
F 1 "mounting-hole-grounded" H 8178 1941 60  0000 L CNN
F 2 "wbraun_smd:M3-tight-fit-pan-head" H 7900 2100 60  0001 C CNN
F 3 "" H 7900 2100 60  0001 C CNN
	1    7900 2100
	1    0    0    -1  
$EndComp
$Comp
L wbraun_ic_lib:mounting-hole-grounded J1006
U 1 1 5D8938BA
P 8550 2100
F 0 "J1006" H 8828 2047 60  0000 L CNN
F 1 "mounting-hole-grounded" H 8828 1941 60  0000 L CNN
F 2 "wbraun_smd:M3-tight-fit-pan-head" H 8550 2100 60  0001 C CNN
F 3 "" H 8550 2100 60  0001 C CNN
	1    8550 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 2550 7900 2750
Wire Wire Line
	7250 2750 7900 2750
$EndSCHEMATC
