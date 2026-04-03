# Contributing to Hotel Management System

Thank you for contributing to the Hotel Management System! This document outlines the standards and procedures for contributing to this project.

---

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Branching Strategy](#branching-strategy)
4. [Commit Message Convention](#commit-message-convention)
5. [Pull Request Process](#pull-request-process)
6. [Coding Standards](#coding-standards)
7. [Testing Requirements](#testing-requirements)
8. [Reporting Bugs](#reporting-bugs)
9. [Requesting Features](#requesting-features)

---

## Code of Conduct

- Be respectful and constructive in all communications.
- Focus feedback on code, not on individuals.
- Acknowledge and address all review comments before requesting re-review.

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/ChitrakVerma/hotel-management-system.git
cd hotel-management-system
```

### 2. Set Up Your Development Environment

**Python backend:**
```bash
python -m venv venv
source venv/bin/activate        # Linux / macOS
venv\Scripts\activate           # Windows
pip install -r requirements.txt
pip install -r requirements-dev.txt
```

**Node.js frontend:**
```bash
cd src/frontend
npm install
```

### 3. Verify Your Setup

```bash
# Run tests to confirm everything works
pytest tests/ -v
```

---

## Branching Strategy

| Branch Pattern | Purpose |
|---------------|---------|
| `main` | Stable, production-ready code only |
| `develop` | Integration branch — all features merge here |
| `feature/<description>` | New features |
| `fix/<description>` | Bug fixes |
| `docs/<description>` | Documentation updates |
| `chore/<description>` | Maintenance tasks (CI, dependencies) |
| `release/<version>` | Release preparation |

**Rules:**
- Never commit directly to `main` or `develop`.
- Always create a branch from `develop` for new work.
- Keep branches short-lived — merge promptly once the feature/fix is complete.

### Creating a Branch

```bash
git checkout develop
git pull origin develop
git checkout -b feature/my-new-feature
```

---

## Commit Message Convention

We use the [Conventional Commits](https://www.conventionalcommits.org/) standard:

```
<type>(<scope>): <short description>

[optional body]

[optional footer: Closes #<issue-number>]
```

**Types:**

| Type | When to Use |
|------|------------|
| `feat` | A new feature |
| `fix` | A bug fix |
| `docs` | Documentation changes only |
| `style` | Formatting, whitespace (no logic change) |
| `refactor` | Code restructuring (no feature / bug change) |
| `test` | Adding or updating tests |
| `chore` | Build process, CI, dependency updates |

**Examples:**

```
feat(booking): add check-in/check-out workflow

fix(billing): correct GST rounding calculation
Closes #42

docs(scmp): update change control section

test(rooms): add unit tests for availability query
```

**Rules:**
- Use lowercase for type and scope.
- Keep the subject line under 72 characters.
- Use imperative mood ("add", "fix", "update" — not "added", "fixed", "updated").
- Reference the related issue number in the footer.

---

## Pull Request Process

1. **Ensure your branch is up-to-date:**
   ```bash
   git fetch origin
   git rebase origin/develop
   ```

2. **Run all tests locally and confirm they pass:**
   ```bash
   pytest tests/ -v
   ```

3. **Open a Pull Request** on GitHub:
   - Target branch: `develop` (or `main` for release PRs)
   - Title: follows the commit convention (e.g., `feat(booking): add check-in workflow`)
   - Description: explain *what* and *why*, and link to the related issue (`Closes #<number>`)

4. **Wait for CI to pass** — the pipeline runs automatically. Fix any failures.

5. **Address review feedback** — update your commits and push; the PR updates automatically.

6. **Do not merge your own PR** unless you are the sole contributor. Request a review.

7. Once approved, the PR author (or reviewer) merges using **"Squash and merge"** or **"Create a merge commit"** as appropriate.

---

## Coding Standards

### Python

- Follow [PEP 8](https://peps.python.org/pep-0008/) style guide.
- Maximum line length: 127 characters.
- Use type hints for all function signatures.
- Write docstrings for all public functions and classes.

```python
def calculate_total_bill(room_rate: float, nights: int, tax_rate: float = 0.18) -> float:
    """
    Calculate the total bill including tax.

    Args:
        room_rate: Nightly room rate in INR.
        nights: Number of nights stayed.
        tax_rate: Tax rate as a decimal (default 18%).

    Returns:
        Total bill amount including tax.
    """
    subtotal = room_rate * nights
    return round(subtotal * (1 + tax_rate), 2)
```

### JavaScript / TypeScript (Frontend)

- Follow [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript).
- Use `const` and `let` — avoid `var`.
- Prefer arrow functions.
- Use meaningful variable names.

### SQL

- Use UPPER CASE for SQL keywords.
- Use `snake_case` for table and column names.
- Always add primary keys, foreign keys, and NOT NULL constraints where appropriate.

---

## Testing Requirements

- Every new feature **must** include unit tests.
- Every bug fix **must** include a test that would have caught the bug.
- Tests live in `tests/unit/` (unit) or `tests/integration/` (integration).
- Test files follow the naming convention: `test_<module_name>.py`.
- CI will fail if tests fail — the PR **cannot** be merged in that state.

```bash
# Run all tests
pytest tests/ -v

# Run tests with coverage report
pytest tests/ -v --cov=src --cov-report=term-missing
```

---

## Reporting Bugs

Use the **Bug Report** issue template:

1. Go to [Issues → New Issue](https://github.com/ChitrakVerma/hotel-management-system/issues/new/choose)
2. Select **Bug Report**
3. Fill in all sections completely
4. Apply appropriate labels

---

## Requesting Features

Use the **Feature Request** issue template:

1. Go to [Issues → New Issue](https://github.com/ChitrakVerma/hotel-management-system/issues/new/choose)
2. Select **Feature Request**
3. Describe the problem and the proposed solution
4. Define acceptance criteria

---

*These guidelines are maintained under version control. Changes must go through the standard PR process.*
