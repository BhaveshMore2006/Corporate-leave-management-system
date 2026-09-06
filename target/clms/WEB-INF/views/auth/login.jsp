<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="../common/header.jsp"/>

<div class="row g-0 min-vh-100">
    <!-- Left Column (Info) -->
    <div class="col-lg-5 navbar-custom text-white d-flex flex-column justify-content-center p-5">
        <div class="mb-5">
            <h3 class="fw-bold"><i class="bi bi-person-check-fill me-2"></i>Corporate Leave Management System</h3>
        </div>
        <h1 class="display-4 fw-bold mb-3" style="line-height: 1.2;">The OS for<br><span style="color: #4ade80;">Modern Workforces</span></h1>
        <p class="lead mb-5" style="color: #b5a9cc; font-size: 1.1rem;">Sign in to manage your daily attendance, track team leaves, and optimize operational efficiency in real-time.</p>
        
        <div class="feature-item d-flex align-items-start mb-4">
            <div class="feature-icon me-3">
                <i class="bi bi-lightning-charge-fill"></i>
            </div>
            <div>
                <h5 class="fw-bold mb-1">Effortless Workflow</h5>
                <p class="mb-0" style="color: #b5a9cc; font-size: 0.95rem;">Automate repetitive tasks and focus on productive employee experiences.</p>
            </div>
        </div>
        
        <div class="feature-item d-flex align-items-start mb-4">
            <div class="feature-icon me-3">
                <i class="bi bi-shield-lock-fill"></i>
            </div>
            <div>
                <h5 class="fw-bold mb-1">Secured Data</h5>
                <p class="mb-0" style="color: #b5a9cc; font-size: 0.95rem;">Enterprise-grade security to keep your workforce records safe.</p>
            </div>
        </div>
        

    </div>
    
    <!-- Right Column (Form) -->
    <div class="col-lg-7 d-flex align-items-center justify-content-center bg-white">
        <div class="w-100 p-4" style="max-width: 450px;">
            <h2 class="fw-bold text-center mb-2" style="color: #2e1d44;">Welcome Back</h2>
            <p class="text-center text-muted mb-5">Sign in to your dashboard.</p>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/auth/login" method="post">
                <div class="mb-4">
                    <label for="email" class="form-label text-muted fw-bold" style="font-size: 0.75rem; letter-spacing: 1px;">EMAIL ADDRESS</label>
                    <div class="input-group login-input-group">
                        <span class="input-group-text bg-white text-muted border-end-0"><i class="bi bi-envelope"></i></span>
                        <input type="email" class="form-control border-start-0 ps-0" id="email" name="email" required placeholder="you@company.com">
                    </div>
                </div>
                
                <div class="mb-5">
                    <label for="password" class="form-label text-muted fw-bold" style="font-size: 0.75rem; letter-spacing: 1px;">PASSWORD</label>
                    <div class="input-group login-input-group">
                        <span class="input-group-text bg-white text-muted border-end-0"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control border-start-0 ps-0" id="password" name="password" required placeholder="••••••••">
                    </div>
                </div>
                
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg fw-bold rounded-3">Sign In to Dashboard</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
