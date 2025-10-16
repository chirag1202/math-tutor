import os
from dotenv import load_dotenv
from supabase import create_client, Client

load_dotenv()
SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)


def sign_up_user(email: str, password: str, full_name: str, role: str = "student"):
    import logging

    logging.basicConfig(level=logging.INFO)
    # Register user with Supabase Auth
    try:
        response = supabase.auth.sign_up({"email": email, "password": password})
        logging.info(f"Supabase sign_up response: {response}")
        if response.user:
            user_id = response.user.id
            try:
                insert_resp = (
                    supabase.table("users")
                    .insert(
                        {
                            "id": user_id,
                            "email": email,
                            "full_name": full_name,
                            "role": role,
                        }
                    )
                    .execute()
                )
                logging.info(f"Inserted into users table: {insert_resp}")
                return {"user_id": user_id, "email": email}
            except Exception as db_err:
                logging.error(f"Error inserting user profile: {db_err}")
                raise Exception(f"Error inserting user profile: {db_err}")
        else:
            logging.error(f"Sign up failed, no user object: {response}")
            raise Exception(f"Sign up failed: {response}")
    except Exception as e:
        logging.error(f"Exception during sign up: {e}")
        raise


def sign_in_user(email: str, password: str):
    response = supabase.auth.sign_in_with_password(
        {"email": email, "password": password}
    )
    if response.session:
        return {
            "access_token": response.session.access_token,
            "user_id": response.user.id,
            "email": response.user.email,
        }
    else:
        raise Exception(f"Sign in failed: {response}")


def get_user_profile(user_id: str):
    result = supabase.table("users").select("*").eq("id", user_id).single().execute()
    return result.data
