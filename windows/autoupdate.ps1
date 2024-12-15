$uniserver = Get-Content -Path "tmp/uniserver-addr.txt"
$token = Get-Content -Path "tmp/uniserver-token.txt"

$lps1_file="mfnano-worker.ps1"
$lworker_file="mfnano-worker.exe"

$rpath_url="http://$uniserver/up-install"
$rps1_file="tmp/remote-mfnano-worker.ps1"
$rps1_url="$rpath_url/mfnano-worker.ps1"
$rworker_file="tmp/remote-mfnano-worker.exe"
$rworker_url="$rpath_url/mfnano-worker.exe"
$cnt = 0

$strdate = date
if (-not (Test-Path "tmp")) {
  New-Item -ItemType Directory -Path "tmp"
}
"$strdate : Invoke-WebRequest -Uri $rpath_url -OutFile tmp/url.txt" > tmp/autoupdate-ps1.log
Invoke-WebRequest -Uri $rpath_url -OutFile tmp/url.txt
$fileContent = Get-Content -Path tmp/url.txt -Raw

while ($true) {
  if ($cnt -ge 1000) {
    "" > tmp/autoupdate-ps1.log
    $cnt = 0
  }
  $cnt = $cnt + 1

  "##############Get remote mfnano-worker.ps1################-" >> tmp/autoupdate-ps1.log
  Write-Output "##############Get remote mfnano-worker.ps1################-"
  if ($fileContent.Contains($lps1_file)) {
    "$strdate : Invoke-WebRequest -Uri $rps1_url -OutFile $rps1_file" >> tmp/autoupdate-ps1.log
    $error_message = Invoke-WebRequest -Uri $rps1_url -OutFile $rps1_file
    if ($error_message -ne $null -and $error_message.Trim() -ne "") {
      "get $rps1_url failed!" >> tmp/autoupdate-ps1.log
    } else {
      "get $rps1_url successful!" >> tmp/autoupdate-ps1.log
    }
  } else {
    "$strdate : $rps1_url do not extist ..." >> tmp/autoupdate-ps1.log
  }
  Write-Output .

  "##############Check mfnano-worker.ps1 need replace################-"  >> tmp/autoupdate-ps1.log
  Write-Output "##############Check mfnano-worker.ps1 need replace################-"
  if (Test-Path -Path $lps1_file -PathType Leaf) {
    $diff = Compare-Object -ReferenceObject (Get-Content -Path $lps1_file) -DifferenceObject (Get-Content -Path $rps1_file)
    if (!$diff) {
      "$strdate : $lps1_file is newest, no update" >> tmp/autoupdate-ps1.log
    } else {
      del $lps1_file
      copy $rps1_file $lps1_file
      "$strdate : $lps1_file is diff $rps1_file, replaced" >> tmp/autoupdate-ps1.log
    }
  }
  Write-Output .

  "##############Get remote mfnano-worker################-" >> tmp/autoupdate-ps1.log
  Write-Output "##############Get remote mfnano-worker################-"
  if ($fileContent.Contains($lworker_file)) {
    "$strdate : Invoke-WebRequest -Uri $rworker_url -OutFile $rworker_file" >> tmp/autoupdate-ps1.log
    $error_message = Invoke-WebRequest -Uri $rworker_url -OutFile $rworker_file
    if ($error_message -ne $null -and $error_message.Trim() -ne "") {
      "get $rworker_url failed!" >> tmp/autoupdate-ps1.log
    } else {
      "get $rworker_url successful!" >> tmp/autoupdate-ps1.log
    }
  } else {
    "$strdate : $rworker_url do not extist ..." >> tmp/autoupdate-ps1.log
  }
  Write-Output .

  "##############Check mfnano-worker need replace################-"  >> tmp/autoupdate-ps1.log
  Write-Output "##############Check mfnano-worker need replace################-"
  if (Test-Path -Path $lworker_file -PathType Leaf -and Test-Path -Path $rworker_file -PathType Leaf) {
    $hash1 = (Get-FileHash -Path $lworker_file -Algorithm MD5).Hash
    $hash2 = (Get-FileHash -Path $rworker_file -Algorithm MD5).Hash
    if ($hash1 -ne $hash2) {
      TASKKILL /F /IM mfnano-worker.exe /T
      Sleep 1
      del $lworker_file
      copy $rworker_file $lworker_file
      "$strdate : $lworker_file is diff $rworker_file, replaced" >> tmp/autoupdate-ps1.log
    } else {
      "$strdate : $lworker_file is newest, no update" >> tmp/autoupdate-ps1.log
    }
  }
  Write-Output .

  "##############start mfnano-worker.ps1################-" >> tmp/autoupdate-ps1.log
  $powershellProcesses = Get-Process powershell -ErrorAction SilentlyContinue
  $found = $false
  foreach ($process in $powershellProcesses) {
    try {
      $commandLine = $process.MainModule.FilePath + " " + $process.StartInfo.Arguments
      if ($commandLine.Contains($lps1_file)) {
        $found = $true
        break
      }
    } catch {
      continue
    }
  }
  if (!$found) {
    Unblock-File -Path "$lps1_file"
    & powershell.exe -File "$lps1_file" "$uniserver" "$token"
    Write-Output "$lps1_file started." >> tmp/autoupdate-ps1.log
  } else {
    Write-Output "$lps1_file is already running." >> tmp/autoupdate-ps1.log
  }
  Write-Output .
  Start-Sleep -Seconds 50
}
