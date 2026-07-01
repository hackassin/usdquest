-- USDQuest v3: weekly league columns on profiles.
-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.
-- The app works without this; running it enables the 🏅 Weekly League tab.

alter table public.profiles add column if not exists weekly_xp  int  not null default 0;
alter table public.profiles add column if not exists week_start text;

-- (Optional) speed up the weekly ranking query:
create index if not exists profiles_week_idx on public.profiles (week_start, weekly_xp desc);
