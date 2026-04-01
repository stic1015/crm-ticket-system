@echo off
setlocal EnableExtensions

set "REPO_ROOT=%~dp0"
if "%REPO_ROOT:~-1%"=="\" set "REPO_ROOT=%REPO_ROOT:~0,-1%"

call "%REPO_ROOT%\..\tools\activate-dev-env.cmd"
cd /d "%REPO_ROOT%\apps\server"
call mvn -Dmaven.repo.local="%REPO_ROOT%\.m2" spring-boot:run
