# Microflow-nano (mfnano) Docker 

## Introduction

Microflow-nano (mfnano) is a lightweight data flow processing engine designed for efficiently capturing and processing network traffic data. It allows real-time monitoring, analysis, and sends network data in JSON format to a specified server, supporting automatic protocol analysis and traffic log export. It is suitable for network monitoring, data traffic analysis, and similar scenarios.

## System Requirements

- Linux with Docker 

## Quick Start

Download `mfnano` image from [Github](https://github.com/Microflow-IO/microflow-nano/releases)  and import

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
USER         PID %CPU %MEM  TIME COMMAND
root           1  0.0  0.0  0:00 /bin/bash /usr/local/bin/mfnano
root         162  0.0  0.6  0:00 /usr/local/bin/mfnano-worker @/etc/mfnano/mfnano.conf
```

The configuration file script `mfnano-conf.sh` will be automatically created in the `/etc/mfnano/` directory. You can modify the command in this file to fetch the configuration as needed, with the default fetching from [Github](https://github.com/Microflow-IO/microflow-nano/blob/main/linux/mfnano.conf).

```bash
root@d86f5c92b655:/# cat /etc/mfnano/mfnano-conf.sh 
curl -s https://raw.githubusercontent.com/Microflow-IO/microflow-nano/refs/heads/main/linux/mfnano.conf
```

With this configuration, `mfnano` will send traffic logs to demo.microflow.io on port 12201 in UDP+GELF (JSON) format. You can view your probe ID with the following command:

```bash
root@d86f5c92b655:/# cat /etc/mfnano/mfnano.conf | grep probe-id
probe-id=37403430542246
```

To access the platform, visit https://demo.microflow.io in your browser. Login with the username `admin` and password `admin@123`. Search for the probe ID using the filter: **gl2_source_collector:37403430542246** to see your traffic logs.
![image-20241128145259754](https://github.com/user-attachments/assets/f305c7b9-72ef-40d6-b3cd-ab8b21b659bf)

## Configuration Guide

### Important Configuration Items

The configuration file `mfnano.conf` contains the following important settings:

- **device**: Specifies the network interface to capture traffic from. `any` captures traffic from all interfaces.
- **exp-domain**: Specifies the target domain and port for sending data, in UDP GELF format.

#### All Configuration Items:

| Parameter      | Description                                                  |
| -------------- | ------------------------------------------------------------ |
| auto-check     | 0: Parse all Layer 7 traffic, but only HTTP session headers; 1: Parse all Layer 7 traffic including headers and bodies. Empty: Parse only Layer 4 traffic. |
| base64         | Specifies whether to base64 encode probe output information; any value encodes, empty value does not encode. |
| compress       | Set to 1 to compress JSON data using ZIP before transmission. |
| **device**     | **Specifies which network interface the probe listens to, `any` listens to all interfaces; specific interface name listens to a specific interface.** |
| filter-net     | Select traffic based on criteria such as IP:port, IP, or port number for further processing. |
| l4-switch      | Specifies whether to enable Layer 4 traffic parsing. Empty: does not parse Layer 4 traffic; net parses TCP and UDP; tcp parses only TCP traffic; udp parses only UDP traffic. |
| **exp-domain** | **Specifies the address and port to send parsed data back to, in the format IP:port.** |
| json-path      | Specifies the local path to store parsed JSON files. If not set, JSON is not stored. |
| json-size      | Specifies the size of the local directory to store JSON files, must be a multiple of 100. |
| pcap-path      | Specifies the local directory to store raw traffic in pcap format. If not set, raw traffic is not stored. |
| pcap-size      | Specifies the local directory size to store raw traffic in pcap format, must be a multiple of 100. |
| pcap-file-size | Specifies the size of each pcap file, default is 50MB. If not set, the default is used. |
| filter-bpf     | Specifies BPF filter conditions.                             |
| max-length     | Specifies the maximum length of a single packet to parse; packets exceeding this length will be truncated. |
| drop           | Specifies conditions to filter out traffic during parsing, opposite effect to filter-net. |
| forward        | Specifies the destination address for forwarding traffic.    |
| bodylen        | Specifies the maximum parsing length for HTTP session request body and header, in bytes. |
| license        | Specifies the probe's licensing encryption string.           |
| encrypt        | Specifies whether the probe's traffic parsing content is encrypted, and provides the encryption key. |
| proclist       | Specifies the processes to monitor on the probe host, or the number of top N processes by load. Multiple process names should be separated by commas. |
