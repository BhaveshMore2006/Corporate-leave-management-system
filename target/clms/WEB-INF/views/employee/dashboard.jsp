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
            <h2>Employee Dashboard</h2>
            <hr>
            <div class="row mt-4">
                <c:forEach var="balance" items="${balances}">
                    <div class="col-md-4 mb-3">
                        <div class="card shadow-sm border-0 bg-light">
                            <div class="card-body text-center">
                                <h5 class="card-title text-uppercase text-muted">${balance.leaveType} Leave</h5>
                                <h2 class="display-4 text-primary">${balance.remainingDays}</h2>
                                <p class="card-text text-muted mb-0">Total: ${balance.allocatedDays} | Used: ${balance.usedDays}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
