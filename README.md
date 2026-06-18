# AIC Chore Tracker

Mobile-first chore management app for Advanced Implant Centers.
Staff log in by name, see only their assigned tasks, and check them off in real time.
Admin (Dr. Brian) sees full status across all staff.

---

## Deploy in 10 minutes

### Step 1 — Push to GitHub Pages

```bash
# In your terminal / GitHub Desktop:
git init
git add .
git commit -m "AIC chore tracker"
git remote add origin https://github.com/YOUR_USERNAME/aic-chores.git
git push -u origin main
```

Then in GitHub → repo Settings → Pages → Source: **main branch / root** → Save.

Your app will be live at: `https://YOUR_USERNAME.github.io/aic-chores`

---

### Step 2 — Set up Supabase (real-time sync)

1. Go to **supabase.com** → New project (free tier is plenty)
2. Wait ~2 min for it to spin up
3. Open **SQL Editor** → paste and run the entire `supabase-setup.sql` file
4. Go to **Database → Replication** → find `chore_checks` → toggle Realtime **ON**
5. Go to **Settings → API** → copy:
   - **Project URL** (looks like `https://abcxyz.supabase.co`)
   - **anon public** key (long JWT string)

---

### Step 3 — First-time setup in the app

1. Open the app URL on any device
2. Enter your Supabase URL and anon key → **Save & continue**
3. You're live — all check-offs sync across every phone in real time

> The app also works without Supabase (local storage only) — tap "Skip" on setup.
> In that mode, checks only show on the device that made them.

---

## Staff logins

| Name    | Type       | Scheduled days  |
|---------|------------|-----------------|
| Osmani  | Full-time  | Every day       |
| Shawna  | Full-time  | Every day       |
| Chrissy | Full-time  | Every day       |
| Autumn  | Full-time  | Every day       |
| Jessica | Part-time  | Mon & Wed only  |

---

## How rotation works

- Each staff member is assigned **1–2 full operatories** per day
- They own all 4 tasks in their op(s): water check, trash, restock, sweep/mop
- Common areas (kitchen, bathrooms, lobby, autoclave) rotate among full-time staff
- Assignments shift automatically each day and each week
- Admin can manually nudge rotation with the **Rotate** button

---

## Sharing with staff

Send each staff member the GitHub Pages URL. They can:
- Add it to their **home screen** (Safari → Share → Add to Home Screen) for an app-like experience
- Tap their name each morning to see their tasks
- Check off tasks as they complete them — admin sees live updates

---

## Customizing

All config is at the top of `index.html`:

```js
const STAFF = [ ... ]        // add/remove staff, change colors
const OPS = [ ... ]          // add/remove operatories  
const OP_TASKS = [ ... ]     // tasks done in each op
const COMMON_TASKS = [ ... ] // shared area tasks
```

To change Jessica's days, edit the `isJessicaDay()` function:
```js
function isJessicaDay(ds) {
  const d = dow(ds);
  return d === 1 || d === 3; // 0=Sun 1=Mon 2=Tue 3=Wed 4=Thu 5=Fri 6=Sat
}
```
