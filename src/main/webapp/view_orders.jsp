<%@page import="com.eazydelzs.entities.Message"%>
<%@page import="com.eazydelzs.dao.UserDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.eazydelzs.entities.OrderedProduct"%>
<%@page import="com.eazydelzs.entities.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydelzs.dao.OrderedProductDao"%>
<%@page import="com.eazydelzs.dao.OrderDao"%>
<%@page import="com.eazydelzs.helper.ConnectionProvider"%>

<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
OrderedProductDao ordProdDao = new OrderedProductDao(ConnectionProvider.getConnection());
List<Order> orderList = orderDao.getAllOrder();
UserDao userDao = new UserDao(ConnectionProvider.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Order's</title>
<%@include file="Component/css_js.jsp"%>
<style>
    /* Body and General Styling */
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
    }

    /* Table Styling */
    table {
        width: 100%;
        margin-top: 20px;
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
        border-radius: 5px;
    }

    table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    table tr:hover {
        background-color: #f1f1f1;
    }

    table img {
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    /* Button Styling */
    .btn {
        border-radius: 5px;
        padding: 8px 16px;
        font-size: 16px;
        margin: 5px;
        display: inline-block;
    }

    .btn-secondary {
        background-color: #6c757d;
        border-color: #6c757d;
    }

    .btn-secondary:hover {
        background-color: #5a6268;
        border-color: #545b62;
    }

    .btn-success {
        background-color: #28a745;
        border-color: #28a745;
    }

    .btn-success.disabled {
        background-color: #b3d7b3;
        border-color: #b3d7b3;
    }

    .btn-success:hover {
        background-color: #218838;
        border-color: #1e7e34;
    }

    /* Form and Select Styling */
    .form-select {
        padding: 8px;
        font-size: 16px;
        border-radius: 5px;
        width: 100%;
    }

    /* Empty cart image */
    .empty-cart {
        max-width: 200px;
    }

    /* Alert Message Styling */
    .alert-message {
        font-size: 16px;
        padding: 10px;
        border-radius: 5px;
    }

    /* Container Styles */
    .container-fluid {
        margin-top: 20px;
    }

    .container.mt-5.mb-5 {
        text-align: center;
    }
</style>
</head>
<body>
	<!-- Navbar -->
	<%@include file="Component/navbar.jsp"%>

	<!-- Order Details -->
	<div class="container-fluid px-3 py-3">
		<%
		if (orderList == null || orderList.size() == 0) {
		%>
		<div class="container mt-5 mb-5 text-center">
			<img src="Images/empty-cart.png" class="empty-cart img-fluid">
			<h4 class="mt-3">Zero Orders Found</h4>
		</div>
		<%
		} else {
		%>
		<div class="container-fluid">
			<table class="table table-hover">
				<tr class="table-primary" style="font-size: 18px;">
					<th class="text-center">Product</th>
					<th>Order ID</th>
					<th>Product Details</th>
					<th>Delivery Address</th>
					<th>Date & Time</th>
					<th>Payment Type</th>
					<th>Status</th>
					<th colspan="2" class="text-center">Action</th>
				</tr>
				<%
				for (Order order : orderList) {
					List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
					for (OrderedProduct orderProduct : ordProdList) {
				%>
				<form action="UpdateOrderServlet?oid=<%=order.getId()%>" method="post">
				<tr>
					<td class="text-center"><img src="Product_imgs\<%=orderProduct.getImage()%>" style="width: 50px; height: 50px; width: auto;"></td>
					<td><%=order.getOrderId()%></td>
					<td><%=orderProduct.getName()%><br>Quantity: <%=orderProduct.getQuantity()%><br>Total Price: &#8377;<%=orderProduct.getPrice() * orderProduct.getQuantity()%></td>
					<td><%=userDao.getUserName(order.getUserId())%><br>Mobile No. <%=userDao.getUserPhone(order.getUserId())%><br><%=userDao.getUserAddress(order.getUserId())%></td>
					<td><%=order.getDate()%></td>
					<td><%=order.getPayementType()%></td>
					<td><%=order.getStatus()%></td>
					<td>
						<select id="operation" name="status" class="form-select">
							<option>--Select Operation--</option>
							<option value="Order Confirmed">Order Confirmed</option>
							<option value="Shipped">Shipped</option>
							<option value="Out For Delivery">Out For Delivery</option>
							<option value="Delivered">Delivered</option>
						</select>
					</td>
					<td>
						<%
						if (order.getStatus().equals("Delivered")) {
						%>
						<button type="submit" class="btn btn-success disabled">Update</button>
						<%
						} else {
						%>
						<button type="submit" class="btn btn-secondary">Update</button> 
						<%
						 }
						 %>
					</td>
				</tr>
				</form>
				<%
				}
				}
				%>
			</table>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>
