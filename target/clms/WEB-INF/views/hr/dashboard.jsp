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
            <h2>HR Admin Dashboard</h2>
            <hr>
            <p>Welcome to the HR Admin dashboard. Manage users and view reports here.</p>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
