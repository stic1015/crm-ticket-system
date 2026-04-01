# GitHub + Vercel + Render Deployment

This repo is now prepared for this setup:

- GitHub: source code
- Vercel: frontend from `apps/web`
- Render: Spring Boot backend from `apps/server`
- Render Postgres: database

## What is already prepared

- `render.yaml` for Render Blueprint creation
- `apps/server/Dockerfile` for the backend
- `apps/web/vercel.json` for SPA route fallback on Vercel
- frontend environment split:
  - local dev uses `http://localhost:18080/api`
  - production can be set from Vercel env vars
- backend can read Render's `DATABASE_URL`

## Recommended flow

## 1. Put the code into your GitHub repo

Your repo:

- `https://github.com/stic1015/crm-ticket-system`

## 2. Deploy the backend on Render

In Render:

1. Choose **New +**
2. Choose **Blueprint**
3. Connect the GitHub repo `stic1015/crm-ticket-system`
4. Render will read `render.yaml`
5. Create the resources

After creation you will get a backend public URL like:

- `https://crm-ticket-api.onrender.com`

Then set this environment variable on the Render web service:

```env
APP_SECURITY_ALLOWED_ORIGINS=https://your-vercel-domain.vercel.app
```

If you later bind a custom frontend domain, update it to:

```env
APP_SECURITY_ALLOWED_ORIGINS=https://app.yourdomain.com
```

## 3. Deploy the frontend on Vercel

In Vercel:

1. Import the same GitHub repo
2. Set **Root Directory** to `apps/web`
3. Framework preset can stay as **Vite**
4. Add this environment variable:

```env
VITE_API_BASE_URL=https://crm-ticket-api.onrender.com/api
```

Replace the host with your actual Render backend URL.

Then deploy.

## 4. Open the site

Frontend:

- `https://your-project.vercel.app`

Backend health:

- `https://crm-ticket-api.onrender.com/actuator/health`

## Notes

- Render free or low-cost instances may sleep and become slow on first request
- If you want zero browser CORS headaches, keep `APP_SECURITY_ALLOWED_ORIGINS` aligned with the final Vercel domain
- For production use, bind your own domain on both Vercel and Render
