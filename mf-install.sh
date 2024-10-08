#!/bin/bash

microflowPath="/usr/local/bin/microflow"
downloadUrl="http://stu.jxit.net.cn:88/uniprobe/microflow"

echo "******check microflow exsist******"
if [ -e "$microflowPath" ]; then
  echo "******microflow exsits!******"
  rm -f $microflowPath
fi
    
echo "******kill microflow process******"
ps -ef | grep microflow | grep -v grep | awk '{print $2}' | xargs kill -9  
sleep 5
    
echo "******download microflow software******"
if [[ `arch` =~ "x86_64" ]]; then
  if [[ -n "`cat /etc/issue | grep 'CentOS\|Red Hat' | grep 6 | grep -v grep`" ]]; then
    curl -o $microflowPath $downloadUrl/linux/microflow-x86-centos6
  else
    curl -o $microflowPath $downloadUrl/linux/microflow-x86
  fi
elif [[ `arch` =~ "aarch64" ]]; then
  curl -o $microflowPath $downloadUrl/linux/microflow-arm
else 
  echo "Have no version for this os-release, please connect whit the manager!"
  exit
fi

chmod +x $microflowPath

