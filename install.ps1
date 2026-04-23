$ErrorActionPreference = "Stop"

$dir = "$env:USERPROFILE\jouko"
$raw = "https://raw.githubusercontent.com/Rafanov/ToManyJouko/main"

Write-Host "Installing jouko..." -ForegroundColor Cyan

if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }

Write-Host "Downloading files..." -ForegroundColor Yellow
Invoke-WebRequest "$raw/main.py"   -OutFile "$dir\main.py"
Invoke-WebRequest "$raw/chara.png" -OutFile "$dir\chara.png"
Invoke-WebRequest "$raw/icon.ico"  -OutFile "$dir\icon.ico"

$python = $null

try {
    python --version > $null 2>&1
    if ($LASTEXITCODE -eq 0) { $python = "python" }
} catch {}

if (-not $python) {
    try {
        py --version > $null 2>&1
        if ($LASTEXITCODE -eq 0) { $python = "py" }
    } catch {}
}

if (-not $python) {
    Write-Host "Python tidak ditemukan. Mengunduh Python..." -ForegroundColor Yellow

    $installer = "$env:TEMP\python_installer.exe"
    $url = "https://www.python.org/ftp/python/3.12.4/python-3.12.4-amd64.exe"

    Invoke-WebRequest $url -OutFile $installer

    Write-Host "Menginstall Python..." -ForegroundColor Yellow

    Start-Process $installer -ArgumentList "/quiet InstallAllUsers=0 PrependPath=1" -Wait

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path","Machine")

    try {
        python --version > $null 2>&1
        if ($LASTEXITCODE -eq 0) { $python = "python" }
    } catch {}

    if (-not $python) {
        Write-Host "Gagal menginstall Python. Silakan install manual." -ForegroundColor Red
        exit
    }
}

Write-Host "Installing dependencies..." -ForegroundColor Yellow

& $python -m ensurepip --upgrade 2>$null
& $python -m pip install pillow --quiet

Write-Host "Launching jouko..." -ForegroundColor Green
Start-Process $python -ArgumentList "$dir\main.py" -WindowStyle Hidden