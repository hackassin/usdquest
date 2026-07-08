# Changelog

All notable changes to USDQuest. This project follows a simple incremental versioning scheme.

## [1.7.0] — 2026-07-02

### Added
- **Section 3 · Practice Exams** — 5 full timed simulations (65 questions / 120 minutes each),
  drawing refreshed questions from the whole curriculum plus a new **106-question practice bank**
  weighted toward Composition/Kind/LIVERPS per the exam blueprint.
- **Multi-select ("Select 2/3") questions** — a new checkbox question type, used throughout the
  practice bank; graded on the exact set.
- **Elaborative exam feedback** — after any exam, a per-domain performance breakdown plus ranked
  **focus areas** with concrete, domain-specific study guidance.
- **Chapter deep-dives** (Study tab) — richer overviews with **animated GIF demos** (timeSamples
  interpolation, LIVERPS strength ordering, value resolution) and worked example questions with
  reveal-able explanations.

## [1.6.0] — 2026-07-02

### Added
- **Exam Readiness Report** (Profile → 📊 Exam Readiness) — maps your progress onto the
  8 official NCP-OUSD exam domains, weighted by the blueprint. Shows an overall readiness
  ring, per-domain bars (Strong/OK/Weak), a "focus next" list ranked by exam impact, your
  best exam scores, and a **Print / Save-as-PDF** view.

## [1.5.0] — 2026-07-02

### Added
- **Two-section curriculum** aligned to the NVIDIA NCP-OUSD exam blueprint.
  - **Section 1 · Foundations & Core Concepts** — the original 10 units (unchanged).
  - **Section 2 · Developer & Production** — 4 new units closing the exam-domain gaps:
    **Debugging & Troubleshooting**, **Data Exchange**, **Pipeline Development**, **Customizing USD**.
- Now **14 units · 43 lessons · 430 questions** (each new lesson has 10 questions + study notes).
- **Retuned Final Exam** at the end of Section 2: **65 questions / 120 minutes**, sampled by
  domain weight to mirror the real exam.
- Section headers on the learning path and in the Study tab.

## [1.4.0] — 2026-07-02

### Added
- **Timed checkpoint exams** between unit blocks — a shuffled mix of concepts from the
  units you've completed (cumulative), with generous XP rewards scaled by your score.
- **1-hour Final Exam** covering all 10 units, with a score, medal (Gold/Silver/Bronze),
  and a **certificate** (70%+ to earn it).
- Live countdown timer during exams (turns red under 30s); exams cost no hearts; best
  score per exam is saved and shown on its card.

### Fixed
- Lesson study notes now render `<b>`/`<code>` formatting instead of literal tags.

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
