package com.clms.controller;

import com.clms.dao.LeaveBalanceDAO;
import com.clms.dao.LeaveRequestDAO;
import com.clms.model.LeaveBalance;
import com.clms.model.LeaveRequest;
import com.clms.model.LeaveType;
import com.clms.service.LeaveService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/employee/*")
public class EmployeeController extends HttpServlet {
    private LeaveRequestDAO leaveRequestDAO = new LeaveRequestDAO();
    private LeaveBalanceDAO leaveBalanceDAO = new LeaveBalanceDAO();
    private LeaveService leaveService = new LeaveService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("user_id");

        if ("/dashboard".equals(pathInfo)) {
            List<LeaveBalance> balances = leaveBalanceDAO.getBalancesByUserId(userId, 2026);
            List<LeaveRequest> requests = leaveRequestDAO.getRequestsByUserId(userId);
            
            double totalLeaves = 0.0;
            double totalUsed = 0.0;
            double totalRemaining = 0.0;
            for (LeaveBalance b : balances) {
                totalLeaves += b.getAllocatedDays();
                totalUsed += b.getUsedDays();
                totalRemaining += b.getRemainingDays();
            }

            long pendingRequests = requests.stream().filter(r -> "PENDING".equals(r.getStatus())).count();

            // Find upcoming leave (earliest approved request in the future)
            LeaveRequest upcomingLeave = null;
            java.util.Date today = new java.util.Date();
            for (LeaveRequest r : requests) {
                if ("APPROVED".equals(r.getStatus()) && r.getStartDate() != null && !r.getStartDate().before(today)) {
                    if (upcomingLeave == null || r.getStartDate().before(upcomingLeave.getStartDate())) {
                        upcomingLeave = r;
                    }
                }
            }

            request.setAttribute("balances", balances);
            request.setAttribute("requests", requests);
            request.setAttribute("totalLeaves", totalLeaves);
            request.setAttribute("totalUsed", totalUsed);
            request.setAttribute("totalRemaining", totalRemaining);
            request.setAttribute("pendingRequestsCount", pendingRequests);
            request.setAttribute("upcomingLeave", upcomingLeave);

            request.getRequestDispatcher("/WEB-INF/views/employee/dashboard.jsp").forward(request, response);
        } else if ("/apply".equals(pathInfo)) {
            request.getRequestDispatcher("/WEB-INF/views/employee/apply-leave.jsp").forward(request, response);
        } else if ("/history".equals(pathInfo)) {
            List<LeaveRequest> requests = leaveRequestDAO.getRequestsByUserId(userId);
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("/WEB-INF/views/employee/leave-history.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("user_id");

        if ("/apply".equals(pathInfo)) {
            LeaveRequest lr = new LeaveRequest();
            lr.setUserId(userId);
            lr.setLeaveType(LeaveType.valueOf(request.getParameter("leaveType")));
            lr.setStartDate(Date.valueOf(request.getParameter("startDate")));
            lr.setEndDate(Date.valueOf(request.getParameter("endDate")));
            lr.setTotalDays(Double.parseDouble(request.getParameter("totalDays")));
            lr.setReason(request.getParameter("reason"));

            boolean success = leaveService.applyLeave(lr);
            if(success) {
                session.setAttribute("flash_success", "Leave applied successfully!");
                response.sendRedirect(request.getContextPath() + "/employee/history");
            } else {
                request.setAttribute("error", "Failed to apply leave.");
                request.getRequestDispatcher("/WEB-INF/views/employee/apply-leave.jsp").forward(request, response);
            }
        }
    }
}
