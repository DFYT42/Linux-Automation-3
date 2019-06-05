
#!/bin/bash
# This is a script meant to let us test NRPE
# plugins we write
#http://tldp.org/LDP/abs/html/comparison-ops.html

versionp=$(ls -l /usr/bin/ | grep python* | wc -l)

if [ "$versionp" -gt 1 ]; then
    echo "You have multiple versions of Python installed"
    echo "Your default version is:"
    python --version
    exit 0;

  elif [ $versionp -lt 1 ]; then
    echo "You do not have Python installed"
    apt-get -y install python
    exit 2;

  elif [ $versionp = 1 ]; then
    echo "You have one version of Python installed"
    python --version
else
   echo "VERSION:UNKNOWN"
   exit 3;
fi
