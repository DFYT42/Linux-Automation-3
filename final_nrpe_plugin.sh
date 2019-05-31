
#!/bin/bash
# This is a script meant to let us test NRPE
# plugins we write
#http://tldp.org/LDP/abs/html/comparison-ops.html

versionp=$(python --version) 
versionp3=$(python3 --version)

if [ "$versionp3" != "bash: python3: command not found" && "$versionp" != "bash: python: command not found" ]; then
    echo "Overachiever! You have both Python3 and Python installed"
    exit 0;
    
  elif [ $versionp3 == "bash: python3: command not found" && $versionp == "bash: python: command not found" ]; then
    echo "You do not have Python3 or Python installed"
    exit 2;
    
  elif [ $versionp3 == "bash: python3: command not found" && $versionp != "bash: python: command not found" ] ; then
    echo "You do not have Python3 installed but do have Python installed"
    exit 1;
    
else
   echo "VERSION:UNKNOWN"
   exit 3;
fi
