# backend/routes/summary.py
from datetime import datetime, date
from fastapi import APIRouter, Depends
from database import supabase
from auth import get_current_user
from schemas import DailySummary

router = APIRouter()

@router.get("/today", response_model=DailySummary)
async def today_summary(user_id: str = Depends(get_current_user)):
    # 1. Get today's meals
    today_start = datetime.combine(date.today(), datetime.min.time()).isoformat()
    meals_resp = (
        supabase.table("meals")
        .select("calories,protein,carbs,fats")
        .eq("user_id", user_id)
        .gte("created_at", today_start)
        .execute()
    )

    total_cal = total_pro = total_carb = total_fat = 0.0
    for m in meals_resp.data:
        total_cal += float(m.get("calories", 0))
        total_pro += float(m.get("protein", 0))
        total_carb += float(m.get("carbs", 0))
        total_fat += float(m.get("fats", 0))

    # 2. Get user's goal (or default if not set)
    goal_resp = supabase.table("goals").select("*").eq("user_id", user_id).execute()
    if not goal_resp.data:
        # Default fallback goals so it doesn't crash
        goal = {
            "daily_calories": 2000.0,
            "daily_protein": 150.0,
            "daily_carbs": 200.0,
            "daily_fats": 65.0,
        }
    else:
        goal = goal_resp.data[0]

    # 3. Compute remaining values
    remaining_cal = max(0.0, float(goal.get("daily_calories", 2000.0)) - total_cal)
    remaining_pro = max(0.0, float(goal.get("daily_protein", 150.0)) - total_pro)
    remaining_carb = max(0.0, float(goal.get("daily_carbs", 200.0)) - total_carb)
    remaining_fat = max(0.0, float(goal.get("daily_fats", 65.0)) - total_fat)

    return DailySummary(
        date=date.today(),
        total_calories=total_cal,
        total_protein=total_pro,
        total_carbs=total_carb,
        total_fats=total_fat,
        remaining_calories=remaining_cal,
        remaining_protein=remaining_pro,
        remaining_carbs=remaining_carb,
        remaining_fats=remaining_fat,
    )
