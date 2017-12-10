#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

export MONITOR=$(polybar -m|tail -1|sed -e 's/:.*$//g')

# Launch bar
polybar example

echo "Bars launched..."
