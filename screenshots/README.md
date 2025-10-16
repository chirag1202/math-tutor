# MathsTutor Application Screenshots

This folder contains screenshots of the MathsTutor application running locally.

## Screenshots

### 1. Backend Root Endpoint
**File:** `backend-root-endpoint.png`

Shows the FastAPI backend health check endpoint (`GET /`) returning `{"status":"ok"}`, confirming the backend server is running successfully.

### 2. Backend OpenAPI Specification
**File:** `backend-openapi-spec.png`

Displays the complete OpenAPI/Swagger specification (`GET /openapi.json`) for the MathsTutor API, showing all available endpoints including:
- `GET /` - Health check endpoint
- `POST /register` - User registration endpoint

### 3. Backend Demo Page
**File:** `backend-demo-page.png`

Shows a custom HTML demo page created to interact with the MathsTutor API. The page includes:
- **GET / - Health Check**: Button to test if the API is running
- **GET /openapi.json - API Documentation**: Button to fetch the OpenAPI specification
- **POST /register - User Registration**: Form to register new users with fields for email, full name, role, and password

### 4. Backend Demo Page with Response
**File:** `backend-demo-page-with-response.png`

Demonstrates the demo page in action, showing the successful response from the health check endpoint (`{"status": "ok"}`) after clicking the "Test Endpoint" button.

## Running the Application

### Backend (FastAPI)
```bash
cd backend_fastapi
pip install -r requirements.txt
pip install python-dotenv supabase
python -m uvicorn app.main:app --reload --port 8000
```

### Demo Page
```bash
cd backend_fastapi
python -m http.server 8080
# Then open http://127.0.0.1:8080/demo.html in your browser
```

## API Endpoints

- **Health Check**: `GET http://127.0.0.1:8000/`
- **OpenAPI Spec**: `GET http://127.0.0.1:8000/openapi.json`
- **Swagger UI**: `GET http://127.0.0.1:8000/docs`
- **User Registration**: `POST http://127.0.0.1:8000/register`

## Notes

- The backend requires a `.env` file with `SUPABASE_URL` and `SUPABASE_KEY` environment variables
- The frontend Flutter application is not shown in these screenshots as Flutter is not available in this environment
- The demo page provides an alternative way to test the API functionality without the Flutter frontend
