<img src="https://github.com/Microflow-IO/microflow-nano/blob/main/docs/github_microflow_B.png" alt="logo" style="float:left; margin-right:10px;" />



<h1 style="font-size: 20px;">MicroFlow Nano Output List</h1>  



<h2 style="font-size: 20px;color: #1E90FF;">The world's smallest enterprise-level host traffic analysis probe</h3>  


> [!IMPORTANT]
>
> **Nano, a 500KB standalone program, enables real-time output of the following content without adding computing resources in 99% of production environments.**

1. Host-Metrix, CPU/MEM/HD...
2. Network, TCP/UDP pairs, KPI/KQI
3. HTTP/API, REQ/RSP, header/body, KPI/KQI
4. SQL, the mainstream structured database
5. DNS
6. ......
7. Raw Packets (forward or FIFO save to PCAP)

> [!NOTE]
>
> - ***KPI refers to communication indicators based on traffic/links/packets, etc.***
> - ***KQI refers to performance indicators mainly based on various types of latency, errors, etc.***



------

[TOC]

# 🏠   Host-Metrics

| No.  | KPI Name        | Description                                                  |
| :--: | --------------- | ------------------------------------------------------------ |
|  1   | host_name       | host name                                                    |
|  2   | host_cpu        | Current CPU overhead of the host (percentage of total CPU usage) |
|  3   | host_mem        | The current memory overhead of the host                      |
|  4   | host_load       | The average system load of the host within 5 minutes         |
|  5   | host_wa         | The percentage of time the CPU or CPU is idle when there are unfinished disk I/O requests in the host system |
|  6   | proc_name       | process name                                                 |
|  7   | proc_pid        | Process ID                                                   |
|  8   | proc_sts        | The status of the process                                    |
|  9   | proc_cpu        | CPU overhead of the process (percentage of usage of a single CPU) |
|  10  | proc_mem        | Memory overhead of processes                                 |
|  11  | host_disk_total | Total number of disks                                        |
|  12  | host_disk_use   | Actual disk usage                                            |
|  13  | host_mem_total  | Total amount of memory                                       |



# 🌍   Network

| No.  | KPI Name             | Description                                                  |
| :--: | -------------------- | ------------------------------------------------------------ |
|  1   | TIME                 | The generation time of the session data                      |
|  2   | PROBE_VER            | Program version                                              |
|  3   | host                 | host name                                                    |
|  4   | SYSTEM               | operating system                                             |
|  5   | SRC_IP               | Session source IP (initiator)                                |
|  6   | DST_IP               | Session destination IP (destination)                         |
|  7   | SRC_PORT             | Session source port                                          |
|  8   | DST_PORT             | Session destination port                                     |
|  9   | SRC_MAC              | Session source MAC                                           |
|  10  | DST_MAC              | Session destination MAC                                      |
|  11  | NIC                  | Program packet capture network card                          |
|  12  | CARD                 | The data packet originates from which specific network card (when nic specifies any, it can identify which specific network card it is) |
|  13  | CARD_IP              | The IP address of the network card from which the data packet originates |
|  14  | SRC_BYTES            | The amount of data (in bytes) sent by the initiator (source) |
|  15  | DST_BYTES            | The amount of data sent by the destination (in bytes)        |
|  16  | BYTES                | SRC_BYTES+DST_BYTES                                          |
|  17  | SRC_SYN_PKTS         | Number of active connection (syn) packets sent by the initiator (source) (unit) |
|  18  | DST_SYN_PKTS         | Number of active connection (syn) packets sent by the destination party (unit) |
|  19  | SYN_PKTS             | SRC_SYN_PKTS+DST_SYN_PKTS                                    |
|  20  | SRC_SYN_ACK_PKTS     | The number of passive connection (synapk) packets sent by the initiator (source) (unit) |
|  21  | DST_SYN_ACK_PKTS     | Number of Passive Synack packets sent by the destination party (unit) |
|  22  | SYN_ACK_PKTS         | SRC_SYN_ACK_PKTS+DST_SYN_ACK_PKTS                            |
|  23  | SRC_RST_PKTS         | Number of Interrupted Connection (RST) packets sent by the initiator (source) (unit) |
|  24  | DST_RST_PKTS         | Number of Interrupted Connection (RST) packets sent by the destination party (unit) |
|  25  | RST_PKTS             | SRC_RST_PKTS+DST_RST_PKTS                                    |
|  26  | SRC_FIN_PKTS         | Number of end connection (fin) packets sent by the initiator (source) (unit) |
|  27  | DST_FIN_PKTS         | Number of End Connection (fin) packets sent by the destination party (unit) |
|  28  | FIN_PKTS             | SRC_FIN_PKTS+DST_FIN_PKTS                                    |
|  29  | SRC_RETRANS_PKTS     | Number of retransmission packets sent by the initiator (source) (unit) |
|  30  | DST_RETRANS_PKTS     | Number of retransmission packets sent by the destination party (unit) |
|  31  | RETRANS_PKTS         | SRC_RETRANS_PKTS+ DST_RETRANS_PKTS                           |
|  32  | SRC_TINY_PKTS        | The number of small packets sent by the initiator (source) (usually less than 64 ack, unit) |
|  33  | DST_TINY_PKTS        | Number of small packets sent by the destination party (unit) |
|  34  | TINY_PKTS            | SRC_TINY_PKTS+DST_TINY_PKTS                                  |
|  35  | SRC_ZEROWIN_PKTS     | Zero window count in the data packet sent by the initiator (source) |
|  36  | DST_ZEROWIN_PKTS     | Zero window count in the data packet sent by the destination party |
|  37  | ZEROWIN_PKTS         | SRC_ZEROWIN_PKTS+DST_ZEROWIN_PKTS                            |
|  38  | APP_RESPONSE         | Application processing latency (the time interval between the initiator sending loaded data and the destination sending loaded data) |
|  39  | SRC_NET_DELAY        | Initiator latency (the interval between the destination sending a loaded packet and the sender returning an ACK) |
|  40  | DST_NET_DELAY        | Destination latency (the interval between the initiator sending a loaded packet and the destination returning an ACK) |
|  41  | NET_DELAY            | SRC_NET_DELAY+DST_NET_DELAY                                  |
|  42  | HAND_DELAY           | Handshake latency, the time interval between the first path (syn) and the third path (ack) of a three-way handshake |
|  43  | LOAD_TRANS_DELAY     | Loading latency, the initiator sends a request, the destination returns data (in multiple packets), and the interval between the first and last packets sent back by the destination |
|  44  | SRC_RETRANS_DELAY    | Initiator retransmission delay (the interval between the first packet and the ACK returned by the sender when the destination sends a loaded data packet and the packet is retransmitted) |
|  45  | DST_RETRANS_DELAY    | Destination retransmission delay (the interval between the sender sending a loaded data packet and the packet being retransmitted, and the first packet returning an ACK from the destination) |
|  46  | L7_PROTOCOL          | Layer 7 protocol (HTTP oracle、mysql…）                      |
|  47  | L4_PROTOCOL          | Layer 4 protocols (TCP, UDP, ICMP)                           |
|  48  | message              | host name                                                    |
|  49  | message-type         | Indicate information category (currently outputting comm for traffic data and proc for process data) |
|  50  | gl2_source_collector | Probe ID, from portal configuration                          |
|  51  | DISK_RATIO           | Host disk utilization rate                                   |
|  52  | TOTAL_CPU            | Number of CPUs                                               |
|  53  | LICENSE              | Validity period information                                  |



# 🪐   HTTP/API

| No.  | KPI Name             | Description                                                  |
| :--: | -------------------- | ------------------------------------------------------------ |
|  1   | BEGIN_TIME           | The time of the first request packet for this session        |
|  2   | END_TIME             | The time of the last response packet in the conversation     |
|  3   | PROBE_VER            | Program version                                              |
|  4   | host                 | host name                                                    |
|  5   | SYSTEM               | operating system                                             |
|  6   | SRC_IP               | Session source IP (initiator)                                |
|  7   | DST_IP               | Session destination IP (destination)                         |
|  8   | SRC_PORT             | Session source port                                          |
|  9   | DST_PORT             | Session destination port                                     |
|  10  | SRC_MAC              | Session source MAC                                           |
|  11  | DST_MAC              | Session destination MAC                                      |
|  12  | NIC                  | Program packet capture network card                          |
|  13  | CARD                 | The data packet originates from which specific network card (when nic specifies any, it can identify which specific network card it is) |
|  14  | CARD_IP              | The IP address of the network card from which the data packet originates |
|  15  | SRC_NET_DELAY        | Initiator latency (the interval between the destination sending a loaded packet and the sender returning an ACK) |
|  16  | DST_NET_DELAY        | Destination latency (the interval between the initiator sending a loaded packet and the destination returning an ACK) |
|  17  | NET_DELAY            | Destination latency (the interval between the initiator sending a loaded packet and the destination returning an ACK) |
|  18  | BYTES                | The total number of bytes from the beginning to the end of this session |
|  19  | HTTP_RESPONSE        | HTTP response latency (the time interval between the destination sending HTTP 200 OK and the initiator sending the last packet of the request) |
|  20  | PAGELOAD             | Page loading time, time interval between the destination sending HTTP 200 OK and the last data packet sent |
|  21  | RETCODE              | HTTP return code                                             |
|  22  | METHOD               | Request methods (POST, GET, etc.)                            |
|  23  | URL                  | Request URL                                                  |
|  24  | DOMAIN               | Domain name (e.g. www.sina. com. cn)                         |
|  25  | CONTENTTYPE          | Content type of HTTP, message type such as text, HTML, application |
|  26  | FORWARD              | The original IP address of the client will have this option for forwarded HTTP requests |
|  27  | REQ_HEADER           | HTTP request header message (before \r\n\r\n)                |
|  28  | REQ_BODY             | HTTP request message format (after \r\n\r\n)                 |
|  29  | RSP_HEADER           | HTTP response header message (before \r\n\r\n)               |
|  30  | RSP_BODY             | HTTP response message type (after \r\n\r\n)                  |
|  31  | L7_PROTOCOL          | Layer 7 protocol, currently HTTP                             |
|  32  | L4_PROTOCOL          | Layer 4 protocol, currently TCP                              |
|  33  | message              | host name                                                    |
|  34  | message-type         | Representing communication (currently outputting comm)       |
|  35  | gl2_source_collector | Probe ID, from portal configuration                          |
|  36  | DISK_RATIO           | Host disk utilization rate                                   |
|  37  | TOTAL_CPU            | Number of CPUs                                               |
|  38  | LICENSE              | Validity period information                                  |



# 🏭   SQL

MySQL, MS-SQL, Oracle, PG...

| No.  | KPI Name             | Description                                                  |
| :--: | -------------------- | ------------------------------------------------------------ |
|  1   | BEGIN_TIME           | The time of the first request packet for this session        |
|  2   | END_TIME             | The time of the last response packet in the conversation     |
|  3   | PROBE_VER            | Program version                                              |
|  4   | host                 | host name                                                    |
|  5   | SYSTEM               | operating system                                             |
|  6   | SRC_IP               | Session source IP (initiator)                                |
|  7   | DST_IP               | Session destination IP (destination)                         |
|  8   | SRC_PORT             | Session source port                                          |
|  9   | DST_PORT             | Session destination port                                     |
|  10  | SRC_MAC              | Session source MAC                                           |
|  11  | DST_MAC              | Session destination MAC                                      |
|  12  | NIC                  | Program packet capture network card                          |
|  13  | CARD                 | The data packet originates from which specific network card (when nic specifies any, it can identify which specific network card it is) |
|  14  | CARD_IP              | The IP address of the network card from which the data packet originates |
|  15  | SRC_NET_DELAY        | Initiator latency (the interval between the destination sending a loaded packet and the sender returning an ACK) |
|  16  | DST_NET_DELAY        | Destination latency (the interval between the initiator sending a loaded packet and the destination returning an ACK) |
|  17  | NET_DELAY            | SRC_NET_DELAY+DST_NET_DELAY                                  |
|  18  | BYTES                | The total number of bytes from the beginning to the end of this session |
|  19  | SQL_RESPONSE         | SQL response latency (the time interval between the initiator sending an SQL query statement and the destination sending back the first data packet) |
|  20  | SQL                  | sql statement                                                |
|  21  | RESP                 | Is there a response from the server                          |
|  22  | ERR                  | Error message                                                |
|  23  | RET_CODE             | Database return code, usually 0 indicates success, greater than 0 indicates error code |
|  24  | USER                 | Client login username                                        |
|  25  | L7_PROTOCOL          | 7 protocol, currently oracle,mysql                           |
|  26  | L4_PROTOCOL          | Layer 4 protocol, currently TCP                              |
|  27  | message              | host name                                                    |
|  28  | message-type         | Indicate information category (currently outputting comm for traffic data and proc for process data) |
|  29  | gl2_source_collector | Probe ID, from portal configuration                          |
|  30  | DISK_RATIO           | Host disk utilization rate                                   |
|  31  | TOTAL_CPU            | Number of CPUs                                               |
|  32  | LICENSE              | Validity period information                                  |



# ⚓   DNS

| No.  | KPI Name      | Description                                                  |
| :--: | ------------- | ------------------------------------------------------------ |
|  1   | BEGIN_TIME    | The time of the first request packet for this session        |
|  2   | END_TIME      | The time of the last response packet in the conversation     |
|  3   | PROBE_VER     | Program version                                              |
|  4   | SYSTEM        | operating system                                             |
|  5   | SRC_IP        | Session source IP (initiator)                                |
|  6   | DST_IP        | Session destination IP (destination)                         |
|  7   | SRC_PORT      | Session source port                                          |
|  8   | DST_PORT      | Session destination port                                     |
|  9   | SRC_MAC       | Session source MAC                                           |
|  10  | DST_MAC       | Session destination MAC                                      |
|  11  | NIC           | Program packet capture network card                          |
|  12  | CARD          | The data packet originates from which specific network card (when nic specifies any, it can identify which specific network card it is) |
|  13  | CARD_IP       | The IP address of the network card from which the data packet originates |
|  14  | RESULT_IP     | Returned IP address                                          |
|  15  | SRC_NET_DELAY | Initiator latency (the interval between the destination sending a loaded packet and the sender returning an ACK) |
|  16  | DST_NET_DELAY | Destination latency (the interval between the initiator sending a loaded packet and the destination returning an ACK) |
|  17  | NET_DELAY     | SRC_NET_DELAY+DST_NET_DELAY                                  |
|  18  | BYTES         | The total number of bytes from the beginning to the end of this session |
|  19  | DNS_RESPONSE  | Query DNS service time for domain                            |
|  20  | DOMAIN        | Query domain name                                            |
|  21  | L7_PROTOCOL   | Layer 7 protocol, currently dns                              |
|  22  | L4_PROTOCOL   | Layer 4 protocol, currently tcp                              |
|  23  | message       | host name                                                    |
|  24  | message-type  | Representing communication (currently outputting comm)       |
|  25  | DISK_RATIO    | Host disk utilization rate                                   |
|  26  | TOTAL_CPU     | Number of CPUs                                               |
|  27  | LICENSE       | Validity period information                                  |



# ⛽   Redis

| No.  | KPI Name             | Description                                                  |
| :--: | -------------------- | ------------------------------------------------------------ |
|  1   | BEGIN_TIME           | The time of the first request packet for this session        |
|  2   | END_TIME             | The time of the last response packet in the conversation     |
|  3   | PROBE_VER            | Program version                                              |
|  4   | host                 | host name                                                    |
|  5   | SYSTEM               | operating system                                             |
|  6   | SRC_IP               | Session source IP (initiator)                                |
|  7   | DST_IP               | Session destination IP (destination)                         |
|  8   | SRC_PORT             | Session source port                                          |
|  9   | DST_PORT             | Session destination port                                     |
|  10  | SRC_MAC              | Session source MAC                                           |
|  11  | DST_MAC              | Session destination MAC                                      |
|  12  | NIC                  | packet capture network card                                  |
|  13  | CARD                 | The data packet originates from which specific network card (when nic specifies any, it can identify which specific network card it is) |
|  14  | CARD_IP              | The IP address of the network card from which the data packet originates |
|  15  | SRC_NET_DELAY        | Initiator latency (the interval between the destination sending a loaded packet and the sender returning an ACK) |
|  16  | DST_NET_DELAY        | Destination latency (the interval between the initiator sending a loaded packet and the destination returning an ACK) |
|  17  | NET_DELAY            | SRC_NET_DELAY+DST_NET_DELAY                                  |
|  18  | BYTES                | The total number of bytes from the beginning to the end of this session |
|  19  | REDIS_RESPONSE       | Redis response latency (the time interval between the initiator sending a request command and the destination sending back the first data packet) |
|  20  | REQ                  | request text                                                 |
|  21  | RES                  | response text                                                |
|  22  | RESP                 | Is there a response from the server                          |
|  23  | L7_PROTOCOL          | 7 protocol, currently redis                                  |
|  24  | L4_PROTOCOL          | 4 protocol, currently tcp                                    |
|  25  | message              | host name                                                    |
|  26  | message-type         | Representing communication (currently outputting comm)       |
|  27  | gl2_source_collector | Probe ID, from portal configuration                          |
|  28  | DISK_RATIO           | Host disk utilization rate                                   |
|  29  | TOTAL_CPU            | Number of CPUs                                               |
|  30  | LICENSE              | Validity period information                                  |



# 🏍   AMQ

| Num  | KPI Name             | Description                                                  |
| ---- | -------------------- | ------------------------------------------------------------ |
| 1    | BEGIN_TIME           | The time of the first request packet for this session        |
| 2    | END_TIME             | The time of the last response packet in the conversation     |
| 3    | PROBE_VER            | Program version                                              |
| 4    | host                 | host name                                                    |
| 5    | SYSTEM               | operating system                                             |
| 6    | SRC_IP               | Session source IP (initiator)                                |
| 7    | DST_IP               | Session destination IP (destination)                         |
| 8    | SRC_PORT             | Session source port                                          |
| 9    | DST_PORT             | Session destination port                                     |
| 10   | SRC_MAC              | Session source MAC                                           |
| 11   | DST_MAC              | Session destination MAC                                      |
| 12   | NIC                  | Program packet capture network card                          |
| 13   | CARD                 | The data packet originates from which specific network card (when nic specifies any, it can identify which specific network card it is) |
| 14   | CARD_IP              | The IP address of the network card from which the data packet originates |
| 15   | SRC_NET_DELAY        | Initiator latency (the interval between the destination sending a loaded packet and the sender returning an ACK) |
| 16   | DST_NET_DELAY        | Destination latency (the interval between the initiator sending a loaded packet and the destination returning an ACK) |
| 17   | NET_DELAY            | SRC_NET_DELAY+DST_NET_DELAY                                  |
| 18   | BYTES                | The total number of bytes from the beginning to the end of this session |
| 19   | AMQ_RESPONSE         | AMQ response latency (the time interval between the initiator sending a request command and the destination sending back the first data packet) |
| 20   | HOST                 | domain name                                                  |
| 21   | EXCHANGE             | switch domain                                                |
| 22   | QUEUE                | queue name                                                   |
| 23   | METHOD               | Request method name                                          |
| 24   | TEXT                 | The transmitted message content (message content placed in or extracted from the queue) |
| 25   | RESP                 | Is there a response from the server                          |
| 26   | L7_PROTOCOL          | Layer 7 protocol, currently amq                              |
| 27   | L4_PROTOCOL          | Layer 4 protocol, currently tcp                              |
| 28   | message              | host name                                                    |
| 29   | message-type         | Indicate information category (currently outputting comm for traffic data and proc for process data) |
| 30   | gl2_source_collector | Probe ID, from portal configuration                          |
| 31   | DISK_RATIO           | Host disk utilization rate                                   |
| 32   | TOTAL_CPU            | Number of CPUs                                               |
| 33   | LICENSE              | Validity period information                                  |





------



**www.microflow.io**

**leoyoung@microflow.io**

**07/23/2023**
