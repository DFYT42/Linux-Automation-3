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

sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, 10.168.0.2/g' /etc/nagios/nrpe.cfg

systemctl restart nrp
