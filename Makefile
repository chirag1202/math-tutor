.PHONY: backend flutter test backend-test flutter-test lint clean help

help:
	@echo "MathsTutor Makefile Commands"
	@echo "============================"
	@echo "make backend       - Run the FastAPI backend"
	@echo "make flutter       - Run the Flutter frontend"
	@echo "make test          - Run all tests (backend + frontend)"
	@echo "make backend-test  - Run backend tests only"
	@echo "make flutter-test  - Run frontend tests only"
	@echo "make lint          - Run linters on backend and frontend"
	@echo "make clean         - Clean build artifacts"

backend:
	@echo "Starting FastAPI backend..."
	cd backend_fastapi && \
	. venv/bin/activate 2>/dev/null || python3 -m venv venv && . venv/bin/activate && \
	pip install -q -r requirements.txt && \
	uvicorn app.main:app --reload

flutter:
	@echo "Starting Flutter frontend..."
	cd frontend_flutter && \
	flutter pub get && \
	flutter run -d chrome

test: backend-test flutter-test

backend-test:
	@echo "Running backend tests..."
	cd backend_fastapi && \
	. venv/bin/activate 2>/dev/null || (python3 -m venv venv && . venv/bin/activate) && \
	pip install -q -r requirements.txt && \
	pytest -v

flutter-test:
	@echo "Running frontend tests..."
	cd frontend_flutter && \
	flutter test

lint:
	@echo "Linting backend..."
	cd backend_fastapi && \
	. venv/bin/activate 2>/dev/null || (python3 -m venv venv && . venv/bin/activate) && \
	pip install -q black ruff && \
	black . && \
	ruff check .
	@echo "Linting frontend..."
	cd frontend_flutter && \
	flutter analyze && \
	dart format .

clean:
	@echo "Cleaning build artifacts..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	cd frontend_flutter && flutter clean || true
	@echo "Clean complete!"
