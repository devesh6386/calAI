# SnapMacro Backend

FastAPI backend for SnapMacro AI calorie tracker app. Uses Supabase for database and storage.

## Setup

1. Create a virtual environment:
   ```bash
   cd backend
   python3 -m venv venv
   source venv/bin/activate
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Configure environment variables:
   Copy `.env.example` to `.env` and fill in your Supabase details.

4. Run the server:
   ```bash
   uvicorn main:app --reload
   ```
   The backend will be available at `http://localhost:8000`.
