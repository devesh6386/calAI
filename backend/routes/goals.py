# backend/routes/goals.py
from fastapi import APIRouter, Depends, HTTPException
from database import supabase
from auth import get_current_user
from schemas import GoalCreate, GoalResponse
from datetime import datetime

router = APIRouter()

# ---- GET /goals ----
@router.get("/", response_model=GoalResponse)
async def get_goal(user_id: str = Depends(get_current_user)):
    resp = supabase.table("goals").select("*").eq("user_id", user_id).execute()
    if not resp.data:
        raise HTTPException(status_code=404, detail="Goal not set")
    return GoalResponse(**resp.data[0])

# ---- POST /goals (create or update) ----
@router.post("/", response_model=GoalResponse)
async def upsert_goal(
    goal: GoalCreate,
    user_id: str = Depends(get_current_user),
):
    data = goal.model_dump()
    data["user_id"] = user_id
    data["updated_at"] = datetime.utcnow().isoformat()
    resp = supabase.table("goals").upsert(data, on_conflict="user_id").execute()
    if not resp.data:
        raise HTTPException(status_code=400, detail="Failed to save goal")
    return GoalResponse(**resp.data[0])
