#!/bin/sh
Xvfb :99 -screen 0 1280x800x24 -nolisten tcp >/dev/null 2>&1 &
export DISPLAY=:99
sleep 1
exec lucidadl "$@"
