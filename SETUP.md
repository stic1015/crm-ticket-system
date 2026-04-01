# CRM Ticket System Setup

## Recommended versions

- Node.js: `22.x LTS`
- npm: `10+`
- Java: `21`
- Maven: `3.9+`
- Docker Desktop: latest stable

## Quick start on Windows

If you just want to open the project locally without remembering all commands:

```powershell
cd D:\Codex\crm-ticket-system
.\start-local.cmd
```

What it does:

- Starts PostgreSQL and Redis with Docker Compose
- Opens one terminal for the Spring Boot backend
- Opens one terminal for the Vite frontend
- Opens the browser at `http://localhost:5174`

To stop everything:

```powershell
cd D:\Codex\crm-ticket-system
.\stop-local.cmd
```

Notes:

- Start Docker Desktop before running `start-local.cmd`
- The first backend startup can take a few minutes because Maven may download dependencies
- Demo login: `admin / admin`

## Install checklist for Windows

### 1. Node.js

Install Node.js 22 LTS.

Verify:

```powershell
node -v
npm -v
```

### 2. Java 21

Install one of:

- Eclipse Temurin 21
- Microsoft Build of OpenJDK 21
- Oracle JDK 21

Verify:

```powershell
java -version
javac -version
```

### 3. Maven

Install Apache Maven 3.9+ and ensure `mvn` is in `PATH`.

Verify:

```powershell
mvn -v
```

### 4. Docker Desktop

Install Docker Desktop for Windows and enable Linux containers.

Verify:

```powershell
docker -v
docker compose version
```

## Optional local tools

- IntelliJ IDEA
- VS Code
- Postman / Bruno

## After install

### Local tools in this workspace

Java 21 and Maven are currently placed under:

- `D:\Codex\tools\JDK21`
- `D:\Codex\tools\apache-maven-3.9.14-bin\apache-maven-3.9.14`

To activate them for the current terminal session on Windows PowerShell:

```powershell
D:\Codex\tools\activate-dev-env.ps1
```

Or for `cmd`:

```cmd
D:\Codex\tools\activate-dev-env.cmd
```

Open PowerShell in `D:\Codex\crm-ticket-system` and run:

```powershell
docker compose up -d
```

Frontend:

```powershell
cd D:\Codex\crm-ticket-system\apps\web
npm install
npm run dev
```

Backend:

```powershell
cd D:\Codex\crm-ticket-system\apps\server
mvn -Dmaven.repo.local=D:\Codex\crm-ticket-system\.m2 spring-boot:run
```

## Expected local ports

- Web: `5174`
- API: `18080`
- PostgreSQL: `5432`
- Redis: `6379`

## Current note

If `mvn` is not in your global `PATH`, activate the bundled tools first with `D:\Codex\tools\activate-dev-env.ps1` and keep using the local Maven cache under `D:\Codex\crm-ticket-system\.m2`.
