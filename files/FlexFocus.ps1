# Set the PowerShell process priority to Idle (very low CPU usage)
$proc = Get-Process -Id $PID
$proc.PriorityClass = 'BelowNormal'

# Define the monitored apps
$flexLauncher = "flex-launcher"
$otherApps = @("firefox", "brave", "kodi", "retroarch", "sor4", "supertuxkart", "tmnt")

# Import necessary Win32 functions
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    [DllImport("user32.dll")]
    public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
}
"@

# Main loop
while ($true) {
    $flex = Get-Process -Name $flexLauncher -ErrorAction SilentlyContinue
    if ($flex) {
        $shouldFocus = $true

        foreach ($app in $otherApps) {
            if (Get-Process -Name $app -ErrorAction SilentlyContinue) {
                $shouldFocus = $false
                break
            }
        }

        if ($shouldFocus) {
            $hwnd = ($flex | Select-Object -First 1).MainWindowHandle
            if ($hwnd -ne 0) {
                [Win32]::ShowWindowAsync($hwnd, 9) | Out-Null
                [Win32]::SetForegroundWindow($hwnd) | Out-Null
            }
        }
    }

    Start-Sleep -Seconds 30
}
