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
                    <div class="col-md-4 mb-4">
                        <c:choose>
                            <c:when test="${balance.leaveType == 'CASUAL'}">
                                <c:set var="cardClass" value="card-theme card-casual" />
                                <c:set var="iconClass" value="bi bi-umbrella-fill" />
                            </c:when>
                            <c:when test="${balance.leaveType == 'SICK'}">
                                <c:set var="cardClass" value="card-theme card-sick" />
                                <c:set var="iconClass" value="bi bi-plus-circle-fill" />
                            </c:when>
                            <c:when test="${balance.leaveType == 'EARNED'}">
                                <c:set var="cardClass" value="card-theme card-earned" />
                                <c:set var="iconClass" value="bi bi-flower1" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="cardClass" value="card-theme card-default" />
                                <c:set var="iconClass" value="bi bi-calendar3" />
                            </c:otherwise>
                        </c:choose>

                        <div class="${cardClass}">
                            <div class="icon-wrapper">
                                <i class="${iconClass}"></i>
                            </div>
                            <div class="card-details">
                                <h5 class="text-uppercase">${balance.leaveType} LEAVE</h5>
                                <h2>${balance.remainingDays}</h2>
                                <p>Total: ${balance.allocatedDays} | Used: ${balance.usedDays}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
