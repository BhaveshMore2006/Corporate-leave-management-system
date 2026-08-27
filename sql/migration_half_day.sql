-- Migration Script to support Half-Day, WFH, and Unpaid Leave

USE clms_db;

-- 1. Update leave_balances to use DECIMAL(5,1) and add new ENUM values
ALTER TABLE leave_balances 
MODIFY COLUMN leave_type ENUM('CASUAL', 'SICK', 'EARNED', 'WORK_FROM_HOME', 'UNPAID') NOT NULL,
MODIFY COLUMN allocated_days DECIMAL(5,1) NOT NULL DEFAULT 0.0,
MODIFY COLUMN used_days DECIMAL(5,1) NOT NULL DEFAULT 0.0,
DROP COLUMN remaining_days;

ALTER TABLE leave_balances
ADD COLUMN remaining_days DECIMAL(5,1) GENERATED ALWAYS AS (allocated_days - used_days) STORED;

-- 2. Update leave_requests to use DECIMAL(5,1) and add new ENUM values
ALTER TABLE leave_requests 
MODIFY COLUMN leave_type ENUM('CASUAL', 'SICK', 'EARNED', 'WORK_FROM_HOME', 'UNPAID') NOT NULL,
MODIFY COLUMN total_days DECIMAL(5,1) NOT NULL;
