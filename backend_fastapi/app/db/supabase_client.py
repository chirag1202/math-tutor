

from supabase import create_client, Client

SUPABASE_URL = "https://fldmzcgwygtooaboinsi.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZsZG16Y2d3eWd0b29hYm9pbnNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk0MTY0NzgsImV4cCI6MjA3NDk5MjQ3OH0.FeNifv6sM2xKROAIrAkSwcQooRyQUHANBL5WKBE_K4c"

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

def sign_up_user(email: str, password: str, full_name: str, role: str = "student"):
    # Register user with Supabase Auth
    response = supabase.auth.sign_up({"email": email, "password": password})
    if response.user:
        # Sync user profile to custom users table
        user_id = response.user.id
        supabase.table("users").insert({
            "id": user_id,
            "email": email,
            "full_name": full_name,
            "role": role
        }).execute()
        return {"user_id": user_id, "email": email}
    else:
        raise Exception(f"Sign up failed: {response}")

def sign_in_user(email: str, password: str):
    response = supabase.auth.sign_in_with_password({"email": email, "password": password})
    if response.session:
        return {
            "access_token": response.session.access_token,
            "user_id": response.user.id,
            "email": response.user.email
        }
    else:
        raise Exception(f"Sign in failed: {response}")

def get_user_profile(user_id: str):
    result = supabase.table("users").select("*").eq("id", user_id).single().execute()
    return result.data
