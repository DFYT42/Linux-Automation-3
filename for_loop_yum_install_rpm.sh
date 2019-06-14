for servername in $( gcloud compute instances list | awk '{print $1}' | sed "1 d" );  do 
    gcloud compute ssh --zone us-west1-b g42dfyt@$servername --command='sudo yum -y install wget && sudo wget https://raw.githubusercontent.com/DFYT42/Linux-Automation-3/master/add_yum_repo.sh && sudo bash add_yum_repo.sh'
done
