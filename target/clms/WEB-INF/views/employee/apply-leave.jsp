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
            <h2>Apply Leave</h2>
            <hr>
            <div class="row mt-4">
                <div class="col-lg-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>
                            <form action="${pageContext.request.contextPath}/${sessionScope.role == 'MANAGER' ? 'manager' : 'employee'}/apply" method="post" id="leaveForm">
                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <label for="leaveType" class="form-label">Leave Type</label>
                                        <select class="form-select" id="leaveType" name="leaveType" required>
                                            <option value="">Select Type</option>
                                            <option value="CASUAL">Casual</option>
                                            <option value="SICK">Sick</option>
                                            <option value="EARNED">Earned</option>
                                            <option value="WORK_FROM_HOME">Work From Home</option>
                                            <option value="UNPAID">Unpaid Leave</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="halfDay" name="halfDay" value="true">
                                            <label class="form-check-label" for="halfDay">
                                                Half Day (Sets duration to 0.5 days)
                                            </label>
                                        </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="startDate" class="form-label">Start Date</label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="endDate" class="form-label">End Date</label>
                                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <label for="totalDays" class="form-label">Total Days</label>
                                        <input type="number" class="form-control bg-light" id="totalDays" name="totalDays" readonly required>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <label for="reason" class="form-label">Reason</label>
                                        <textarea class="form-control" id="reason" name="reason" rows="3" required></textarea>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary px-4">Submit Application</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
