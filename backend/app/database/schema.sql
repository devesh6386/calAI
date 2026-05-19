-- Supabase Schema for SnapMacro

-- 1. profiles
CREATE TABLE IF NOT EXISTS profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  username TEXT,
  avatar_url TEXT
);

-- 2. goals
CREATE TABLE IF NOT EXISTS goals (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) NOT NULL UNIQUE,
  calories INTEGER DEFAULT 2000,
  protein INTEGER DEFAULT 150,
  carbs INTEGER DEFAULT 200,
  fat INTEGER DEFAULT 65,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. meals
CREATE TABLE IF NOT EXISTS meals (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  meal_type TEXT NOT NULL, -- e.g., 'breakfast', 'lunch', 'dinner', 'snack'
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  image_url TEXT,
  total_calories NUMERIC DEFAULT 0,
  total_protein NUMERIC DEFAULT 0,
  total_carbs NUMERIC DEFAULT 0,
  total_fat NUMERIC DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. food_items
CREATE TABLE IF NOT EXISTS food_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  meal_id UUID REFERENCES meals(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  quantity TEXT,
  calories NUMERIC DEFAULT 0,
  protein NUMERIC DEFAULT 0,
  carbs NUMERIC DEFAULT 0,
  fat NUMERIC DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
