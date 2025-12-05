Write-Host "Downloading Yes Steve Model Repository..."
$url = "https://github.com/Elaina69/Yes-Steve-Model-Repo/archive/refs/heads/main.zip"
$zipPath = "ysm_models.zip"
$destPath = "../config/yes_steve_model/custom"

# Create directory if it doesn't exist
New-Item -ItemType Directory -Force -Path $destPath | Out-Null

# Download
Invoke-WebRequest -Uri $url -OutFile $zipPath

# Extract
Write-Host "Extracting models..."
Expand-Archive -Path $zipPath -DestinationPath "temp_ysm" -Force

# Move files
Write-Host "Installing models..."
# The zip contains a root folder "Yes-Steve-Model-Repo-main". We want the contents of that.
Get-ChildItem "temp_ysm/Yes-Steve-Model-Repo-main/*" | Move-Item -Destination $destPath -Force

# Cleanup
Remove-Item $zipPath
Remove-Item "temp_ysm" -Recurse -Force

Write-Host "Done! Models installed to $destPath"