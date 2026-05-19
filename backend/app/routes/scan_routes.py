import uuid
from fastapi import APIRouter, UploadFile, File, Form
from app.models.schemas import ScanResponse
from app.services.ai_food_service import analyze_food_image
from app.database.supabase_client import supabase

router = APIRouter()

@router.post("/scan-food", response_model=ScanResponse)
async def scan_food(
    image: UploadFile = File(...),
    user_id: str = Form(None),
    meal_type: str = Form(None)
):
    try:
        contents = await image.read()
        
        # 1. Analyze image
        ai_result = analyze_food_image(contents)
        
        # 2. Upload image to Supabase Storage (if supabase is configured and user_id is provided)
        image_url = None
        if supabase and user_id:
            file_extension = image.filename.split(".")[-1] if "." in image.filename else "jpg"
            file_name = f"{user_id}/{uuid.uuid4()}.{file_extension}"
            
            # Use public bucket "food-images"
            supabase.storage.from_("food-images").upload(file_name, contents)
            image_url = supabase.storage.from_("food-images").get_public_url(file_name)
        
        # We can return the AI result directly. The frontend will hit `/diary/add` 
        # to actually save it after the user confirms.
        return {
            "success": True,
            "message": "Food analyzed successfully.",
            "data": ai_result
        }
    except Exception as e:
        return {
            "success": False,
            "message": f"Error scanning food: {str(e)}",
            "data": None
        }
