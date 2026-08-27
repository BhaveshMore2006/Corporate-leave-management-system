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
            <h2>Leave Reports (Aggregated)</h2>
            <hr>
            <div class="card shadow-sm border-0 mt-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead class="table-dark">
                                <tr>
                                    <th>Employee Code</th>
                                    <th>Department</th>
                                    <th>Leave Type</th>
                                    <th>Total Approved Days</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${reports}">
                                    <tr>
                                        <td>${row.employeeCode}</td>
                                        <td>${row.department}</td>
                                        <td>${row.leaveType}</td>
                                        <td>${row.totalLeaves}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty reports}">
                                    <tr><td colspan="4" class="text-center">No data available.</td></tr>
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
