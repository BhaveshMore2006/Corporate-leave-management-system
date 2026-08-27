package com.clms.model;

public class LeaveBalance {
    private int balanceId;
    private int userId;
    private LeaveType leaveType;
    private double allocatedDays;
    private double usedDays;
    private double remainingDays;
    private int fiscalYear;

    public int getBalanceId() { return balanceId; }
    public void setBalanceId(int balanceId) { this.balanceId = balanceId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public LeaveType getLeaveType() { return leaveType; }
    public void setLeaveType(LeaveType leaveType) { this.leaveType = leaveType; }

    public double getAllocatedDays() { return allocatedDays; }
    public void setAllocatedDays(double allocatedDays) { this.allocatedDays = allocatedDays; }

    public double getUsedDays() { return usedDays; }
    public void setUsedDays(double usedDays) { this.usedDays = usedDays; }

    public double getRemainingDays() { return remainingDays; }
    public void setRemainingDays(double remainingDays) { this.remainingDays = remainingDays; }

    public int getFiscalYear() { return fiscalYear; }
    public void setFiscalYear(int fiscalYear) { this.fiscalYear = fiscalYear; }
}
