#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

MONITOR=$(xrandr -q | grep " connected" | head -1 | cut -d ' ' -f1) polybar my_bar &

echo "Bars launched..."
