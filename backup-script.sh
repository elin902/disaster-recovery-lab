#!/bin/bash

#This is a simple backup script that creates an archive of folders and sends them to a remote backup host via SSH.

remote="vagrant@192.168.56.102"
host="vagrant@192.168.56.101"

#What to backup
backup_files="/home /etc /root /boot /opt /var /usr/local/bin /usr/local/sbin"

#backup destination
destination="/tmp/server-01-backups"

#log destination
log_destination="/var/log/vm_backup_logs"

#archive filename
date=$(date +"%d-%m-%Y-%H-%M-%S")
hostname=$(hostname -s)
archive_file="$hostname-backup-$date.tgz"

#log filename
log_file="$hostname-backup-$date.log"


echo "Backing up $backup_files to $destination/$archive_file"
date
echo

#backup the files using tar
sudo tar czf $destination/$archive_file $backup_files          

#archive size
archive_size=$(du -ah $destination/$archive_file | cut -f 1)

#move backup to backup VM

echo "Backed up $archive_size of files to $archive_file"
echo "Moving backup files to remote backup machine."

scp $host:$destination/$archive_file $remote:$destination

#create and move runlogs
echo "Succefully backed up $archive_size of files to $archive_file" | sudo tee -a $log_destination/$log_file
scp $host:$log_destination/$log_file $remote:$log_destination

echo "Done"
