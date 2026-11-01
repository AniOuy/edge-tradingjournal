create table if not exists public.edgebook_data (
 user_id uuid primary key references auth.users(id) on delete cascade,
 payload jsonb not null default '{"accounts":[],"trades":[]}'::jsonb,
 updated_at timestamptz not null default now()
);
alter table public.edgebook_data enable row level security;
create policy "Users read own data" on public.edgebook_data for select to authenticated using (auth.uid() = user_id);
create policy "Users insert own data" on public.edgebook_data for insert to authenticated with check (auth.uid() = user_id);
create policy "Users update own data" on public.edgebook_data for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
