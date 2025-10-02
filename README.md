# MathsTutor
One-line description...

## Quickstart
1. Create a Supabase project and run sql/schema.sql
2. Set environment variables...
3. Run backend:
   cd backend_fastapi
   python -m venv venv && venv\Scripts\activate
   pip install -r requirements.txt
   uvicorn app.main:app --reload
4. Run frontend:
   cd frontend_flutter
   flutter pub get
   flutter run -d chrome
