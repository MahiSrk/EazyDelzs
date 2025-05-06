<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<%@include file="Component/css_js.jsp"%>
<style>
body {
	background: linear-gradient(to right, #e0f7fa, #ffffff);
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

label {
	font-weight: 600;
	color: #333;
}

.card {
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	border: none;
	border-radius: 15px;
	background-color: #ffffff;
}

.card-body {
	padding: 30px;
}

.card-body h3 {
	font-weight: 700;
	color: #007bff;
}

.form-control {
	border-radius: 10px;
	padding: 10px;
	font-size: 15px;
}

.btn-outline-primary {
	border-radius: 10px;
	padding: 10px 25px;
	font-weight: bold;
	font-size: 15px;
	transition: background-color 0.3s ease;
}

.btn-outline-primary:hover {
	background-color: #007bff;
	color: white;
}

a {
	color: #007bff;
	font-weight: 500;
}

a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>  

	<!--navbar -->
	<%@include file="Component/navbar.jsp"%>

	<div class="container-fluid flex-grow-1 d-flex align-items-center justify-content-center">
		<div class="row mt-5 w-100">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body px-4">

						<div class="container text-center mb-3">
							<img src="Images/loginicon.png" style="max-width: 100px;"
								class="img-fluid" alt="Login Icon">
						</div>
						<h3 class="text-center mb-3">Sign-In</h3>
						<%@include file="Component/alertmessage.jsp" %>
						
						<!--login-form-->
						<form id="login-form" action="LoginServlet" method="post">
							<input type="hidden" name="login" value="user"> 
							<div class="mb-3">
								<label class="form-label">Email</label>
								<input type="email" name="user_email" placeholder="Email address"
									class="form-control" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Password</label>
								<input type="password" name="user_password"
									placeholder="Enter your password" class="form-control" required>
							</div>
							<div id="login-btn" class="container text-center mt-3">
								<button type="submit" class="btn btn-outline-primary me-3">Login</button>
							</div>
						</form>
						<div class="mt-4 text-center">
							<h6>
								Don't have an account? <a href="register.jsp">Sign Up</a>
							</h6>
						</div>
					</div>  
				</div>
			</div>
		</div>
	</div>
</body>
</html>
