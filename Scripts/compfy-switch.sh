#!/bin/bash
if pgrep -x "compfy" > /dev/null
then
    killall compfy
else
    compfy --daemon
fi
