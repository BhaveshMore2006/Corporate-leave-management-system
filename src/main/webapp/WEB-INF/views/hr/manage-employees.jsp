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
            <div class="d-flex justify-content-between align-items-center">
                <h2>Manage Employees</h2>
                <a href="${pageContext.request.contextPath}/hr/employees/add" class="btn btn-primary"><i class="bi bi-person-plus"></i> Add Employee</a>
            </div>
            <hr>
            <c:if test="${not empty sessionScope.flash_success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.flash_success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="flash_success" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.flash_error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.flash_error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="flash_error" scope="session"/>
            </c:if>
            <div class="card shadow-sm border-0 mt-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Emp Code</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Department</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="emp" items="${employees}">
                                    <tr>
                                        <td>${emp.employeeCode}</td>
                                        <td>${emp.fullName}</td>
                                        <td>${emp.email}</td>
                                        <td>${emp.role}</td>
                                        <td>${emp.department}</td>
                                        <td>
                                            <span class="badge ${emp.active ? 'bg-success' : 'bg-secondary'}">
                                                ${emp.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <a href="${pageContext.request.contextPath}/hr/employees/edit?id=${emp.userId}" class="btn btn-sm btn-outline-secondary"><i class="bi bi-pencil"></i> Edit</a>
                                                <form action="${pageContext.request.contextPath}/hr/employees/delete" method="post" onsubmit="return confirm('Are you sure you want to delete this employee?');">
                                                    <input type="hidden" name="userId" value="${emp.userId}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i> Delete</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
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
