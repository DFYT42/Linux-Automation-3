#!/bin/bash

for servername in $( gcloud compute instances list | awk '{print $1}' | sed "1 d" | grep -v nti320-final-repo-server );  do 
   
    gcloud compute ssh g42dfyt@$servername --zone us-west1-b --strict-host-key-checking='no' --command='sudo yum -y install wget && sudo wget https://raw.githubusercontent.com/DFYT42/Linux-Automation-3/master/add_yum_repo.sh && sudo bash add_yum_repo.sh';

done

#for servername in $(gcloud compute instances list | awk '{print $1}' | sed "1 d" | grep -v $repo_server); do 

#gcloud compute ssh cchang30@$servername --zone us-west1-b --strict-host-key-checking='no' --command='sudo yum -y install wget && sudo wget https://raw.githubusercontent.com/chuanisawesome/NTI-320/master/lab4_repo/add-yum.sh && sudo bash add-yum.sh';

#done
