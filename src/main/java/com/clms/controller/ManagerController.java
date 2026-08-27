package com.clms.controller;

import com.clms.dao.LeaveRequestDAO;
import com.clms.dao.ReportDAO;
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

@WebServlet("/manager/*")
public class ManagerController extends HttpServlet {
    private LeaveRequestDAO leaveRequestDAO = new LeaveRequestDAO();
    private LeaveService leaveService = new LeaveService();
    private ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);
        int managerId = (int) session.getAttribute("user_id");

        if ("/dashboard".equals(pathInfo)) {
            List<LeaveRequest> requests = leaveRequestDAO.getRequestsForManager(managerId);
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("/WEB-INF/views/manager/dashboard.jsp").forward(request, response);
        } else if ("/pending-approvals".equals(pathInfo)) {
            List<LeaveRequest> requests = leaveRequestDAO.getRequestsForManager(managerId);
            // Filter pending can be done in view or DAO
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("/WEB-INF/views/manager/pending-approvals.jsp").forward(request, response);
        } else if ("/reports".equals(pathInfo)) {
            request.setAttribute("reports", reportDAO.getLeaveSummaryByDepartment());
            request.getRequestDispatcher("/WEB-INF/views/hr/reports.jsp").forward(request, response);
        } else if ("/apply".equals(pathInfo)) {
            request.getRequestDispatcher("/WEB-INF/views/employee/apply-leave.jsp").forward(request, response);
        } else if ("/history".equals(pathInfo)) {
            List<LeaveRequest> requests = leaveRequestDAO.getRequestsByUserId(managerId);
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("/WEB-INF/views/employee/leave-history.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);
        int managerId = (int) session.getAttribute("user_id");

        if ("/approve-reject".equals(pathInfo)) {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            int employeeId = Integer.parseInt(request.getParameter("employeeId"));
            String status = request.getParameter("status"); // APPROVED or REJECTED
            String remarks = request.getParameter("remarks");
            double totalDays = Double.parseDouble(request.getParameter("totalDays"));
            String leaveType = request.getParameter("leaveType");

            boolean success = leaveService.processLeaveRequest(requestId, managerId, status, remarks, totalDays, leaveType, employeeId);
            
            if (success) {
                session.setAttribute("flash_success", "Leave request " + status.toLowerCase() + " successfully.");
            } else {
                session.setAttribute("flash_error", "Failed to process leave request.");
            }
            response.sendRedirect(request.getContextPath() + "/manager/pending-approvals");
        } else if ("/apply".equals(pathInfo)) {
            LeaveRequest lr = new LeaveRequest();
            lr.setUserId(managerId);
            lr.setLeaveType(LeaveType.valueOf(request.getParameter("leaveType")));
            lr.setStartDate(Date.valueOf(request.getParameter("startDate")));
            lr.setEndDate(Date.valueOf(request.getParameter("endDate")));
            lr.setTotalDays(Double.parseDouble(request.getParameter("totalDays")));
            lr.setReason(request.getParameter("reason"));

            boolean success = leaveService.applyLeave(lr);
            if(success) {
                session.setAttribute("flash_success", "Leave applied successfully!");
                response.sendRedirect(request.getContextPath() + "/manager/history");
            } else {
                request.setAttribute("error", "Failed to apply leave.");
                request.getRequestDispatcher("/WEB-INF/views/employee/apply-leave.jsp").forward(request, response);
            }
        }
    }
}
