# ☁️ USDQuest — Cloud Sync Setup (Supabase)

Follow these once. After this, your progress saves to the cloud and you can log
in with the same email on your phone (or any device) to continue.

Total time: ~10 minutes. Everything here is on Supabase's **free** tier.

---

## 1. Create a Supabase project
1. Go to **https://supabase.com** → **Sign in** (GitHub or email) → **New project**.
2. Give it a name (e.g. `usdquest`), set a database password (save it somewhere),
   pick a region near you, and click **Create new project**.
3. Wait ~2 minutes for it to finish provisioning.

## 2. Create the progress table
1. In the left sidebar, open **SQL Editor** → **New query**.
2. Paste everything below and click **Run**. (This also lives in `schema.sql`.)

```sql
create table if not exists public.progress (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.progress enable row level security;

create policy "read own progress"   on public.progress
  for select using (auth.uid() = user_id);
create policy "insert own progress" on public.progress
  for insert with check (auth.uid() = user_id);
create policy "update own progress" on public.progress
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
```

> Row-Level Security means each account can only ever read/write **its own** row.

## 3. Turn on email login (and skip email confirmation)
1. Sidebar → **Authentication** → **Providers** → make sure **Email** is **enabled**.
2. Sidebar → **Authentication** → **Sign In / Providers** (or **Settings**) →
   find **"Confirm email"** and **turn it OFF**.
   - This lets you sign up and use the app immediately without clicking a
     confirmation link. (Fine for a personal learning app. Leave it ON if you
     prefer verified emails — you'll just have to click the link once.)

## 4. Copy your two keys
1. Sidebar → **Project Settings** (gear) → **API**.
2. Copy:
   - **Project URL** — looks like `https://abcdefgh.supabase.co`
   - **anon public** key — a long token under *Project API keys* (the `anon` `public` one — **not** the `service_role` key).

> The `anon` key is safe to put in front-end code. RLS (step 2) is what keeps
> data private. **Never** paste the `service_role` key into the app.

## 5. Paste the keys into the app
1. Open `index.html` and find this block near the top of the `<script>`:

```js
const SUPABASE_URL      = "https://YOUR-PROJECT-ID.supabase.co";
const SUPABASE_ANON_KEY = "YOUR-PUBLIC-ANON-KEY";
```

2. Replace the two strings with your **Project URL** and **anon public** key.
   (Claude can do this for you — just paste the two values into the chat.)

3. Reload the app. The login screen now says **Email** instead of Username, and
   your progress syncs to the cloud automatically.

---

## How it behaves
- **Logged-in session is remembered** across reloads and devices.
- Every change (finishing a lesson, XP, mistakes) saves locally instantly and
  pushes to the cloud about a second later.
- On a new device, log in with the same email → your progress loads from the cloud.
- If the keys are left as placeholders, the app safely falls back to **local
  accounts** (no cloud), so it always runs.

## Using it on your phone
The app still needs to be reachable at a public URL (localhost only works on this
PC). Once cloud sync is confirmed working, tell Claude and we'll **host it** (e.g.
Netlify drop, Vercel, or GitHub Pages) so you get an `https://…` link. Open that
on your phone, log in, and you're synced. You can also **Add to Home Screen** in
your phone browser so it behaves like an installed app.
