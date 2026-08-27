package com.clms.controller;

import com.clms.model.User;
import com.clms.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth/*")
public class AuthController extends HttpServlet {
    private AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if ("/logout".equals(pathInfo)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/auth/login");
        } else {
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = authService.authenticate(email, password);
        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user_id", user.getUserId());
            session.setAttribute("full_name", user.getFullName());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("role", user.getRole());
            session.setAttribute("department", user.getDepartment());

            // Redirect based on role
            switch (user.getRole()) {
                case "EMPLOYEE":
                    response.sendRedirect(request.getContextPath() + "/employee/dashboard");
                    break;
                case "MANAGER":
                    response.sendRedirect(request.getContextPath() + "/manager/dashboard");
                    break;
                case "HR_ADMIN":
                    response.sendRedirect(request.getContextPath() + "/hr/dashboard");
                    break;
            }
        } else {
            request.setAttribute("error", "Invalid credentials or account disabled.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}
