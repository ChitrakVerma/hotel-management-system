<<<<<<< HEAD
"# Hotel Management System" 
=======

# 🏨 Hotel Management System

> Implementation of Software Configuration Management (SCM) concepts using Git and GitHub  
> **Course:** ISWE403L – Software Configuration Management

---

## 👥 Team Members

| Name | GitHub Username | Role |
|------|----------------|------|
| Chitrak Verma | [@ChitrakVerma](https://github.com/ChitrakVerma) | Project Lead / Developer |
| Sankalp Singh Solanki | [@sankalpsolankii](https://github.com/sankalpsolankii) | Developer |

---

## 📖 Introduction

The **Hotel Management System** is a software application designed to streamline and automate the day-to-day operations of a hotel. It provides an integrated platform for managing rooms, bookings, guests, staff, and billing, replacing manual processes with an efficient and reliable digital solution.
This project also serves as a practical demonstration of Software Configuration Management (SCM) principles, leveraging Git and GitHub to manage the software development lifecycle from planning through release.

---

## ❗ Problem Statement

Hotels today face significant operational challenges:

- **Manual booking processes** leading to errors, double-bookings, and inefficiencies.
- **Lack of real-time room availability** information across departments.
- **Disorganised guest records** making it difficult to personalise services.
- **Fragmented billing systems** resulting in delayed invoicing and payment errors.
- **Inefficient staff scheduling** causing service gaps or overstaffing.

These issues lead to poor guest experiences, revenue loss, and high administrative overhead. There is a clear need for a centralised, automated system to manage hotel operations effectively.

---

## 🎯 Project Objectives

1. Develop a **centralised Hotel Management System** that integrates all key hotel operations.
2. Implement **real-time room availability tracking** and dynamic pricing.
3. Automate **reservation, check-in, and check-out workflows** to reduce manual effort.
4. Maintain comprehensive **guest profiles** to enable personalised service.
5. Provide an **accurate billing and payment system** with automated invoice generation.
6. Manage **staff roles, schedules, and responsibilities** efficiently.
7. Apply **SCM best practices** (version control, change management, CI/CD) throughout the development lifecycle.

---

## 📋 Project Description

The Hotel Management System is a full-stack web application comprising:
- Backend: A RESTful API server responsible for handling business logic and data management
- Frontend: An intuitive web interface designed for hotel staff and administrators
- Database: A relational database used to store all operational data
- The system is built using a modular architecture, enabling independent development, testing, and maintenance of each subsystem. All source code, database schemas, documentation, and configuration files are managed under version control using Git and GitHub.
- The project follows an Agile development methodology, with iterative releases tracked through milestones, issues, and pull requests on GitHub—effectively demonstrating the Software Configuration Management (SCM) concepts required for ISWE403L.

---

## ✨ Features Overview

### 🛏 Room Management
- View, add, update, and delete room records.
- Track room categories (Single, Double, Suite, etc.) and pricing.
- Monitor real-time room availability and occupancy status.
- Manage housekeeping and maintenance schedules.

### 📅 Booking Management
- Create, modify, and cancel reservations.
- Handle check-in and check-out processes.
- View booking history and upcoming reservations.
- Support for group bookings and special requests.

### 👤 Guest Management
- Maintain detailed guest profiles (contact info, preferences, history).
- Track loyalty points and repeat-guest discounts.
- Store identification and KYC records securely.

### 💰 Billing System
- Automatically generate detailed, itemised invoices during checkout
- Support diverse payment methods such as cash, card, and online transactions
- Monitor pending payments and generate comprehensive financial reports
- Ensure accurate calculation of discounts, taxes, and additional charges

### 👨‍💼 Staff Management
- Manage employee profiles, roles, and departments.
- Assign and track staff shifts and schedules.
- Role-based access control for system security.
- Monitor staff performance and attendance.

---

## 📁 Repository Structure

The repository is organised around **5 explicit Configuration Items (CIs)** as required by ISWE403L:

```
hotel-management-system/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   └── feature_request.md
│   └── workflows/
│       └── ci.yml
│
├── src/                    ← CI #1: Source Code
│   ├── backend/
│   │   ├── booking/
│   │   ├── billing/
│   │   └── inventory/
│   └── frontend/
│
├── database/               ← CI #2: Database Schema
│   └── schema.sql
│
├── docs/                   ← CI #3: Documentation
│   ├── SCMP.md
│   └── PROJECT_PLAN.md
│
├── tests/                  ← CI #4: Test Cases
│   └── test_booking.py
│
├── scripts/                ← CI #5: Build Scripts
│   ├── build.sh
│   ├── deploy.sh
│   └── setup.sh
│
├── .gitignore
├── CONTRIBUTING.md
├── VERSION.md
└── README.md
```

### Configuration Items

| CI # | Name | Location | Description |
|------|------|----------|-------------|
| **CI #1** | Source Code | `src/` | Backend (booking, billing, inventory) and frontend application code |
| **CI #2** | Database Schema | `database/` | SQL schema definitions, table relationships, and seed data |
| **CI #3** | Documentation | `docs/` | SCMP, project plan, and all project documentation |
| **CI #4** | Test Cases | `tests/` | Automated unit and integration tests |
| **CI #5** | Build Scripts | `scripts/` | Environment setup, build, and deployment automation scripts |

---

## 🚀 Getting Started

### Prerequisites
- Python ≥ 3.8 or Node.js ≥ 18 for application development
- Git for source code management and version control
- PostgreSQL or MySQL as the relational database system

### Clone the Repository
```bash
git clone https://github.com/ChitrakVerma/hotel-management-system.git
cd hotel-management-system
```

### Development Setup
```bash
./scripts/setup.sh    # install dependencies and initialise the database
./scripts/build.sh    # compile and package the application
```

Refer to [CONTRIBUTING.md](CONTRIBUTING.md) for full contribution guidelines.

---

## 📄 Documentation

| Document | Description |
|----------|-------------|
| [SCMP.md](docs/SCMP.md) | Software Configuration Management Plan |
| [PROJECT_PLAN.md](docs/PROJECT_PLAN.md) | Project plan and schedule |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines |
| [VERSION.md](VERSION.md) | Version history and release procedures |

---

## 🔧 SCM Practices

This project demonstrates the following SCM practices:

- **Version Control** – All changes tracked via Git commits on feature branches.
- **Change Control** – GitHub Issues and Pull Requests used for all changes.
- **Configuration Audits** – Enforced through PR reviews and commit history.
- **CI/CD** – Automated testing and build pipeline via GitHub Actions.
- **Release Management** – Semantic versioning with GitHub Releases and tags.

See [docs/SCMP.md](docs/SCMP.md) for the full Software Configuration Management Plan.

---

## 📜 License

This project was developed as part of the ISWE403L – Software Configuration Management course at VIT, for academic learning and practical implementation.

---

*Last updated: April 2026*
>>>>>>> 7cf6180940e6201ad224c1f1de8cd9d6c7f58869
