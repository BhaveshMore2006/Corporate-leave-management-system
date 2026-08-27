<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<div class="bg-dark text-white p-3 min-vh-100">
    <ul class="nav flex-column">
        <c:if test="${sessionScope.role == 'EMPLOYEE'}">
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/employee/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/employee/apply"><i class="bi bi-calendar-plus"></i> Apply Leave</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/employee/history"><i class="bi bi-clock-history"></i> Leave History</a>
            </li>
        </c:if>
        
        <c:if test="${sessionScope.role == 'MANAGER'}">
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/manager/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/manager/apply"><i class="bi bi-calendar-plus"></i> Apply Leave</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/manager/history"><i class="bi bi-clock-history"></i> Leave History</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/manager/pending-approvals"><i class="bi bi-check2-square"></i> Team Approvals</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/manager/reports"><i class="bi bi-graph-up"></i> Reports</a>
            </li>
        </c:if>

        <c:if test="${sessionScope.role == 'HR_ADMIN'}">
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/hr/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/hr/pending-approvals"><i class="bi bi-check2-square"></i> Manager Approvals</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/hr/employees"><i class="bi bi-people"></i> Manage Employees</a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/hr/reports"><i class="bi bi-graph-up"></i> Reports</a>
            </li>
        </c:if>
    </ul>
</div>
