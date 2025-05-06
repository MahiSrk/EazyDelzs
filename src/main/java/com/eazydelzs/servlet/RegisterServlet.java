package com.eazydelzs.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.eazydelzs.dao.UserDao;
import com.eazydelzs.entities.Message;
import com.eazydelzs.entities.User;
import com.eazydelzs.helper.ConnectionProvider;
import com.eazydelzs.helper.MailMessenger;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Message message = null;

        try {
            // Retrieve form parameters
            String userName = request.getParameter("user_name");
            String userEmail = request.getParameter("user_email");
            String userPassword = request.getParameter("user_password");
            String userPhone = request.getParameter("user_mobile_no");
            String userGender = request.getParameter("gender");
            String userAddress = request.getParameter("user_address");
            String userCity = request.getParameter("city");
            String userPincode = request.getParameter("pincode");
            String userState = request.getParameter("state");

            // Create a User object
            User user = new User(userName, userEmail, userPassword, userPhone, userGender, userAddress, userCity, userPincode, userState);
            
            // Save user to the database
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean isUserSaved = userDao.saveUser(user);

            // Prepare message based on user save status
            if (isUserSaved) {
                message = new Message("Registration Successful!!", "success", "alert-success");
                // Send registration confirmation email
                MailMessenger.successfullyRegister(userName, userEmail);
            } else {
                message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = new Message("An error occurred! Please try again later.", "error", "alert-danger");
        } finally {
            // Set the message and redirect
            session.setAttribute("message", message);
            response.sendRedirect("register.jsp");
        }
    }
}
