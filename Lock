# 1. Define your exact GitHub RAW source URLs
$scriptUrl = "https://githubusercontent.com"
$imageUrl  = "https://githubusercontent.com"

# 2. Automatically create the directory if it doesn't exist
$dir = "C:\New folder"
if (!(Test-Path $dir)) { New-Item -Path $dir -ItemType Directory -Force | Out-Null }

# 3. Download both files directly from GitHub into the folder
Invoke-WebRequest -Uri $scriptUrl -OutFile "$dir\TimedWallpaperLock2027.ps1" -UseBasicParsing
Invoke-WebRequest -Uri $imageUrl -OutFile "$dir\daniel-leone-v7daTKlZzaw-unsplash.jpg" -UseBasicParsing

# 4. Create the Windows Task Scheduler task (Runs under the logged-in user group with admin rights)
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File '$dir\TimedWallpaperLock2027.ps1'"
$trigger = New-ScheduledTaskTrigger -AtLogOn

# Using 'BUILTIN\Users' ensures the script interacts with the active screen and current user's registry hive
$principal = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Users" -RunLevel Highest

Register-ScheduledTask -TaskName "2027WallpaperAutomator" -Action $action -Trigger $trigger -Principal $principal -Force

Write-Host "Smart Board deployment completed! Files downloaded and automated successfully." -ForegroundColor Green
