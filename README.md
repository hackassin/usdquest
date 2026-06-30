# 🧊 USDQuest

A **Duolingo-style learning game** for the **NVIDIA OpenUSD** certification. Bite-sized
lessons, XP, streaks, hearts, a mistakes-practice mode, cloud-synced progress, friends,
and leaderboards — in a single self-contained web app.

### ▶️ Live app: **https://hackassin.github.io/usdquest/**

Open it on desktop or phone, create an account, and start learning. On mobile you can
**Add to Home Screen** to install it like a native app.

---

## ✨ Features

- **10 units · 21 lessons · 88 questions** spanning OpenUSD foundations → Omniverse production
  (stages & layers, prims, composition/LIVRPS, schemas, Hydra, lighting, physics, animation, MDL…).
- **Gamified learning** — XP, daily streaks, 5 hearts (regenerating), per-lesson results, and a
  👑 boss lesson. Questions and answer choices **shuffle every attempt** so repeats stay fresh.
- **Question types** — multiple choice, true/false, and type-the-answer, each with a teaching explanation.
- **Practice / Exercises** — *Review Mistakes* (re-attempt anything you got wrong) and *Quick Practice*
  (a random mixed quiz; no hearts lost).
- **Accounts** — email + password login via Supabase, with graceful fallback to local accounts
  if cloud isn't configured.
- **Cloud sync** — progress saves to the cloud automatically and follows you across devices.
- **Profile / Stats** — XP, streak, lessons completed, lifetime accuracy, mistakes pending/cleared,
  and per-unit progress bars.
- **Friends** — add by `@username`, accept/decline requests, unfriend.
- **Leaderboards** — a **Friends** board and a **Global Top 50** (with your personal rank if you're off the list).
- **Installable PWA** — polished app icon + web manifest; launches full-screen on mobile.
- **Backups** — export/import your progress as a JSON file.

## 🗂️ Project structure

| File | Purpose |
|------|---------|
| `index.html` | The entire app (HTML + CSS + JS, no build step) |
| `manifest.webmanifest`, `icon-*.png`, `apple-touch-icon.png`, `favicon-32.png` | PWA icons & manifest |
| `schema.sql` | Supabase: `progress` table + row-level security |
| `schema-v2.sql` | Supabase: `profiles` + `friendships` tables (stats, friends, leaderboard) |
| `CLOUD-SETUP.md` | Step-by-step Supabase cloud-sync setup |
| `start.bat` | Launch the app locally (double-click) |
| `redeploy.bat` / `redeploy.ps1` | One-click push to GitHub Pages |
| `make_icons.py` | Regenerate the app icons (Pillow) |
| `CHANGELOG.md` | Version history |

> `deploy.local.json` holds the GitHub deploy token and is **git-ignored** — it is never published.

## 🚀 Run locally

```bash
# from the usd-quest folder
py -m http.server 4173
# then open http://localhost:4173
```

…or just double-click **`start.bat`** (Windows).

## ☁️ Cloud sync (optional)

Cloud accounts, sync, friends, and leaderboards are powered by [Supabase](https://supabase.com)
(free tier). See **[CLOUD-SETUP.md](CLOUD-SETUP.md)** to create a project, run `schema.sql` +
`schema-v2.sql`, and paste your project URL + anon key into `index.html`. Without keys, the app
runs in **local-account** mode.

## 📦 Deploy

Hosted on **GitHub Pages**. To publish changes:

```bash
# double-click redeploy.bat, or:
powershell -ExecutionPolicy Bypass -File redeploy.ps1 "your commit message"
```

Pages rebuilds automatically (~1 min).

## 🔒 Security notes

- The Supabase **anon** key in `index.html` is meant to be public; **Row-Level Security** protects all data.
- The `service_role` key is **never** used in the client.
- Local-mode passwords are lightly obfuscated, not securely hashed — don't reuse a real password there.

## 🛠️ Tech

Vanilla HTML/CSS/JS (zero dependencies, single file) · Supabase (Auth + Postgres) ·
GitHub Pages · PWA.

---

*Built for NVIDIA OpenUSD certification prep. Not affiliated with NVIDIA or Pixar.*
