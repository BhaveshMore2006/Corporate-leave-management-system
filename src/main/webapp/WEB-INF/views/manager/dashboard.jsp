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
                    <h2 class="fw-bold mb-0" style="color: #2e1d44;">Manager Dashboard</h2>
                    <p class="text-muted mb-0">Manage and approve leave requests for your team</p>
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
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card stat-blue">
                        <div class="stat-icon"><i class="bi bi-file-earmark-text-fill"></i></div>
                        <div class="stat-details">
                            <p>Total Leave Requests</p>
                            <h3>${totalRequests}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card stat-red">
                        <div class="stat-icon"><i class="bi bi-clock-history"></i></div>
                        <div class="stat-details">
                            <p>Pending Approvals</p>
                            <h3 style="color: #e53e3e;">${pendingCount}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card stat-green">
                        <div class="stat-icon"><i class="bi bi-check-circle-fill"></i></div>
                        <div class="stat-details">
                            <p>Approved This Month</p>
                            <h3 style="color: #2b7a3e;">${approvedThisMonth}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pending Requests Table -->
            <div class="card shadow-sm border-0 mb-4 rounded-4 overflow-hidden">
                <div class="card-header bg-white border-0 py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold" style="color: #2e1d44;"><i class="bi bi-file-earmark-text-fill text-primary me-2"></i>Pending Leave Requests</h5>
                    <a href="${pageContext.request.contextPath}/manager/pending-approvals" class="text-decoration-none fw-bold" style="color: #5a3e8c;">View All</a>
                </div>
                <div class="card-body p-0">
                    <table class="table custom-table mb-0">
                        <thead class="bg-light text-muted">
                            <tr>
                                <th>Employee Name</th>
                                <th>Leave Type</th>
                                <th>From</th>
                                <th>To</th>
                                <th>Days</th>
                                <th>Applied On</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="req" items="${pendingRequests}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-circle me-3">${fn:toUpperCase(fn:substring(req.employeeName, 0, 2))}</div>
                                            <span class="fw-semibold text-dark">${req.employeeName}</span>
                                        </div>
                                    </td>
                                    <td>${req.leaveType} Leave</td>
                                    <td><fmt:formatDate value="${req.startDate}" pattern="dd MMM yyyy" /></td>
                                    <td><fmt:formatDate value="${req.endDate}" pattern="dd MMM yyyy" /></td>
                                    <td>${req.totalDays}</td>
                                    <td><fmt:formatDate value="${req.appliedAt}" pattern="dd MMM yyyy" /></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/manager/approve-reject" method="post" class="d-inline">
                                            <input type="hidden" name="requestId" value="${req.requestId}">
                                            <input type="hidden" name="employeeId" value="${req.userId}">
                                            <input type="hidden" name="totalDays" value="${req.totalDays}">
                                            <input type="hidden" name="leaveType" value="${req.leaveType.name()}">
                                            <input type="hidden" name="status" value="APPROVED">
                                            <button type="submit" class="btn btn-sm btn-approve me-2">Approve</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/manager/approve-reject" method="post" class="d-inline">
                                            <input type="hidden" name="requestId" value="${req.requestId}">
                                            <input type="hidden" name="employeeId" value="${req.userId}">
                                            <input type="hidden" name="totalDays" value="${req.totalDays}">
                                            <input type="hidden" name="leaveType" value="${req.leaveType.name()}">
                                            <input type="hidden" name="status" value="REJECTED">
                                            <button type="submit" class="btn btn-sm btn-reject-light">Reject</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty pendingRequests}">
                                <tr><td colspan="7" class="text-center py-4 text-muted">No pending requests found.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Recent Activity Tables -->
            <div class="row">
                <!-- Approved -->
                <div class="col-md-6">
                    <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                        <div class="card-header bg-white border-0 py-3 d-flex justify-content-between align-items-center">
                            <h5 class="mb-0 fw-bold" style="color: #2e1d44;"><i class="bi bi-check-circle-fill text-success me-2"></i>Recently Approved Requests</h5>
                            <a href="#" class="text-decoration-none fw-bold" style="color: #5a3e8c;">View All</a>
                        </div>
                        <div class="card-body p-0">
                            <table class="table custom-table mb-0">
                                <thead class="bg-light text-muted" style="font-size: 0.85rem;">
                                    <tr>
                                        <th>Employee Name</th>
                                        <th>Leave Type</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th>Days</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="req" items="${approvedRequests}" end="4">
                                        <tr>
                                            <td class="fw-semibold text-dark">${req.employeeName}</td>
                                            <td>${req.leaveType} Leave</td>
                                            <td><fmt:formatDate value="${req.startDate}" pattern="dd MMM yyyy" /></td>
                                            <td><fmt:formatDate value="${req.endDate}" pattern="dd MMM yyyy" /></td>
                                            <td>${req.totalDays}</td>
                                            <td><span class="badge badge-approved">Approved</span></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty approvedRequests}">
                                        <tr><td colspan="6" class="text-center py-3 text-muted">No recently approved requests.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- Rejected -->
                <div class="col-md-6">
                    <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                        <div class="card-header bg-white border-0 py-3 d-flex justify-content-between align-items-center">
                            <h5 class="mb-0 fw-bold" style="color: #2e1d44;"><i class="bi bi-x-circle-fill text-danger me-2"></i>Recently Rejected Requests</h5>
                            <a href="#" class="text-decoration-none fw-bold" style="color: #5a3e8c;">View All</a>
                        </div>
                        <div class="card-body p-0">
                            <table class="table custom-table mb-0">
                                <thead class="bg-light text-muted" style="font-size: 0.85rem;">
                                    <tr>
                                        <th>Employee Name</th>
                                        <th>Leave Type</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th>Days</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="req" items="${rejectedRequests}" end="4">
                                        <tr>
                                            <td class="fw-semibold text-dark">${req.employeeName}</td>
                                            <td>${req.leaveType} Leave</td>
                                            <td><fmt:formatDate value="${req.startDate}" pattern="dd MMM yyyy" /></td>
                                            <td><fmt:formatDate value="${req.endDate}" pattern="dd MMM yyyy" /></td>
                                            <td>${req.totalDays}</td>
                                            <td><span class="badge badge-rejected">Rejected</span></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty rejectedRequests}">
                                        <tr><td colspan="6" class="text-center py-3 text-muted">No recently rejected requests.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
