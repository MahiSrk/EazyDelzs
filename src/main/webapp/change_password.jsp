<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create new password</title>
<%@include file="Component/css_js.jsp"%>
<style>
    body {
        background-color: #f7f7f7;
    }

    label {
        font-weight: 600;
    }

    .card {
        border-radius: 16px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
    }

    .form-control {
        border-radius: 8px;
    }

    .btn {
        padding: 10px 24px;
        font-size: 16px;
        border-radius: 8px;
    }

    h3 {
        font-weight: 700;
        color: #333;
    }

    .card-body {
        padding: 40px 30px;
    }
</style>
</head>
<body>
    <!--navbar -->
    <%@include file="Component/navbar.jsp"%>

    <div class="container-fluid">
        <div class="row mt-5">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body px-4">

                        <div class="container text-center mb-3">
                            <img src="Images/forgot-password.png" style="max-width: 90px;" class="img-fluid mb-2">
                        </div>

                        <h3 class="text-center mb-4">Update Password</h3>

                        <%@include file="Component/alertmessage.jsp"%>

                        <form action="ChangePasswordServlet" method="post">
                            <div class="mb-4">
                                <label class="form-label">New Password</label>
                                <input type="password" name="password" id="password"
                                    placeholder="Enter new password" class="form-control" required>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Confirm Password</label>
                                <input type="password" id="confirm_password"
                                    placeholder="Confirm password" class="form-control" required>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-outline-primary">Submit</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var password = document.getElementById("password");
        var confirm_password = document.getElementById("confirm_password");

        function validatePassword() {
            if (password.value != confirm_password.value) {
                confirm_password.setCustomValidity("Passwords Don't Match");
            } else {
                confirm_password.setCustomValidity('');
            }
        }
        password.onchange = validatePassword;
        confirm_password.onkeyup = validatePassword;
    </script>
</body>
</html>
