#!/bin/env bash

playerctl metadata --format '{{status}}_{{playerName}}_{{position}}_{{volume}}_{{album}}_{{artist}}_{{title}}'
