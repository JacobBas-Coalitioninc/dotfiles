# Windows Dotfiles Setup Script (Explicit Version)
# This script specifically links Neovim and WezTerm configurations.
# It contains extra checks and logging to make troubleshooting easier.

# -----------------------------------------------------------------------------
# 1. PRE-FLIGHT CHECKS
# -----------------------------------------------------------------------------

# Ensure we're running as Administrator to create symbolic links
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "STOP: This script requires Administrator privileges." -ForegroundColor Red
    Write-Host "Please right-click PowerShell and 'Run as Administrator', then try again." -ForegroundColor Red
    exit 1
}

# Get the script's directory reliably. This is where your dotfiles should be.
$dotfilesPath = $PSScriptRoot
Write-Host "Dotfiles source location: $dotfilesPath" -ForegroundColor Cyan

# Create the $HOME/.config directory if it's missing
$configDir = "$env:USERPROFILE\.config"
if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force
    Write-Host "Created directory: $configDir" -ForegroundColor Yellow
}

# -----------------------------------------------------------------------------
# 2. PROCESS NEOVIM
# -----------------------------------------------------------------------------

Write-Host "`n--- Processing Neovim ---" -ForegroundColor White
$nvimSource = Join-Path $dotfilesPath "nvim"
$nvimTarget = "$env:USERPROFILE\AppData\Local\nvim"

# Check if the source 'nvim' directory actually exists in your dotfiles
if (Test-Path $nvimSource) {
    Write-Host "Found Neovim source at: $nvimSource" -ForegroundColor Green

    # Remove existing target if it exists
    if (Test-Path $nvimTarget) {
        Write-Host "Removing existing config at: $nvimTarget" -ForegroundColor Yellow
        Remove-Item $nvimTarget -Recurse -Force
    }

    # Create the symbolic link
    try {
        New-Item -ItemType SymbolicLink -Path $nvimTarget -Target $nvimSource -ErrorAction Stop
        Write-Host "✓ Successfully linked Neovim." -ForegroundColor Green
    } catch {
        Write-Host "✗ FAILED to link Neovim. Error: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "INFO: Neovim source directory not found at '$nvimSource'. Skipping." -ForegroundColor Gray
}


# -----------------------------------------------------------------------------
# 3. PROCESS WEZTERM
# -----------------------------------------------------------------------------

Write-Host "`n--- Processing WezTerm ---" -ForegroundColor White

# Option A: Link the 'wezterm' directory to .config/wezterm
$weztermDirSource = Join-Path $dotfilesPath "wezterm"
$weztermDirTarget = "$env:USERPROFILE\.config\wezterm"

if (Test-Path $weztermDirSource) {
    Write-Host "Found wezterm source directory at: $weztermDirSource" -ForegroundColor Green

    # Remove existing target if it exists
    if (Test-Path $weztermDirTarget) {
        Write-Host "Removing existing config at: $weztermDirTarget" -ForegroundColor Yellow
        Remove-Item $weztermDirTarget -Recurse -Force
    }

    # Create the symbolic link
    try {
        New-Item -ItemType SymbolicLink -Path $weztermDirTarget -Target $weztermDirSource -ErrorAction Stop
        Write-Host "✓ Successfully linked wezterm directory." -ForegroundColor Green
    } catch {
        Write-Host "✗ FAILED to link wezterm directory. Error: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
     Write-Host "INFO: WezTerm source directory not found at '$weztermDirSource'. Skipping." -ForegroundColor Gray
}


# Option B: Link the '.wezterm.lua' file to the home directory
# $weztermFileSource = Join-Path $dotfilesPath ".wezterm.lua"
# $weztermFileTarget = "$env:USERPROFILE\.wezterm.lua"
#
# if (Test-Path $weztermFileSource) {
#     Write-Host "Found standalone .wezterm.lua file." -ForegroundColor Green
#
#      # Remove existing target if it exists
#     if (Test-Path $weztermFileTarget) {
#         Write-Host "Removing existing config at: $weztermFileTarget" -ForegroundColor Yellow
#         Remove-Item $weztermFileTarget -Force
#     }
#
#     # Create the symbolic link
#     try {
#         New-Item -ItemType SymbolicLink -Path $weztermFileTarget -Target $weztermFileSource -ErrorAction Stop
#         Write-Host "✓ Successfully linked .wezterm.lua file." -ForegroundColor Green
#     } catch {
#         Write-Host "✗ FAILED to link .wezterm.lua. Error: $($_.Exception.Message)" -ForegroundColor Red
#     }
# } else {
#      Write-Host "INFO: Standalone .wezterm.lua file not found. Skipping." -ForegroundColor Gray
# }


# -----------------------------------------------------------------------------
# 4. COMPLETE
# -----------------------------------------------------------------------------
Write-Host "`n=== Setup Complete ===" -ForegroundColor Green
Write-Host "Check the logs above for success or failure of each step." -ForegroundColor White
