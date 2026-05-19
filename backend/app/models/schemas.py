from pydantic import BaseModel
from typing import List, Optional
from datetime import date

# Standard Response
class APIResponse(BaseModel):
    success: bool
    message: str
    data: Optional[dict] = None

# Food Item
class FoodItem(BaseModel):
    name: str
    quantity: str
    calories: float
    protein: float
    carbs: float
    fat: float

# Scan Response
class ScanResponseData(BaseModel):
    items: List[FoodItem]
    total: dict

class ScanResponse(APIResponse):
    data: Optional[ScanResponseData] = None

# Diary Models
class AddMealRequest(BaseModel):
    user_id: str
    meal_type: str
    date: str
    food_items: List[FoodItem]
    total_calories: float
    total_protein: float
    total_carbs: float
    total_fat: float
    image_url: Optional[str] = None

# Goal Models
class GoalRequest(BaseModel):
    user_id: str
    calories: int
    protein: int
    carbs: int
    fat: int
