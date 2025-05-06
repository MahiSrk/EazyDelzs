package com.eazydelzs.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.eazydelzs.dao.AdminDao;
import com.eazydelzs.dao.UserDao;
import com.eazydelzs.entities.Admin;
import com.eazydelzs.entities.Message;
import com.eazydelzs.entities.User;
import com.eazydelzs.helper.ConnectionProvider;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login = request.getParameter("login");

        if ("user".equals(login.trim())) {
            handleUserLogin(request, response);
        } else if ("admin".equals(login.trim())) {
            handleAdminLogin(request, response);
        }
    }

    private void handleUserLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String userEmail = request.getParameter("user_email");
            String userPassword = request.getParameter("user_password");

            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            User user = userDao.getUserByEmailPassword(userEmail, userPassword);

            HttpSession session = request.getSession();
            if (user != null) {
                session.setAttribute("activeUser", user);
                response.sendRedirect("index.jsp");
            } else {
                Message message = new Message("Invalid details! Try again!!", "error", "alert-danger");
                session.setAttribute("message", message);
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Optionally, show a generic error message to the user
            Message message = new Message("An error occurred. Please try again later.", "error", "alert-danger");
            request.getSession().setAttribute("message", message);
            response.sendRedirect("login.jsp");
        }
    }

    private void handleAdminLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String adminEmail = request.getParameter("email");
            String adminPassword = request.getParameter("password");

            AdminDao adminDao = new AdminDao(ConnectionProvider.getConnection());
            Admin admin = adminDao.getAdminByEmailPassword(adminEmail, adminPassword);

            HttpSession session = request.getSession();
            if (admin != null) {
                session.setAttribute("activeAdmin", admin);
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                Message message = new Message("Invalid details! Try again!!", "error", "alert-danger");
                session.setAttribute("message", message);
                response.sendRedirect("adminlogin.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Optionally, show a generic error message to the user
            Message message = new Message("An error occurred. Please try again later.", "error", "alert-danger");
            request.getSession().setAttribute("message", message);
            response.sendRedirect("adminlogin.jsp");
        }
    }
}
