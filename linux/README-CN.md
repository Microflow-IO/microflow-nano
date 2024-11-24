使用以下命令进行一键在线安装

```bash
curl https://raw.githubusercontent.com/Microflow-IO/microflow-sentinel/refs/heads/main/mfs-install.sh | bash -x
```

这将会在 `/usr/local/bin` 目录下安装 `mfs`，它是一个脚本程序

```
root@VM-16-2-ubuntu:~# ls -al /usr/local/bin/
-rwxr-xr-x.  1 root root  1409223 Oct  9 04:12 mfs
```

启动 mfs

```
nohup /usr/local/bin/mfs > /dev/null 2>&1 &
```

Mfs 会创建 `/usr/local/bin/mfs-worker`，它是一个工作程序

```
root@VM-16-2-ubuntu:~# ls -al /usr/local/bin/
-rwxr-xr-x.  1 root root  1408113 Oct  9 04:12 mfs-worker
```

Mfs 会创建 `/etc/mfs/mfs-conf.sh`

脚本会执行该文件以获取工作程序的配置

您可以编辑此文件以从自己的服务器获取配置

默认情况下配置来源为：http://stu.jxit.net.cn:88/uniprobe/mfs/linux/mfs.conf

```
[root@ecs-2d16-0001 uniprobe]# cat /etc/mfs/mfs-conf.sh 
curl -s http://stu.jxit.net.cn:88/uniprobe/mfs/linux/mfs.conf
```

配置将保存到 `/etc/mfs/mfs.conf`

```
root@VM-16-2-ubuntu:~# cat /etc/mfs/mfs.conf 
device=any
exp-domain=demo.microflow.io:12201
token=1hafs2nigai62j9fm8eau6c5d6qb4e9725rqeaohj9u58gpvfm21
license=
...
```

部分重要配置选项如下，其余内容在文档末尾：

- **device**：捕获数据包的网卡，`any` 表示所有网卡
- **exp-domain**：使用 UDP GELF 格式发送 JSON 结果
- **license**：运行 3 个月后需要许可证码

配置文件内容的解释：

```
# 使用 UDP GELF 格式发送 JSON 结果
exp-domain=demo.microflow.io:12201
# 设置为 1 启用自动应用层协议检查
auto-check=1
# 使用 base64 编码导出流量日志（JSON 格式）
base64=
# 监控的网络接口，“any” 表示所有接口
device=any
filter-net=
l4-switch=net
# 存储 JSON 格式流量日志的路径
json-path=
# 每个 JSON 日志文件的最大大小（单位：MB，必须大于 110），固定为每文件 50MB
json-size=
# 存储原始数据包的路径
pcap-path=
# 每个原始数据包文件的总大小（单位：MB，必须大于 110）
pcap-size=
# 每个原始数据包文件的大小（单位：MB，必须大于 110）
pcap-file-size=
# BPF 捕获过滤器
filter-bpf=
# 最大数据包捕获长度
max-length=
proto=
# 监控主机上 TOPN 进程，避免设置过高，因为每个进程每分钟发送一次数据
proclist=2
source=
bytecode=
play=
forward=
# 主机 TOPN 进程的监控间隔，避免设置过高
interval=10
# 应用层请求/响应体解析的最大长度
bodylen=1024
license=
jsonsample=
ignorel7=
# 设置为 1 加密发送的流量日志数据
encrypt=
forward-ip=
# 以下字段不要修改
probe-id=24447682964177
sys-version=20241006-45-972
host-address=198.46.233.196
```
