for servername in $( gcloud compute instances list | awk '{print $1}' | sed "1 d");  do 
    gcloud compute scp nti-320-plugins-0.1-1.el7.x86_64.rpm g42dfyt@$servername:/home/g42dfyt/
done
