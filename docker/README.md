# Public Cloud Deployment

Download a release docker image from Github and import

```bash
root@graylog:/opt# docker load -i microflow-mfnano-1.0.tar 
Loaded image: microflow/mfnano:1.0
root@graylog:/opt# docker images | grep mfnano
microflow/mfnano                                                 1.0         67dcbd0e7b99   14 minutes ago   96.4MB
```

Start mfnano container and entry it

```bash
root@graylog:/opt# docker run -dit --name mfnano microflow/mfnano:1.0 /usr/local/bin/mfnano
d86f5c92b655ad15fe9ac0ba38a497724561a2151ea97ee5c1c5eb05f5ef7d0b
root@graylog:/opt# docker ps
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS     NAMES
d86f5c92b655   microflow/mfnano:1.0   "/usr/local/bin/mfna…"   3 seconds ago   Up 3 seconds             mfnano
root@graylog:/opt# docker exec -it mfnano bash
```

Mfnano will create `/usr/local/bin/mfnano-worker`, it is worker program

```bash
root@d86f5c92b655:/# ls -al /usr/local/bin/
-rwxr-xr-x.  1 root root  1408113 Oct  9 04:12 mfnano-worker
```

Check worker process is running, it will running after 3 minutes

```bash
root@d86f5c92b655:/# docker exec -it mfnano ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   4600  3340 pts/0    Ss+  07:39   0:00 /bin/bash /usr/local/bin/mfnano
root         162  0.0  0.6 110068 99740 ?        Sl   07:40   0:00 /usr/local/bin/mfnano-worker @/etc/mfnano/mfnano.conf
```

Mfnano will create `/etc/mfnano/mfnano-conf.sh`

mfnano will execute it get configure for mfnano-worker, edit this file get from your own server

by default will get configure from 
https://raw.githubusercontent.com/Microflow-IO/microflow-nano/refs/heads/main/linux/mfnano.conf

```bash
root@d86f5c92b655:/# cat /etc/mfnano/mfnano-conf.sh 
curl -s https://raw.githubusercontent.com/Microflow-IO/microflow-nano/refs/heads/main/linux/mfnano.conf
```

Configure will save to /etc/mfnano/mfnano.conf, note mfnano exec /etc/mfnano/mfnano-conf.sh 10s timeout

```bash
root@d86f5c92b655:/# cat /etc/mfnano/mfnano.conf 
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
