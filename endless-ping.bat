@echo off
setlocal

set ip=8.8.8.8

powershell -ExecutionPolicy Bypass -Command ^
    "$ip = '%ip%'; " ^
    "Clear-Host; " ^
    "if (-not (Test-Path 'C:\Logs')) { " ^
    "    New-Item 'C:\Logs' -ItemType Directory -Force | Out-Null; " ^
    "} " ^
    "$log = 'C:\Logs\ping.log'; " ^
    "$line = '-' * 75; " ^
    "Add-Content -Path $log -Value $line; " ^
    "Add-Content -Path $log -Value ''; " ^
    "$i = 1; " ^
    "while ($true) { " ^
    "    $time = Get-Date -Format '|dd.MM.yyyy, HH:mm:ss|'; " ^
    "    $line = \"[$($i).]   $($time)\"; " ^
    "    Write-Host \"$($line)\"; " ^
    "    Add-Content -Path $log -Value $line; " ^
    "    $line = cmd /c \"ping $ip -n 1\" | Out-String; " ^
    "    Write-Host \"$($line)\"; " ^
    "    Add-Content -Path $log -Value $line; " ^
    "    $i++; " ^
    "    Start-Sleep -Seconds 1; " ^
    "}"

endlocal