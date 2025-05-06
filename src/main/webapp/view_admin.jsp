<%@page import="com.eazydelzs.dao.AdminDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("admin_login.jsp");
	return;
}
AdminDao adminDao = new AdminDao(ConnectionProvider.getConnection());
List<Admin> adminList = adminDao.getAllAdmin();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Admin's</title>
<%@include file="Component/css_js.jsp"%>
<style>
    /* Styling for overall page */
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f6f9;
    }

    /* Card styling */
    .card {
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border: none;
    }

    .card-body {
        padding: 20px;
    }

    /* Table styling */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    table th, table td {
        padding: 12px;
        text-align: center;
        font-size: 16px;
        vertical-align: middle;
    }

    table th {
        background-color: #007bff;
        color: white;
    }

    table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    table tr:hover {
        background-color: #f1f1f1;
    }

    /* Button styling */
    .btn {
        border-radius: 5px;
    }

    .btn-danger {
        background-color: #dc3545;
        border-color: #dc3545;
    }

    .btn-danger:hover {
        background-color: #c82333;
        border-color: #c82333;
    }

    /* Form styling */
    .form-label {
        font-weight: bold;
        color: #495057;
    }

    .form-control {
        border-radius: 5px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }

    .container {
        margin-top: 20px;
    }

    .text-center img {
        max-width: 100px;
    }

    .d-grid {
        display: grid;
        justify-items: center;
    }
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Component/navbar.jsp"%>

	<div class="container-fluid px-5 py-3">
		<div class="row">
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<div class="container text-center">
							<img src="Images/Addadminicn.jpg" class="img-fluid">
						</div>
						<h3 class="text-center">Add Admin</h3>
						<%@include file="Component/alertmessage.jsp"%>

						<!--admin-form-->
						<form action="AdminServlet?operation=save" method="post">
							<div class="mb-3">
								<label class="form-label">Name</label>
								<input type="text" name="name" placeholder="Enter name" class="form-control" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Email</label>
								<input type="email" name="email" placeholder="Email address" class="form-control" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Password</label>
								<input type="password" name="password" placeholder="Enter password" class="form-control" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Phone</label>
								<input type="number" name="phone" placeholder="Enter phone number" class="form-control" required>
							</div>
							<div class="d-grid gap-2 py-3">
								<button type="submit" class="btn btn-primary">Register</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-md-8">
				<div class="card">
					<div class="card-body">
						<table class="table table-hover">
							<tr class="text-center table-primary" style="font-size: 18px;">
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Action</th>
							</tr>
							<%
							for (Admin a : adminList) {
							%>
							<tr class="text-center">
								<td><%=a.getName() %></td>
								<td><%=a.getEmail() %></td>
								<td><%=a.getPhone() %></td>
								<td><a href="AdminServlet?operation=delete&id=<%=a.getId()%>" role="button" class="btn btn-danger">Remove</a></td>
							</tr>
							<%
							}
							%>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
