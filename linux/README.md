# Public Cloud Deployment

Use the following command for one-click online installation:

```bash
curl https://raw.githubusercontent.com/Microflow-IO/microflow-sentinel/refs/heads/main/mfs-install.sh | bash -x
```

This will install `mfs` in the `/usr/local/bin` directory:

```bash
[root@racknerd-b20bda0 linux]# ls -al /usr/local/bin/
-rwxr-xr-x.  1 root root  1409223 Oct  9 04:12 mfs
```

Connect the probe to the data platform at `http://graylog.jxit.net.cn:9000/` using the online configuration file, with the username/password: `admin/admin@123`:

```bash
mfs https://raw.githubusercontent.com/Microflow-IO/microflow-sentinel/refs/heads/main/linux/mfs.conf
```

The probe will automatically download the configuration file and save it to `/etc/mfs`:

```bash
[root@racknerd-b20bda0 linux]# ls -al /etc/mfs/
-rw-r--r--.  1 root root  491 Oct  9 04:13 mfs-url.conf
```

You can also manually edit the above configuration file as per your needs. After making changes, run it with the following command:

```bash
[root@racknerd-b20bda0 linux]# mfs /etc/mfs/mfs-url.conf
```

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
# Do not modify the fields below
exp-domain=graylog.jxit.net.cn:12201
graylog=graylog.jxit.net.cn:9000
token=dahvtggeh3v048k20dpsnlcfcadc0haogcs9afoluup5o2o9j95
drop=graylog.jxit.net.cn:9000
probe-id=24447682964177
sys-version=20241006-45-972
host-address=198.46.233.196
```

