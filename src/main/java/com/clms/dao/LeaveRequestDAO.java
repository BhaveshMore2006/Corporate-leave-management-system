package com.clms.dao;

import com.clms.config.DBConnection;
import com.clms.model.LeaveRequest;
import com.clms.model.LeaveType;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveRequestDAO {

    public boolean createLeaveRequest(LeaveRequest request) {
        String query = "INSERT INTO leave_requests (user_id, leave_type, start_date, end_date, total_days, reason, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, request.getUserId());
            stmt.setString(2, request.getLeaveType().name());
            stmt.setDate(3, request.getStartDate());
            stmt.setDate(4, request.getEndDate());
            stmt.setDouble(5, request.getTotalDays());
            stmt.setString(6, request.getReason());
            stmt.setString(7, "PENDING");
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<LeaveRequest> getRequestsByUserId(int userId) {
        List<LeaveRequest> list = new ArrayList<>();
        String query = "SELECT * FROM leave_requests WHERE user_id = ? ORDER BY applied_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToLeaveRequest(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<LeaveRequest> getRequestsForManager(int managerId) {
        List<LeaveRequest> list = new ArrayList<>();
        String query = "SELECT lr.*, u.full_name FROM leave_requests lr JOIN users u ON lr.user_id = u.user_id WHERE u.manager_id = ? ORDER BY lr.applied_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, managerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LeaveRequest lr = mapResultSetToLeaveRequest(rs);
                lr.setEmployeeName(rs.getString("full_name"));
                list.add(lr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<LeaveRequest> getRequestsForHRAdmin() {
        List<LeaveRequest> list = new ArrayList<>();
        // HR Admins approve leave requests from MANAGERS
        String query = "SELECT lr.*, u.full_name FROM leave_requests lr JOIN users u ON lr.user_id = u.user_id WHERE u.role = 'MANAGER' ORDER BY lr.applied_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LeaveRequest lr = mapResultSetToLeaveRequest(rs);
                lr.setEmployeeName(rs.getString("full_name"));
                list.add(lr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<LeaveRequest> getAllRequests() {
        List<LeaveRequest> list = new ArrayList<>();
        String query = "SELECT lr.*, u.full_name FROM leave_requests lr JOIN users u ON lr.user_id = u.user_id ORDER BY lr.applied_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LeaveRequest lr = mapResultSetToLeaveRequest(rs);
                lr.setEmployeeName(rs.getString("full_name"));
                list.add(lr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private LeaveRequest mapResultSetToLeaveRequest(ResultSet rs) throws SQLException {
        LeaveRequest request = new LeaveRequest();
        request.setRequestId(rs.getInt("request_id"));
        request.setUserId(rs.getInt("user_id"));
        request.setLeaveType(LeaveType.valueOf(rs.getString("leave_type")));
        request.setStartDate(rs.getDate("start_date"));
        request.setEndDate(rs.getDate("end_date"));
        request.setTotalDays(rs.getDouble("total_days"));
        request.setReason(rs.getString("reason"));
        request.setStatus(rs.getString("status"));
        request.setAppliedAt(rs.getTimestamp("applied_at"));
        request.setReviewedBy(rs.getInt("reviewed_by") != 0 ? rs.getInt("reviewed_by") : null);
        request.setReviewedAt(rs.getTimestamp("reviewed_at"));
        request.setManagerRemarks(rs.getString("manager_remarks"));
        return request;
    }
}
