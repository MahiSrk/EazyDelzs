<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Login</title>
<%@include file="Component/css_js.jsp"%>
<style>
    body {
        background-color: #f4f9fd; /* Soft light blue background */
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    label {
        font-weight: bold;
        color: #333;
    }

    .card {
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        background-color: #ffffff;
        padding: 30px;
    }

    .card-header {
        text-align: center;
        border-bottom: 2px solid #f0f0f0;
        padding-bottom: 20px;
    }

    .card-header h3 {
        font-size: 2rem;
        color: #4a90e2; /* Soft blue for header */
    }

    .form-control {
        border-radius: 10px;
        padding: 15px;
        border: 1px solid #ddd;
        font-size: 1rem;
    }

    .form-control:focus {
        outline: none;
        border-color: #4a90e2; /* Highlight on focus */
        box-shadow: 0 0 5px rgba(74, 144, 226, 0.5);
    }

    .btn-outline-primary {
        padding: 12px 25px;
        font-weight: bold;
        border-radius: 25px;
        background-color: #4a90e2; /* Soft blue button */
        color: white;
        border: none;
        transition: background-color 0.3s ease;
    }

    .btn-outline-primary:hover {
        background-color: #357ab7; /* Slightly darker blue on hover */
    }

    .container-fluid {
        margin-top: 100px;
    }

    .text-center h6 {
        font-size: 1rem;
        color: #777;
    }

    .text-center a {
        color: #4a90e2;
        text-decoration: none;
        font-weight: bold;
    }

    .text-center a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
    <!--navbar -->
    <%@include file="Component/navbar.jsp"%>

    <div class="container-fluid">
        <div class="row justify-content-center align-items-center" style="min-height: 80vh;">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <img src="Images/administrator.webp" class="img-fluid mb-2" style="max-width: 80px;">
                        <h3>Admin Login</h3>
                        <%@include file="Component/alertmessage.jsp"%>
                    </div>
                    <div class="card-body">
                        <!--login-form-->
                        <form id="login-form" action="LoginServlet" method="post">
                            <input type="hidden" name="login" value="admin"> 

                            <div class="mb-4">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" id="email" name="email" placeholder="Email address" class="form-control" required>
                            </div>

                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" id="password" name="password" placeholder="Enter your password" class="form-control" required>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-outline-primary">Login</button>
                            </div>
                        </form>
                    </div>  
                </div>
            </div>
        </div>
    </div>
</body>
</html>
