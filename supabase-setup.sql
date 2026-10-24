-- الريسيفر والدش — إعداد مشروع Supabase جديد
-- شغّل النص مرة واحدة من SQL Editor في المشروع الجديد.

create table if not exists public.shops (
  id text primary key,
  owner uuid not null default auth.uid() references auth.users(id) on delete cascade,
  data jsonb not null default '{"products":[],"sales":[],"moves":[],"settings":{"shopName":"الريسيفر والدش"},"nextId":1}'::jsonb,
  rev bigint not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.shops enable row level security;

drop policy if exists shops_select on public.shops;
create policy shops_select on public.shops
  for select to authenticated using (owner = auth.uid());

drop policy if exists shops_insert on public.shops;
create policy shops_insert on public.shops
  for insert to authenticated with check (owner = auth.uid());

drop policy if exists shops_update on public.shops;
create policy shops_update on public.shops
  for update to authenticated using (owner = auth.uid()) with check (owner = auth.uid());

-- لا توجد سياسة حذف؛ لا يمكن حذف صف المحل من واجهة التطبيق.

do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'shops'
  ) then
    alter publication supabase_realtime add table public.shops;
  end if;
end $$;

create or replace function public.touch_shops()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end $$;

drop trigger if exists shops_touch on public.shops;
create trigger shops_touch before update on public.shops
  for each row execute function public.touch_shops();