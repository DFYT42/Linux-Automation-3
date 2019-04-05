#!/bin/bash

yum -y install nrpe nagios-nrpe-server nagios-plugins

systemctl enable nrpe
systemctl start nrpe

sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, 10.168.0.2/g' /etc/nagios/nrpe.cfg

systemctl restart nrp
