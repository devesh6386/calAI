# backend/main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import meals, goals, upload, summary

app = FastAPI(
    title="Calorie Tracker API",
    description="FastAPI backend powered by Supabase",
    version="0.1.0",
)

# ---------- CORS ----------
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ---------- Include routers ----------
app.include_router(meals.router, prefix="/meals", tags=["Meals"])
app.include_router(goals.router, prefix="/goals", tags=["Goals"])
app.include_router(upload.router, prefix="/upload", tags=["Upload"])
app.include_router(summary.router, prefix="/summary", tags=["Summary"])

# ---------- Health check ----------
@app.get("/")
async def root():
    return {"message": "Calorie Tracker API is running"}
