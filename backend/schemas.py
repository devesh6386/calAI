# backend/schemas.py
from datetime import date, datetime
from typing import Optional
from pydantic import BaseModel, Field

# ---------- Meal ----------
class MealCreate(BaseModel):
    food_name: str = Field(..., json_schema_extra={"example": "Apple"})
    calories: float = Field(..., ge=0)
    protein: float = Field(..., ge=0)
    carbs: float = Field(..., ge=0)
    fats: float = Field(..., ge=0)
    quantity: float = Field(..., gt=0, json_schema_extra={"description": "Serving size, e.g., 1.0"})
    meal_type: str = Field(..., json_schema_extra={"example": "breakfast"})
    image_url: Optional[str] = None

class MealResponse(BaseModel):
    id: str
    user_id: str
    food_name: str
    calories: float
    protein: float
    carbs: float
    fats: float
    quantity: float
    meal_type: str
    image_url: Optional[str] = None
    created_at: str

# ---------- Goal ----------
class GoalBase(BaseModel):
    daily_calories: float = Field(..., gt=0)
    daily_protein: float = Field(..., gt=0)
    daily_carbs: float = Field(..., gt=0)
    daily_fats: float = Field(..., gt=0)

class GoalCreate(GoalBase):
    pass

class GoalResponse(GoalBase):
    user_id: str
    updated_at: str

# ---------- Summary ----------
class DailySummary(BaseModel):
    date: date
    total_calories: float
    total_protein: float
    total_carbs: float
    total_fats: float
    remaining_calories: float
    remaining_protein: float
    remaining_carbs: float
    remaining_fats: float
