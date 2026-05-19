from app.config import AI_PROVIDER, AI_API_KEY
from app.models.schemas import FoodItem

def analyze_food_image(image_bytes: bytes) -> dict:
    if AI_PROVIDER == "mock" or not AI_API_KEY:
        # Return mock data for testing
        return {
            "items": [
                {
                    "name": "Grilled Chicken Breast",
                    "quantity": "1 piece (150g)",
                    "calories": 248,
                    "protein": 46.5,
                    "carbs": 0,
                    "fat": 5.4
                },
                {
                    "name": "Brown Rice",
                    "quantity": "1 cup (195g)",
                    "calories": 216,
                    "protein": 5.0,
                    "carbs": 45.0,
                    "fat": 1.8
                }
            ],
            "total": {
                "calories": 464,
                "protein": 51.5,
                "carbs": 45.0,
                "fat": 7.2
            }
        }
    
    # In a real scenario, you'd send `image_bytes` to OpenAI Vision API or similar
    # and parse the JSON response here.
    raise NotImplementedError("Real AI provider integration not implemented yet.")
