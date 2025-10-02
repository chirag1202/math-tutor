from fastapi import APIRouter, Request
from pydantic import BaseModel
from ..db.supabase_client import sign_up_user

router = APIRouter()

class UserProfile(BaseModel):
    email: str
    full_name: str
    role: str
    password: str

@router.post("/register")
def register_user(profile: UserProfile):
    # Register user in Supabase Auth and sync to users table
    result = sign_up_user(
        email=profile.email,
        password=profile.password,
        full_name=profile.full_name,
        role=profile.role
    )
    return result
