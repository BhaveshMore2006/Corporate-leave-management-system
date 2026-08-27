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
            <h2>Manager Leave Approvals</h2>
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
                                    <th>Req ID</th>
                                    <th>Employee Name</th>
                                    <th>Type</th>
                                    <th>Dates</th>
                                    <th>Days</th>
                                    <th>Reason</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="req" items="${requests}">
                                    <c:if test="${req.status == 'PENDING'}">
                                        <tr>
                                            <td>#${req.requestId}</td>
                                            <td>${req.employeeName}</td>
                                            <td>${req.leaveType}</td>
                                            <td>${req.startDate} to ${req.endDate}</td>
                                            <td>${req.totalDays}</td>
                                            <td>${req.reason}</td>
                                            <td><span class="badge bg-warning text-dark">PENDING</span></td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#actionModal${req.requestId}">
                                                    Review
                                                </button>
                                                <!-- Action Modal -->
                                                <div class="modal fade" id="actionModal${req.requestId}" tabindex="-1">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Review Leave Request #${req.requestId}</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <form action="${pageContext.request.contextPath}/hr/approve-reject" method="post">
                                                                <div class="modal-body">
                                                                    <input type="hidden" name="requestId" value="${req.requestId}">
                                                                    <input type="hidden" name="employeeId" value="${req.userId}">
                                                                    <input type="hidden" name="totalDays" value="${req.totalDays}">
                                                                    <input type="hidden" name="leaveType" value="${req.leaveType}">
                                                                    
                                                                    <div class="mb-3">
                                                                        <label class="form-label">HR Remarks (Required for Reject)</label>
                                                                        <textarea class="form-control" name="remarks" rows="2"></textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="submit" name="status" value="REJECTED" class="btn btn-danger">Reject</button>
                                                                    <button type="submit" name="status" value="APPROVED" class="btn btn-success">Approve</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
