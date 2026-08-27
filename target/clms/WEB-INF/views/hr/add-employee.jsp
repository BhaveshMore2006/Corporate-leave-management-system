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
            <h2>Add New Employee</h2>
            <hr>
            <div class="card shadow-sm border-0 mt-4 w-75">
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/hr/employees/add" method="post">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Employee Code</label>
                                <input type="text" class="form-control" name="employeeCode" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="fullName" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label">Email Address</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role" required>
                                    <option value="EMPLOYEE">Employee</option>
                                    <option value="MANAGER">Manager</option>
                                    <option value="HR_ADMIN">HR Admin</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Department</label>
                                <input type="text" class="form-control" name="department" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label">Reporting Manager (Optional)</label>
                                <select class="form-select" name="managerId">
                                    <option value="">-- None --</option>
                                    <c:forEach var="mgr" items="${managers}">
                                        <option value="${mgr.userId}">${mgr.fullName} (${mgr.department})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <p class="text-muted small"><i class="bi bi-info-circle"></i> A default password of 'password' will be assigned, and standard leave balances will be allocated automatically.</p>
                        <button type="submit" class="btn btn-primary">Create Employee</button>
                        <a href="${pageContext.request.contextPath}/hr/employees" class="btn btn-secondary ms-2">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
