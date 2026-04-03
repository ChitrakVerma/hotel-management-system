# Project Plan – Hotel Management System

**Course:** ISWE403L – Software Configuration Management  
**Repository:** [ChitrakVerma/hotel-management-system](https://github.com/ChitrakVerma/hotel-management-system)  
**Author:** Chitrak Verma  
**Version:** 1.0  
**Date:** April 2026

---

## 1. Project Overview

The Hotel Management System is a web-based application to automate and centralise hotel operations including room management, booking, guest management, staff management, and billing. The project is developed as part of the ISWE403L course to demonstrate Software Configuration Management (SCM) best practices using Git and GitHub.

---

## 2. Team Members

| Name | Role | GitHub |
|------|------|--------|
| Chitrak Verma | Project Lead / Full-Stack Developer | [@ChitrakVerma](https://github.com/ChitrakVerma) |

---

## 3. Project Milestones

| Milestone | Description | Target Date |
|-----------|-------------|-------------|
| M1 – Project Setup | Repository structure, documentation, SCM configuration | Week 1 |
| M2 – Database Design | Schema design, ER diagram, migration scripts | Week 2 |
| M3 – Backend Core | API server setup, authentication, room management API | Week 3–4 |
| M4 – Booking & Guest | Booking workflow, guest profile management | Week 5–6 |
| M5 – Billing & Staff | Billing system, staff management, role-based access | Week 7–8 |
| M6 – Frontend | User interface for all modules | Week 9–10 |
| M7 – Testing | Unit tests, integration tests, bug fixes | Week 11 |
| M8 – Release v1.0 | Final QA, documentation review, v1.0.0 release | Week 12 |

---

## 4. Work Breakdown Structure (WBS)

### Phase 1 – Project Initiation & SCM Setup (Week 1)

- [x] Create GitHub repository
- [x] Configure `.gitignore`
- [x] Write README.md
- [x] Write SCMP.md
- [x] Write PROJECT_PLAN.md
- [x] Create CONTRIBUTING.md
- [x] Create VERSION.md
- [x] Create GitHub Issue Templates (bug report, feature request)
- [x] Configure GitHub Actions CI/CD pipeline
- [x] Set up directory structure (`src/`, `tests/`, `docs/`)

### Phase 2 – Database Design (Week 2)

- [ ] Design entity-relationship (ER) diagram
- [x] Write `src/database/schema.sql`
- [ ] Create migration scripts for initial tables
- [ ] Document schema in `docs/database.md`
- [ ] Create seed data for testing

### Phase 3 – Backend Development (Week 3–4)

- [ ] Set up backend project structure
- [ ] Implement authentication (login, session management)
- [ ] Room Management API (CRUD operations)
- [ ] Category and pricing management
- [ ] Write unit tests for backend modules
- [ ] API documentation

### Phase 4 – Booking & Guest Management (Week 5–6)

- [ ] Booking creation, modification, cancellation API
- [ ] Check-in / check-out workflow
- [ ] Guest profile management (create, update, view)
- [ ] Guest history and preferences
- [ ] Write tests for booking and guest modules

### Phase 5 – Billing & Staff Management (Week 7–8)

- [ ] Invoice generation on checkout
- [ ] Payment recording and tracking
- [ ] Staff profile management (CRUD)
- [ ] Shift and schedule assignment
- [ ] Role-based access control
- [ ] Write tests for billing and staff modules

### Phase 6 – Frontend Development (Week 9–10)

- [ ] Set up frontend project
- [ ] Login and dashboard page
- [ ] Room management UI
- [ ] Booking management UI
- [ ] Guest management UI
- [ ] Billing UI
- [ ] Staff management UI
- [ ] Responsive design and accessibility review

### Phase 7 – Testing (Week 11)

- [ ] Complete unit test suite
- [ ] Integration tests for all API endpoints
- [ ] End-to-end testing
- [ ] Performance testing
- [ ] Bug fixes from testing
- [ ] Test coverage report

### Phase 8 – Release (Week 12)

- [ ] Final code review and audit
- [ ] Update all documentation
- [ ] Functional Configuration Audit
- [ ] Physical Configuration Audit
- [ ] Tag v1.0.0 release on GitHub
- [ ] Create GitHub Release with release notes
- [ ] Update VERSION.md

---

## 5. Task Schedule (Gantt Overview)

```
Week:    1    2    3    4    5    6    7    8    9   10   11   12
Phase 1: ████
Phase 2:      ████
Phase 3:           ████ ████
Phase 4:                     ████ ████
Phase 5:                               ████ ████
Phase 6:                                         ████ ████
Phase 7:                                                   ████
Phase 8:                                                        ████
```

---

## 6. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Scope creep – adding too many features | Medium | High | Stick to defined features; use GitHub Issues to manage scope |
| Technical difficulty with a module | Medium | Medium | Research early; break into smaller tasks; ask for help |
| Lost work due to merge conflicts | Low | Medium | Frequent commits and rebasing from `develop` regularly |
| CI pipeline failures blocking merges | Low | Medium | Fix CI failures promptly; never bypass pipeline |
| Incomplete documentation | Medium | High | Document alongside development, not after |

---

## 7. GitHub Project Tracking

All project tasks are tracked using:

- **GitHub Issues** – One issue per task or bug.
- **GitHub Milestones** – Group issues by project phase (M1–M8).
- **GitHub Labels** – Categorise as `feature`, `bug`, `documentation`, `testing`, `chore`.
- **GitHub Projects Board** – Kanban board with columns: `Backlog`, `In Progress`, `In Review`, `Done`.

---

## 8. Definition of Done

A task or feature is considered **Done** when:

1. Code is implemented and working as expected.
2. Unit tests are written and passing.
3. CI pipeline passes (all checks green).
4. Pull Request reviewed and approved.
5. PR merged to `develop`.
6. Relevant documentation updated.
7. Corresponding GitHub Issue closed.

---

*This document is maintained in version control. Any changes must be proposed via Pull Request.*
