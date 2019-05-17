#!/bin/bash
bash /home/g42dfyt/Linux-Automation-3/generate_config.sh $1 $2
gcloud compute scp --zone us-west2-a $1.cfg g42dfyt@nagios-a:/etc/nagios/servers
# Note: 
#Nagios server code near bottom: I had to add user nicolebade to group nagios on nagios server using usermod -a -G nagios g42dfyt
# I also had to chmod 777 /etc/nagios/servers
gcloud compute ssh --zone us-west2-a g42dfyt@nagios-a --command='sudo /usr/sbin/nagios -v /etc/nagios/nagios.cfg'
