-- USDQuest v4: index to keep the Global leaderboard fast as profiles grow.
-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.

create index if not exists profiles_xp_idx on public.profiles (xp desc);
