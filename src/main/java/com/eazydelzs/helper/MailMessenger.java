package com.eazydelzs.helper;

public class MailMessenger {

    public static void successfullyRegister(String userName, String userEmail) {
        String subject = "Welcome to EazyDelzs - Successful Registration!";
        String body = buildHtmlEmail("Welcome to EazyDeals, " + userName + "!",
                "<p>Congratulations and a warm welcome to <b>EazyDeals</b>! We are thrilled to have you with us.</p>" +
                "<p>Your registration was successful. Explore a wide range of products and exciting deals tailored to your preferences.</p>" +
                "<p>Happy shopping!</p>");
        send(userEmail, subject, body);
    }

    public static void successfullyOrderPlaced(String userName, String userEmail, String orderId, String orderDate) {
        String subject = "Order Confirmation - Your Product is on its way!";
        String body = buildHtmlEmail("Hi " + userName + ",",
                "<p>Thank you for shopping with <b>EazyDeals</b>! Your order has been placed successfully.</p>" +
                "<p><b>Order Number:</b> " + orderId + "<br><b>Order Date:</b> " + orderDate + "</p>" +
                "<p>Your order is being prepared for shipment. You’ll receive tracking details shortly.</p>" +
                "<p>We appreciate your trust and look forward to delivering your items soon.</p>");
        send(userEmail, subject, body);
    }

    public static void orderShipped(String userName, String userEmail, String orderId, String orderDate) {
        String subject = "Your Order is Out for Delivery!";
        String body = buildHtmlEmail("Good news, " + userName + "!",
                "<p>Your order is on its way and will be delivered soon.</p>" +
                "<p><b>Order Number:</b> " + orderId + "<br><b>Order Date:</b> " + orderDate + "</p>" +
                "<p>Thank you for choosing <b>EazyDeals</b>. We hope you enjoy your purchase!</p>");
        send(userEmail, subject, body);
    }

    public static void sendOtp(String userEmail, int code) {
        String subject = "Verification Code for Password Change";
        String body = buildHtmlEmail("Password Reset Code",
                "<p>Please use the following verification code to reset your password:</p>" +
                "<h2 style='color:#2c3e50'>" + code + "</h2>");
        send(userEmail, subject, body);
    }

    // Centralized method to send email
    private static void send(String to, String subject, String htmlBody) {
        try {
            Mail.sendMail(to, subject, htmlBody);
        } catch (Exception e) {
            System.err.println("Failed to send email to " + to + ": " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Utility to generate consistent email HTML template
    private static String buildHtmlEmail(String title, String content) {
        return "<div style='font-family: Arial, sans-serif; padding: 20px; background-color: #f7f7f7;'>"
                + "<div style='max-width: 600px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);'>"
                + "<h2 style='color: #4CAF50;'>" + title + "</h2>"
                + content
                + "<br><p style='font-size: 0.9em; color: #555;'>Regards,<br><b>EazyDeals Team</b></p>"
                + "</div></div>";
    }
}
