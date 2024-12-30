# Microflow-nano (mfnano) K8S

## Introduction

Microflow-nano (mfnano) is a lightweight data flow processing engine designed for efficiently capturing and processing network traffic data. It allows real-time monitoring, analysis, and sends network data in JSON format to a specified server, supporting automatic protocol analysis and traffic log export. It is suitable for network monitoring, data traffic analysis, and similar scenarios.

## System Requirements

- Linux with K8S

## Quick Start

Use follow yaml will create daemonset pod with host network, mfnano will analy node traffic

```bash
root@graylog:/opt# docker load -i microflow-mfnano-1.0.tar 
```

By default TOKEN and HTTP_SERVER will connect http://demo.microflow.io:9000 (graylog platfrom)

```yaml
      hostNetwork: true
      serviceAccountName: mfnano-sa
      hostname: mfnano
      containers:
      - name: mfnano
        image: registry.jxit.net.cn:5000/uniserver/uniprobe:k8s-1664
        imagePullPolicy: Always
        command:    
        - sh                
        - -xc                              
        - |
          HTTP_SERVER="demo.microflow.io:9000"
          TOKEN="13plt363ce0b3bbmrggdbhbi67iafffn52ehvoa6uksoi1j1o2bi"
          /opt/up-install/uniprobe -n $HTTP_SERVER -a $TOKEN > /dev/null 2>&1
```

You can use admin/admin@123 to login, modify them connect you own graylog

![image-20241230165020379](https://github.com/user-attachments/assets/04cea82e-9bf3-4737-97c2-2dab7b2b8787)


## Configuration Guide

After mfnano connect to graylog, create Log Collector and config for it.

On above image Click Configuration -> Create log Collector, input name etc ....

![image-20241230170143354](https://github.com/user-attachments/assets/6c25e27e-0e1a-4ee9-b69e-3f66734dc0e4)


Click Create Configuration create config for Log Collector, input name select log collector and configure msg

![image-20241230170446748](https://github.com/user-attachments/assets/60386ec8-233b-44f9-91a8-018b82ae06a3)


### Important Configuration Items

The configuration file `mfnano.conf` contains the following important settings:

- **device**: Specifies the network interface to capture traffic from. `any` captures traffic from all interfaces.
- **exp-domain**: Specifies the target domain and port for sending data, in UDP GELF format.

Return sidecar page click "Manage Sidecar" -> Selcet mfnano -> use config "test"

![image-20241230171234570](https://github.com/user-attachments/assets/edf8cc41-7c78-4748-9373-b4e06b1e713f)


After 3 minutes in sidecar page click "show message" will see traffice analy result

![image-20241230172241135](https://github.com/user-attachments/assets/f34a6473-de8d-4371-bf37-b2474a5c3122)


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
