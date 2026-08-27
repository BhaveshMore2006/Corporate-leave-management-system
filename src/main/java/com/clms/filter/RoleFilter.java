package com.clms.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/employee/*", "/manager/*", "/hr/*"})
public class RoleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            String role = (String) session.getAttribute("role");
            String path = req.getRequestURI().substring(req.getContextPath().length());

            boolean authorized = false;
            if (path.startsWith("/employee") && ("EMPLOYEE".equals(role) || "MANAGER".equals(role) || "HR_ADMIN".equals(role))) {
                authorized = true;
            } else if (path.startsWith("/manager") && ("MANAGER".equals(role) || "HR_ADMIN".equals(role))) {
                authorized = true;
            } else if (path.startsWith("/hr") && "HR_ADMIN".equals(role)) {
                authorized = true;
            }

            if (authorized) {
                chain.doFilter(request, response);
            } else {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this resource.");
            }
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {}
}
