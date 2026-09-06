<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="../common/sidebar.jsp"/>
        </div>
        <div class="col-md-9 col-lg-10 p-4" style="background-color: #fcfbfe;">
            <!-- Header Row -->
            <jsp:useBean id="now" class="java.util.Date" />
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold mb-0" style="color: #2e1d44;">HR Admin Dashboard</h2>
                    <p class="text-muted mb-0">Welcome to the HR Admin dashboard. Manage users, approvals and view reports here.</p>
                </div>
                <div class="d-flex align-items-center bg-white px-3 py-2 rounded shadow-sm">
                    <i class="bi bi-calendar4-week fs-5 me-2" style="color: #5a3e8c;"></i>
                    <span class="fw-semibold text-muted"><fmt:formatDate value="${now}" pattern="EEEE, d MMMM yyyy" /></span>
                </div>
            </div>

            <!-- Stats Row -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card stat-purple">
                        <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
                        <div class="stat-details">
                            <p>Total Employees</p>
                            <h3>${totalEmployees}</h3>
                            <small class="text-success"><i class="bi bi-arrow-up-short"></i> 4% from last month</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card stat-blue">
                        <div class="stat-icon"><i class="bi bi-file-earmark-text-fill"></i></div>
                        <div class="stat-details">
                            <p>Total Leave Requests</p>
                            <h3>${totalLeaveRequests}</h3>
                            <small class="text-muted">+3 new this week</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card stat-red">
                        <div class="stat-icon"><i class="bi bi-clock-history"></i></div>
                        <div class="stat-details">
                            <p>Pending Approvals</p>
                            <h3 style="color: #e53e3e;">${pendingApprovals}</h3>
                            <small style="color: #e53e3e;">Needs your action</small>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card stat-green">
                        <div class="stat-icon"><i class="bi bi-check-circle-fill"></i></div>
                        <div class="stat-details">
                            <p>Approved This Month</p>
                            <h3 style="color: #2b7a3e;">${approvedThisMonth}</h3>
                            <small class="text-success"><i class="bi bi-arrow-up-short"></i> 12% from last month</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts Row -->
            <div class="row mb-4">
                <!-- Leave Distribution -->
                <div class="col-md-7">
                    <div class="card shadow-sm border-0 rounded-4 h-100 p-3">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <h5 class="mb-0 fw-bold" style="color: #2e1d44;"><i class="bi bi-bar-chart-fill text-primary me-2"></i>Leave Distribution (This Month)</h5>
                                <small class="text-muted">Leave requests status by leave type</small>
                            </div>
                        </div>
                        <div style="height: 250px;">
                            <canvas id="leaveDistributionChart"></canvas>
                        </div>
                    </div>
                </div>
                <!-- Leave Summary -->
                <div class="col-md-5">
                    <div class="card shadow-sm border-0 rounded-4 h-100 p-4">
                        <h5 class="mb-4 fw-bold" style="color: #2e1d44;">Leave Summary (All Employees)</h5>
                        
                        <!-- Casual Leave -->
                        <c:set var="casualData" value="${leaveSummary['CASUAL']}" />
                        <c:set var="casualPct" value="${casualData[0] > 0 ? (casualData[1] / casualData[0]) * 100 : 0}" />
                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle d-flex justify-content-center align-items-center text-white me-3" style="width: 40px; height: 40px; background-color: #3b82f6;">
                                        <i class="bi bi-umbrella-fill fs-5"></i>
                                    </div>
                                    <span class="fw-bold" style="color: #2e1d44;">Casual Leave</span>
                                </div>
                                <div class="text-end">
                                    <span class="fw-bold text-dark"><fmt:formatNumber value="${casualData[1]}" pattern="#,##0.##"/> / <fmt:formatNumber value="${casualData[0]}" pattern="#,##0.##"/></span><br>
                                    <small class="text-muted"><fmt:formatNumber value="${casualPct}" maxFractionDigits="0"/>% used</small>
                                </div>
                            </div>
                            <div class="progress" style="height: 10px; background-color: #eff6ff;">
                                <div class="progress-bar rounded-pill" role="progressbar" style="width: ${casualPct}%; background-color: #7b61ff;"></div>
                            </div>
                        </div>

                        <!-- Sick Leave -->
                        <c:set var="sickData" value="${leaveSummary['SICK']}" />
                        <c:set var="sickPct" value="${sickData[0] > 0 ? (sickData[1] / sickData[0]) * 100 : 0}" />
                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle d-flex justify-content-center align-items-center text-white me-3" style="width: 40px; height: 40px; background-color: #ef4444;">
                                        <i class="bi bi-plus-lg fs-5"></i>
                                    </div>
                                    <span class="fw-bold" style="color: #2e1d44;">Sick Leave</span>
                                </div>
                                <div class="text-end">
                                    <span class="fw-bold text-dark"><fmt:formatNumber value="${sickData[1]}" pattern="#,##0.##"/> / <fmt:formatNumber value="${sickData[0]}" pattern="#,##0.##"/></span><br>
                                    <small class="text-muted"><fmt:formatNumber value="${sickPct}" maxFractionDigits="0"/>% used</small>
                                </div>
                            </div>
                            <div class="progress" style="height: 10px; background-color: #fef2f2;">
                                <div class="progress-bar rounded-pill" role="progressbar" style="width: ${sickPct}%; background-color: #fca5a5;"></div>
                            </div>
                        </div>

                        <!-- Earned Leave -->
                        <c:set var="earnedData" value="${leaveSummary['EARNED']}" />
                        <c:set var="earnedPct" value="${earnedData[0] > 0 ? (earnedData[1] / earnedData[0]) * 100 : 0}" />
                        <div>
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle d-flex justify-content-center align-items-center text-white me-3" style="width: 40px; height: 40px; background-color: #22c55e;">
                                        <i class="bi bi-calendar-event fs-5"></i>
                                    </div>
                                    <span class="fw-bold" style="color: #2e1d44;">Earned Leave</span>
                                </div>
                                <div class="text-end">
                                    <span class="fw-bold text-dark"><fmt:formatNumber value="${earnedData[1]}" pattern="#,##0.##"/> / <fmt:formatNumber value="${earnedData[0]}" pattern="#,##0.##"/></span><br>
                                    <small class="text-muted"><fmt:formatNumber value="${earnedPct}" maxFractionDigits="0"/>% used</small>
                                </div>
                            </div>
                            <div class="progress" style="height: 10px; background-color: #f0fdf4;">
                                <div class="progress-bar rounded-pill" role="progressbar" style="width: ${earnedPct}%; background-color: #86efac;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tables Row -->
            <div class="row">
                <!-- Recent Leave Requests -->
                <div class="col-md-7">
                    <div class="card shadow-sm border-0 rounded-4 overflow-hidden h-100">
                        <div class="card-header bg-white border-0 py-3 d-flex justify-content-between align-items-center">
                            <h5 class="mb-0 fw-bold" style="color: #2e1d44;"><i class="bi bi-file-text-fill text-primary me-2"></i>Recent Leave Requests</h5>
                            <a href="#" class="text-decoration-none fw-bold" style="color: #5a3e8c;">View All</a>
                        </div>
                        <div class="card-body p-0">
                            <table class="table custom-table mb-0">
                                <thead class="bg-light text-muted" style="font-size: 0.8rem;">
                                    <tr>
                                        <th>Employee Name</th>
                                        <th>Leave Type</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th>Days</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="req" items="${recentRequests}">
                                        <tr>
                                            <td class="fw-semibold text-dark">${req.employeeName}</td>
                                            <td>${req.leaveType} Leave</td>
                                            <td><fmt:formatDate value="${req.startDate}" pattern="dd MMM yyyy" /></td>
                                            <td><fmt:formatDate value="${req.endDate}" pattern="dd MMM yyyy" /></td>
                                            <td>${req.totalDays}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${req.status == 'APPROVED'}"><span class="badge badge-approved">Approved</span></c:when>
                                                    <c:when test="${req.status == 'REJECTED'}"><span class="badge badge-rejected">Rejected</span></c:when>
                                                    <c:otherwise><span class="badge badge-pending" style="background-color: #fef3c7; color: #d97706; padding: 6px 12px; border-radius: 6px; font-weight: 600;">Pending</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><button class="btn btn-sm btn-light-purple">View</button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- Pending Approvals (Managers) -->
                <div class="col-md-5">
                    <div class="card shadow-sm border-0 rounded-4 overflow-hidden h-100">
                        <div class="card-header bg-white border-0 py-3 d-flex justify-content-between align-items-center">
                            <h5 class="mb-0 fw-bold" style="color: #2e1d44;"><i class="bi bi-clock-fill text-danger me-2"></i>Pending Approvals (Managers)</h5>
                            <a href="${pageContext.request.contextPath}/hr/pending-approvals" class="text-decoration-none fw-bold" style="color: #5a3e8c;">View All</a>
                        </div>
                        <div class="card-body p-0">
                            <table class="table custom-table mb-0">
                                <thead class="bg-light text-muted" style="font-size: 0.8rem;">
                                    <tr>
                                        <th>Employee Name</th>
                                        <th>Leave Type</th>
                                        <th>From - To</th>
                                        <th>Days</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="req" items="${recentPendingHR}">
                                        <tr>
                                            <td class="fw-semibold text-dark">${req.employeeName}</td>
                                            <td>${req.leaveType} Leave</td>
                                            <td><fmt:formatDate value="${req.startDate}" pattern="dd MMM" /> - <fmt:formatDate value="${req.endDate}" pattern="dd MMM yyyy" /></td>
                                            <td>${req.totalDays}</td>
                                            <td><a href="${pageContext.request.contextPath}/hr/pending-approvals" class="btn btn-sm btn-light-purple">Review</a></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty recentPendingHR}">
                                        <tr><td colspan="5" class="text-center py-3 text-muted">No pending manager requests.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const ctx = document.getElementById('leaveDistributionChart').getContext('2d');
        const chartApproved = [${chartApproved[0]}, ${chartApproved[1]}, ${chartApproved[2]}];
        const chartPending = [${chartPending[0]}, ${chartPending[1]}, ${chartPending[2]}];
        const chartRejected = [${chartRejected[0]}, ${chartRejected[1]}, ${chartRejected[2]}];

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Casual Leave', 'Sick Leave', 'Earned Leave'],
                datasets: [
                    {
                        label: 'Approved',
                        data: chartApproved,
                        backgroundColor: '#22c55e',
                        borderRadius: 4
                    },
                    {
                        label: 'Pending',
                        data: chartPending,
                        backgroundColor: '#fcd34d',
                        borderRadius: 4
                    },
                    {
                        label: 'Rejected',
                        data: chartRejected,
                        backgroundColor: '#ef4444',
                        borderRadius: 4
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: { grid: { display: false } },
                    y: { border: { display: false }, grid: { color: '#f1f5f9' }, beginAtZero: true }
                },
                plugins: {
                    legend: { position: 'top', align: 'end', labels: { usePointStyle: true, boxWidth: 8 } }
                }
            }
        });
    });
</script>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
