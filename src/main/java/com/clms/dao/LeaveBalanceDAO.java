package com.clms.dao;

import com.clms.config.DBConnection;
import com.clms.model.LeaveBalance;
import com.clms.model.LeaveType;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveBalanceDAO {

    public List<LeaveBalance> getBalancesByUserId(int userId, int fiscalYear) {
        List<LeaveBalance> list = new ArrayList<>();
        String query = "SELECT * FROM leave_balances WHERE user_id = ? AND fiscal_year = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, fiscalYear);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToLeaveBalance(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void createDefaultBalances(int userId, int fiscalYear) {
        String query = "INSERT INTO leave_balances (user_id, leave_type, allocated_days, used_days, fiscal_year) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            // Casual: 12 days
            stmt.setInt(1, userId);
            stmt.setString(2, "CASUAL");
            stmt.setDouble(3, 12.0);
            stmt.setDouble(4, 0.0);
            stmt.setInt(5, fiscalYear);
            stmt.addBatch();

            // Sick: 10 days
            stmt.setString(2, "SICK");
            stmt.setDouble(3, 10.0);
            stmt.addBatch();

            // Earned: 15 days
            stmt.setString(2, "EARNED");
            stmt.setDouble(3, 15.0);
            stmt.addBatch();

            stmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public java.util.Map<String, double[]> getCompanyWideLeaveSummary(int fiscalYear) {
        java.util.Map<String, double[]> summary = new java.util.HashMap<>();
        String query = "SELECT leave_type, SUM(allocated_days) as total_allocated, SUM(used_days) as total_used FROM leave_balances WHERE fiscal_year = ? GROUP BY leave_type";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, fiscalYear);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String leaveType = rs.getString("leave_type");
                double[] totals = {rs.getDouble("total_allocated"), rs.getDouble("total_used")};
                summary.put(leaveType, totals);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return summary;
    }

    private LeaveBalance mapResultSetToLeaveBalance(ResultSet rs) throws SQLException {
        LeaveBalance lb = new LeaveBalance();
        lb.setBalanceId(rs.getInt("balance_id"));
        lb.setUserId(rs.getInt("user_id"));
        lb.setLeaveType(LeaveType.valueOf(rs.getString("leave_type")));
        lb.setAllocatedDays(rs.getDouble("allocated_days"));
        lb.setUsedDays(rs.getDouble("used_days"));
        lb.setRemainingDays(rs.getDouble("remaining_days"));
        lb.setFiscalYear(rs.getInt("fiscal_year"));
        return lb;
    }
}
