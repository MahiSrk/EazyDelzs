<%@page import="com.eazydelzs.entities.Message"%>
<%@page import="com.eazydelzs.entities.Product"%>
<%@page import="com.eazydelzs.dao.ProductDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
<title>Update Product</title>
<%@include file="Component/css_js.jsp"%>
<style>
	.card {
		box-shadow: 0 4px 20px rgba(0,0,0,0.1);
		border-radius: 15px;
	}
	.card-header {
		background: #0d6efd;
		color: white;
		border-radius: 15px 15px 0 0;
		padding: 1.2rem;
	}
	.form-label {
		font-weight: 600;
		color: #333;
	}
	.card-footer {
		background-color: #f8f9fa;
		border-top: 1px solid #dee2e6;
		border-radius: 0 0 15px 15px;
	}
	textarea.form-control {
		resize: none;
	}
</style>
</head>
<body>
	<%@include file="Component/navbar.jsp"%>

	<%
	int pid = Integer.parseInt(request.getParameter("pid"));
	ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
	Product product = productDao.getProductsByProductId(pid);
	%>

	<div class="container mt-4">
		<div class="row justify-content-center">
			<div class="col-lg-8 col-md-10">
				<div class="card">
					<div class="card-header text-center">
						<h3>Edit Product</h3>
					</div>
					<form action="AddOperationServlet?pid=<%=pid%>" method="post"
						name="updateProductForm" enctype="multipart/form-data">
						<div class="card-body">
							<input type="hidden" name="operation" value="updateProduct">

							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label">Product Name</label>
									<input type="text" name="name" value="<%=product.getProductName()%>" class="form-control">
								</div>
								<div class="col-md-6">
									<label class="form-label">Unit Price</label>
									<input type="number" name="price" value="<%=product.getProductPrice()%>" class="form-control" required>
								</div>
							</div>

							<div class="mb-3">
								<label class="form-label">Product Description</label>
								<textarea class="form-control" name="description" rows="3"><%=product.getProductDescription()%></textarea>
							</div>

							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label">Product Quantity</label>
									<input type="number" name="quantity" value="<%=product.getProductQunatity()%>" class="form-control">
								</div>
								<div class="col-md-6">
									<label class="form-label">Discount Percentage</label>
									<input type="number" name="discount" onblur="validate()" value="<%=product.getProductDiscount()%>" class="form-control">
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label">Product Image</label>
									<input type="file" name="product_img" class="form-control">
								</div>
								<div class="col-md-6">
									<label class="form-label">Select Category Type</label>
									<select name="categoryType" class="form-control">
										<option value="0">--Select Category--</option>
										<%
										for (Category c : categoryList) {
										%>
										<option value="<%=c.getCategoryId()%>"><%=c.getCategoryName()%></option>
										<%
										}
										%>
									</select>
									<input type="hidden" name="category" value="<%=product.getCategoryId()%>">
								</div>
							</div>

							<div class="mb-3">
								<label class="form-label">Uploaded Image</label><br>
								<span class="text-muted"><%=product.getProductImages()%></span>
								<img src="Product_imgs\<%=product.getProductImages()%>" class="img-thumbnail ms-3" style="height: 80px; width: auto;">
								<input type="hidden" name="image" value="<%=product.getProductImages()%>">
							</div>
						</div>

						<div class="card-footer text-center">
							<button type="submit" class="btn btn-lg btn-primary px-4">Update</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function validate() {
			var dis = document.updateProductForm.discount.value;
			if (dis > 100 || dis < 0) {
				alert("Discount needs to be between 0–100!");
				return false;
			}
		}
	</script>
</body>
</html>
