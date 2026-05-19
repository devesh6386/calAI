from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import scan_routes, diary_routes, goal_routes, analytics_routes

app = FastAPI(title="SnapMacro API", description="AI Calorie Tracker Backend")

# Add CORS so Flutter frontend can access it
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Adjust in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(scan_routes.router, prefix="/api")
app.include_router(diary_routes.router, prefix="/api/diary")
app.include_router(goal_routes.router, prefix="/api/goals")
app.include_router(analytics_routes.router, prefix="/api")

@app.get("/")
def read_root():
    return {"message": "Welcome to SnapMacro API!"}
