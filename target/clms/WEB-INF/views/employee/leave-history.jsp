<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 col-lg-2 p-0">
            <jsp:include page="../common/sidebar.jsp"/>
        </div>
        <div class="col-md-9 col-lg-10 p-4">
            <h2>Leave History</h2>
            <hr>
            <c:if test="${not empty sessionScope.flash_success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.flash_success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="flash_success" scope="session"/>
            </c:if>
            <div class="card shadow-sm border-0 mt-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Type</th>
                                    <th>Dates</th>
                                    <th>Days</th>
                                    <th>Applied On</th>
                                    <th>Status</th>
                                    <th>Manager Remarks</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="req" items="${requests}">
                                    <tr>
                                        <td>#${req.requestId}</td>
                                        <td>${req.leaveType}</td>
                                        <td>${req.startDate} to ${req.endDate}</td>
                                        <td>${req.totalDays}</td>
                                        <td>${req.appliedAt}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${req.status == 'APPROVED'}">
                                                    <span class="badge bg-success">APPROVED</span>
                                                </c:when>
                                                <c:when test="${req.status == 'REJECTED'}">
                                                    <span class="badge bg-danger">REJECTED</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark">PENDING</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${req.managerRemarks != null ? req.managerRemarks : '-'}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty requests}">
                                    <tr><td colspan="7" class="text-center text-muted">No leave requests found.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
