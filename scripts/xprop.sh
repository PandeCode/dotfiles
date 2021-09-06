#!/bin/env bash

DISPLAY=:0 dunstify $(xprop | grep -i 'class')
