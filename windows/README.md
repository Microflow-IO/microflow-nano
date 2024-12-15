# Microflow-nano (mfnano) Deployment Guide


## System Requirements

- Supports Windows systems (such as Windows 10, PowerShell5), please mail to: service@microflow.io.
- System administrator privileges are required.

## Quick Start

Download mfnano from Github and place it in a non root directory on any disk:

```powershell
PS D:\test\mfnano> dir

    Directory: D:\test\mfnano

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----         2024/12/1     10:14                tmp
-a----         2024/12/2     20:48           4482 autoupdate.ps1
-a----         2024/12/1     10:54            141 mfnano-conf.ps1
-a----        2024/11/15     15:15         663197 mfnano-worker.exe
-a----        2024/12/10     21:19           9413 mfnano-worker.ps1
-a----        2024/12/10     21:19           3197 mfnano.ps1
-a----         2024/7/12     11:25        1162272 npcap-1.79.exe
-a----        2024/11/13     16:54         915128 WinPcap_4_1_3.exe

PS D:\test\mfnano>
```

Before running, install winpcap (which is the WinPcap_4_1_3. exe above).

Start `mfnano`:

```powershell
PS D:\test\mfnano> .\mfnano-worker.ps1
```

The configuration file script `mfnano-conf.ps1` will be automatically created in the current directory. You can modify the command in this file to fetch the configuration as needed, with the default fetching from [Github](https://github.com/Microflow-IO/microflow-nano/blob/main/linux/mfnano.conf).

```powershell
PS D:\test\mfnano> cat .\mfnano-conf.ps1
Invoke-WebRequest -Uri https://raw.githubusercontent.com/Microflow-IO/microflow-nano/refs/heads/main/linux/mfnano.conf -OutFile mfnano.conf
PS D:\test\mfnano>
```

With this configuration, `mfnano` will send traffic logs to demo.microflow.io on port 12201 in UDP+GELF (JSON) format. You can view your probe ID with the following command:

```bash
PS D:\test\mfnano> type .\mfnano.conf | findstr probe-id
probe-id=E40D3662F23C
PS D:\test\mfnano>
```

To access the platform, visit https://demo.microflow.io in your browser. Login with the username `admin` and password `admin@123`. Search for the probe ID using the filter: **gl2_source_collector:45701902147155360** to see your traffic logs.
![image](https://github.com/user-attachments/assets/bd2e35e3-d4fb-4dc1-902d-2f8335e1963b)




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

## Verify Deployment

### Check Process Status

Use the following command to check if `mfnano` and `mfnano-worker` are running correctly:

```powershell
PS D:\test\mfnano> tasklist|findstr mfnano
mfnano-worker.exe           7476 Console                    3    103,264 K
PS D:\test\mfnano>
```

## Troubleshooting

### Common Issues and Solutions

- Issue: `mfnano-worker` fails to run
  - Solution: Check if the `mfnano-conf.sh` file is configured correctly and ensure all configuration items are spelled correctly.
- Issue: Data not sent to the target server
  - Solution: Check the `exp-domain` configuration to ensure the target server address and port are correct and accessible.
