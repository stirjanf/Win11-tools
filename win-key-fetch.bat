@echo off
setlocal

NET SESSION >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process cmd.exe -ArgumentList '/c', '%~f0' -Verb RunAs"
    exit /b
)

powershell -ExecutionPolicy Bypass -Command ^
    "$key = (Get-WmiObject -Query 'Select * from SoftwareLicensingService').OA3xOriginalProductKey;" ^
    "if ($null -eq $key) {" ^
    "   Write-Host 'OEM key doesn''t exist';" ^
    "} else {" ^
    "   $dsktp = Join-Path $env:USERPROFILE 'Desktop';" ^
    "   $hostname = [System.Environment]::MachineName;" ^
    "   $edition = (Get-CimInstance -ClassName Win32_OperatingSystem).Caption;" ^
    "   $filename = $hostname + ' - ' + $edition + ' key.txt';" ^
    "   $file = Join-Path $dsktp $filename;" ^
    "   $txt = '(' + $hostname + ') ' + $edition + ' license key: ' + $key;" ^
    "   $txt | Out-File -FilePath $file;" ^
    "   $txt;" ^
    "   Write-Host '';" ^
    "}" ^
    "Read-Host -Prompt 'Press any key to exit...';"

endlocal