# Contributing to MathsTutor

Thank you for your interest in contributing to MathsTutor! This document provides guidelines and steps for contributing.

## Getting Started

### Prerequisites
- Python 3.8 or higher
- Flutter SDK
- Git
- Docker (optional, for local development)

### Setting Up Your Development Environment

1. **Fork the repository**
   - Navigate to the [MathsTutor repository](https://github.com/chirag1202/math-tutor)
   - Click the "Fork" button in the top-right corner

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/math-tutor.git
   cd math-tutor
   ```

3. **Set up the backend**
   ```bash
   cd backend_fastapi
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

4. **Set up the frontend**
   ```bash
   cd frontend_flutter
   flutter pub get
   ```

5. **Configure environment variables**
   ```bash
   cp env.example .env
   # Edit .env with your configuration
   ```

6. **Install pre-commit hooks**
   ```bash
   pip install pre-commit
   pre-commit install
   ```

## Development Workflow

### Creating a Branch

Always create a new branch for your changes:

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

Branch naming conventions:
- `feature/` - for new features
- `fix/` - for bug fixes
- `docs/` - for documentation changes
- `test/` - for test additions/modifications

### Making Changes

1. **Write clean, maintainable code**
   - Follow PEP 8 for Python code
   - Follow Dart style guide for Flutter code
   - Add comments where necessary
   - Keep functions small and focused

2. **Test your changes**
   ```bash
   # Backend tests
   cd backend_fastapi
   pytest
   
   # Frontend tests
   cd frontend_flutter
   flutter test
   ```

3. **Lint your code**
   ```bash
   # Python
   cd backend_fastapi
   black .
   ruff check .
   
   # Flutter
   cd frontend_flutter
   flutter analyze
   dart format .
   ```

### Committing Changes

1. **Stage your changes**
   ```bash
   git add .
   ```

2. **Commit with a clear message**
   ```bash
   git commit -m "Add feature: brief description of changes"
   ```

   Commit message guidelines:
   - Use present tense ("Add feature" not "Added feature")
   - Be concise but descriptive
   - Reference issue numbers when applicable (e.g., "Fix #123: ...")

3. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

### Opening a Pull Request

1. Navigate to the original repository
2. Click "New Pull Request"
3. Select your fork and branch
4. Fill out the PR template with:
   - Clear description of changes
   - Related issue numbers
   - Screenshots (for UI changes)
   - Testing steps

5. Submit the PR and wait for review

## Code Review Process

- Maintainers will review your PR
- Address any requested changes
- Once approved, your PR will be merged

## Reporting Issues

When reporting issues, please include:
- Clear, descriptive title
- Steps to reproduce
- Expected vs actual behavior
- Environment details (OS, Python version, Flutter version)
- Screenshots or error logs if applicable

## Code Style Guidelines

### Python
- Follow PEP 8
- Use type hints
- Maximum line length: 88 characters (Black default)
- Use meaningful variable names

### Flutter/Dart
- Follow official Dart style guide
- Use meaningful widget names
- Keep widgets focused and reusable
- Add comments for complex logic

## Testing Guidelines

- Write tests for new features
- Ensure all tests pass before submitting PR
- Aim for meaningful test coverage
- Include both positive and negative test cases

## Questions?

If you have questions or need help:
- Open an issue with the "question" label
- Reach out to maintainers

Thank you for contributing to MathsTutor! 🎓
