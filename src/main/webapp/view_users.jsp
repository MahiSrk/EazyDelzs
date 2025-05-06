<%@page import="com.eazydelzs.entities.Message"%>
<%@page import="com.eazydelzs.dao.UserDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
    Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
    session.setAttribute("message", message);
    response.sendRedirect("adminlogin.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View User's</title>
<%@include file="Component/css_js.jsp"%>
<style>
    body {
        background-color: #f8f9fa;
    }
    .table th, .table td {
        vertical-align: middle;
    }
    .table-hover tbody tr:hover {
        background-color: #e9f5ff;
        transition: background-color 0.3s ease;
    }
    .table-primary {
        background: linear-gradient(to right, #007bff, #00c6ff);
        color: white;
    }
</style>
</head>
<body>
    <!--navbar -->
    <%@include file="Component/navbar.jsp"%>

    <div class="container-fluid px-5 py-4">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-primary">Registered Users</h3>
            <hr class="mx-auto" style="width: 200px; height: 3px; background-color: #007bff; opacity: 1;">
        </div>
        <div class="table-responsive rounded shadow-sm">
            <table class="table table-hover table-bordered text-center bg-white">
                <thead class="table-primary" style="font-size: 18px;">
                    <tr>
                        <th>User Name</th>
                        <th>Email</th>
                        <th>Phone No.</th>
                        <th>Gender</th>
                        <th>Address</th>
                        <th>Register Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                    List<User> userList = userDao.getAllUser();
                    for (User u : userList) {
                    %>
                    <tr>
                        <td><%=u.getUserName()%></td>
                        <td><%=u.getUserEmail()%></td>
                        <td><%=u.getUserPhone()%></td>
                        <td><%=u.getUserGender()%></td>
                        <td><%=userDao.getUserAddress(u.getUserId())%></td>
                        <td><%=u.getDateTime()%></td>
                        <td>
                            <a href="UpdateUserServlet?operation=deleteUser&uid=<%=u.getUserId()%>" role="button" class="btn btn-sm btn-danger shadow-sm">Remove</a>
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
