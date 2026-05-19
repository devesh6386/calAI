# backend/routes/meals.py
from datetime import datetime, date
from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from database import supabase
from auth import get_current_user
from schemas import MealCreate, MealResponse

router = APIRouter()

# ---- POST /meals ----
@router.post("/", response_model=MealResponse)
async def create_meal(
    meal: MealCreate,
    user_id: str = Depends(get_current_user),
):
    data = meal.model_dump()
    data["user_id"] = user_id
    data["created_at"] = datetime.utcnow().isoformat()
    resp = supabase.table("meals").insert(data).execute()
    if not resp.data:
        raise HTTPException(status_code=400, detail="Failed to insert meal")
    inserted = resp.data[0]
    return MealResponse(**inserted)

# ---- GET /meals (all) ----
@router.get("/", response_model=List[MealResponse])
async def get_all_meals(user_id: str = Depends(get_current_user)):
    resp = supabase.table("meals").select("*").eq("user_id", user_id).order("created_at", desc=True).execute()
    return [MealResponse(**r) for r in resp.data]

# ---- GET /meals/today ----
@router.get("/today", response_model=List[MealResponse])
async def get_today_meals(user_id: str = Depends(get_current_user)):
    today_start = datetime.combine(date.today(), datetime.min.time()).isoformat()
    resp = (
        supabase.table("meals")
        .select("*")
        .eq("user_id", user_id)
        .gte("created_at", today_start)
        .order("created_at", desc=True)
        .execute()
    )
    return [MealResponse(**r) for r in resp.data]

# ---- DELETE /meals/{meal_id} ----
@router.delete("/{meal_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_meal(
    meal_id: str,
    user_id: str = Depends(get_current_user),
):
    # Verify ownership
    check = supabase.table("meals").select("id").eq("id", meal_id).eq("user_id", user_id).execute()
    if not check.data:
        raise HTTPException(status_code=404, detail="Meal not found or not owned")

    del_resp = supabase.table("meals").delete().eq("id", meal_id).execute()
    if not del_resp.data:
        raise HTTPException(status_code=400, detail="Failed to delete meal")
    return
