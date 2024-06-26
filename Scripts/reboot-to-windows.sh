#!/bin/sh
efibootmgr --bootnext $(efibootmgr | grep Windows | tail -n1 | cut -d' ' -f1 | cut -d't' -f2 | sed s/.$//) && reboot
