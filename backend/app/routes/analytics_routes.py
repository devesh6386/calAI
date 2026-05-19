from fastapi import APIRouter
from app.models.schemas import APIResponse
from app.database.supabase_client import supabase
from datetime import datetime, timedelta

router = APIRouter()

@router.get("/analytics/weekly/{user_id}", response_model=APIResponse)
def get_weekly_analytics(user_id: str):
    if not supabase:
        return {"success": False, "message": "Supabase not configured.", "data": None}
        
    try:
        # Fetch last 7 days of meals
        seven_days_ago = (datetime.now() - timedelta(days=7)).strftime("%Y-%m-%d")
        res = supabase.table("meals").select("*").eq("user_id", user_id).gte("date", seven_days_ago).execute()
        
        # Group by date
        daily_totals = {}
        for meal in res.data:
            date = meal["date"]
            if date not in daily_totals:
                daily_totals[date] = {"calories": 0, "protein": 0, "carbs": 0, "fat": 0}
            daily_totals[date]["calories"] += meal["total_calories"]
            daily_totals[date]["protein"] += meal["total_protein"]
            daily_totals[date]["carbs"] += meal["total_carbs"]
            daily_totals[date]["fat"] += meal["total_fat"]
            
        return {"success": True, "message": "Weekly analytics fetched.", "data": daily_totals}
    except Exception as e:
        return {"success": False, "message": f"Error fetching analytics: {str(e)}", "data": None}

@router.get("/streak/{user_id}", response_model=APIResponse)
def get_streak(user_id: str):
    if not supabase:
        return {"success": False, "message": "Supabase not configured.", "data": None}
        
    try:
        # Simplified streak calculation
        # Fetch unique dates where meals were logged
        res = supabase.table("meals").select("date").eq("user_id", user_id).order("date", desc=True).execute()
        
        dates = sorted(list(set(m["date"] for m in res.data)), reverse=True)
        streak = 0
        logged_today = False
        
        today = datetime.now().strftime("%Y-%m-%d")
        if dates and dates[0] == today:
            logged_today = True
            streak += 1
            current_date = datetime.strptime(dates[0], "%Y-%m-%d")
            for d in dates[1:]:
                expected_date = current_date - timedelta(days=1)
                if d == expected_date.strftime("%Y-%m-%d"):
                    streak += 1
                    current_date = expected_date
                else:
                    break
        elif dates:
            # Check if yesterday was logged
            yesterday = (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
            if dates[0] == yesterday:
                streak += 1
                current_date = datetime.strptime(dates[0], "%Y-%m-%d")
                for d in dates[1:]:
                    expected_date = current_date - timedelta(days=1)
                    if d == expected_date.strftime("%Y-%m-%d"):
                        streak += 1
                        current_date = expected_date
                    else:
                        break
                        
        return {"success": True, "message": "Streak fetched.", "data": {"streak": streak, "logged_today": logged_today}}
    except Exception as e:
        return {"success": False, "message": f"Error fetching streak: {str(e)}", "data": None}
