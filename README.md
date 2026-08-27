# Corporate Leave Management System (CLMS)

A robust, enterprise-grade leave management web application built with Java EE / Jakarta EE.

## 🚀 Features

- **Role-Based Access Control**: Secure login and separate workspaces for Employees, Managers, and HR Admins.
- **Employee Portal**: Apply for leave, check real-time balance (Casual, Sick, Earned), and view application history.
- **Manager Portal**: View team leave requests, approve/reject applications with remarks, and manage team availability.
- **HR Dashboard**: Manage employees, assign managers, allocate leaves, and view organization-wide metrics.
- **Robust Security**: Protected routes, hashed passwords (BCrypt), and session validation.
- **Transactional Consistency**: Atomic operations for leave approval/deduction to ensure data integrity.

## 🛠️ Technology Stack

- **Backend**: Java 17+, Jakarta EE (Servlet 6.0, JSP 3.1)
- **Database**: MySQL 8.0+
- **Connection Pool**: HikariCP
- **Frontend**: HTML5, CSS3, Bootstrap 5.3, Vanilla JS, JSTL
- **Build Tool**: Maven

## ⚙️ Setup Instructions

### 1. Database Setup
1. Create a MySQL database using the provided script: `sql/schema.sql`.
2. Seed the database with initial data (users and leave balances) using `sql/seed_data.sql`.

### 2. Configuration
Update the `src/main/resources/db.properties` with your database credentials:
```properties
db.url=jdbc:mysql://localhost:3306/clms_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
db.username=root
db.password=your_password
```

### 3. Build & Deploy
Run the following Maven command to build the project:
```bash
mvn clean package
```
This will generate `clms.war` inside the `target/` directory. Deploy this WAR file to your application server (e.g., Apache Tomcat 10+).

### 4. Default Accounts (Login)
- **HR Admin**: hr@clms.enterprise.com
- **Manager**: manager@clms.enterprise.com
- **Employee**: bhavesh@clms.enterprise.com
*(Note: Initial default passwords are set in the seed data)*
