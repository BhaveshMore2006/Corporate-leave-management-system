package com.clms.controller;

import com.clms.dao.LeaveBalanceDAO;
import com.clms.dao.LeaveRequestDAO;
import com.clms.dao.ReportDAO;
import com.clms.dao.UserDAO;
import com.clms.model.LeaveRequest;
import com.clms.model.User;
import com.clms.service.LeaveService;
import com.clms.util.PasswordHasher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/hr/*")
public class HRController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private ReportDAO reportDAO = new ReportDAO();
    private LeaveBalanceDAO leaveBalanceDAO = new LeaveBalanceDAO();
    private LeaveRequestDAO leaveRequestDAO = new LeaveRequestDAO();
    private LeaveService leaveService = new LeaveService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if ("/dashboard".equals(pathInfo)) {
            // Stats
            int totalEmployees = userDAO.getAllUsers().size();
            List<LeaveRequest> allRequests = leaveRequestDAO.getAllRequests();
            int totalLeaveRequests = allRequests.size();
            
            List<LeaveRequest> hrPendingRequests = leaveRequestDAO.getRequestsForHRAdmin();
            int pendingApprovals = hrPendingRequests.size();
            
            int approvedThisMonth = 0;
            java.util.Calendar cal = java.util.Calendar.getInstance();
            int currentMonth = cal.get(java.util.Calendar.MONTH);
            int currentYear = cal.get(java.util.Calendar.YEAR);
            
            int casualApproved=0, casualPending=0, casualRejected=0;
            int sickApproved=0, sickPending=0, sickRejected=0;
            int earnedApproved=0, earnedPending=0, earnedRejected=0;

            for(LeaveRequest req : allRequests) {
                boolean isThisMonth = false;
                if (req.getAppliedAt() != null) {
                    cal.setTime(req.getAppliedAt());
                    if (cal.get(java.util.Calendar.MONTH) == currentMonth && cal.get(java.util.Calendar.YEAR) == currentYear) {
                        isThisMonth = true;
                    }
                }
                
                if (isThisMonth) {
                    String status = req.getStatus();
                    String type = req.getLeaveType().name();
                    if ("CASUAL".equals(type)) {
                        if ("APPROVED".equals(status)) casualApproved++;
                        else if ("PENDING".equals(status)) casualPending++;
                        else if ("REJECTED".equals(status)) casualRejected++;
                    } else if ("SICK".equals(type)) {
                        if ("APPROVED".equals(status)) sickApproved++;
                        else if ("PENDING".equals(status)) sickPending++;
                        else if ("REJECTED".equals(status)) sickRejected++;
                    } else if ("EARNED".equals(type)) {
                        if ("APPROVED".equals(status)) earnedApproved++;
                        else if ("PENDING".equals(status)) earnedPending++;
                        else if ("REJECTED".equals(status)) earnedRejected++;
                    }
                }

                if ("APPROVED".equals(req.getStatus()) && req.getReviewedAt() != null) {
                    cal.setTime(req.getReviewedAt());
                    if (cal.get(java.util.Calendar.MONTH) == currentMonth && cal.get(java.util.Calendar.YEAR) == currentYear) {
                        approvedThisMonth++;
                    }
                }
            }
            
            // Pass chart data as arrays
            request.setAttribute("chartApproved", new int[]{casualApproved, sickApproved, earnedApproved});
            request.setAttribute("chartPending", new int[]{casualPending, sickPending, earnedPending});
            request.setAttribute("chartRejected", new int[]{casualRejected, sickRejected, earnedRejected});

            // Company Wide Leave Summary
            java.util.Map<String, double[]> leaveSummary = leaveBalanceDAO.getCompanyWideLeaveSummary(currentYear);
            if (!leaveSummary.containsKey("CASUAL")) leaveSummary.put("CASUAL", new double[]{0, 0});
            if (!leaveSummary.containsKey("SICK")) leaveSummary.put("SICK", new double[]{0, 0});
            if (!leaveSummary.containsKey("EARNED")) leaveSummary.put("EARNED", new double[]{0, 0});
            request.setAttribute("leaveSummary", leaveSummary);

            // Recent Requests (first 5 from all)
            List<LeaveRequest> recentRequests = allRequests.size() > 5 ? allRequests.subList(0, 5) : allRequests;
            request.setAttribute("recentRequests", recentRequests);

            // Pending HR Approvals (first 5 from hrPending)
            List<LeaveRequest> recentPendingHR = hrPendingRequests.size() > 5 ? hrPendingRequests.subList(0, 5) : hrPendingRequests;
            request.setAttribute("recentPendingHR", recentPendingHR);

            request.setAttribute("totalEmployees", totalEmployees);
            request.setAttribute("totalLeaveRequests", totalLeaveRequests);
            request.setAttribute("pendingApprovals", pendingApprovals);
            request.setAttribute("approvedThisMonth", approvedThisMonth);

            request.getRequestDispatcher("/WEB-INF/views/hr/dashboard.jsp").forward(request, response);
        } else if ("/employees".equals(pathInfo)) {
            List<User> employees = userDAO.getAllUsers();
            request.setAttribute("employees", employees);
            request.getRequestDispatcher("/WEB-INF/views/hr/manage-employees.jsp").forward(request, response);
        } else if ("/employees/add".equals(pathInfo)) {
            // Get managers for the dropdown
            List<User> managers = userDAO.getAllUsers().stream().filter(u -> "MANAGER".equals(u.getRole())).toList();
            request.setAttribute("managers", managers);
            request.getRequestDispatcher("/WEB-INF/views/hr/add-employee.jsp").forward(request, response);
        } else if ("/employees/edit".equals(pathInfo)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.getUserById(userId);
            List<User> managers = userDAO.getAllUsers().stream().filter(u -> "MANAGER".equals(u.getRole())).toList();
            request.setAttribute("employee", user);
            request.setAttribute("managers", managers);
            request.getRequestDispatcher("/WEB-INF/views/hr/edit-employee.jsp").forward(request, response);
        } else if ("/reports".equals(pathInfo)) {
            request.setAttribute("reports", reportDAO.getLeaveSummaryByDepartment());
            request.getRequestDispatcher("/WEB-INF/views/hr/reports.jsp").forward(request, response);
        } else if ("/pending-approvals".equals(pathInfo)) {
            List<LeaveRequest> requests = leaveRequestDAO.getRequestsForHRAdmin();
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("/WEB-INF/views/hr/pending-approvals.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);

        if ("/employees/add".equals(pathInfo)) {
            User user = new User();
            user.setEmployeeCode(request.getParameter("employeeCode"));
            user.setFullName(request.getParameter("fullName"));
            user.setEmail(request.getParameter("email"));
            user.setPasswordHash(PasswordHasher.hashPassword("password")); // Default password
            user.setRole(request.getParameter("role"));
            user.setDepartment(request.getParameter("department"));
            String managerIdStr = request.getParameter("managerId");
            if (managerIdStr != null && !managerIdStr.isEmpty()) {
                user.setManagerId(Integer.parseInt(managerIdStr));
            }
            user.setActive(true);

            int newUserId = userDAO.createUser(user);
            if (newUserId > 0) {
                leaveBalanceDAO.createDefaultBalances(newUserId, 2026);
                session.setAttribute("flash_success", "Employee added successfully with default leave balances.");
            } else {
                session.setAttribute("flash_error", "Failed to add employee.");
            }
            response.sendRedirect(request.getContextPath() + "/hr/employees");
        } else if ("/employees/edit".equals(pathInfo)) {
            User user = new User();
            user.setUserId(Integer.parseInt(request.getParameter("userId")));
            user.setFullName(request.getParameter("fullName"));
            user.setEmail(request.getParameter("email"));
            user.setRole(request.getParameter("role"));
            user.setDepartment(request.getParameter("department"));
            String managerIdStr = request.getParameter("managerId");
            if (managerIdStr != null && !managerIdStr.isEmpty()) {
                user.setManagerId(Integer.parseInt(managerIdStr));
            }
            user.setActive("true".equals(request.getParameter("isActive")));

            userDAO.updateUser(user);
            session.setAttribute("flash_success", "Employee updated successfully!");
            response.sendRedirect(request.getContextPath() + "/hr/employees");
        } else if ("/employees/delete".equals(pathInfo)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean success = userDAO.deleteUser(userId);
            if (success) {
                session.setAttribute("flash_success", "Employee deleted successfully!");
            } else {
                session.setAttribute("flash_error", "Failed to delete employee.");
            }
            response.sendRedirect(request.getContextPath() + "/hr/employees");
        } else if ("/approve-reject".equals(pathInfo)) {
            int hrAdminId = (int) session.getAttribute("user_id");
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            int employeeId = Integer.parseInt(request.getParameter("employeeId"));
            String status = request.getParameter("status"); // APPROVED or REJECTED
            String remarks = request.getParameter("remarks");
            double totalDays = Double.parseDouble(request.getParameter("totalDays"));
            String leaveType = request.getParameter("leaveType");

            boolean success = leaveService.processLeaveRequest(requestId, hrAdminId, status, remarks, totalDays, leaveType, employeeId);
            
            if (success) {
                session.setAttribute("flash_success", "Manager leave request " + status.toLowerCase() + " successfully.");
            } else {
                session.setAttribute("flash_error", "Failed to process manager leave request.");
            }
            response.sendRedirect(request.getContextPath() + "/hr/pending-approvals");
        }
    }
}
