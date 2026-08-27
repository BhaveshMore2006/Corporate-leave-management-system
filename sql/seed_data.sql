USE clms_db;

-- Sample Data Seeding
-- Passwords are set to 'password' (bcrypt hash format or similar hash from the prompt, in this case it is a sha256 hash representation from the prompt but let's use the exact hash from the spec)
INSERT INTO users (employee_code, full_name, email, password_hash, role, department, manager_id) VALUES
('HR001', 'Admin HR', 'hr@clms.enterprise.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'HR_ADMIN', 'Human Resources', NULL),
('MGR001', 'Prof. Mohini S', 'manager@clms.enterprise.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'MANAGER', 'Information Technology', NULL),
('EMP001', 'Bhavesh More', 'bhavesh@clms.enterprise.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'EMPLOYEE', 'Information Technology', 2),
('EMP002', 'Tej Panchal', 'tej@clms.enterprise.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'EMPLOYEE', 'Information Technology', 2),
('EMP003', 'Bhumi Singh', 'bhumi@clms.enterprise.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'EMPLOYEE', 'Information Technology', 2);

-- Default Leave Balances (12 Casual, 10 Sick, 15 Earned)
INSERT INTO leave_balances (user_id, leave_type, allocated_days, used_days, fiscal_year) VALUES
(3, 'CASUAL', 12, 0, 2026), (3, 'SICK', 10, 0, 2026), (3, 'EARNED', 15, 0, 2026),
(4, 'CASUAL', 12, 0, 2026), (4, 'SICK', 10, 0, 2026), (4, 'EARNED', 15, 0, 2026),
(5, 'CASUAL', 12, 0, 2026), (5, 'SICK', 10, 0, 2026), (5, 'EARNED', 15, 0, 2026);
