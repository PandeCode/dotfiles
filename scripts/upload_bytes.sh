#!/bin/env sh

awk -f $DOTFILES/scripts/parse_bytes.awk /sys/class/net/wlo1/statistics/tx_bytes # Upload
