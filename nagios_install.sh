#!/bin/bash
##From https://github.com/nic-instruction/NTI-320/blob/master/nagios/nagios_install.sh

#####INSTALL NAGIOS
yum -y install nagios
systemctl enable nagios
systemctl start nagios

#####TURN OFF SE LINUX
setenforce 0

#####INSTALL APACHE
yum -y install httpd
systemctl enable httpd
systemctl start httpd

#####NAGIOS
yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe

#####INSTALL NAGIOS SERVER PLUGINS
yum -y install nagios-plugins-all

#####INSTALL NAGIOS CLIENT PLUGINS
yum -y install nagios-plugins-nrpe

#####CREATE PASSWORD
htpasswd -c /etc/nagios/passwd nagiosadmin

#####ENABLE rw/rw/rw FOR LOGS
chmod 666 /var/log/nagios/nagios.log

#####RESTARTING NAGIOS TO BYPASS SE LINUX PREVENTIONS
systemctl restart nagios


