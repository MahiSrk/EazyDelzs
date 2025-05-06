<%@page import="com.eazydelzs.entities.Message"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<title>Update Category</title>
<%@include file="Component/css_js.jsp"%>
<style>
	body {
		background-color: #f4f6f9;
	}

	.card {
		border: none;
		border-radius: 12px;
		box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
	}

	.card-header {
		background-color: #007bff;
		color: white;
		border-top-left-radius: 12px;
		border-top-right-radius: 12px;
	}

	.card-body label {
		font-weight: 600;
		font-size: 15px;
	}

	.card-footer {
		background-color: #f8f9fa;
		border-bottom-left-radius: 12px;
		border-bottom-right-radius: 12px;
	}

	.form-control {
		border-radius: 8px;
	}

	img {
		border-radius: 8px;
		border: 1px solid #dee2e6;
	}
</style>
</head>
<body>
	<%@include file="Component/navbar.jsp"%>

	<%
	int cid = Integer.parseInt(request.getParameter("cid"));
	Category category = catDao.getCategoryById(cid);
	%>

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card">
					<div class="card-header text-center">
						<h3>Edit Category</h3>
					</div>
					<form action="AddOperationServlet?cid=<%=cid%>" method="post" enctype="multipart/form-data">
						<div class="card-body p-4">
							<input type="hidden" name="operation" value="updateCategory">
							<div class="mb-3">
								<label class="form-label">Category Name</label>
								<input type="text" name="category_name" value="<%=category.getCategoryName()%>" class="form-control">
							</div>
							<div class="mb-3">
								<label class="form-label">Category Image</label>
								<input class="form-control" type="file" name="category_img">
							</div>
							<div class="mb-3">
								<label class="form-label">Uploaded Image:</label>
								<div class="d-flex align-items-center mt-2">
									<span class="me-3"><%=category.getCategoryImage()%></span>
									<img src="Product_imgs/<%=category.getCategoryImage()%>" style="width: 80px; height: 80px;">
								</div>
								<input type="hidden" name="image" value="<%=category.getCategoryImage()%>">
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
</body>
</html>
