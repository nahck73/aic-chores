-- AIC Chore Tracker — Supabase setup
-- Run this entire file in your Supabase SQL Editor (supabase.com → project → SQL Editor)

-- 1. Create the chore checks table
create table if not exists chore_checks (
  id          bigint generated always as identity primary key,
  date        date        not null,
  chore_id    text        not null,
  done        boolean     not null default true,
  updated_at  timestamptz not null default now(),
  constraint chore_checks_date_chore_id_key unique (date, chore_id)
);

-- 2. Index for fast date lookups
create index if not exists chore_checks_date_idx on chore_checks (date);

-- 3. Auto-update timestamp
create or replace function update_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger chore_checks_updated_at
  before update on chore_checks
  for each row execute function update_updated_at();

-- 4. Enable Row Level Security but allow all reads/writes (no auth required)
--    This is fine for an internal office tool on a private URL
alter table chore_checks enable row level security;

create policy "Allow all reads"  on chore_checks for select using (true);
create policy "Allow all writes" on chore_checks for insert with check (true);
create policy "Allow all updates" on chore_checks for update using (true);

-- 5. Enable Realtime for live sync across devices
-- Go to: Supabase Dashboard → Database → Replication → chore_checks → toggle ON
-- (Cannot be done via SQL — must be done in the dashboard UI)

-- Done! Your database is ready.
-- Next: copy your Project URL and anon key from Settings → API into the app setup screen.
