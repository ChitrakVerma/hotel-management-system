# Software Configuration Management Plan (SCMP)

**Project:** Hotel Management System  
**Course:** ISWE403L – Software Configuration Management  
**Repository:** [ChitrakVerma/hotel-management-system](https://github.com/ChitrakVerma/hotel-management-system)  
**Author:** Chitrak Verma  
**Version:** 1.0  
**Date:** April 2026

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [SCM Tools Used](#2-scm-tools-used)
3. [Configuration Items](#3-configuration-items)
4. [SCM Activities](#4-scm-activities)
   - 4.1 [Version Control](#41-version-control)
   - 4.2 [Change Control Process](#42-change-control-process)
   - 4.3 [Configuration Audits](#43-configuration-audits)
   - 4.4 [Build and Release Management](#44-build-and-release-management)
5. [Roles and Responsibilities](#5-roles-and-responsibilities)
6. [SCM Schedule](#6-scm-schedule)

---

## 1. Introduction

### 1.1 Purpose

This Software Configuration Management Plan (SCMP) defines the policies, procedures, and tools used to manage the configuration of the Hotel Management System project. It ensures that all project artefacts — including source code, database schemas, documentation, and test cases — are properly identified, controlled, and tracked throughout the software development lifecycle.

### 1.2 Scope

This SCMP applies to all phases of the Hotel Management System project:

- Requirements gathering and analysis
- System design and architecture
- Implementation (frontend, backend, database)
- Testing and quality assurance
- Deployment and release management

### 1.3 Definitions

| Term | Definition |
|------|-----------|
| **CI** | Configuration Item — any project artefact placed under version control |
| **SCM** | Software Configuration Management |
| **VCS** | Version Control System (Git) |
| **PR** | Pull Request — a mechanism for code review before merging |
| **CI/CD** | Continuous Integration / Continuous Delivery pipeline |
| **Baseline** | A formally reviewed and agreed-upon snapshot of one or more CIs |

---

## 2. SCM Tools Used

### 2.1 Git

**Git** is the distributed version control system (VCS) used for all local and remote version tracking.

| Feature | Usage in This Project |
|---------|----------------------|
| Branching | Feature branches (`feature/`), bug fix branches (`fix/`), release branches (`release/`) |
| Commits | Atomic commits with descriptive messages following Conventional Commits format |
| Merging | Merges via Pull Requests only — no direct pushes to `main` |
| Tagging | Semantic version tags (`v1.0.0`, `v1.1.0`) mark official releases |
| History | Full audit trail of all changes with author, timestamp, and rationale |

**Branching Strategy:**

```
main            ← stable production-ready code
  └── develop   ← integration branch for ongoing development
        ├── feature/room-management
        ├── feature/booking-system
        ├── feature/billing-module
        └── fix/booking-date-validation
```

**Commit Message Convention:**

```
<type>(<scope>): <short description>

Types: feat, fix, docs, style, refactor, test, chore
Examples:
  feat(booking): add check-in/check-out workflow
  fix(billing): correct tax calculation rounding error
  docs(scmp): update version control section
```

### 2.2 GitHub

**GitHub** is the remote hosting platform providing centralised collaboration, issue tracking, and repository management.

| GitHub Feature | SCM Purpose |
|---------------|-------------|
| **Repositories** | Central storage for all project artefacts |
| **Issues** | Change requests, bug reports, and feature tracking |
| **Pull Requests** | Code review and controlled merge mechanism |
| **Milestones** | Group issues into project phases/releases |
| **Labels** | Categorise issues (`bug`, `enhancement`, `documentation`, `critical`) |
| **Project Boards** | Visual Kanban-style tracking of work in progress |
| **Releases** | Official version snapshots with release notes and changelogs |
| **Branch Protection** | Enforce PR reviews before merging to `main` |
| **Wiki** | Supplementary documentation |

### 2.3 GitHub Actions

**GitHub Actions** is the CI/CD automation platform used for continuous integration, automated testing, and release management.

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `ci.yml` | Push / Pull Request | Run tests, lint code, validate builds |
| Release workflow | Tag push (`v*.*.*`) | Build artefacts, create GitHub Release |

---

## 3. Configuration Items

A **Configuration Item (CI)** is any project artefact that is placed under version control and formally managed. The following **5 CIs** are defined for the Hotel Management System:

| CI # | Name | Location |
|------|------|----------|
| CI #1 | Source Code | `src/` |
| CI #2 | Database Schema | `database/` |
| CI #3 | Documentation | `docs/` |
| CI #4 | Test Cases | `tests/` |
| CI #5 | Build Scripts | `scripts/` |

### 3.1 Source Code

| Item | Location | Description |
|------|----------|-------------|
| Backend source | `src/backend/` | Server-side application logic, API endpoints |
| Frontend source | `src/frontend/` | Client-side user interface components |
| Configuration files | `src/backend/config/` | Environment and application configuration |

**Management:**
- All source code is version-controlled in Git.
- Changes made only through feature branches and Pull Requests.
- Code reviewed by at least one team member before merging.

### 3.2 Database Schema

| Item | Location | Description |
|------|----------|-------------|
| Schema definition | `database/schema.sql` | Table definitions, relationships, constraints |
| Migration scripts | `database/migrations/` | Incremental database change scripts |
| Seed data | `database/seeds/` | Initial/test data population scripts |

**Management:**
- Schema is maintained as a separate root-level CI (`database/`), independent of source code.
- Database migrations use sequential numbering to ensure ordered execution.
- Schema changes require a corresponding PR describing the impact.

### 3.3 Documentation

| Item | Location | Description |
|------|----------|-------------|
| README | `README.md` | Project overview and getting-started guide |
| SCMP | `docs/SCMP.md` | This document — SCM procedures and policies |
| Project Plan | `docs/PROJECT_PLAN.md` | Timeline, milestones, and task breakdown |
| API Documentation | `docs/api/` | Endpoint specifications |
| Version History | `VERSION.md` | Release notes and version changelog |

**Management:**
- Documentation updated alongside code changes in the same commit or PR.
- README must be updated whenever a major feature is added or changed.

### 3.4 Test Cases

| Item | Location | Description |
|------|----------|-------------|
| Unit tests | `tests/unit/` | Tests for individual functions and modules |
| Integration tests | `tests/integration/` | Tests for component interactions |
| Test utilities | `tests/utils/` | Shared test helpers and fixtures |

**Management:**
- All tests version-controlled in the `tests/` directory.
- New features must include corresponding tests.
- Tests automatically executed by CI pipeline on every push and PR.

### 3.5 Build Scripts

| Item | Location | Description |
|------|----------|-------------|
| Environment setup | `scripts/setup.sh` | Installs dependencies and initialises the local dev environment |
| Build script | `scripts/build.sh` | Compiles and packages the application for deployment |
| Deployment script | `scripts/deploy.sh` | Deploys the built application to the target environment |
| CI pipeline | `.github/workflows/ci.yml` | Automated test and build configuration |
| Dependency manifest | `src/backend/requirements.txt` / `src/frontend/package.json` | Project dependencies and versions |
| Git ignore rules | `.gitignore` | Files excluded from version control |
| Issue templates | `.github/ISSUE_TEMPLATE/` | Standardised bug and feature templates |

**Management:**
- All scripts in `scripts/` are executable shell scripts under version control.
- CI/CD configuration is version-controlled and changes reviewed via PR.
- Dependency versions pinned to ensure reproducible builds.

---

## 4. SCM Activities

### 4.1 Version Control

#### 4.1.1 Repository Initialisation

The repository is hosted at [github.com/ChitrakVerma/hotel-management-system](https://github.com/ChitrakVerma/hotel-management-system) and follows this structure:

```
hotel-management-system/
├── .github/               ← GitHub configuration (CI, templates)
├── src/                   ← CI #1: Source Code (backend, frontend)
├── database/              ← CI #2: Database Schema
├── docs/                  ← CI #3: Documentation
├── tests/                 ← CI #4: Test Cases
├── scripts/               ← CI #5: Build Scripts
├── .gitignore             ← Version control exclusions
├── CONTRIBUTING.md        ← Developer guidelines
├── README.md              ← Project overview
└── VERSION.md             ← Version history
```

#### 4.1.2 Branching Procedures

1. All development work starts by creating a new branch from `develop`.
2. Branch names follow the convention: `<type>/<short-description>`.
   - Examples: `feature/room-availability`, `fix/invoice-calculation`, `docs/update-scmp`
3. Commits are made frequently with descriptive messages.
4. When work is complete, a Pull Request is opened to merge back into `develop`.
5. `develop` is merged into `main` only for release milestones.

#### 4.1.3 Commit Procedures

- Commits must be **atomic** — each commit represents one logical change.
- Commit messages must follow the Conventional Commits format.
- Large changes must be split into multiple smaller, reviewable commits.
- No secrets, credentials, or build artefacts are committed to the repository.

#### 4.1.4 Tagging and Releases

- Official releases are tagged using Semantic Versioning: `MAJOR.MINOR.PATCH`
  - `MAJOR` — Breaking changes or complete feature overhauls
  - `MINOR` — New features added in a backward-compatible manner
  - `PATCH` — Bug fixes and minor improvements
- Tags are created from the `main` branch only.
- Each tag triggers the release GitHub Actions workflow.

### 4.2 Change Control Process

All changes to project artefacts follow a formal process:

#### Step 1 – Change Request
- Developer identifies a required change (new feature, bug fix, improvement).
- A **GitHub Issue** is created using the appropriate template:
  - Bug reports use `.github/ISSUE_TEMPLATE/bug_report.md`
  - Feature requests use `.github/ISSUE_TEMPLATE/feature_request.md`
- The issue is labelled, assigned to a milestone, and assigned to a developer.

#### Step 2 – Implementation
- Developer creates a new branch from `develop`: `git checkout -b feature/issue-<number>-<description>`
- Changes are implemented incrementally with regular commits.
- Unit tests are written or updated for the change.

#### Step 3 – Code Review (Pull Request)
- A **Pull Request** is opened on GitHub referencing the original issue (e.g., `Closes #12`).
- The PR must pass all CI checks (automated tests) before review.
- At least one team member reviews the code for correctness, style, and completeness.
- Review comments are addressed and the PR updated if necessary.

#### Step 4 – Merge and Close
- Once approved and all CI checks pass, the PR is merged into `develop`.
- The originating branch is deleted after merge.
- The corresponding issue is automatically closed.

#### Step 5 – Release
- When a milestone is complete, `develop` is merged into `main`.
- A version tag is applied and a GitHub Release is created with release notes.

#### Change Control Workflow Diagram

```
[GitHub Issue Created]
         │
         ▼
[Branch Created from develop]
         │
         ▼
[Development & Local Testing]
         │
         ▼
[Pull Request Opened]
         │
         ▼
[CI Pipeline Runs Automatically]
         │
    ┌────┴────┐
   FAIL      PASS
    │          │
    ▼          ▼
[Fix Issues] [Peer Code Review]
    │          │
    └────┬─────┘
         ▼
   [Review Approved?]
    │          │
   NO         YES
    │          │
    ▼          ▼
[Request  [Merged to develop]
 Changes]       │
                ▼
         [Issue Closed]
```

### 4.3 Configuration Audits

Configuration audits ensure that the software product matches its documented configuration and that SCM procedures are being followed.

#### 4.3.1 Functional Configuration Audit (FCA)

Performed at each release milestone to verify:
- All planned features are implemented and working.
- Test suite passes completely with no failures.
- Documentation is current and accurate.
- All configuration items match their recorded baseline.

**How it is performed:**
- Review of GitHub milestone — all associated issues must be closed.
- CI pipeline must show a passing status on the release commit.
- Manual review of README and docs to confirm they reflect current state.

#### 4.3.2 Physical Configuration Audit (PCA)

Performed before tagging an official release to verify:
- Repository contains only the files listed in the project structure.
- `.gitignore` is correctly excluding build artefacts and sensitive files.
- All version references (in code, docs, VERSION.md) match the release tag.
- No uncommitted changes exist in the repository.

**How it is performed:**
```bash
git status                    # Verify clean working directory
git log --oneline -10         # Review recent commit history
git tag -l                    # List all release tags
```

#### 4.3.3 Ongoing Audits via Pull Request Reviews

Every Pull Request serves as a mini-audit:
- Reviewers verify that changes are consistent with the design and requirements.
- Automated CI checks enforce code quality and test coverage.
- The PR discussion thread documents the rationale for every change.

### 4.4 Build and Release Management

#### 4.4.1 Continuous Integration (CI)

The CI pipeline defined in `.github/workflows/ci.yml` runs automatically on:
- Every push to any branch
- Every Pull Request targeting `main` or `develop`

**CI Pipeline Steps:**
1. **Checkout** – Fetch the repository code.
2. **Environment Setup** – Install runtime (Python/Node.js) and dependencies.
3. **Lint** – Check code style and formatting compliance.
4. **Unit Tests** – Run all unit tests and report results.
5. **Integration Tests** – Run integration tests.
6. **Build** – Attempt to build the application artefact.
7. **Report** – Surface pass/fail status on the PR/commit.

A PR **cannot be merged** if the CI pipeline fails.

#### 4.4.2 Release Process

```
1. All milestone issues closed ──► Merge develop → main
2. Tag the release ──────────────► git tag -a v1.0.0 -m "Release v1.0.0"
3. Push tag ─────────────────────► git push origin v1.0.0
4. GitHub Actions builds ────────► Artefacts generated automatically
5. GitHub Release created ───────► Release notes and changelog published
6. VERSION.md updated ───────────► Document new version details
```

#### 4.4.3 Environment Management

| Environment | Branch | Purpose |
|------------|--------|---------|
| Development | `feature/*`, `fix/*` | Local developer testing |
| Integration | `develop` | Combined feature testing |
| Production | `main` | Stable, released software |

---

## 5. Roles and Responsibilities

| Role | Responsibility |
|------|---------------|
| **Project Lead / Developer** | Overall SCM oversight, approve PRs, create releases, maintain documentation |
| **Developer** | Create feature branches, write code and tests, submit PRs |
| **Reviewer** | Review PRs for correctness, style, and completeness |

*For this project, Chitrak Verma fulfils all roles.*

---

## 6. SCM Schedule

| Activity | Frequency | Responsible |
|----------|-----------|-------------|
| Commit to feature branch | Daily during development | Developer |
| Create/update GitHub Issues | As needed | All team members |
| Pull Request submission | Per feature / bug fix | Developer |
| PR code review | Within 48 hours of PR submission | Reviewer |
| CI pipeline run | Automatic on push / PR | GitHub Actions |
| Functional Configuration Audit | At each milestone | Project Lead |
| Physical Configuration Audit | Before each release | Project Lead |
| VERSION.md update | With each release | Project Lead |
| Release tagging | At each milestone | Project Lead |

---

*This document is subject to version control and any changes must be made via Pull Request.*
