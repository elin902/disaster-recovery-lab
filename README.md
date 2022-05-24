# DR Task Lab

This is a project that creates a functioning DR lab. 
It consists of 2 virtual machines created in a private network. 
One of the machines runs a backup service that archives the most important folders 
and copies them securely to a remote server that acts as a backup storage device.

## Prerequisites

In order to succesfully create the lab you need to have a host with sudo privileges and the following packages installed:

- Vagrant 2.2.19+
- Vagrant-scp (run $vagrant plugin install vagrant-scp)
- Virtualbox 6.1

## Installation
To run the lab, clone the project and execute the "runlab.sh" script. It's being processed in following steps:

1. The script creates 2 virtual machines based on a vagrant file. They are on the same private network.
2. Configuration files are copied onto the VMs.
3. Backup and log folders are created on the VMs.
4. The backup script and systemd units are being placed in their native folders.
5. The SSH config on both VMs is edited so the machines can communicate via SSH without interuptions.
6. SystemD timer and service are enabled and started.
7. Voila, we have a working client-server environment with a backup service. 
8. Run the "drcheck.sh" script to check if the service is running and see the last logs.