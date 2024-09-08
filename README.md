# Wi-Fi Auto-Connect Script

A Windows batch script that automates Wi-Fi connectivity, ensuring you stay connected to the internet by continuously attempting to connect to available remembered networks.

## Features

- Automatically connects to the first available remembered Wi-Fi network
- Restarts the network adapter if connection attempts fail
- Continuously retries until an internet connection is established
- Configurable wait times for performance optimization
- Runs minimized in the background

## Requirements

- Windows operating system
- Administrative privileges to execute network commands

## Quick Start

1. Download `wifi_auto_connect.bat` to your Windows PC.
2. Right-click the script and select "Run as administrator".
3. The script will minimize itself and start monitoring your internet connection.

## Detailed Usage

1. Open the script in a text editor to customize settings (optional).
2. Run the script with administrative privileges.
3. The script will:
   - Check internet connectivity at regular intervals
   - Attempt to connect to remembered Wi-Fi networks if the connection is lost
   - Restart the network adapter if connection attempts fail
   - Repeat this process until an internet connection is established

## Configuration

Customize the script by modifying these variables at the beginning:

```batch
set "ping_target=8.8.8.8"
set "wifi_disconnect_timeout=3"
set "wifi_connect_timeout=5"
set "adapter_disable_timeout=5"
set "adapter_enable_timeout=10"
set "loop_wait_time=30"
set "retry_wait_time=5"
```

- `ping_target`: IP address to ping for checking internet connectivity
- `wifi_disconnect_timeout`: Wait time after disconnecting from Wi-Fi (seconds)
- `wifi_connect_timeout`: Wait time for Wi-Fi connection attempts (seconds)
- `adapter_disable_timeout`: Wait time after disabling the network adapter (seconds)
- `adapter_enable_timeout`: Wait time after enabling the network adapter (seconds)
- `loop_wait_time`: Interval between internet connection checks (seconds)
- `retry_wait_time`: Wait time before retrying the connection process (seconds)

## How It Works

1. The script pings the specified IP address to verify internet connectivity.
2. If the connection is lost, it attempts to connect to remembered Wi-Fi networks.
3. If no connection is established, it restarts the network adapter.
4. This process repeats until an internet connection is restored.

## Security Considerations

- The script automatically connects to the first available remembered Wi-Fi network.
- Ensure you've removed any unsecured or unwanted networks from your list of remembered networks before using this script.
- Be cautious when using this script on public or shared computers.

## Troubleshooting

- If the script isn't working as expected, try increasing the timeout values.
