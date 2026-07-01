# Changelog

All notable changes to USDQuest. This project follows a simple incremental versioning scheme.

## [1.3.0] — 2026-07-01

### Added
- **Much more content** — now **31 lessons across 10 units with 310 questions** (up from ~95).
  Each unit gained a new lesson and every lesson now has **10 questions**.
- **Harder, exam-style questions** aligned to the NVIDIA NCP-OUSD / OpenUSD Development
  scope (API usage, composition & value-resolution semantics, production workflows).
- **65 code questions** — read a real `.usda` or USD Python snippet and choose the correct
  answer / output.
- Study notes authored for every lesson.

### Changed
- Lessons now present up to 10 questions (shuffled each attempt) instead of a subset of 6.

### Added (backend)
- `schema-v4.sql` — index on `profiles(xp)` to keep the Global leaderboard fast at scale.

## [1.2.0] — 2026-07-01

### Added
- **Bonus hearts** — earn a heart for every 5 exercises completed, with a progress
  indicator on the home Exercises section.
- **Study notes** — short tips pop up once before a lesson's first attempt, and a new
  **Study** tab (bottom nav) lets you revisit notes for all 21 lessons anytime.
- **New question types** — Duolingo-style **match-the-pairs**, and **code-reference**
  questions using real `.usda` snippets.
- **Weekly league** — a 🏅 League tab ranking everyone by XP earned this week
  (resets Monday), alongside the Friends and Global boards.

### Notes
- Requires `schema-v3.sql` (adds `weekly_xp` / `week_start` to `profiles`) to enable the league.

## [1.1.0] — 2026-07-01

### Added
- **Sound effects** (synthesized with the Web Audio API — no files, works offline):
  correct-answer chime, wrong-answer buzz, and a lesson/practice completion fanfare.
- **Sound on/off toggle** on the Profile page, persisted across sessions.

### Fixed
- **Single Continue button** — after answering, the feedback sheet's *Continue* now
  advances directly to the next question in one tap (previously it required two taps).

## [1.0.0] — 2026-07-01

First public release. 🎉 Live at https://hackassin.github.io/usdquest/

### Learning content
- 10 units, 21 lessons, 88 questions covering OpenUSD from foundations to Omniverse production.
- Multiple-choice, true/false, and type-the-answer question types, each with an explanation.
- Question order and answer choices are randomized on every attempt; long lessons sample a subset.

### Gameplay
- XP, daily streaks, 5 regenerating hearts, per-lesson results, and a boss lesson.
- **Practice modes:** Review Mistakes (clears items when answered correctly) and Quick Practice
  (random mixed quiz, no hearts lost).

### Accounts & cloud
- Email + password accounts via Supabase Auth, with graceful fallback to local accounts.
- Automatic cloud sync of progress (debounced), resuming across devices.
- Export / import progress as a JSON backup.

### Social
- **Profile / Stats** page: XP, streak, lessons completed, lifetime accuracy, mistakes
  pending/cleared, and per-unit progress bars.
- **Friends:** add by `@username`, accept/decline requests, unfriend.
- **Leaderboards:** Friends board and Global Top 50, with personal rank.

### Platform
- Installable PWA: app icon + web manifest, full-screen standalone on mobile.
- Bottom navigation (Learn / Leaderboard / Profile).
- Hosted on GitHub Pages with one-click redeploy scripts.

### Data model (Supabase)
- `progress` (per-user JSON state) with row-level security.
- `profiles` (public stats for leaderboard/search) and `friendships` (requester/addressee + status).

---

### Build history (pre-1.0 milestones)
- Single-file learning app with the unit/lesson path and gamification.
- Added progress backup (export/import).
- Added local accounts and the practice/mistakes system; expanded the question bank.
- Added Supabase cloud sync and email/password login.
- Deployed to GitHub Pages with automated redeploy.
- Added 4 more units, randomized questions, and the installable app icon.
- Added Profile/Stats, Friends, and the Friends leaderboard with a bottom nav.
- Added the Global Top 50 leaderboard.
