# Supabase Database & Security Guide

This guide contains the SQL database schema and security policies required for the calAI/SnapMacro FastAPI backend and Flutter application.

---

## 1. SQL Database Schema

Run the following SQL queries inside the **SQL Editor** of your Supabase Dashboard to create the necessary tables, indexes, and configure Row-Level Security (RLS).

```sql
-- ----------------------------------------------------
-- 1. Create Meals Table
-- ----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.meals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    food_name TEXT NOT NULL,
    calories DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    protein DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    carbs DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    fats DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    quantity DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    meal_type VARCHAR(50) NOT NULL DEFAULT 'snack', -- e.g., breakfast, lunch, dinner, snack
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Index user_id for high-performance lookup
CREATE INDEX IF NOT EXISTS meals_user_id_idx ON public.meals (user_id);
CREATE INDEX IF NOT EXISTS meals_created_at_idx ON public.meals (created_at);

-- Enable Row Level Security (RLS)
ALTER TABLE public.meals ENABLE ROW LEVEL SECURITY;

-- ----------------------------------------------------
-- 2. Create Goals Table
-- ----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.goals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
    daily_calories DOUBLE PRECISION NOT NULL DEFAULT 2000.0,
    daily_protein DOUBLE PRECISION NOT NULL DEFAULT 150.0,
    daily_carbs DOUBLE PRECISION NOT NULL DEFAULT 200.0,
    daily_fats DOUBLE PRECISION NOT NULL DEFAULT 65.0,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.goals ENABLE ROW LEVEL SECURITY;
```

---

## 2. Row-Level Security (RLS) Policies

To protect your users' privacy and secure all requests, execute the following SQL to apply RLS policies. These enforce that authenticated users can only view, insert, update, or delete their own calorie tracking entries.

```sql
-- ====================================================
-- RLS Policies for meals
-- ====================================================

-- 1. Select Policy: Users can only read their own meals
CREATE POLICY "Allow users to read own meals" ON public.meals
    FOR SELECT
    USING (auth.uid() = user_id);

-- 2. Insert Policy: Users can only insert meals for their own ID
CREATE POLICY "Allow users to insert own meals" ON public.meals
    FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- 3. Update Policy: Users can only modify their own meals
CREATE POLICY "Allow users to update own meals" ON public.meals
    FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- 4. Delete Policy: Users can only remove their own meals
CREATE POLICY "Allow users to delete own meals" ON public.meals
    FOR DELETE
    USING (auth.uid() = user_id);


-- ====================================================
-- RLS Policies for goals
-- ====================================================

-- 1. Select Policy: Users can only read their own goals
CREATE POLICY "Allow users to read own goals" ON public.goals
    FOR SELECT
    USING (auth.uid() = user_id);

-- 2. Insert Policy: Users can only insert goals for their own ID
CREATE POLICY "Allow users to insert own goals" ON public.goals
    FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- 3. Update Policy: Users can only update their own goals
CREATE POLICY "Allow users to update own goals" ON public.goals
    FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
```

---

## 3. Storage Bucket Setup

To store food scan images, you need to create a **Storage Bucket** in Supabase:

1. In the Supabase Dashboard, go to **Storage**.
2. Click **New Bucket**.
3. Set the Bucket Name to exactly `food-images`.
4. Ensure **Public Bucket** is enabled (so image URLs can be displayed in the app).
5. (Optional) Under **Allowed MIME types**, restrict it to `image/*`.
6. Click **Save**.

### Storage RLS Policies
To allow users to upload their images:
- Go to the bucket's **Policies** tab.
- Click **New Policy** -> **For full customization**.
- Add an INSERT policy for authenticated users:
  - Allowed operations: `INSERT`
  - Target roles: `authenticated`
  - Target folder path: `auth.uid() = (storage.foldername(name))[1]` (this structures image directories cleanly inside user-specific folders).

---

## 4. Run the Backend Locally

1. Go to the `backend` directory:
   ```bash
   cd backend
   ```
2. Activate your python virtual environment:
   ```bash
   source venv/bin/activate
   ```
3. Copy `.env.example` to `.env` and fill in your keys:
   ```bash
   cp .env.example .env
   ```
4. Run the server using:
   ```bash
   uvicorn main:app --reload
   ```

---

## 5. API Testing Examples

### 1. Upload Food Image
```bash
curl -X POST "http://localhost:8000/upload/food-image" \
  -H "Authorization: Bearer YOUR_SUPABASE_USER_JWT" \
  -F "file=@/path/to/food_photo.jpg"
```
*Response:*
```json
{
  "image_url": "https://gyfremsxvbbwvfmorstp.supabase.co/storage/v1/object/public/food-images/userId/1723456789.jpg"
}
```

### 2. Add a Meal
```bash
curl -X POST "http://localhost:8000/meals" \
  -H "Authorization: Bearer YOUR_SUPABASE_USER_JWT" \
  -H "Content-Type: application/json" \
  -d '{
    "food_name": "Chicken Rice",
    "calories": 520.0,
    "protein": 35.0,
    "carbs": 60.0,
    "fats": 12.0,
    "quantity": 1.0,
    "meal_type": "lunch",
    "image_url": "https://url-to-image.jpg"
  }'
```
