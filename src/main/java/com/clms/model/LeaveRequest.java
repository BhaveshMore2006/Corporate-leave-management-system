package com.clms.model;

import java.sql.Date;
import java.sql.Timestamp;

public class LeaveRequest {
    private int requestId;
    private int userId;
    private LeaveType leaveType;
    private Date startDate;
    private Date endDate;
    private double totalDays;
    private String reason;
    private String status; // PENDING, APPROVED, REJECTED, CANCELLED
    private Timestamp appliedAt;
    private Integer reviewedBy;
    private Timestamp reviewedAt;
    private String managerRemarks;
    
    // Additional transient fields for display
    private String employeeName;

    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public LeaveType getLeaveType() { return leaveType; }
    public void setLeaveType(LeaveType leaveType) { this.leaveType = leaveType; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public double getTotalDays() { return totalDays; }
    public void setTotalDays(double totalDays) { this.totalDays = totalDays; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getAppliedAt() { return appliedAt; }
    public void setAppliedAt(Timestamp appliedAt) { this.appliedAt = appliedAt; }

    public Integer getReviewedBy() { return reviewedBy; }
    public void setReviewedBy(Integer reviewedBy) { this.reviewedBy = reviewedBy; }

    public Timestamp getReviewedAt() { return reviewedAt; }
    public void setReviewedAt(Timestamp reviewedAt) { this.reviewedAt = reviewedAt; }

    public String getManagerRemarks() { return managerRemarks; }
    public void setManagerRemarks(String managerRemarks) { this.managerRemarks = managerRemarks; }
    
    public String getEmployeeName() { return employeeName; }
    public void setEmployeeName(String employeeName) { this.employeeName = employeeName; }
}
