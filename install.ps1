# jouko installer
$ErrorActionPreference = "Stop"

$dir = "$env:USERPROFILE\jouko"
$repo = "GITHUB_USERNAME/REPO_NAME"  # <-- ganti ini
$raw  = "https://raw.githubusercontent.com/$repo/main"

Write-Host "Installing jouko..." -ForegroundColor Cyan

# Buat folder
if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }

# Download files
Write-Host "Downloading files..." -ForegroundColor Yellow
Invoke-WebRequest "$raw/main.py"    -OutFile "$dir\main.py"
Invoke-WebRequest "$raw/chara.png"  -OutFile "$dir\chara.png"
Invoke-WebRequest "$raw/icon.ico"   -OutFile "$dir\icon.ico"

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
pip install pillow --quiet

# Jalanin langsung
Write-Host "Launching jouko..." -ForegroundColor Green
Start-Process python -ArgumentList "$dir\main.py" -WindowStyle Hidden