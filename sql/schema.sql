-- Database Initialization
CREATE DATABASE IF NOT EXISTS clms_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE clms_db;

-- 1. Users & Hierarchy Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_code VARCHAR(20) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('EMPLOYEE', 'MANAGER', 'HR_ADMIN') NOT NULL DEFAULT 'EMPLOYEE',
    department VARCHAR(50) NOT NULL,
    manager_id INT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (manager_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- 2. Leave Balance Allocation Table
CREATE TABLE IF NOT EXISTS leave_balances (
    balance_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    leave_type ENUM('CASUAL', 'SICK', 'EARNED', 'WORK_FROM_HOME', 'UNPAID') NOT NULL,
    allocated_days DECIMAL(5,1) NOT NULL DEFAULT 0.0,
    used_days DECIMAL(5,1) NOT NULL DEFAULT 0.0,
    remaining_days DECIMAL(5,1) GENERATED ALWAYS AS (allocated_days - used_days) STORED,
    fiscal_year INT NOT NULL DEFAULT 2026,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY uq_user_leave_year (user_id, leave_type, fiscal_year)
);

-- 3. Leave Requests Table
CREATE TABLE IF NOT EXISTS leave_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    leave_type ENUM('CASUAL', 'SICK', 'EARNED', 'WORK_FROM_HOME', 'UNPAID') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days DECIMAL(5,1) NOT NULL,
    reason TEXT NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reviewed_by INT NULL,
    reviewed_at TIMESTAMP NULL,
    manager_remarks TEXT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewed_by) REFERENCES users(user_id) ON DELETE SET NULL
);
