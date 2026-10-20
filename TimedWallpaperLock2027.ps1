# 1. Target Date Setup (5 January 2027)
$triggerDate = [DateTime]"2027-01-05"
$currentDate = Get-Date

# Exact path to your image in C:\New folder
$ImagePath = "C:\New folder\daniel-leone-v7daTKlZzaw-unsplash.jpg"

# Registry paths for enforcement
$SystemPolicies = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$ActiveDesktop   = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop"

# 2. Dynamic Check
if ($currentDate -ge $triggerDate) {
    # =========================================================================
    # ON OR AFTER JAN 5, 2027: Apply Custom Wallpaper and LOCK Settings
    # =========================================================================
    if (Test-Path $ImagePath) {
        if (!(Test-Path $SystemPolicies)) { New-Item -Path $SystemPolicies -Force | Out-Null }
        Set-ItemProperty -Path $SystemPolicies -Name "Wallpaper" -Value $ImagePath -Type String
        Set-ItemProperty -Path $SystemPolicies -Name "WallpaperStyle" -Value "10" -Type String

        if (!(Test-Path $ActiveDesktop)) { New-Item -Path $ActiveDesktop -Force | Out-Null }
        Set-ItemProperty -Path $ActiveDesktop -Name "NoChangingWallPaper" -Value 1 -Type DWord

        RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters
    }
} else {
    # =========================================================================
    # BEFORE JAN 5, 2027: Enable Windows Spotlight & Keep Settings Unlocked
    # =========================================================================
    if (Test-Path $SystemPolicies) {
        Remove-ItemProperty -Path $SystemPolicies -Name "Wallpaper" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path $SystemPolicies -Name "WallpaperStyle" -ErrorAction SilentlyContinue
    }
    if (Test-Path $ActiveDesktop) {
        Remove-ItemProperty -Path $ActiveDesktop -Name "NoChangingWallPaper" -ErrorAction SilentlyContinue
    }

    $wallpaperReg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers"
    if (-not (Test-Path $wallpaperReg)) { New-Item -Path $wallpaperReg -Force | Out-Null }
    Set-ItemProperty -Path $wallpaperReg -Name "BackgroundType" -Value 3
    
    $desktopReg = "HKCU:\Control Panel\Desktop"
    Set-ItemProperty -Path $desktopReg -Name "Wallpaper" -Value ""
    Stop-Process -Name explorer -Force
}
