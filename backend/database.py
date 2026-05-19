# backend/database.py
import os
from supabase import create_client, Client
from dotenv import load_dotenv

load_dotenv()   # reads .env

SUPABASE_URL = os.getenv("SUPABASE_URL")
SERVICE_ROLE_KEY = os.getenv("SUPABASE_SERVICE_ROLE_KEY")

if not SUPABASE_URL or not SERVICE_ROLE_KEY:
    # Use empty strings as defaults to prevent immediate crash during build/dry-run,
    # but print a warning.
    print("WARNING: SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY is missing from environment!")
    SUPABASE_URL = SUPABASE_URL or ""
    SERVICE_ROLE_KEY = SERVICE_ROLE_KEY or ""

# Service-role client - full DB and Storage rights (kept server-side only)
supabase: Client = create_client(SUPABASE_URL, SERVICE_ROLE_KEY)
