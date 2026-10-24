# Dsh Store أونلاين | ريسيفرات - دش - شاشات

## خطوات التشغيل

### ١) إنشاء مشروع Supabase جديد كلياً
1. افتح [supabase.com](https://supabase.com) وسجّل دخول
2. اضغط **New Project**
3. **Project name:** `dsh-store`
4. **Database Password:** ضع باسورد قوي واحفظه
5. **Region:** اختر أقرب منطقة ليك
6. اضغط **Create new project** واستنى دقيقتين حتى يجهز

### ٢) إعداد قاعدة البيانات
1. من القائمة الجانبية → **SQL Editor** → **New query**
2. افتح ملف `supabase-setup.sql` وانسخ محتواه كله
3. الصقه في المحرر واضغط **Run**
4. لو ظهر `Success. No rows returned` يبقى تمام

### ٣) أخذ مفاتيح المشروع
1. من القائمة الجانبية → **Project Settings** → **API**
2. انسخ **Project URL** (يبدأ بـ `https://...supabase.co`)
3. انسخ **anon public** key (يبدأ بـ `eyJ...`)

### ٤) تعديل ملف index.html
1. افتح `index.html` بأي محرر نصوص
2. ابحث عن السطور التالية في أعلى السكريبت:

```js
const SB_URL = 'PASTE_YOUR_NEW_SUPABASE_URL';
const SB_ANON = 'PASTE_YOUR_NEW_SUPABASE_ANON_KEY';
const SHOP_ID = 'dsh-store-main';
const TABLE_NAME = 'dsh_stores';
```

3. حط القيم اللي نسختها مكان `PASTE_YOUR_NEW_SUPABASE_URL` و `PASTE_YOUR_NEW_SUPABASE_ANON_KEY`
4. احفظ الملف

### ٥) رفع الموقع على GitHub Pages
1. اعمل حساب على [github.com](https://github.com) لو مش عندك
2. اعمل **New repository** باسم `dsh-store` واجعله **Public**
3. ارفع الملفات الأربعة: `index.html` ، `supabase-setup.sql` ، `robots.txt` ، `START-HERE.md`
4. اذهب لـ **Settings** → **Pages**
5. **Source:** `Deploy from a branch`
6. **Branch:** `main` و **Folder:** `/ (root)`
7. اضغط **Save** واستنى ٢-٣ دقائق
8. هيظهر لك الرابط: `https://<username>.github.io/dsh-store/`

### ٦) تفعيل المصادقة
1. في Supabase → **Authentication** → **Providers** → **Email**
2. تأكد إن **Enable Email provider** مفعل
3. لو عايز تسجل مباشرة من غير تأكيد إيميل اقفل **Confirm email** (اختياري)

## الاستخدام
- سجّل حساب جديد من الشاشة الأولى ويفضل تستخدمه على كل الأجهزة
- أي بيع / إضافة صنف / تعديل يظهر فورًا على باقي الأجهزة
- نسخة احتياطية متاحة من أعلى الشاشة لو عايز تحفظ نسخة JSON
- البيانات كلها متزامنة على حسابك فقط حسب سياسات الأمان
