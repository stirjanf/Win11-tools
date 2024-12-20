@echo off
setlocal

NET SESSION >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process cmd.exe -ArgumentList '/c', '%~f0' -Verb RunAs"
    exit /b
)
cls

powershell -ExecutionPolicy Bypass -Command ^
    "$domain = 'domain'; " ^
    "do { " ^
    "    $err = $false; " ^
    "    ping 'dns-server'; " ^
    "    ipconfig /flushdns; " ^
    "    ping 'dns-server'; " ^
    "    try { " ^
    "        Add-Computer -DomainName $domain -ErrorAction Stop; " ^
    "    } catch { " ^
    "        Write-Host 'An error occurred: $($_.Exception.Message)`n'; " ^
    "        $err = $true; " ^
    "    } " ^
    "} while ($err); " ^
    "$accept = Read-Host 'Restart computer now? (y/n)'; " ^
    "if ($accept -eq 'y') { Restart-Computer -Force }; " ^
    "exit"

endlocal