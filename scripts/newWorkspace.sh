#!/bin/env bash

Array1=( "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" )
Array2=$(i3-msg -t get_workspaces | sed 's/},{/\n/g' | awk -F, '{print $3}' | awk -F: '{print $2}' | sed "s/"//g" | sort -n) 
ws=$(echo ${Array1[@]} ${Array2[@]} | tr ' ' '\n' | sort -n | uniq -u | head -n 1) 
i3-msg workspace $ws
