# Public Cloud Deployment

Use the following command for one-click online installation

```bash
curl https://raw.githubusercontent.com/Microflow-IO/microflow-sentinel/refs/heads/main/mfs-install.sh | bash -x
```

This will install `mfs` in the `/usr/local/bin` directory and create configure file /etc/mfs/mfs.conf

```bash
root@VM-16-2-ubuntu:~# ls -al /usr/local/bin/
-rwxr-xr-x.  1 root root  1409223 Oct  9 04:12 mfs
root@VM-16-2-ubuntu:~# ls -al /etc/mfs/
-rw-r--r--   1 root root  493 Oct 21 16:09 mfs.conf
```

Some important configure option as follows, other is end of document:

- device:  capture packet NIC, any is all
- exp-domain:  send json result use UDP to graylog
- graylog  token:  login to graylog web interface
- confurl：remote configure file mfs will sync real-time
- license:  need an license code after running 3 months

```bash
root@VM-16-2-ubuntu:~# cat /etc/mfs/mfs.conf 
device=any
exp-domain=graylog.jxit.net.cn:12201
graylog=graylog.jxit.net.cn:9000
token=gf3gh7ogcuf1v4ntpd89ec9fvq6oeu20qebpe99ie61pbs94n1g
license=
confurl=http://stu.jxit.net.cn:88/uniprobe/mfs/linux/mfs.conf
```

Use this configure file start mfs, it will connect to graylog platform`http://graylog.jxit.net.cn:9000/` 

```bash
nohup mfs /etc/mfs/mfs.conf &
```

Use admin/admin@123 login http://graylog.jxit.net.cn:9000/ , Click System - Sidecars will see your mfs


Explanation of the configuration file contents:

```bash
# Set to 1 for automatic application-layer protocol checking
auto-check=1
# Export traffic logs in JSON format using base64 encoding
base64=
# Network interface to monitor, "any" monitors all interfaces
device=any
filter-net=
l4-switch=net
# Path to store traffic logs in JSON format
json-path=
# Maximum size of each JSON log file in MB (must be greater than 110), fixed at 50MB per file
json-size=
# Path to store raw packet data
pcap-path=
# Total size of each raw packet file in MB (must be greater than 110)
pcap-size=
# Size of each raw packet file in MB (must be greater than 110)
pcap-file-size=
# BPF capture filter
filter-bpf=
# Maximum packet capture length
max-length=
proto=
# Monitor TOPN processes on the host, avoid setting this too high, as each process sends data once per minute
proclist=2
source=
bytecode=
play=
forward=
# Monitoring interval for TOPN processes on the host, avoid setting this too high
interval=10
# Maximum length of application-layer request/response body parsing
bodylen=1024
license=
jsonsample=
ignorel7=
# Set to 1 to encrypt the traffic log data sent
encrypt=
forward-ip=
confurl=http://stu.jxit.net.cn:88/uniprobe/mfs/linux/mfs.conf
# Do not modify the fields below
exp-domain=graylog.jxit.net.cn:12201
graylog=graylog.jxit.net.cn:9000
token=dahvtggeh3v048k20dpsnlcfcadc0haogcs9afoluup5o2o9j95
probe-id=24447682964177
sys-version=20241006-45-972
host-address=198.46.233.196
```
