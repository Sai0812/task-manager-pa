# TaskPilot - Always-on-Top Launcher
# Double-click TaskPilot.bat to run this

param([switch]$AddToStartup, [switch]$RemoveFromStartup)

Add-Type -AssemblyName System.Windows.Forms

# ===== STARTUP MANAGEMENT =====
$startupFolder = [System.Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupFolder "TaskPilot.lnk"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$batPath = Join-Path $scriptDir "TaskPilot.bat"

if ($AddToStartup) {
    $ws = New-Object -ComObject WScript.Shell
    $sc = $ws.CreateShortcut($shortcutPath)
    $sc.TargetPath = $batPath
    $sc.WorkingDirectory = $scriptDir
    $sc.Description = "TaskPilot - Personal Task Manager"
    $sc.WindowStyle = 7  # minimized
    $sc.Save()
    [System.Windows.Forms.MessageBox]::Show("TaskPilot will now auto-start when you log in!`n`nTo remove, run: TaskPilot.bat /remove", "TaskPilot - Startup Enabled", 0, 64)
    exit
}

if ($RemoveFromStartup) {
    if (Test-Path $shortcutPath) {
        Remove-Item $shortcutPath -Force
        [System.Windows.Forms.MessageBox]::Show("TaskPilot removed from startup.", "TaskPilot", 0, 64)
    } else {
        [System.Windows.Forms.MessageBox]::Show("TaskPilot is not in startup.", "TaskPilot", 0, 64)
    }
    exit
}

# ===== ALWAYS-ON-TOP LAUNCHER =====
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {
    [DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
    public static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
    public const uint SWP_SHOWWINDOW = 0x0040;
}
"@

$url = "https://sai0812.github.io/task-manager-pa/"
$width = 420
$height = 700

$screen = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
$posX = $screen.Width - $width - 20
$posY = $screen.Height - $height - 20

# Find browser
$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$edgeAlt = "${env:ProgramFiles}\Microsoft\Edge\Application\msedge.exe"

$browser = $null
if (Test-Path $edgePath) { $browser = $edgePath }
elseif (Test-Path $edgeAlt) { $browser = $edgeAlt }
elseif (Test-Path $chromePath) { $browser = $chromePath }

if (-not $browser) {
    [System.Windows.Forms.MessageBox]::Show("Could not find Edge or Chrome.", "TaskPilot", 0, 48)
    exit
}

# Launch in app mode
$proc = Start-Process -FilePath $browser -ArgumentList "--app=$url", "--window-size=$width,$height", "--window-position=$posX,$posY", "--disable-extensions", "--new-window" -PassThru

# Wait and pin always-on-top
Start-Sleep -Seconds 3

$hwnd = $proc.MainWindowHandle
if ($hwnd -ne [IntPtr]::Zero) {
    [WinAPI]::SetWindowPos($hwnd, [WinAPI]::HWND_TOPMOST, $posX, $posY, $width, $height, [WinAPI]::SWP_SHOWWINDOW)
    [WinAPI]::SetForegroundWindow($hwnd)
    Write-Host "TaskPilot is running always-on-top!" -ForegroundColor Magenta
    Write-Host "Close the browser window to exit." -ForegroundColor Gray
} else {
    Write-Host "TaskPilot launched!" -ForegroundColor Yellow
    Write-Host "Tip: If always-on-top didn't work, try closing other Edge windows first." -ForegroundColor Gray
}
