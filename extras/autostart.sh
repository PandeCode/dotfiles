#!/bin/bash
sudo -E chmod 777 /sys/class/backlight/intel_backlight/brightness
sudo sysctl dev.i915.perf_stream_paranoid=0
