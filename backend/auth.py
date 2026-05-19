# backend/auth.py
from fastapi import Request, HTTPException, status
from supabase.lib.auth_client import AuthException
from database import supabase
import os
from dotenv import load_dotenv

load_dotenv()
JWT_SECRET = os.getenv("SUPABASE_JWT_SECRET")

def get_current_user(request: Request) -> str:
    """
    Extract Bearer token, verify with Supabase Auth, and return the user's UUID.
    Raises 401 if token is missing or invalid.
    """
    auth_header: str | None = request.headers.get("Authorization")
    if not auth_header or not auth_header.startswith("Bearer "):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Missing or malformed Authorization header",
        )
    token = auth_header.split(" ", 1)[1]

    try:
        resp = supabase.auth.get_user(token)
        user = resp.user
        if not user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid token",
            )
        return str(user.id)   # UUID string
    except AuthException as exc:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=f"Supabase auth error: {exc.message}",
        )
