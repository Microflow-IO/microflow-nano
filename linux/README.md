# Public Cloud Deployment

Download a release from Github and install `mfnano` to `/usr/local/bin` directory

```bash
root@VM-16-2-ubuntu:~# chmod +x /usr/local/bin/mfnano
root@VM-16-2-ubuntu:~# ls -al /usr/local/bin/
-rwxr-xr-x.  1 root root  1409223 Oct  9 04:12 mfnano
```

Start mfnano

```bash
nohup /usr/local/bin/mfnano > /dev/null 2>&1 &
```

Mfnano will create `/usr/local/bin/mfnano-worker`, it is worker program

```bash
root@VM-16-2-ubuntu:~# ls -al /usr/local/bin/
-rwxr-xr-x.  1 root root  1408113 Oct  9 04:12 mfnano-worker
```

Mfnano will create `/etc/mfnano/mfnano-conf.sh`

script will execute it get configure for mfnano-worker

you can edit this file get configure from your own server

by default will get configure from 
https://raw.githubusercontent.com/Microflow-IO/microflow-nano/refs/heads/main/linux/mfnano.conf

```bash
[root@ecs-2d16-0001 uniprobe]# cat /etc/mfnano/mfnano-conf.sh 
curl -s https://raw.githubusercontent.com/Microflow-IO/microflow-nano/refs/heads/main/linux/mfnano.conf
```

Configure will save to /etc/mfnano/mfnano.conf, note mfnano exec /etc/mfnano/mfnano-conf.sh 10s timeout

```bash
root@VM-16-2-ubuntu:~# cat /etc/mfnano/mfnano.conf 
device=any
exp-domain=demo.microflow.io:12201
token=1hafs2nigai62j9fm8eau6c5d6qb4e9725rqeaohj9u58gpvfm21
license=
...
```

Some important configure option as follows, other is end of document:

- device:  capture packet NIC, any is all
- exp-domain:  send json result use UDP GELF format
- license:  need an license code after running 3 months

Explanation of the configuration file contents:

```bash
# send json result use UDP GELF format
exp-domain=demo.microflow.io:12201
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
# Do not modify the fields below
probe-id=24447682964177
sys-version=20241006-45-972
host-address=198.46.233.196
```
