from fastapi import APIRouter
from app.models.schemas import APIResponse, AddMealRequest
from app.database.supabase_client import supabase

router = APIRouter()

@router.post("/add", response_model=APIResponse)
def add_meal(request: AddMealRequest):
    if not supabase:
        return {"success": False, "message": "Supabase not configured.", "data": None}
    
    try:
        # 1. Insert Meal
        meal_data = {
            "user_id": request.user_id,
            "meal_type": request.meal_type,
            "date": request.date,
            "total_calories": request.total_calories,
            "total_protein": request.total_protein,
            "total_carbs": request.total_carbs,
            "total_fat": request.total_fat,
            "image_url": request.image_url
        }
        
        meal_res = supabase.table("meals").insert(meal_data).execute()
        meal_id = meal_res.data[0]["id"]
        
        # 2. Insert Food Items
        items_data = []
        for item in request.food_items:
            items_data.append({
                "meal_id": meal_id,
                "name": item.name,
                "quantity": item.quantity,
                "calories": item.calories,
                "protein": item.protein,
                "carbs": item.carbs,
                "fat": item.fat
            })
            
        if items_data:
            supabase.table("food_items").insert(items_data).execute()
            
        return {"success": True, "message": "Meal added successfully", "data": meal_res.data[0]}
    except Exception as e:
        return {"success": False, "message": f"Error adding meal: {str(e)}", "data": None}

@router.get("/today/{user_id}", response_model=APIResponse)
def get_today_meals(user_id: str):
    if not supabase:
        return {"success": False, "message": "Supabase not configured.", "data": None}
        
    try:
        # In a real app, query by today's date
        res = supabase.table("meals").select("*, food_items(*)").eq("user_id", user_id).order("created_at", desc=True).execute()
        
        total_cals = sum(m["total_calories"] for m in res.data)
        total_prot = sum(m["total_protein"] for m in res.data)
        total_carbs = sum(m["total_carbs"] for m in res.data)
        total_fat = sum(m["total_fat"] for m in res.data)
        
        return {
            "success": True,
            "message": "Today's meals fetched.",
            "data": {
                "meals": res.data,
                "totals": {
                    "calories": total_cals,
                    "protein": total_prot,
                    "carbs": total_carbs,
                    "fat": total_fat
                }
            }
        }
    except Exception as e:
        return {"success": False, "message": f"Error fetching meals: {str(e)}", "data": None}
