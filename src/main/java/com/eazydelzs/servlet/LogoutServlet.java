package com.eazydelzs.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.eazydelzs.entities.Message;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("user");
        HttpSession session = request.getSession();

        if (user == null || user.trim().isEmpty()) {
            // Redirect to login page if user parameter is missing
            response.sendRedirect("login.jsp");
            return;
        }

        Message message = new Message("Logout successfully!!", "success", "alert-success");

        if (user.trim().equals("user")) {
            session.removeAttribute("activeUser");
            session.setAttribute("message", message);
            response.sendRedirect("login.jsp");

        } else if (user.trim().equals("admin")) {
            session.removeAttribute("activeAdmin");
            session.setAttribute("message", message);
            response.sendRedirect("admin_login.jsp");
        } else {
            // Handle unexpected user parameter value
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
