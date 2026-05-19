from supabase import create_client, Client
from app.config import SUPABASE_URL, SUPABASE_KEY

def get_supabase() -> Client:
    # If credentials are empty (e.g. for testing without a real DB), this might fail,
    # but for a real app, it requires valid URL and KEY.
    if not SUPABASE_URL or not SUPABASE_KEY:
        raise ValueError("Supabase URL and Key must be provided in the .env file")
    return create_client(SUPABASE_URL, SUPABASE_KEY)

try:
    supabase = get_supabase()
except ValueError:
    supabase = None
