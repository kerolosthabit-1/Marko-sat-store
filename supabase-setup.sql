-- ============================================================
--  Dsh Store - إعداد قاعدة البيانات على Supabase
--  انسخ الكود ده كله والصقه في SQL Editor ثم اضغط Run
-- ============================================================

-- جدول واحد يخزن كل بيانات المحل كـ JSON مرتبط بالحساب
create table if not exists public.dsh_stores (
  id          text primary key,
  owner       uuid not null default auth.uid() references auth.users(id) on delete cascade,
  data        jsonb not null default '{"products":[],"sales":[],"moves":[],"settings":{"shopName":"محل الدش والريسيفرات"},"nextId":1}'::jsonb,
  rev         bigint not null default 0,
  updated_at  timestamptz not null default now()
);

-- تفعيل حماية الصفوف RLS
alter table public.dsh_stores enable row level security;

-- سياسات الأمان
drop policy if exists dsh_stores_select on public.dsh_stores;
create policy dsh_stores_select on public.dsh_stores
  for select to authenticated using (owner = auth.uid());

drop policy if exists dsh_stores_insert on public.dsh_stores;
create policy dsh_stores_insert on public.dsh_stores
  for insert to authenticated with check (owner = auth.uid());

drop policy if exists dsh_stores_update on public.dsh_stores;
create policy dsh_stores_update on public.dsh_stores
  for update to authenticated using (owner = auth.uid()) with check (owner = auth.uid());

-- تفعيل المزامنة اللحظية
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'dsh_stores'
  ) then
    alter publication supabase_realtime add table public.dsh_stores;
  end if;
end $$;

-- تحديث تاريخ التعديل تلقائياً
create or replace function public.touch_dsh_stores()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end $$;

drop trigger if exists dsh_stores_touch on public.dsh_stores;
create trigger dsh_stores_touch before update on public.dsh_stores
  for each row execute function public.touch_dsh_stores();
