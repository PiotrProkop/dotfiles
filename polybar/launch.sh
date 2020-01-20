#!/usr/bin/env bash

# Terminate polybar
killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

echo "---" | tee -a /tmp/polybar1.log
echo "---" | tee -a /tmp/polybar2.log
polybar -c $HOME/.config/polybar/config.ini bar1 >> /tmp/polybar1.log 2>&1 &
polybar -c $HOME/.config/polybar/config.ini bar2 >> /tmp/polybar2.log 2>&1 &
