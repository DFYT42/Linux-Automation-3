
#!/bin/bash
# This is a script meant to let us test NRPE
# plugins we write
#http://tldp.org/LDP/abs/html/comparison-ops.html

versionp=$(ls -l | grep python | wc -l)

if [ "$versionp" -gt 0]; then
    echo "You have Python installed"
    exit 0;
    
  elif [ $versionp -e 0]; then
    echo "You do not have Python installed"
    yum install python
    exit 2;
    
else
   echo "VERSION:UNKNOWN"
   exit 3;
fi
