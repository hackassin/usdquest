-- USDQuest v2: public profiles + friendships (for stats, friends & leaderboard)
-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.
-- Safe to run even if you already ran schema.sql (the progress table).

-- ---------- PROFILES (public stats, readable by any logged-in user) ----------
create table if not exists public.profiles (
  id            uuid primary key references auth.users(id) on delete cascade,
  username      text unique not null,
  display_name  text,
  xp            int  not null default 0,
  streak        int  not null default 0,
  lessons       int  not null default 0,
  updated_at    timestamptz not null default now()
);
alter table public.profiles enable row level security;

drop policy if exists "profiles readable by authenticated" on public.profiles;
create policy "profiles readable by authenticated" on public.profiles
  for select to authenticated using (true);

drop policy if exists "insert own profile" on public.profiles;
create policy "insert own profile" on public.profiles
  for insert to authenticated with check (auth.uid() = id);

drop policy if exists "update own profile" on public.profiles;
create policy "update own profile" on public.profiles
  for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

-- ---------- FRIENDSHIPS (requester -> addressee, pending/accepted) ----------
create table if not exists public.friendships (
  id          uuid primary key default gen_random_uuid(),
  requester   uuid not null references auth.users(id) on delete cascade,
  addressee   uuid not null references auth.users(id) on delete cascade,
  status      text not null default 'pending' check (status in ('pending','accepted')),
  created_at  timestamptz not null default now(),
  unique (requester, addressee)
);
alter table public.friendships enable row level security;

drop policy if exists "see own friendships" on public.friendships;
create policy "see own friendships" on public.friendships
  for select to authenticated using (auth.uid() = requester or auth.uid() = addressee);

drop policy if exists "send request" on public.friendships;
create policy "send request" on public.friendships
  for insert to authenticated with check (auth.uid() = requester);

drop policy if exists "accept request" on public.friendships;
create policy "accept request" on public.friendships
  for update to authenticated using (auth.uid() = addressee) with check (auth.uid() = addressee);

drop policy if exists "remove friendship" on public.friendships;
create policy "remove friendship" on public.friendships
  for delete to authenticated using (auth.uid() = requester or auth.uid() = addressee);
