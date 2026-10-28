# Edgebook — Trading Journal

## What's included
- `index.html`: responsive static website, suitable for GitHub Pages
- `supabase-schema.sql`: database tables, row-level security and screenshot storage policies

## GitHub Pages deployment
1. Create a GitHub repository (for a free GitHub account, use a public repository for Pages).
2. Upload `index.html` to the repository root.
3. Go to **Settings → Pages**. Select **Deploy from a branch**, branch `main`, folder `/ (root)`.
4. Wait for the Pages URL to appear.

## Enable cloud login and sync (Supabase)
GitHub Pages only hosts static files. A backend is required for authentication, database sync and private uploads.

1. Create a Supabase project.
2. Open **SQL Editor**, paste `supabase-schema.sql`, and run it.
3. In **Authentication → URL Configuration**, add your GitHub Pages URL to Site URL / Redirect URLs as appropriate.
4. In **Project Settings → API**, copy the Project URL and the publishable/anon client key.
5. Open your deployed site, go to **Settings & data**, paste the URL and public key, click **Save connection**.
6. Click **Connect account**, create an account, then sign in.
7. To keep screenshots private, use a private bucket and implement signed-URL display. This starter uploads images to the private bucket, but currently stores a public-URL-shaped string; private image preview links need a signed URL implementation. Do not make the bucket public if screenshots contain sensitive information.

## Security
- Never put a Supabase `service_role` key in `index.html`.
- RLS policies restrict database rows to the signed-in user.
- Cloud features require you to configure Supabase and run the SQL.
- Local preview works without a backend but is stored only in the current browser.
- The public front-end can be viewed by anyone. User journal rows are protected by Supabase RLS.

## Honest feature status
- Works without backend: dashboard, entry form, custom confluence list, search/filter, edit/delete, CSV/JSON export/import, local browser storage.
- Requires Supabase setup: login, cloud database synchronization and screenshot uploads.
- Cloud screenshot upload is wired to the private bucket. For showing private screenshots in the UI, add signed URL generation; the current starter stores the upload path as a URL field but does not render image previews.
