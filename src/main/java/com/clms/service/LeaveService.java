package com.clms.service;

import com.clms.config.DBConnection;
import com.clms.dao.LeaveRequestDAO;
import com.clms.model.LeaveRequest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class LeaveService {
    private LeaveRequestDAO leaveRequestDAO = new LeaveRequestDAO();

    public boolean applyLeave(LeaveRequest request) {
        // Here we could add logic to check sufficient balance before creating
        return leaveRequestDAO.createLeaveRequest(request);
    }

    public boolean processLeaveRequest(int requestId, int managerId, String status, String remarks, double totalDays, String leaveType, int employeeId) {
        String updateRequestQuery = "UPDATE leave_requests SET status = ?, reviewed_by = ?, reviewed_at = CURRENT_TIMESTAMP, manager_remarks = ? WHERE request_id = ?";
        String updateBalanceQuery = "UPDATE leave_balances SET used_days = used_days + ? WHERE user_id = ? AND leave_type = ? AND fiscal_year = 2026";
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Update Request Status
            try (PreparedStatement stmt = conn.prepareStatement(updateRequestQuery)) {
                stmt.setString(1, status);
                stmt.setInt(2, managerId);
                stmt.setString(3, remarks);
                stmt.setInt(4, requestId);
                stmt.executeUpdate();
            }

            // 2. If approved, update balance
            // 2. If approved and requires balance deduction, update balance
            if ("APPROVED".equals(status) && !leaveType.equals("WORK_FROM_HOME") && !leaveType.equals("UNPAID")) {
                try (PreparedStatement stmt2 = conn.prepareStatement(updateBalanceQuery)) {
                    stmt2.setDouble(1, totalDays);
                    stmt2.setInt(2, employeeId);
                    stmt2.setString(3, leaveType);
                    stmt2.executeUpdate();
                }
            }

            conn.commit(); // Commit transaction
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction on failure
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
