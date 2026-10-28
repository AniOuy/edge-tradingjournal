-- Edgebook / Supabase setup
-- Run this entire file in Supabase Dashboard > SQL Editor.
-- Uses per-user Row Level Security. Never expose the service_role key in your front-end.

create extension if not exists pgcrypto;

create table if not exists public.journal_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null default current_date,
  symbol text,
  session text,
  timeframe text,
  direction text,
  status text,
  r numeric,
  rules text,
  ote text,
  double_ote text,
  sd text,
  poc text,
  vah text,
  val text,
  other_levels text,
  confluences jsonb not null default '[]'::jsonb,
  news text,
  conditions text,
  screenshot_url text,
  notes text,
  review text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.journal_entries enable row level security;
drop policy if exists "Users can view own journal entries" on public.journal_entries;
create policy "Users can view own journal entries" on public.journal_entries for select to authenticated using (auth.uid() = user_id);
drop policy if exists "Users can insert own journal entries" on public.journal_entries;
create policy "Users can insert own journal entries" on public.journal_entries for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "Users can update own journal entries" on public.journal_entries;
create policy "Users can update own journal entries" on public.journal_entries for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "Users can delete own journal entries" on public.journal_entries;
create policy "Users can delete own journal entries" on public.journal_entries for delete to authenticated using (auth.uid() = user_id);

create table if not exists public.journal_settings (
  user_id uuid primary key references auth.users(id) on delete cascade,
  confluences jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.journal_settings enable row level security;
drop policy if exists "Users can view own journal settings" on public.journal_settings;
create policy "Users can view own journal settings" on public.journal_settings for select to authenticated using (auth.uid() = user_id);
drop policy if exists "Users can insert own journal settings" on public.journal_settings;
create policy "Users can insert own journal settings" on public.journal_settings for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "Users can update own journal settings" on public.journal_settings;
create policy "Users can update own journal settings" on public.journal_settings for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Screenshot storage bucket. Private by default; authenticated users can upload/read their own files.
insert into storage.buckets (id, name, public) values ('journal-screenshots', 'journal-screenshots', false)
on conflict (id) do nothing;
drop policy if exists "Users can upload own screenshots" on storage.objects;
create policy "Users can upload own screenshots" on storage.objects for insert to authenticated
with check (bucket_id = 'journal-screenshots' and (storage.foldername(name))[1] = auth.uid()::text);
drop policy if exists "Users can view own screenshots" on storage.objects;
create policy "Users can view own screenshots" on storage.objects for select to authenticated
using (bucket_id = 'journal-screenshots' and (storage.foldername(name))[1] = auth.uid()::text);
drop policy if exists "Users can delete own screenshots" on storage.objects;
create policy "Users can delete own screenshots" on storage.objects for delete to authenticated
using (bucket_id = 'journal-screenshots' and (storage.foldername(name))[1] = auth.uid()::text);

-- Important: for a private bucket, public URLs won't work for viewing images.
-- Use signed URLs for display, or switch to public bucket only if you accept public image access.
