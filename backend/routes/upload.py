# backend/routes/upload.py
import uuid
from fastapi import APIRouter, Depends, File, HTTPException, UploadFile
from auth import get_current_user
from database import supabase

router = APIRouter()

@router.post("/food-image", response_model=dict)
async def upload_food_image(
    file: UploadFile = File(...),
    user_id: str = Depends(get_current_user),
):
    ext = file.filename.split(".")[-1] if "." in file.filename else "jpg"
    filename = f"{uuid.uuid4()}.{ext}"

    try:
        contents = await file.read()
        supabase.storage.from_("food-images").upload(
            filename,
            contents,
            file_options={"content-type": file.content_type or "image/jpeg"}
        )
        project_url = supabase.supabase_url
        public_url = supabase.storage.from_("food-images").get_public_url(filename)
        return {"image_url": public_url}
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc))
