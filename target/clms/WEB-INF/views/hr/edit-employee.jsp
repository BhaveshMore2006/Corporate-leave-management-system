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
            <h2>Edit Employee: ${employee.employeeCode}</h2>
            <hr>
            <div class="card shadow-sm border-0 mt-4 w-75">
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/hr/employees/edit" method="post">
                        <input type="hidden" name="userId" value="${employee.userId}">
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Employee Code</label>
                                <input type="text" class="form-control" value="${employee.employeeCode}" disabled>
                                <small class="text-muted">Employee Code cannot be changed.</small>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="fullName" value="${employee.fullName}" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label">Email Address</label>
                                <input type="email" class="form-control" name="email" value="${employee.email}" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role" required>
                                    <option value="EMPLOYEE" ${employee.role == 'EMPLOYEE' ? 'selected' : ''}>Employee</option>
                                    <option value="MANAGER" ${employee.role == 'MANAGER' ? 'selected' : ''}>Manager</option>
                                    <option value="HR_ADMIN" ${employee.role == 'HR_ADMIN' ? 'selected' : ''}>HR Admin</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Department</label>
                                <input type="text" class="form-control" name="department" value="${employee.department}" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Reporting Manager (Optional)</label>
                                <select class="form-select" name="managerId">
                                    <option value="">-- None --</option>
                                    <c:forEach var="mgr" items="${managers}">
                                        <option value="${mgr.userId}" ${employee.managerId == mgr.userId ? 'selected' : ''}>${mgr.fullName} (${mgr.department})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Account Status</label>
                                <div class="form-check mt-2">
                                    <input class="form-check-input" type="checkbox" name="isActive" value="true" id="isActiveCheck" ${employee.active ? 'checked' : ''}>
                                    <label class="form-check-label" for="isActiveCheck">
                                        Active
                                    </label>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                        <a href="${pageContext.request.contextPath}/hr/employees" class="btn btn-secondary ms-2">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
