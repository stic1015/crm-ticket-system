@echo off
setlocal EnableExtensions

set "REPO_ROOT=%~dp0"
if "%REPO_ROOT:~-1%"=="\" set "REPO_ROOT=%REPO_ROOT:~0,-1%"

set "QUIET="
set "APPS_ONLY="
if /I "%~1"=="--quiet" set "QUIET=1"
if /I "%~1"=="--apps-only" set "APPS_ONLY=1"
if /I "%~2"=="--quiet" set "QUIET=1"
if /I "%~2"=="--apps-only" set "APPS_ONLY=1"

if not defined QUIET echo [INFO] Stopping local CRM services...

taskkill /FI "WINDOWTITLE eq CRM Ticket System Backend" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq CRM Ticket System Frontend" /T /F >nul 2>&1

if not defined APPS_ONLY (
  pushd "%REPO_ROOT%"
  docker compose down >nul 2>&1
  popd
)

if not defined QUIET (
  if defined APPS_ONLY (
    echo [INFO] Frontend and backend windows have been asked to stop.
  ) else (
    echo [INFO] Frontend, backend, PostgreSQL, and Redis have been asked to stop.
  )
)

exit /b 0
