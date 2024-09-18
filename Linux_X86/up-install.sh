HTTP_SERVER="1.181.56.111:9000"
LUJING="up-install"
TOKEN="pmq5tdi2hfm522j0iajcodqkfomcblee7o9kfjomlrmuqifkjcn"
VERSION=""
install_uniprobe（） {
  echo "******begin install uniprobe******"
  echo "******create file dir******"
  mkdir -p /opt/${PATH}
  echo "******change workespace******"
  cd /opt/${LUJING}
  echo "******download uniprobe software******"
  if [[ `arch` =~ "x86_64" ]];then
    curl -o uniprobe http://${HTTP_SERVER}/${LUJING}/uniprobe-20240607-1229
  elif [[ `arch` =~ "aarch64" ]];then
    curl -o uniprobe http://${HTTP_SERVER}/${LUJING}/uniprobe-arm-20240606-1227
  else 
    echo "Have no version for this os-release,please connect whit the manager!"
    exit
  fi
  chmod +x uniprobe
  echo "******run uniprobe worker******"
  nohup ./uniprobe -n ${HTTP_SERVER} -a $TOKEN > /dev/null 2>&1 &
  sleep 20
  ps -ef |grep uniprobe-worker|grep -v auto && echo "Uniprobe has been installed and it's running now!" || echo "******Start failure!******"
}
echo "******check  uniprobe exsist******"
if [[ -e /opt/${LUJING}/uniprobe ]];then
  echo "******uniprobe exsits!******"
  if [[ `strings /opt/${LUJING}/uniprobe |grep "version=" |awk -F"=" '{print $2}'` == $VERSION ]]
    echo "******uniprobe version is newest!******"
    exit
  else
    ps -ef |grep uniprobe|grep -v auto|awk '{print $2}'|xargs kill -9  && rm -f /opt/${LUJING}/uniprobe* 
    sleep 5
    install_uniprobe
  fi
else
  rm -f $(lsof -p $(ps -ef |grep uniprobe|grep " -n"|awk '{print $2}')|tail -n 1|awk '{print $NF}') && ps -ef |grep uniprobe |grep -v grep|awk '{print $2}' |xargs kill -9 && sleep 5
  install_uniprobe
fi
