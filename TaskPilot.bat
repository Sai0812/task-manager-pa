@echo off
if "%1"=="/startup" (
    powershell -ExecutionPolicy Bypass -File "%~dp0TaskPilot.ps1" -AddToStartup
    exit /b
)
if "%1"=="/remove" (
    powershell -ExecutionPolicy Bypass -File "%~dp0TaskPilot.ps1" -RemoveFromStartup
    exit /b
)
powershell -ExecutionPolicy Bypass -File "%~dp0TaskPilot.ps1"
