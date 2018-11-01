#!/bin/sh
# Add a shortcut to this script, it can focus on the opened
# terminal rather than opening a new terminal window
if ps aux | grep "[x]-terminal-emulator" > /dev/null
then xdotool windowactivate $(xdotool search --onlyvisible --class x-terminal-emulator)
else x-terminal-emulator &
fi
