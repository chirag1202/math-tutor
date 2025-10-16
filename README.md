# MathsTutor
AI-powered math learning application with FastAPI backend and Flutter frontend.

## Environment Variables

Copy `env.example` to `.env` in the repository root and configure the following variables:

### Backend Variables
- `SUPABASE_URL`: Your Supabase project URL
- `SUPABASE_KEY`: Your Supabase anonymous/public key

## Local Setup

### Prerequisites
- Python 3.8+
- Flutter SDK
- PostgreSQL (or use Docker Compose)

### Backend Setup
```bash
cd backend_fastapi
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

Copy `env.example` to `.env` and configure your environment variables.

Run the backend:
```bash
uvicorn app.main:app --reload
```

The API will be available at `http://localhost:8000`

### Frontend Setup
```bash
cd frontend_flutter
flutter pub get
flutter run -d chrome
```

### Docker Setup (Optional)
To run the backend with PostgreSQL using Docker:
```bash
docker-compose up
```

## Development Tools

### Makefile Commands
This project includes a Makefile for common development tasks:

```bash
make backend       # Run the FastAPI backend
make flutter       # Run the Flutter frontend
make test          # Run all tests (backend + frontend)
make backend-test  # Run backend tests only
make flutter-test  # Run frontend tests only
make lint          # Run linters on backend and frontend
make clean         # Clean build artifacts
make help          # Show all available commands
```

### Pre-commit Hooks
This project uses pre-commit hooks to ensure code quality. To install:

```bash
pip install pre-commit
pre-commit install
```

The hooks will automatically run:
- `black` - Python code formatter
- `ruff` - Python linter
- `dart format` - Dart/Flutter code formatter

To run manually:
```bash
pre-commit run --all-files
```

## API Endpoints

### Health Check
- **GET** `/health` - Returns the health status of the backend service
  ```json
  {
    "status": "healthy",
    "service": "math-tutor-backend"
  }
  ```

## Quickstart
1. Create a Supabase project and run `supabase/schema.sql`
2. Copy `env.example` to `.env` and set your environment variables
3. Follow Backend Setup or Docker Setup instructions above
4. Follow Frontend Setup instructions above

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
