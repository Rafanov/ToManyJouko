$ErrorActionPreference = "Stop"

$dir = "$env:USERPROFILE\jouko"
$raw = "https://raw.githubusercontent.com/Rafanov/ToManyJouko/main"

Write-Host "Installing jouko..." -ForegroundColor Cyan

if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }

Write-Host "Downloading files..." -ForegroundColor Yellow
Invoke-WebRequest "$raw/main.py"   -OutFile "$dir\main.py"
Invoke-WebRequest "$raw/chara.png" -OutFile "$dir\chara.png"
Invoke-WebRequest "$raw/icon.ico"  -OutFile "$dir\icon.ico"

$python = "python"
if (!(Get-Command python -ErrorAction SilentlyContinue)) {
    if (Get-Command py -ErrorAction SilentlyContinue) {
        $python = "py"
    } else {
        Write-Host "Python does not exist in your computer system, please install it first." -ForegroundColor Red
        exit
    }
}

Write-Host "Installing dependencies..." -ForegroundColor Yellow

& $python -m ensurepip --upgrade 2>$null

& $python -m pip install pillow --quiet

Write-Host "Launching jouko..." -ForegroundColor Green
Start-Process $python -ArgumentList "$dir\main.py" -WindowStyle Hidden