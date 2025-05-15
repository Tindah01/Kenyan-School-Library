# Kenyan High School Library Management System

## Project Description
A comprehensive database system for managing library operations in a Kenyan high school, tracking books, students, staff, borrowing, reservations, and fines.

## Database Schema Overview

### Core Entities
- **Students**: Tracks all student information with Kenyan curriculum details (Form/Stream)
- **Staff**: Library personnel with role-based access
- **Books**: Catalog of all library materials with Kenyan publishing details
- **Book Copies**: Physical inventory management
- **Borrowings**: Circulation transactions
- **Reservations**: Book hold requests
- **Fines**: Penalties for late returns or damages

## Entity-Relationship Diagram
![Library ER Diagram](library_erd.png) *(See below for generation instructions)*

## Key Features
- Form/Stream tracking aligned with Kenyan secondary system
- Support for Kenyan publishers and authors
- Fine calculation in KSh
- KNEC/KICD relevant book categorization
- Bilingual support (English/Kiswahili)

## Setup Instructions

1. **Database Creation**:
```sql
CREATE DATABASE high_school_library;
USE high_school_library;
