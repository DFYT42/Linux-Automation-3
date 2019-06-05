#!/bin/bash
# JBeach
# This is a script meant to check if you have python installed
# If it is installed, it will tell you if you have one or multiple versions, and your default version
# If it is not installed, it will tell you and then install for you
#http://tldp.org/LDP/abs/html/comparison-ops.html

versionp=$(ls -l /usr/bin/ | grep python* | wc -l)

if [ "$versionp" -gt 1 ]; then
    echo "You have multiple versions of Python installed"
    echo "Your default version is:"
    python --version
    echo "OK"
    exit 0;

  elif [ $versionp -lt 1 ]; then
    echo "You do not have Python installed but it will be installed now"
    yum -y install python
    #apt-get -y install python
    echo "CRITICAL"
    exit 2;

  elif [ $versionp = 1 ]; then
    echo "You have one version of Python installed"
    python --version
    echo "OK"
    exit 0;
    
else
   echo "VERSION:UNKNOWN"
   exit 3;
fi
