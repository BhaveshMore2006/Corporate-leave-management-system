package com.clms.dao;

import com.clms.config.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReportDAO {
    // Basic implementation for generating reports
    public List<Map<String, Object>> getLeaveSummaryByDepartment() {
        List<Map<String, Object>> results = new ArrayList<>();
        String query = "SELECT u.employee_code, u.department, lr.leave_type, SUM(lr.total_days) as total_leaves FROM leave_requests lr JOIN users u ON lr.user_id = u.user_id WHERE lr.status = 'APPROVED' GROUP BY u.employee_code, u.department, lr.leave_type";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("employeeCode", rs.getString("employee_code"));
                row.put("department", rs.getString("department"));
                row.put("leaveType", rs.getString("leave_type"));
                row.put("totalLeaves", rs.getDouble("total_leaves"));
                results.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }
}
