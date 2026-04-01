# Public Deployment Guide

This project can be deployed on a single Linux server with Docker Compose.

## Recommended architecture

- `web`: Nginx serves the Vue frontend and proxies `/api` to the backend
- `server`: Spring Boot API
- `postgres`: PostgreSQL database
- `redis`: Redis

Users access the app through one public address:

- `http://your-server-ip`
- or `https://your-domain.com` after DNS and TLS are configured

## Files added for deployment

- `docker-compose.prod.yml`
- `apps/server/Dockerfile`
- `apps/web/Dockerfile`
- `infra/nginx/default.conf`
- `.env.production.example`

## Server requirements

- Ubuntu 22.04 or similar Linux server
- Docker Engine
- Docker Compose plugin
- 2 vCPU / 4 GB RAM is a practical starting point

## 1. Prepare the server

Clone the repo to the server and create the production env file:

```bash
cp .env.production.example .env.production
```

Edit `.env.production` and set at least:

- `POSTGRES_PASSWORD`
- `APP_SECURITY_ALLOWED_ORIGINS`

If you already have a domain, set:

```env
APP_SECURITY_ALLOWED_ORIGINS=https://your-domain.com
```

If you only use a server IP temporarily, set:

```env
APP_SECURITY_ALLOWED_ORIGINS=http://your-server-ip
```

## 2. Build and start

```bash
docker compose --env-file .env.production -f docker-compose.prod.yml up -d --build
```

## 3. Check status

```bash
docker compose --env-file .env.production -f docker-compose.prod.yml ps
docker compose --env-file .env.production -f docker-compose.prod.yml logs -f server
```

## 4. Open the app

Open:

- `http://your-server-ip`
- or your bound domain

The frontend uses same-origin `/api`, so it will call the backend through Nginx automatically.

## 5. Add HTTPS

Recommended:

- point your domain DNS `A` record to the server IP
- install a TLS certificate with Certbot and Nginx

Official references:

- Docker Compose docs: https://docs.docker.com/compose/
- Nginx reverse proxy docs: https://nginx.org/en/docs/http/ngx_http_proxy_module.html
- Certbot instructions: https://certbot.eff.org/

## Useful commands

Restart:

```bash
docker compose --env-file .env.production -f docker-compose.prod.yml restart
```

Stop:

```bash
docker compose --env-file .env.production -f docker-compose.prod.yml down
```

Update after code changes:

```bash
git pull
docker compose --env-file .env.production -f docker-compose.prod.yml up -d --build
```
