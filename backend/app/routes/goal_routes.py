from fastapi import APIRouter
from app.models.schemas import APIResponse, GoalRequest
from app.database.supabase_client import supabase

router = APIRouter()

@router.post("/", response_model=APIResponse)
def save_goals(request: GoalRequest):
    if not supabase:
        return {"success": False, "message": "Supabase not configured.", "data": None}
        
    try:
        data = {
            "user_id": request.user_id,
            "calories": request.calories,
            "protein": request.protein,
            "carbs": request.carbs,
            "fat": request.fat
        }
        
        # Upsert goal
        res = supabase.table("goals").upsert(data, on_conflict="user_id").execute()
        return {"success": True, "message": "Goals saved.", "data": res.data[0] if res.data else None}
    except Exception as e:
        return {"success": False, "message": f"Error saving goals: {str(e)}", "data": None}

@router.get("/{user_id}", response_model=APIResponse)
def get_goals(user_id: str):
    if not supabase:
        return {"success": False, "message": "Supabase not configured.", "data": None}
        
    try:
        res = supabase.table("goals").select("*").eq("user_id", user_id).execute()
        if not res.data:
            # Default goals if none exist
            return {"success": True, "message": "Default goals.", "data": {"calories": 2000, "protein": 150, "carbs": 200, "fat": 65}}
        return {"success": True, "message": "Goals fetched.", "data": res.data[0]}
    except Exception as e:
        return {"success": False, "message": f"Error fetching goals: {str(e)}", "data": None}
