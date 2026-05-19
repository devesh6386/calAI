import os
from dotenv import load_dotenv

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL", "")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "")
SUPABASE_BUCKET = os.getenv("SUPABASE_BUCKET", "food-images")
AI_API_KEY = os.getenv("AI_API_KEY", "")
AI_PROVIDER = os.getenv("AI_PROVIDER", "mock")
