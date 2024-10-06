#!/bin/bash

LUJING="up-install"
HTTP_SERVER="110.41.129.254:9000"

echo "******check  uniprobe exsist******"
if [[ -e /opt/${LUJING}/uniprobe ]]; then
  echo "******uniprobe exsits!******"
  rm -f /opt/${LUJING}/uniprobe* 
fi
    
echo "******kill uniprobe process******"
ps -ef | grep uniprobe | grep -v grep | awk '{print $2}' | xargs kill -9  
sleep 5
    
echo "******begin install uniprobe******"
echo "******create file dir******"
mkdir -p /opt/${LUJING}

echo "******change workespace******"
cd /opt/${LUJING}
    
echo "******download uniprobe software******"
if [[ `arch` =~ "x86_64" ]]; then
  if [[ -n "`cat /etc/issue | grep 'CentOS\|Red Hat' | grep 6 | grep -v grep`" ]]; then
    curl -o uniprobe http://${HTTP_SERVER}/${LUJING}/uniprobe-20240929-41-969-x86-centos6
  else
    curl -o uniprobe http://${HTTP_SERVER}/${LUJING}/uniprobe-20240929-41-969-x86
  fi
elif [[ `arch` =~ "aarch64" ]]; then
  curl -o uniprobe http://${HTTP_SERVER}/${LUJING}/uniprobe-20240929-41-969-arm
else 
  echo "Have no version for this os-release,please connect whit the manager!"
  exit
fi
    
echo "******run uniprobe worker******"
chmod +x /opt/${LUJING}/uniprobe
