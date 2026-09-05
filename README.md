# 🏢 Corporate Leave Management System (CLMS)

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)

A robust, enterprise-grade leave management web application built with Java EE / Jakarta EE. This system streamlines the process of leave tracking and approval within an organization, eliminating manual paper-based requests and providing transparency for employees, managers, and HR administrators.

## 📋 Table of Contents
- [Features](#-features)
- [Modules](#-modules)
- [Technology Stack](#-technology-stack)
- [Prerequisites](#-prerequisites)
- [Setup & Installation](#-setup--installation)
- [Default Accounts](#-default-accounts)
- [Team](#-team)

## 🚀 Features
- **Role-Based Access Control (RBAC)**: Secure login and separate workspaces for Employees, Managers, and HR Admins.
- **Automated Workflow**: Hierarchical leave application, managerial review, and automated leave deduction.
- **Robust Security**: Protected routes, hashed passwords (BCrypt), and session validation.
- **Transactional Consistency**: Atomic operations for leave approval/deduction to ensure absolute data integrity.
- **Responsive UI/UX**: Built with Bootstrap 5 to work seamlessly across desktop and mobile devices.

## 📦 Modules

### 1. Employee Module
- **Dashboard**: Real-time summary of available leave balances (Casual, Sick, Earned).
- **Leave Application**: Intuitive form to request time off (full day / half day).
- **History**: Comprehensive log of past and pending requests, including manager remarks.

### 2. Manager Module
- **Team Dashboard**: View all pending leave requests from direct reportees.
- **Approval Workflow**: Approve or reject leave applications with mandatory remarks.
- **Team Availability**: Check team schedules to ensure coverage before approving leaves.

### 3. HR Admin Module
- **User Management**: Onboard new employees, update profiles, and assign manager hierarchies.
- **Leave Allocation**: Allocate or modify annual leave balances for employees.
- **Analytics**: View organization-wide leave metrics and generate reports.

## 🛠️ Technology Stack
- **Backend**: Java 17+, Jakarta EE (Servlet 6.0, JSP 3.1)
- **Database**: MySQL 8.0+
- **Connection Pool**: HikariCP (optimized database connections)
- **Frontend**: HTML5, CSS3, Bootstrap 5.3, Vanilla JS, JSTL
- **Build Tool**: Maven

## ⚙️ Prerequisites
- JDK 17 or higher
- MySQL Server 8.0+
- Apache Tomcat 10+ (or compatible Jakarta EE container)
- Maven 3.8+

## 🚀 Setup & Installation

### 1. Database Setup
1. Create a MySQL database using the provided schema script:
   ```bash
   mysql -u root -p < sql/schema.sql
   ```
2. Seed the database with initial users and leave balances:
   ```bash
   mysql -u root -p < sql/seed_data.sql
   ```

### 2. Configuration
Update `src/main/resources/db.properties` with your database credentials:
```properties
db.url=jdbc:mysql://localhost:3306/clms_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
db.username=root
db.password=your_secure_password
```

### 3. Build & Deploy
Run the following Maven command to clean and build the project:
```bash
mvn clean package
```
This generates `clms.war` inside the `target/` directory. Deploy this WAR file to your application server's webapps folder (e.g., Apache Tomcat).

## 🔑 Default Accounts
You can log in using the following seeded accounts:
- **HR Admin**: hr@clms.enterprise.com
- **Manager**: manager@clms.enterprise.com
- **Employee**: bhavesh@clms.enterprise.com

*(Note: Check the `seed_data.sql` file for the default passwords)*

## 👥 Team
Developed by a team of 3:
1. [Team Member 1]
2. [Team Member 2]
3. [Team Member 3]
