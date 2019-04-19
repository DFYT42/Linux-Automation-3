#!/bin/bash

#yum -y install nrpe nagios-nrpe-server nagios-plugins
#####INSTALLING NAGIOS NRPE CLIENT PACKAGES#####
#MUST DO THEM SINGLELY
yum install -y nagios-nrpe-server nagios-plugins nrpe nagios-plugins-load nagios-plugins-ping nagios-plugins-disk nagios-plugins-http nagios-plugins-procs wget
# BUG:https://osric.com/chris/accidental-developer/2016/12/missing-nagios-plugins-in-centos-7/ (nrpe plugins have been packaged seperately and don't install with nagios-plugins-all)
# BUG #2 https://cloudwafer.com/blog/installing-nagios-agent-npre-on-centos/ (the nrpe config is commented out and checks are not defined)
# Use sed statments to uncomment NRPE config and add the appropiate flags
# add in command[check_mem]=/usr/lib64/nagios/plugins/check_mem.sh
# Install custom mem monitor
#####INSTALL MEMORY MONITOR#####
wget -O /usr/lib64/nagios/plugins/check_mem.sh https://raw.githubusercontent.com/nic-instruction/NTI-320/master/nagios/check_mem.sh
#####EXECUTE MEMORY MONITOR#####
chmod +x /usr/lib64/nagios/plugins/check_mem.sh

systemctl enable nrpe
systemctl start nrpe
###There's another line over in troubleshooting to pull over here###
#sed #command[check_mem]=/usr/lib64/nagios/plugins/custom_check_mem -n $ARG1$,command[check_mem]=/usr/lib64/nagios/plugins/check_mem.sh -w 80 -c 90,g' /etc/nagios/nrpe.cfg 
### MISC SYSTEM METRICS ###
#command[check_users]=/usr/lib64/nagios/plugins/check_users $ARG1$
#command[check_load]=/usr/lib64/nagios/plugins/check_load $ARG1$
#command[check_disk]=/usr/lib64/nagios/plugins/check_disk $ARG1$
#command[check_swap]=/usr/lib64/nagios/plugins/check_swap $ARG1$
#command[check_cpu_stats]=/usr/lib64/nagios/plugins/check_cpu_stats.sh $ARG1$
### MISC SYSTEM METRICS ###
command[check_users]=/usr/lib64/nagios/plugins/check_users -w 5 -c 10
command[check_load]=/usr/lib64/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[check_disk]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10%
command[check_swap]=/usr/lib64/nagios/plugins/check_swap -w 20% -c 10%
command[check_cpu_stats]=/usr/lib64/nagios/plugins/check_cpu_stats.sh -w 70,40,30 -c 90,50,40

sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, 10.168.0.2/g' /etc/nagios/nrpe.cfg

systemctl restart nrp
