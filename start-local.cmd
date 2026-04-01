@echo off
setlocal EnableExtensions

set "REPO_ROOT=%~dp0"
if "%REPO_ROOT:~-1%"=="\" set "REPO_ROOT=%REPO_ROOT:~0,-1%"

set "TOOLS_ROOT=%REPO_ROOT%\..\tools"
set "ACTIVATE_CMD=%TOOLS_ROOT%\activate-dev-env.cmd"
set "WEB_DIR=%REPO_ROOT%\apps\web"
set "SERVER_DIR=%REPO_ROOT%\apps\server"
set "M2_DIR=%REPO_ROOT%\.m2"
set "RUN_FRONTEND=%REPO_ROOT%\run-frontend.cmd"
set "RUN_BACKEND=%REPO_ROOT%\run-backend.cmd"
set "BACKEND_TITLE=CRM Ticket System Backend"
set "FRONTEND_TITLE=CRM Ticket System Frontend"
set "NO_BROWSER="
set "DRY_RUN="

:parse_args
if "%~1"=="" goto args_done
if /I "%~1"=="--no-browser" (
  set "NO_BROWSER=1"
  shift
  goto parse_args
)
if /I "%~1"=="--dry-run" (
  set "DRY_RUN=1"
  shift
  goto parse_args
)
echo Unsupported argument: %~1
echo Supported arguments: --no-browser --dry-run
exit /b 1

:args_done
if not exist "%ACTIVATE_CMD%" (
  echo [ERROR] Missing tools activator: %ACTIVATE_CMD%
  exit /b 1
)

if not exist "%RUN_FRONTEND%" (
  echo [ERROR] Missing frontend runner: %RUN_FRONTEND%
  exit /b 1
)

if not exist "%RUN_BACKEND%" (
  echo [ERROR] Missing backend runner: %RUN_BACKEND%
  exit /b 1
)

where docker >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Docker Desktop is not installed or docker is not in PATH.
  exit /b 1
)

where npm >nul 2>&1
if errorlevel 1 (
  echo [ERROR] npm is not installed or npm is not in PATH.
  exit /b 1
)

if defined DRY_RUN goto skip_runtime_checks

docker info >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Docker Desktop is not running. Please start Docker Desktop and retry.
  exit /b 1
)

:skip_runtime_checks

if not exist "%WEB_DIR%\node_modules" (
  echo [INFO] Frontend dependencies not found. Running npm install once...
  if defined DRY_RUN (
    echo [DRY-RUN] cd /d "%WEB_DIR%" ^&^& npm install
  ) else (
    pushd "%WEB_DIR%"
    call npm install
    if errorlevel 1 (
      popd
      echo [ERROR] npm install failed.
      exit /b 1
    )
    popd
  )
)

if defined DRY_RUN (
  echo [DRY-RUN] docker compose up -d
) else (
  pushd "%REPO_ROOT%"
  docker compose up -d
  if errorlevel 1 (
    popd
    echo [ERROR] Failed to start PostgreSQL and Redis.
    exit /b 1
  )
  popd
)

call "%REPO_ROOT%\stop-local.cmd" --apps-only --quiet >nul 2>&1

if defined DRY_RUN (
  echo [DRY-RUN] start "%BACKEND_TITLE%" "%RUN_BACKEND%"
  echo [DRY-RUN] start "%FRONTEND_TITLE%" "%RUN_FRONTEND%"
  if not defined NO_BROWSER echo [DRY-RUN] start "" "http://localhost:5174"
  exit /b 0
)

start "%BACKEND_TITLE%" "%RUN_BACKEND%"
start "%FRONTEND_TITLE%" "%RUN_FRONTEND%"

echo [INFO] Backend and frontend windows have been opened.
echo [INFO] First backend startup may take a few minutes while Maven downloads dependencies.
echo [INFO] Frontend URL: http://localhost:5174
echo [INFO] Backend URL:  http://localhost:18080
echo [INFO] Demo account: admin / admin

if not defined NO_BROWSER (
  timeout /t 4 /nobreak >nul
  start "" "http://localhost:5174"
)

exit /b 0
