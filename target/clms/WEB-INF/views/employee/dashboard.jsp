<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
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
                    <h2 class="fw-bold mb-0" style="color: #1e1b4b;">Employee Dashboard</h2>
                    <p class="text-muted mb-0">Manage your leaves and stay updated</p>
                </div>
                <div class="d-flex align-items-center bg-white px-3 py-2 rounded shadow-sm">
                    <i class="bi bi-calendar4-week fs-5 me-2" style="color: #6b7280;"></i>
                    <span class="fw-semibold text-muted"><fmt:formatDate value="${now}" pattern="EEEE, d MMMM yyyy" /></span>
                </div>
            </div>

            <!-- Top Cards Row -->
            <div class="row mb-4">
                <!-- Find balances -->
                <c:forEach var="b" items="${balances}">
                    <c:if test="${b.leaveType == 'CASUAL'}">
                        <c:set var="casualB" value="${b}" />
                    </c:if>
                    <c:if test="${b.leaveType == 'SICK'}">
                        <c:set var="sickB" value="${b}" />
                    </c:if>
                    <c:if test="${b.leaveType == 'EARNED'}">
                        <c:set var="earnedB" value="${b}" />
                    </c:if>
                </c:forEach>

                <div class="col-md-4">
                    <div class="emp-card emp-card-casual">
                        <div class="emp-card-icon"><i class="bi bi-umbrella-fill"></i></div>
                        <div class="emp-card-content">
                            <h6>CASUAL LEAVE</h6>
                            <h2><fmt:formatNumber value="${casualB != null ? casualB.remainingDays : 0}" pattern="0.0"/></h2>
                            <p>Total: <fmt:formatNumber value="${casualB != null ? casualB.allocatedDays : 0}" pattern="0.0"/> | Used: <fmt:formatNumber value="${casualB != null ? casualB.usedDays : 0}" pattern="0.0"/></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="emp-card emp-card-sick">
                        <div class="emp-card-icon"><i class="bi bi-plus-lg"></i></div>
                        <div class="emp-card-content">
                            <h6>SICK LEAVE</h6>
                            <h2><fmt:formatNumber value="${sickB != null ? sickB.remainingDays : 0}" pattern="0.0"/></h2>
                            <p>Total: <fmt:formatNumber value="${sickB != null ? sickB.allocatedDays : 0}" pattern="0.0"/> | Used: <fmt:formatNumber value="${sickB != null ? sickB.usedDays : 0}" pattern="0.0"/></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="emp-card emp-card-earned">
                        <div class="emp-card-icon"><i class="bi bi-calendar-event"></i></div>
                        <div class="emp-card-content">
                            <h6>EARNED LEAVE</h6>
                            <h2><fmt:formatNumber value="${earnedB != null ? earnedB.remainingDays : 0}" pattern="0.0"/></h2>
                            <p>Total: <fmt:formatNumber value="${earnedB != null ? earnedB.allocatedDays : 0}" pattern="0.0"/> | Used: <fmt:formatNumber value="${earnedB != null ? earnedB.usedDays : 0}" pattern="0.0"/></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Middle Row -->
            <div class="row mb-4">
                <!-- Leave Overview -->
                <div class="col-md-8">
                    <div class="card shadow-sm border-0 rounded-4 h-100 p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h5 class="mb-0 fw-bold" style="color: #1e1b4b;"><i class="bi bi-bar-chart-fill text-primary me-2"></i>Leave Overview</h5>
                                <small class="text-muted">Your leave balance and usage at a glance</small>
                            </div>
                            <div class="d-flex">
                                <div class="emp-stat-box emp-stat-total">
                                    <p>Total Leaves</p>
                                    <h4><fmt:formatNumber value="${totalLeaves}" pattern="0"/></h4>
                                </div>
                                <div class="emp-stat-box emp-stat-used">
                                    <p>Used</p>
                                    <h4><fmt:formatNumber value="${totalUsed}" pattern="0"/></h4>
                                </div>
                                <div class="emp-stat-box emp-stat-remaining">
                                    <p>Remaining</p>
                                    <h4><fmt:formatNumber value="${totalRemaining}" pattern="0"/></h4>
                                </div>
                                <div class="emp-stat-box emp-stat-pending">
                                    <p>Pending Requests</p>
                                    <h4>${pendingRequestsCount}</h4>
                                </div>
                            </div>
                        </div>

                        <!-- Casual Progress -->
                        <c:set var="cPct" value="${casualB != null && casualB.allocatedDays > 0 ? (casualB.remainingDays / casualB.allocatedDays) * 100 : 0}" />
                        <div class="row align-items-center mb-3">
                            <div class="col-3 fw-bold" style="color: #1e1b4b;">Casual Leave</div>
                            <div class="col-6">
                                <div class="progress" style="height: 12px; background-color: #e2e8f0; border-radius: 10px;">
                                    <div class="progress-bar" role="progressbar" style="width: ${cPct}%; background-color: #3b82f6; border-radius: 10px;"></div>
                                </div>
                            </div>
                            <div class="col-3 text-end">
                                <span class="text-muted me-3"><fmt:formatNumber value="${casualB != null ? casualB.remainingDays : 0}" pattern="0.0"/> / <fmt:formatNumber value="${casualB != null ? casualB.allocatedDays : 0}" pattern="0.0"/></span>
                                <span class="fw-bold"><fmt:formatNumber value="${cPct}" maxFractionDigits="0"/>%</span>
                            </div>
                        </div>
                        
                        <!-- Sick Progress -->
                        <c:set var="sPct" value="${sickB != null && sickB.allocatedDays > 0 ? (sickB.remainingDays / sickB.allocatedDays) * 100 : 0}" />
                        <div class="row align-items-center mb-3">
                            <div class="col-3 fw-bold" style="color: #1e1b4b;">Sick Leave</div>
                            <div class="col-6">
                                <div class="progress" style="height: 12px; background-color: #e2e8f0; border-radius: 10px;">
                                    <div class="progress-bar" role="progressbar" style="width: ${sPct}%; background-color: #ef4444; border-radius: 10px;"></div>
                                </div>
                            </div>
                            <div class="col-3 text-end">
                                <span class="text-muted me-3"><fmt:formatNumber value="${sickB != null ? sickB.remainingDays : 0}" pattern="0.0"/> / <fmt:formatNumber value="${sickB != null ? sickB.allocatedDays : 0}" pattern="0.0"/></span>
                                <span class="fw-bold"><fmt:formatNumber value="${sPct}" maxFractionDigits="0"/>%</span>
                            </div>
                        </div>

                        <!-- Earned Progress -->
                        <c:set var="ePct" value="${earnedB != null && earnedB.allocatedDays > 0 ? (earnedB.remainingDays / earnedB.allocatedDays) * 100 : 0}" />
                        <div class="row align-items-center">
                            <div class="col-3 fw-bold" style="color: #1e1b4b;">Earned Leave</div>
                            <div class="col-6">
                                <div class="progress" style="height: 12px; background-color: #e2e8f0; border-radius: 10px;">
                                    <div class="progress-bar" role="progressbar" style="width: ${ePct}%; background-color: #22c55e; border-radius: 10px;"></div>
                                </div>
                            </div>
                            <div class="col-3 text-end">
                                <span class="text-muted me-3"><fmt:formatNumber value="${earnedB != null ? earnedB.remainingDays : 0}" pattern="0.0"/> / <fmt:formatNumber value="${earnedB != null ? earnedB.allocatedDays : 0}" pattern="0.0"/></span>
                                <span class="fw-bold"><fmt:formatNumber value="${ePct}" maxFractionDigits="0"/>%</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Upcoming Leave -->
                <div class="col-md-4">
                    <div class="card shadow-sm border-0 rounded-4 h-100 p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="mb-0 fw-bold" style="color: #1e1b4b;"><i class="bi bi-calendar2-check-fill text-primary me-2"></i>Upcoming Leave</h5>
                            <a href="${pageContext.request.contextPath}/employee/history" class="text-decoration-none fw-bold" style="color: #6b21a8;">View All</a>
                        </div>
                        <div class="emp-card emp-card-casual h-100 d-flex align-items-center justify-content-start">
                            <c:choose>
                                <c:when test="${upcomingLeave != null}">
                                    <div class="emp-card-icon shadow-sm" style="background-color: #dbeafe; color: #2563eb;"><i class="bi bi-airplane-fill"></i></div>
                                    <div class="ms-3">
                                        <h6 class="fw-bold text-dark mb-1">${upcomingLeave.leaveType} Leave</h6>
                                        <p class="text-muted mb-2 small"><fmt:formatDate value="${upcomingLeave.startDate}" pattern="dd MMM yyyy" /> - <fmt:formatDate value="${upcomingLeave.endDate}" pattern="dd MMM yyyy" /></p>
                                        <div class="d-flex align-items-center">
                                            <small class="text-muted fw-bold me-3"><i class="bi bi-calendar-event me-1"></i> <fmt:formatNumber value="${upcomingLeave.totalDays}" pattern="0"/> Days</small>
                                            <span class="badge badge-approved px-3 py-1">Approved</span>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center w-100 text-muted">
                                        <i class="bi bi-calendar-x fs-1 mb-2"></i>
                                        <p>No upcoming approved leaves.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Requests -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                        <div class="card-header bg-white border-0 py-3 d-flex justify-content-between align-items-center px-4">
                            <h5 class="mb-0 fw-bold" style="color: #1e1b4b;"><i class="bi bi-file-text-fill text-primary me-2"></i>Recent Leave Requests</h5>
                            <a href="${pageContext.request.contextPath}/employee/history" class="text-decoration-none fw-bold" style="color: #6b21a8;">View All</a>
                        </div>
                        <div class="card-body p-0">
                            <table class="table custom-table mb-0">
                                <thead class="bg-light text-muted" style="font-size: 0.85rem;">
                                    <tr>
                                        <th class="ps-4">Leave Type</th>
                                        <th>From</th>
                                        <th>To</th>
                                        <th>Days</th>
                                        <th>Status</th>
                                        <th class="pe-4">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="req" items="${requests}" end="4">
                                        <tr>
                                            <td class="ps-4 fw-semibold text-dark">${req.leaveType} Leave</td>
                                            <td><fmt:formatDate value="${req.startDate}" pattern="dd MMM yyyy" /></td>
                                            <td><fmt:formatDate value="${req.endDate}" pattern="dd MMM yyyy" /></td>
                                            <td><fmt:formatNumber value="${req.totalDays}" pattern="0"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${req.status == 'APPROVED'}"><span class="badge badge-approved">Approved</span></c:when>
                                                    <c:when test="${req.status == 'REJECTED'}"><span class="badge badge-rejected">Rejected</span></c:when>
                                                    <c:otherwise><span class="badge badge-pending">Pending</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="pe-4">
                                                <c:choose>
                                                    <c:when test="${req.status == 'PENDING'}">
                                                        <a href="#" class="btn btn-sm btn-light-purple px-3">Review</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="#" class="btn btn-sm btn-light-purple px-3">View</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty requests}">
                                        <tr><td colspan="6" class="text-center py-4 text-muted">No leave requests found.</td></tr>
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
