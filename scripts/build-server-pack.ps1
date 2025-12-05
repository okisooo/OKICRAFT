# OKICRAFT Server Pack Build Script
# Run this to generate a server-ready folder from the modpack

param(
    [string]$OutputPath = ".\OKICRAFT-Server",
    [switch]$IncludeForge
)

$SourcePath = $PSScriptRoot | Split-Path -Parent

# Client-only mods to exclude (patterns)
$ClientOnlyMods = @(
    "embeddium-*",
    "oculus-*",
    "ImmediatelyFast-*",
    "skinlayers3d-*",
    "AmbientSounds_*",
    "appleskin-*",
    "chat_heads-*",
    "Controlling-*",
    "EnchantmentDescriptions-*",
    "Jade-*",
    "journeymap-*",
    "MouseTweaks-*",
    "NaturesCompass-*",
    "shulkerboxtooltip-*",
    "Xaeros_Minimap_*",
    "XaerosWorldMap_*",
    "fancymenu_*",
    "drippyloadingscreen_*",
    "konkrete_*",
    "melody_*",
    "YungsMenuTweaks-*",
    "ysm-*",
    "spark-*"  # Optional: remove if you want server profiling
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  OKICRAFT Server Pack Builder" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create output directory
if (Test-Path $OutputPath) {
    Write-Host "Cleaning existing output folder..." -ForegroundColor Yellow
    Remove-Item $OutputPath -Recurse -Force
}
New-Item -ItemType Directory -Path $OutputPath | Out-Null
New-Item -ItemType Directory -Path "$OutputPath\mods" | Out-Null
New-Item -ItemType Directory -Path "$OutputPath\config" | Out-Null
New-Item -ItemType Directory -Path "$OutputPath\defaultconfigs" | Out-Null

# Copy mods (excluding client-only)
Write-Host "Copying server mods..." -ForegroundColor Green
$allMods = Get-ChildItem "$SourcePath\mods" -Filter "*.jar"
$serverMods = $allMods | Where-Object {
    $mod = $_
    $isClientOnly = $false
    foreach ($pattern in $ClientOnlyMods) {
        if ($mod.Name -like $pattern) {
            $isClientOnly = $true
            break
        }
    }
    -not $isClientOnly
}

$excludedCount = $allMods.Count - $serverMods.Count
Write-Host "  Total mods: $($allMods.Count)" -ForegroundColor Gray
Write-Host "  Client-only excluded: $excludedCount" -ForegroundColor Gray
Write-Host "  Server mods: $($serverMods.Count)" -ForegroundColor Gray

$serverMods | ForEach-Object {
    Copy-Item $_.FullName "$OutputPath\mods\"
}

# Copy configs
Write-Host "Copying configs..." -ForegroundColor Green
Copy-Item "$SourcePath\config\*" "$OutputPath\config\" -Recurse -Exclude @(
    "fancymenu*",
    "drippyloadingscreen*",
    "xaerominimap*",
    "xaeroworldmap*",
    "journeymap*",
    "oculus*"
)

# Copy defaultconfigs
Write-Host "Copying default configs..." -ForegroundColor Green
Copy-Item "$SourcePath\defaultconfigs\*" "$OutputPath\defaultconfigs\" -Recurse

# Create server start scripts
Write-Host "Creating start scripts..." -ForegroundColor Green

# Windows batch script
@"
@echo off
title OKICRAFT Server
java -Xms4G -Xmx8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -jar forge-*.jar nogui
pause
"@ | Out-File "$OutputPath\start.bat" -Encoding ASCII

# Linux shell script
@"
#!/bin/bash
java -Xms4G -Xmx8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -jar forge-*.jar nogui
"@ | Out-File "$OutputPath\start.sh" -Encoding UTF8 -NoNewline

# Create eula.txt (you still need to accept it)
@"
# By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).
eula=false
"@ | Out-File "$OutputPath\eula.txt" -Encoding ASCII

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Server pack created at: $OutputPath" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Download Forge 1.20.1 installer" -ForegroundColor Gray
Write-Host "  2. Run: java -jar forge-installer.jar --installServer" -ForegroundColor Gray
Write-Host "  3. Edit eula.txt and set eula=true" -ForegroundColor Gray
Write-Host "  4. Run start.bat (Windows) or start.sh (Linux)" -ForegroundColor Gray
Write-Host ""
