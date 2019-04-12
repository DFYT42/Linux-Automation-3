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
htpasswd -b -c ~/temp/password nagiosadmin nagiosadmin

#####ENABLE rw/rw/rw FOR LOGS
chmod 666 /var/log/nagios/nagios.log

#####UNCOMMENT LINE TO ENABLE NAGIOS.CFG
sed -i '51 s/^#//' /etc/nagios/nagios.cfg

#####RESTARTING NAGIOS TO BYPASS SE LINUX PREVENTIONS
systemctl restart nagios

# Need to put the NRPE changes into your config file
echo "########### NRPE CONFIG LINE #######################
        define command{
        command_name check_nrpe
        command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
}" >> /etc/nagios/servers/commands.cfg

#####RESTARTING NAGIOS TO BYPASS SE LINUX PREVENTIONS
systemctl restart nagios

#######NEED TO BE DONE######
####mkdir
cd /etc/nagios/server
mkdir /server
sed '51i\ cfg_dir=/etc/nagios/server'

##">> /etc/nagios/conf.d/"$host".cfg changed to ">> /etc/nagios/servers/"$host".cfg


