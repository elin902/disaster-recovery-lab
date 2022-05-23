#!/bin/bash

#Script to determine if backup service is currently running and to check the last time it was triggered.

echo "Checking service state..."

state=$(vagrant ssh server-01 -c 'systemctl show -p ActiveState vm_backup.timer | sed 's/ActiveState=//g'')
last_triggered=$(vagrant ssh server-01 -c 'systemctl show -p LastTriggerUSec vm_backup.timer | sed 's/LastTriggerUSec=//g'')

echo "The backup service is currently $state"
echo "Last backup performed on $last_triggered"