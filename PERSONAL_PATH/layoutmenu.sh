#!/bin/sh

cat << EOF |xmenu
[]= flextile(SPLIT_VERTICAL|TOP_TO_BOTTOM |TOP_TO_BOTTOM)                           	0
><> Floating Layout                                                                 	1
[M] flextile(NO_SPLIT|MONOCLE |MONOCLE)                                             	2
||| flextile(SPLIT_VERTICAL|LEFT_TO_RIGHT |TOP_TO_BOTTOM)                           	3
>M> flextile(FLOATING_MASTER |LEFT_TO_RIGHT |LEFT_TO_RIGHT)                         	4
[D] flextile(SPLIT_VERTICAL|TOP_TO_BOTTOM |MONOCLE)                                 	5
TTT flextile(SPLIT_HORIZONTAL|LEFT_TO_RIGHT |LEFT_TO_RIGHT)                         	6
=== flextile(SPLIT_HORIZONTAL|LEFT_TO_RIGHT |TOP_TO_BOTTOM)                         	7
|M| flextile(SPLIT_CENTERED_VERTICAL |LEFT_TO_RIGHT |TOP_TO_BOTTOM |TOP_TO_BOTTOM)  	8
-M- flextile(SPLIT_CENTERED_HORIZONTAL |TOP_TO_BOTTOM |LEFT_TO_RIGHT |LEFT_TO_RIGHT)	9
::: flextile(NO_SPLIT|GAPPLESSGRID|GAPPLESSGRID)                                    	10
[\\]flextile(NO_SPLIT|DWINDLE |DWINDLE)                                             	11
(@) flextile(NO_SPLIT|SPIRAL|SPIRAL)                                                	12
[T] flextile(SPLIT_VERTICAL|LEFT_TO_RIGHT |TATAMI)                                  	13
[]= tile                                                                            	14
[M] monocle                                                                         	15
HHH horizgrid                                                                       	16
EOF
