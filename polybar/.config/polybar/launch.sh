#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

MONITOR=$(polybar -m|head -1|sed -e 's/:.*$//g') polybar my_bar &

echo "Bars launched..."
