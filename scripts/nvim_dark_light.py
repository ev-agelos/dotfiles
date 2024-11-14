#!/bin/python3

import fcntl
import termios
import subprocess
import sys

ESC="\x1B"
ENTER="\x0D"

if len(sys.argv) == 1 or sys.argv[1] not in ("dark", "light"):
    sys.exit(1)

background=sys.argv[1]
colorschemes={"dark": "silenthill", "light": "adwaita"}

for pid in subprocess.run(["pidof nvim"], shell=True, capture_output=True).stdout.decode().split():
    with open(f'/proc/{pid}/fd/0', 'w') as fd:
        for char in f"{ESC}:set background={background}{ENTER}:colorscheme {colorschemes[background]}{ENTER}":
            fcntl.ioctl(fd, termios.TIOCSTI, char)
