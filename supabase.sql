-- Rode no SQL Editor do Supabase (uma vez)
create table app_data (
  user_id uuid primary key default auth.uid() references auth.users on delete cascade,
  data jsonb not null,
  updated_at timestamptz default now()
);

alter table app_data enable row level security;

create policy "cada usuario ve so os proprios dados"
  on app_data for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
