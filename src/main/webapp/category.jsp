<%@page import="com.eazydelzs.entities.Message"%>
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
<title>View Categories</title>
<%@include file="Component/css_js.jsp"%>
<style>
    /* General styling for the page */
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
    }

    /* Navbar and other components can follow the same style */
    .container {
        margin-top: 30px;
    }

    /* Table styling */
    table {
        width: 100%;
        margin-top: 20px;
        border-collapse: collapse;
    }

    table th, table td {
        padding: 15px;
        text-align: center;
        font-size: 18px;
        vertical-align: middle;
    }

    table th {
        background-color: #007bff;
        color: white;
        border-radius: 5px;
    }

    table tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    table tr:hover {
        background-color: #f1f1f1;
    }

    table img {
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    /* Button styling */
    .btn {
        border-radius: 5px;
        padding: 8px 16px;
        font-size: 16px;
        margin: 5px;
    }

    .btn-secondary {
        background-color: #6c757d;
        border-color: #6c757d;
    }

    .btn-secondary:hover {
        background-color: #5a6268;
        border-color: #545b62;
    }

    .btn-danger {
        background-color: #dc3545;
        border-color: #dc3545;
    }

    .btn-danger:hover {
        background-color: #c82333;
        border-color: #c82333;
    }

    /* Alert message styling */
    .alert-message {
        font-size: 16px;
        padding: 10px;
        border-radius: 5px;
    }
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Component/navbar.jsp"%>

	<!-- Category -->
	<div class="container">
		<%@include file="Component/alertmessage.jsp"%>
		<table class="table table-hover">
			<tr class="table-primary text-center" style="font-size: 20px;">
				<th>Image</th>
				<th>Category Name</th>
				<th>Action</th>
			</tr>
			<%
			for (Category c : categoryList) {
			%>
			<tr class="text-center">
				<td><img src="Product_imgs\<%=c.getCategoryImage()%>"
					style="width: 60px; height: 60px; width: auto;"></td>
				<td><%=c.getCategoryName()%></td>
				<td>
					<a href="update_category.jsp?cid=<%=c.getCategoryId()%>" role="button" class="btn btn-secondary">Update</a>
					&emsp;
					<a href="AddOperationServlet?cid=<%=c.getCategoryId()%>&operation=deleteCategory"
					   class="btn btn-danger" role="button">Delete</a>
				</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
</body>
</html>
