#!/bin/bash


echo "
#########################################
#              Building VMs             #
#########################################
"
sleep 1

#spin up VM based on the Vagrantfile provided

vagrant up


echo "
#########################################
#  Running environment configuation...  #
#########################################
"

sleep 1

echo "
-----------------------------
Step 1: Copying files to VMs.
-----------------------------
"
#copy files to VMs
vagrant scp vm_config.sh server-01-backup:/tmp
vagrant scp vm_config.sh server-01:/tmp
vagrant scp backup-script.sh server-01:/tmp
vagrant scp vm_backup.service server-01:/tmp
vagrant scp vm_backup.timer server-01:/tmp

echo "Done."

echo "
--------------------------------------------
Step 2: Creating backup and log directories.
--------------------------------------------
"
sleep 1

#Create backup directory
vagrant ssh server-01 -c 'mkdir /tmp/server-01-backups'
vagrant ssh server-01-backup -c 'mkdir /tmp/server-01-backups'

#create log directory
vagrant ssh server-01 -c 'sudo mkdir /var/log/vm_backup_logs'
vagrant ssh server-01-backup -c 'sudo mkdir /var/log/vm_backup_logs'

echo "Done."

echo "
------------------------------------------
Step 3: Moving backup configuration files.
------------------------------------------
"
sleep 1

#move backup config files
vagrant ssh server-01 -c 'sudo cp /tmp/backup-script.sh /usr/bin; sudo chmod +x /usr/bin/backup-script.sh'
vagrant ssh server-01 -c 'sudo cp /tmp/vm_backup.service /lib/systemd/system' 
vagrant ssh server-01 -c 'sudo cp /tmp/vm_backup.timer /lib/systemd/system'

echo "Done."

sleep 1

echo "
--------------------------------------
Step 4: Edit global SSH configuration.
--------------------------------------
"

vagrant ssh server-01 -c 'echo "    StrictHostKeyChecking=no" | sudo tee -a /etc/ssh/ssh_config'
vagrant ssh server-01-backup -c 'echo "    StrictHostKeyChecking=no" | sudo tee -a /etc/ssh/ssh_config'

echo "Done."

sleep 1

echo "
----------------------------------------------------------------
Step 5: Creating and enabling systemd backup service with timer.
----------------------------------------------------------------
"
sleep 1

#create and enable a SystemD file for backup service
vagrant ssh server-01 -c 'sudo systemctl daemon-reload; sudo systemctl enable vm_backup.timer'

echo "Done."

sleep 1

echo "
--------------------------------
Step 6: Starting backup service.
--------------------------------
"
sleep 1

#start backup service
vagrant ssh server-01 -c 'sudo systemctl start vm_backup.timer'

echo "Done."





