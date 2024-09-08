@echo off
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" %* && exit
setlocal enabledelayedexpansion

:: Configurable variables
set "ping_target=8.8.8.8"
set "wifi_disconnect_timeout=3"
set "wifi_connect_timeout=5"
set "adapter_disable_timeout=5"
set "adapter_enable_timeout=10"
set "loop_wait_time=30"
set "retry_wait_time=5"

:: Flag for first run
set "first_run=1"

:loop
if "%first_run%"=="1" (
    echo [%date% %time%] Initial startup. Executing WiFi connection process...
    call :connection_process
    set "first_run=0"
    goto loop
)

echo [%date% %time%] Checking internet connection...
ping -n 1 %ping_target% >nul 2>&1
if !errorlevel! neq 0 (
    call :connection_process
) else (
    echo Internet connection is active and stable.
)

timeout /t %loop_wait_time% >nul
goto loop

:connection_process
:retry_connection
echo No Internet connection detected. Initiating WiFi connection process...
echo Disconnecting from current WiFi network...
netsh wlan disconnect >nul 2>&1
timeout /t %wifi_disconnect_timeout% >nul

echo Attempting to connect to an available remembered network...
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profile ^| findstr /c:"All User Profile"') do (
    set "network=%%a"
    set "network=!network:~1!"
    echo Trying to connect to !network!...
    netsh wlan connect name="!network!" >nul 2>&1
    timeout /t %wifi_connect_timeout% >nul
    ping -n 1 %ping_target% >nul 2>&1
    if !errorlevel! equ 0 (
        echo SUCCESS: Connected to !network! and internet is accessible.
        goto :eof
    )
)

echo WiFi connection failed. Restarting network adapter...
netsh interface set interface name="Wi-Fi" admin=disable >nul 2>&1
timeout /t %adapter_disable_timeout% >nul
netsh interface set interface name="Wi-Fi" admin=enable >nul 2>&1
timeout /t %adapter_enable_timeout% >nul

ping -n 1 %ping_target% >nul 2>&1
if !errorlevel! equ 0 (
    echo SUCCESS: Internet connection restored after adapter restart.
    goto :eof
) else (
    echo ERROR: Internet connection could not be restored. Retrying...
    timeout /t %retry_wait_time% >nul
    goto retry_connection
)