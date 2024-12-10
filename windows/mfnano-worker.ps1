$uniserver = $args[0]  
$token = $args[1]
$worker_ps1_version = "20241016-38"
$strdate = date

$exp_domain="none"
"$strdate : start mfnano-worker.ps1 $uniserver $token" > tmp/mfnano-worker-ps1.log
del tmp/mfnano-worker-ps1.log.2*
del tmp/autoupdate-ps1.log.2*
del tmp/mfnano-worker.log.2*
"$strdate : ==============-Get version================" >> tmp/mfnano-worker-ps1.log
.\mfnano-worker.exe -k > tmp/worker_exe_version.txt
$fileContent = Get-Content -Path tmp/worker_exe_version.txt -Raw
$fileContent = $fileContent.Trim()
$version="$worker_ps1_version-$fileContent"
"Worker ps1 version : $worker_ps1_version" >> tmp/mfnano-worker-ps1.log
"Worker exe version : $worker_exe_version" >> tmp/mfnano-worker-ps1.log
"full version: $version" >> tmp/mfnano-worker-ps1.log
"." >> tmp/mfnano-worker-ps1.log

"$strdate : ==============-Get Hostname================" >> tmp/mfnano-worker-ps1.log
$hname=hostname
"Hostname : $hname" >> tmp/mfnano-worker-ps1.log
echo . >> tmp/mfnano-worker-ps1.log

"$strdate : ==============-Get IP(first gateway)================" >> tmp/mfnano-worker-ps1.log
$gateway = (Get-NetRoute -DestinationPrefix "0.0.0.0/0")[0].NextHop
$ipAddresses = Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop | Select-Object -ExpandProperty IPAddress
$ipAddress=""
foreach ($tmp in $ipAddresses) {
  $ipAddress=$tmp
  $aa=ping -n 1 $gateway -S $ipAddress
  if($LASTEXITCODE -eq 0){
    break
  }
}
"Default gateway: $gateway" >> tmp/mfnano-worker-ps1.log
"IPv4 Address: $ipAddress" >> tmp/mfnano-worker-ps1.log
"." >> tmp/mfnano-worker-ps1.log

"$strdate : ==============-Get MAC(first gateway)================" >> tmp/mfnano-worker-ps1.log
$adapters = Get-NetAdapter
$ipcollect = Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias $adapters.InterfaceAlias
$mac=""
foreach ($tmp in $adapters) {  
  foreach ($tmpip in $ipcollect | Where-Object { $_.InterfaceAlias -eq $tmp.InterfaceAlias }) {  
    if($($tmpip.IPAddress) -eq $ipAddress){
      $mac=$tmp.LinkLayerAddress.Replace("-", "")
      break
    }
  }  
}
"MAC Address: $mac" >> tmp/mfnano-worker-ps1.log
"." >> tmp/mfnano-worker-ps1.log

"$strdate : ==============-create local host info================" >> tmp/mfnano-worker-ps1.log
'{' > tmp/heart.json
$tmp = '  "node_name": "' + "$ipAddress-$hname" + '",' 
$tmp >> tmp/heart.json
'  "node_details": {' >> tmp/heart.json
'     "operating_system": "windows",' >> tmp/heart.json
'     "ip": "lo eth0"' >> tmp/heart.json
'  }' >> tmp/heart.json
'}' >> tmp/heart.json
"." >> tmp/mfnano-worker-ps1.log

"$strdate : ==============-send heart to server================" >> tmp/mfnano-worker-ps1.log
$headers = @{
    "Content-Type" = "application/json";
    "X-Graylog-Sidecar-Version" = "20241016-38-955";
    "X-Requested-By" = "1";
    "Authorization" = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$token`:token"))
}
$url = "http://$uniserver/api/sidecars/$mac`?pretty=true"
$body = Get-Content -Path "tmp/heart.json" -Raw
"Invoke-WebRequest -Uri $url -Method Put -Headers $headers -Body $body" >> tmp/mfnano-worker-ps1.log
$tmp = (Invoke-WebRequest -Uri $url -Method Put -Headers $headers -Body $body).content
"." >> tmp/mfnano-worker-ps1.log

"$strdate : ==============-get config id from heart info================" >> tmp/mfnano-worker-ps1.log
$tmp > tmp/heartrsp.json
$tmp = $tmp | ConvertFrom-Json
$config_id=$tmp.assignments[0].configuration_id
Write-Output "configure id £º$config_id"
"configure id £º$config_id" >> tmp/mfnano-worker-ps1.log
"." >> tmp/mfnano-worker-ps1.log

"$strdate : ==============-get cmd info from config id================" >> tmp/mfnano-worker-ps1.log
$headers = @{
    "Accept" = "application/json";
    "Authorization" = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$token`:token"))
}
$url = "http://$uniserver/api/sidecar/configurations/$config_id`?pretty=true"
"Invoke-WebRequest -Uri $url -Method Get -Headers $headers" >> tmp/mfnano-worker-ps1.log
$configString = ""
try {
  $tmp = (Invoke-WebRequest -Uri $url -Headers $headers -Method Get).content
  $tmp = $tmp | ConvertFrom-Json
  $configString = $tmp.template
} catch { 
  Write-Error "An error occurred while fetching the configuration"  
}
$configString >> tmp/mfnano-worker-ps1.log
"." >> tmp/mfnano-worker-ps1.log

$configString | Out-File -Encoding ascii tmp/mfnano.conf.tmp
"device=$ipAddress" | Out-File -Encoding ascii -Append tmp/mfnano.conf.tmp
"probe-id=$mac" | Out-File -Encoding ascii -Append tmp/mfnano.conf.tmp
"sys-version=$version" | Out-File -Encoding ascii -Append tmp/mfnano.conf.tmp
"host-address=$ipAddress" | Out-File -Encoding ascii -Append tmp/mfnano.conf.tmp
"run-mode=front" | Out-File -Encoding ascii -Append tmp/mfnano.conf.tmp

"$strdate : ==============checking cmd changed================"  >> tmp/mfnano-worker-ps1.log
$newcmd = ""
$oldcmd = ""
if (Test-Path -Path mfnano.conf -PathType Leaf) {
  $oldcmd = Get-Content -Path mfnano.conf -Raw -ErrorAction Stop
}
$newcmd = Get-Content -Path tmp/mfnano.conf.tmp -Raw -ErrorAction Stop
if ($oldcmd -eq $newcmd) {
  "cmd not change" >> tmp/mfnano-worker-ps1.log
} else {
  "cmd changed, kill mfnano-worker" >> tmp/mfnano-worker-ps1.log
  TASKKILL /F /IM mfnano-worker.exe /T
  del mfnano.conf
  copy tmp/mfnano.conf.tmp mfnano.conf
}
$tmp = -split $newcmd
foreach ($str in $tmp) {
  $parts = $str.Split('=')
  if ($parts[0].Trim() -eq "exp-domain") {
    $exp_domain = $parts[1].Trim()
    "exp domain : $exp_domain" >> tmp/mfnano-worker-ps1.log
  }
}

"$strdate : ==============Splicing command strings================"  >> tmp/mfnano-worker-ps1.log
$cmdresult="mfnano-worker.exe --config-file mfnano.conf"
"command : $cmdresult" >> tmp/mfnano-worker-ps1.log
"." >> tmp/mfnano-worker-ps1.log

"$strdate : ==============check worker file ....================" >> tmp/mfnano-worker-ps1.log
$fileSize=(dir mfnano-worker.exe)[0].length
"worker file size is: $fileSize" >> tmp/mfnano-worker-ps1.log
if (Get-CimInstance Win32_Process -Filter "Name='mfnano-worker.exe'") {
  "mfnano-worker is running" >> tmp/mfnano-worker-ps1.log
} else {
  if ($fileSize -gt 500000) {
    echo "$strdate : start $cmdresult" >> tmp/mfnano-worker-ps1.log
    timeout /t 3
    Start-Process cmd -ArgumentList "/c $cmdResult" -NoNewWindow
  }
}

"$strdate : ==============run coll ....================" >> tmp/mfnano-worker-ps1.log
$cpu=""
$sum=0.0
$count=0
$cwa=0.0
$cpu=0.0
$cpuCore=(Get-WmiObject -Class Win32_Processor).NumberOfCores
$memoryTotal=0.0
$memoryFree=0.0
$memoryRatio=0.0
$mem=0.0
$load=Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty LoadPercentage
$useRate=0.0
$totalSize=0
$totalUsedSpace=0

$cpuLoads = Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty LoadPercentage
foreach ($tmp in $cpuLoads) {
  $sum += $tmp
  $count += 1
}
$cpu = $sum / $count
if ($cpu -eq 0) {
  $cpu = 0.1  
}

$memory=(Get-WmiObject -Class Win32_OperatingSystem).TotalVisibleMemorySize
$memory_free=(Get-WmiObject -Class Win32_OperatingSystem).FreePhysicalMemory
$memoryTotal=$memory / 1048576
$memoryFree=$memory_free / 1048576
$memoryUsage=$memoryTotal - $memoryFree
if ($memoryUsage -lt 0) {
  $memoryUsage = 0
}
if ($memoryTotal -ne 0) {
  $memoryRatio = ($memoryUsage / $memoryTotal) * 100
} else {
  $memoryRatio = 0
}
$processInfo = tasklist | Select-String "PowerShell.exe"
Write-Output "processInfo : $processInfo"
$smemtmp = [regex]::Match($processInfo, '\b\d{1,3}(?:,\d{3})*(?=\s+K)\b')
$smemtmp = $smemtmp.Value.Replace(",", "")
$smemtmp = $smemtmp / 1048576
$smem = "{0:F1}" -f $smemtmp

$disks = wmic logicaldisk get Caption,Size,freespace /format:csv | ConvertFrom-Csv -Delimiter ','
foreach ($disk in $disks) {
  $size = [int]($disk.Size/1048576/1024)
  $freeSpace = [int]($disk.FreeSpace/1048576/1024)
  $usedSpace = $size - $freeSpace
  $totalSize += $size
  $totalUsedSpace += $usedSpace
}

if ($totalUsedSpace -gt $totalSize) {
  $useRate = 100
} else {
  $useRateDecimal = ($totalUsedSpace / $totalSize) * 100
  $useRate = "{0:F2}" -f $useRateDecimal
}
$useRate = [int]$useRate
$memoryTotal = [int]$memoryTotal
$memoryUsage = [int]$memoryUsage
$memoryRatio = [int]$memoryRatio

$json = @"
{"source": "$ipAddress","host": "$ipAddress","host_name":"$hname","host_cpu":"$cpu","host_cpu_core":"$cpuCore","host_mem":"$memoryRatio","host_mem_usage":"$memoryUsage","host_mem_total":"$memoryTotal","host_load":"$load","host_wa":"0","host_disk_use":"$totalUsedSpace","host_disk_total":"$totalSize","host_disk":"$useRate","proc_name":"","proc_pid":"","self_cpu":"","self_mem":"$smem","proc_cpu":"","proc_mem":"","proc_sts":"R","probe_ver":"$version","gl2_source_collector":"$mac","message-type":"proc","message":"$hname"}
"@
Set-Content -Path "tmp/json.txt" -Value $json -Encoding ascii
Write-Output "send coll : .\mfnano-worker.exe -p $exp_domain tmp/json.txt"
"send coll : .\mfnano-worker.exe -p $exp_domain tmp/json.txt" >> tmp/mfnano-worker-ps1.log
.\mfnano-worker.exe -p $exp_domain tmp/json.txt

@'  
wmic process where "name='powershell.exe'" get ProcessId,CommandLine  
wmic process where "name='mfnano-worker.exe'" get ProcessId,CommandLine  
pause  
'@ | Out-File -FilePath 'tmp/proclist.ps1' -Force
