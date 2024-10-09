# 公有云部署

使用下面命令一键在线安装

```bash
curl https://raw.githubusercontent.com/Microflow-IO/microflow-sentinel/refs/heads/main/mfs-install.sh | bash -x
```

会将mfs安装到/usr/local/bin目录

```bash
[root@racknerd-b20bda0 linux]# ls -al /usr/local/bin/
-rwxr-xr-x.  1 root root  1409223 Oct  9 04:12 mfs
```

使用在线配置文件将探针连接到http://218.16.178.146:9000/数据平台，用户名/密码：admin/admin@123

```bash
mfs https://raw.githubusercontent.com/Microflow-IO/microflow-sentinel/refs/heads/main/linux/mfs.conf
```

探针会自动下载配置文件，并保存到/etc/mfs

```bash
[root@racknerd-b20bda0 linux]# ls -al /etc/mfs/
-rw-r--r--.  1 root root  491 Oct  9 04:13 mfs-url.conf
```

也可以手动修改上面配置文件，根据自己需求运行，修改完毕后用如下命令运行

```bash
[root@racknerd-b20bda0 linux]# mfs /etc/mfs/mfs-url.conf
```

配置文件内容解释如下

```bash
# 值为1会自动检查应用层协议
auto-check=1
# 使用base64编码导出JSON流量日志
base64=
# 监听网卡名，any为全部
device=any
filter-net=
l4-switch=net
# 本地存放JSON格式流量日志路径
json-path=
# 本地存放JSON格式每个流量日志文件总大小，单位为MB（必须大于110），每个文件固定50MB
json-size=
# 本地存放原始数据包路径
pcap-path=
# 本地存放每个原始数据包文件总大小，单位为MB（必须大于110）
pcap-size=
# 本地存放每个原始数据包文件大小，单位为MB（必须大于110）
pcap-file-size=
# BPF抓包过滤条件
filter-bpf=
# 数据包捕获长度
max-length=
proto=
# 监控主机TOPN进程，不要写太大，每个进程会每分钟发送一次
proclist=2
source=
bytecode=
play=
forward=
# 监控主机TOPN进程，不要写太大，每个进程会每分钟发送一次
interval=10
# 应用层解析请求体响应体最大长度
bodylen=1024
license=
jsonsample=
ignorel7=
# 值为1，流量日志加密发送
encrypt=
forward-ip=
# 下面字段不要修改
exp-domain=218.16.178.146:12201
graylog=218.16.178.146:9000
token=dahvtggeh3v048k20dpsnlcfcadc0haogcs9afoluup5o2o9j95
drop=218.16.178.146:9000
probe-id=24447682964177
sys-version=20241006-45-972
host-address=198.46.233.196

```
