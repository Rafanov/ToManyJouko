$ErrorActionPreference = "Stop"

$dir = "$env:USERPROFILE\jouko"
$raw = "https://raw.githubusercontent.com/Rafanov/ToManyJouko/main"

Write-Host "Installing jouko..." -ForegroundColor Cyan

if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }

Write-Host "Downloading files..." -ForegroundColor Yellow
Invoke-WebRequest "$raw/main.py"   -OutFile "$dir\main.py"
Invoke-WebRequest "$raw/chara.png" -OutFile "$dir\chara.png"
Invoke-WebRequest "$raw/icon.ico"  -OutFile "$dir\icon.ico"

Write-Host "Installing dependencies..." -ForegroundColor Yellow
pip install pillow --quiet

Write-Host "Launching jouko..." -ForegroundColor Green
Start-Process python -ArgumentList "$dir\main.py" -WindowStyle Hidden