# Version History – Hotel Management System

This document records the release history of the Hotel Management System project following [Semantic Versioning](https://semver.org/) (`MAJOR.MINOR.PATCH`).

---

## Versioning Policy

| Segment | Increment When… |
|---------|----------------|
| **MAJOR** | Incompatible API changes or complete module rewrites |
| **MINOR** | New features added in a backward-compatible manner |
| **PATCH** | Backward-compatible bug fixes and minor improvements |

### Pre-release Tags

- `v0.x.x` — Development / early prototype phase
- `v1.0.0` — First stable release
- `-alpha`, `-beta`, `-rc.1` suffixes for pre-release builds

---

## Release Procedure

### Step-by-Step Guide

1. **Verify all milestone issues are closed** on GitHub.
2. **Ensure CI is passing** on the `develop` branch.
3. **Merge `develop` into `main`** via a Pull Request titled `release: v<X.Y.Z>`.
4. **Create an annotated Git tag:**
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0 – Initial stable release"
   git push origin v1.0.0
   ```
5. **Create a GitHub Release:**
   - Go to Releases → Draft a new release
   - Select the tag
   - Add release title and release notes (see template below)
   - Attach any build artefacts if applicable
   - Publish the release
6. **Update this file** (`VERSION.md`) to record the new release.
7. **Update the version reference** in any source files or configuration that embed the version string.
8. **Close the GitHub Milestone** for this release.

### Release Notes Template

```markdown
## What's Changed

### ✨ New Features
- 

### 🐛 Bug Fixes
- 

### 📄 Documentation
- 

### 🔧 Maintenance
- 

**Full Changelog:** https://github.com/ChitrakVerma/hotel-management-system/compare/v0.0.0...v1.0.0
```

---

## Version History

### v0.1.0 – Repository Initialisation *(April 2026)*

**Tag:** `v0.1.0`  
**Branch:** `main`  
**Status:** Released

#### Changes
- Initialised GitHub repository with complete project structure.
- Created `README.md` with project overview, team details, problem statement, objectives, and features.
- Created `docs/SCMP.md` – Software Configuration Management Plan.
- Created `docs/PROJECT_PLAN.md` – Project plan, milestones, and WBS.
- Created `CONTRIBUTING.md` – Development and contribution guidelines.
- Created `VERSION.md` – This document.
- Configured `.gitignore` for Python and Node.js projects.
- Added `.github/ISSUE_TEMPLATE/bug_report.md`.
- Added `.github/ISSUE_TEMPLATE/feature_request.md`.
- Added `.github/workflows/ci.yml` – GitHub Actions CI pipeline.
- Created directory scaffolding: `src/backend/`, `src/frontend/`, `src/database/`, `tests/`.
- Created initial `src/database/schema.sql` template.

---

### Upcoming Releases

| Version | Planned Content | Target |
|---------|----------------|--------|
| v0.2.0 | Database schema finalised, migration scripts | Week 2 |
| v0.3.0 | Backend API – Room Management | Week 3–4 |
| v0.4.0 | Backend API – Booking & Guest Management | Week 5–6 |
| v0.5.0 | Backend API – Billing & Staff Management | Week 7–8 |
| v0.6.0 | Frontend implementation | Week 9–10 |
| v0.7.0 | Complete test suite | Week 11 |
| v1.0.0 | First stable release | Week 12 |

---

*This document is maintained in version control. All updates must go through a Pull Request.*
