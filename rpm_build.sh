#!/bin/bash
# This should be the finishing script for a micro with a 50G hard drive

yum -y install rpm-build make gcc git                                         # install rpm tools, compiling tools and source tools
mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}                      # create the rpmbuild dirrectory structure 
                                                                              # (the docs say this happens by default, this is incorrect on centos 7)
cd ~/
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros                         # Set the rpmbuild path in an .rpmmacros file
cd ~/rpmbuild/SOURCES
###Not needed but to better automate what is needed
git clone https://github.com/nic-instruction/custom-nrpe-2019.git

cp custom-nrpe-2019/nti-320-plugins-0.1.tar.gz .
cp custom-nrpe-2019/plugins/nrpe_plugin_python_version.sh .
cp custom-nrpe-2019/nti-320-plugins.spec .
mv nti-320-plugins.spec ../SPECS
cd ..
##builds rpm
##want to exit with 0
rpmbuild -v -bb --clean SPECS/nti-320-plugins.spec

##did it work?
#ls -l RPMS/x86_64/helloworld-0.1-1.el7.x86_64.rpm

yum -y install RPMS/x86_64/nti-320-plugins-0.1-1.el7.x86_64.rpm

##did it work?
#ls -l /



#git clone https://github.com/NagiosEnterprises/nrpe.git                       # Get the nrpe source from github
#git clone https://github.com/NagiosEnterprises/nagioscore.git                 # Get the nagios source from github

#tar -czvf nrpe-3.1.tar.gz /root/rpmbuild/SOURCES/nrpe                         # Tar up the source (needed to create an RPM)
#tar -czvf nagioscore-4.3.1.tar.gz /root/rpmbuild/SOURCES/nagioscore           # Tar up the source (needed to create an RPM)

#mv nagioscore nagioscore-4.3.1                                                # Clean up our source dir by making a dirrectory
#mv nrpe nrpe-3.1                                                              # structure that will allow us to have multiple
#mkdir nagioscore                                                              # versions of our source code
#mkdir nrpe
#mv nagioscore-4.3.1 nagioscore
#mv nrpe-3.1 nrpe

#cd ../SPECS                                                                   # head to the SPECS directory
#cp /usr/share/vim/vimfiles/template.spec .                                    # copy a template .spec file over from /usr/share

#cp /root/rpmbuild/RPMS/x86_64/nti-320-plugins-0.1-1.el7.x86_64.rpm /home/g42dfyt/
#gcloud compute scp g42dfyt@nti320-final-build-server:/home/g42dfyt/nti-320-plugins-0.1-1.el7.x86-64.rpm .
#gcloud compute scp nti-320-plugins-0.1-1.el7.x86_64.rpm g42dfyt@nti320-final-repo-server:/home/g42dfyt
