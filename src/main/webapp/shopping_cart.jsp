<%@page import="com.eazydelzs.entities.Message"%>
<%@page import="com.eazydelzs.entities.Product"%>
<%@page import="com.eazydelzs.dao.ProductDao"%>
<%@page import="com.eazydelzs.entities.Cart"%>
<%@page import="com.eazydelzs.dao.CartDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
User activeUser = (User) session.getAttribute("activeUser");
if (activeUser == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shopping Cart</title>
<%@include file="Component/css_js.jsp"%>
<style type="text/css">
.qty {
	display: inline-block;
	padding: 3px 6px;
	width: 46px;
	height: 32px;
	border-radius: 4px;
	background-color: #fff;
	border: 1px solid #c2c2c2;
	margin: 0 5px;
	line-height: 24px;
	text-align: center;
	font-weight: bold;
}
.cart-img {
	width: 60px;
	height: 60px;
	object-fit: contain;
}
.table td, .table th {
	vertical-align: middle;
}
.card {
	box-shadow: 0 4px 12px rgba(0,0,0,0.1);
	border-radius: 10px;
}
.btn-light {
	border: 1px solid #ccc;
}
</style>
</head>
<body>
	<%@include file="Component/navbar.jsp"%>

	<%
	float totalPrice = 0;
	CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
	List<Cart> listOfCart = cartDao.getCartListByUserId(user.getUserId());
	if (listOfCart == null || listOfCart.size() == 0) {
	%>
	<div class="container text-center py-5 px-5">
		<img src="Images/empty-cart.png" class="img-fluid mb-3" style="max-width: 250px;">
		<h4 class="mb-2">Your cart is empty!</h4>
		<p class="text-muted">Add items to it now.</p>
		<a href="products.jsp" class="btn btn-primary btn-lg">Shop Now</a>
	</div>
	<%
	} else {
	%>

	<div class="container mt-5">
		<%@include file="Component/alertmessage.jsp"%>
		<div class="card p-4">
			<h4 class="mb-3">Your Cart</h4>
			<div class="table-responsive">
				<table class="table table-hover align-middle">
					<thead class="table-primary text-center">
						<tr style="font-size: 17px;">
							<th>Item</th>
							<th>Item Name</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Total Price</th>
							<th>Remove</th>
						</tr>
					</thead>
					<tbody>
						<%
						ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
						for (Cart c : listOfCart) {
							Product prod = productDao.getProductsByProductId(c.getProductId());
						%>
						<tr class="text-center">
							<td><img src="Product_imgs/<%=prod.getProductImages()%>" class="cart-img"></td>
							<td class="text-start"><%=prod.getProductName()%></td>
							<td>&#8377;<%=prod.getProductPriceAfterDiscount()%></td>
							<td>
								<a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=1" class="btn btn-light btn-sm rounded-circle">
									<i class="fa-regular fa-plus"></i>
								</a>
								<span class="qty"><%=c.getQuantity()%></span>
								<%
								if(c.getQuantity() > 1){
								%>
								<a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=2" class="btn btn-light btn-sm rounded-circle">
									<i class="fa-solid fa-minus"></i>
								</a>
								<%} else { %>
								<a href="#" class="btn btn-light btn-sm rounded-circle disabled">
									<i class="fa-solid fa-minus"></i>
								</a>
								<%} %>
							</td>
							<td>&#8377;<%=c.getQuantity() * prod.getProductPriceAfterDiscount()%></td>
							<td>
								<a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=3" class="btn btn-outline-danger btn-sm">Remove</a>
							</td>
						</tr>
						<%
						totalPrice += c.getQuantity() * prod.getProductPriceAfterDiscount();
						}
						%>
						<tr>
							<td colspan="6" class="text-end">
								<h5 class="pe-3">Total Amount: <strong>&#8377;<%=totalPrice%></strong></h5>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="text-end mt-3">
				<a href="products.jsp" class="btn btn-outline-primary me-2">Continue Shopping</a>
				<a href="checkout.jsp" id="checkout-btn" class="btn btn-primary">Checkout</a>
			</div>
		</div>
	</div>
	<%
	}
	%>

	<script>
		$(document).ready(function(){
			$('#checkout-btn').click(function(){
			<%
			session.setAttribute("totalPrice", totalPrice);
			session.setAttribute("from", "cart");
			%>	
			});
		});
	</script>
</body>
</html>
