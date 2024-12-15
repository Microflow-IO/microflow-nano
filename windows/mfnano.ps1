$scriptDir = ""
$uniserver = "218.16.178.148:9000"  
$token = "td8hmfdis9cpgoqt2jcv7q688aq808eft04p6vkl3lnppj6m9q6"

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
  Write-Output "This script requires administrator privileges"
  Read-Host -Prompt "Press any key to exit the script ..."
  exit 1
}

Write-Output "############## Write server addr and token ################"
$uniserver > "tmp/uniserver-addr.txt"
$token > "tmp/uniserver-token.txt"
$scriptDir = Split-Path $MyInvocation.MyCommand.Path
Set-Location -Path $scriptDir
Write-Output "$scriptDir"

Write-Output "############## Kill all ps1 and worker ################"
$tmpstr = wmic process where "name='PowerShell.exe'" get ProcessId,CommandLine | findstr autoupdate.ps1
if ($tmpstr -ne $null -and $tmpstr -ne "") {
  $number = [regex]::Match($tmpstr.TrimEnd(), '\d+$').Value
  $number > tmp/autoupdate.ps1.pid.tmp
  Write-Output "Terminating autoupdate.ps1 with PID: $number"
  TASKKILL /F /PID $number /T
  TASKKILL /F /IM mfnano-worker.exe /T
}

cd $scriptDir
Write-Output "############## Make auto startup link for autoupdate.ps1 ################"
$lnkPath="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\autoupdate.vbs"
Write-Output "Delete auto startup symbolic link ..."
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\autoupdate.vbs" 2>&1 >$null
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\mfnano.vbs" 2>&1 >$null
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\mfnano.ps1" 2>&1 >$null

Write-Output "############## Creating auto startup symbolic link ################"
$scriptPath = Join-Path -Path $scriptDir -ChildPath 'autoupdate.ps1'
$shortcutPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Autoupdate.lnk"
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)

$shortcut.TargetPath = "powershell.exe"
$shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`""
$shortcut.WorkingDirectory = "$scriptDir"
$shortcut.Description = "Run Autoupdate Script at Startup"
$shortcut.IconLocation = "powershell.exe, 0"
$shortcut.WindowStyle = 7

$shortcut.Save()
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("mfnano autoupdate running background ...", "пео╒", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

echo "##############Check autoupdate.ps1 already running ################-"
$tmpstr = wmic process where "name='PowerShell.exe'" get ProcessId,CommandLine | findstr autoupdate.ps1
if ($tmpstr -ne $null -and $tmpstr -ne "") {
  Write-Host "mfnano autoupdate already running ..."
  Read-Host -Prompt "Press any key to exit the script ..."
  exit
}

Write-Host "##############Start autoupdate.ps1 ... ################-"
Start-Sleep -Seconds 5
Unblock-File -Path autoupdate.ps1
Start-Process powershell -ArgumentList "-NoProfile -File `"$scriptPath`"" -WindowStyle Hidden
Read-Host -Prompt "Press any key to continue ..."
