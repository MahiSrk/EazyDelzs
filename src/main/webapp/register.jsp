<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Registration</title>
    <%@ include file="Component/css_js.jsp"%>
    <style>
        label {
            font-weight: bold;
        }

        body {
            background-color: #f2f7fc; /* Soft light blue background */
        }

        .card {
            border-radius: 15px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            background-color: #ffffff; /* White card for the form */
        }

        .container-fluid {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <!--navbar -->
    <%@ include file="Component/navbar.jsp"%>

    <div class="container-fluid mt-4">
        <div class="row g-0">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-body px-5">

                        <div class="container text-center">
                            <img src="Images/register.jpg" style="max-width: 80px;" class="img-fluid">
                        </div>
                        <h3 class="text-center">Create Account</h3>
                        <%@ include file="Component/alertmessage.jsp"%>

                        <!-- registration-form -->
                        <form id="register-form" action="RegisterServlet" method="post">
                            <div class="row">
                                <div class="col-md-6 mt-2">
                                    <label class="form-label">Your name</label>
                                    <input type="text" name="user_name" class="form-control" placeholder="First and last name" required>
                                </div>
                                <div class="col-md-6 mt-2">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="user_email" placeholder="Email address" class="form-control" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mt-2">
                                    <label class="form-label">Mobile number</label>
                                    <input type="number" name="user_mobile_no" placeholder="Mobile number" class="form-control" required>
                                </div>
                                <div class="col-md-6 mt-2">
                                    <label class="form-label">Gender</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="gender" value="Male" required>
                                        <label class="form-check-label">Male</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="gender" value="Female" required>
                                        <label class="form-check-label">Female</label>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-2">
                                <label class="form-label">Address</label>
                                <input type="text" name="user_address" placeholder="Enter Address(Area and Street)" class="form-control" required>
                            </div>  
                            <div class="row">
                                <div class="col-md-6 mt-2">
                                    <label class="form-label">City</label>
                                    <input class="form-control" type="text" name="city" placeholder="City/District/Town" required>
                                </div>
                                <div class="col-md-6 mt-2">
                                    <label class="form-label">Pincode</label>
                                    <input class="form-control" type="number" name="pincode" placeholder="Pincode" maxlength="6" required>
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col-md-6 mt-2">
                                    <label class="form-label">State</label>
                                    <select name="state" class="form-select" required>
                                        <option selected>--Select State--</option>
                                        <option value="Andaman & Nicobar Islands">Andaman & Nicobar Islands</option>
                                        <option value="Andhra Pradesh">Andhra Pradesh</option>
                                        <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                                        <!-- Add other states here -->
                                    </select>
                                </div>
                                <div class="col-md-6 mt-2">
                                    <label class="form-label">Password</label>
                                    <input type="password" name="user_password" placeholder="Enter Password" class="form-control" required>
                                </div>
                            </div>

                            <div id="submit-btn" class="container text-center mt-4">
                                <button type="submit" class="btn btn-outline-primary me-3">Submit</button>
                                <button type="reset" class="btn btn-outline-primary">Reset</button>
                            </div>
                            <div class="mt-3 text-center">
                                <h6>Already have an account? <a href="login.jsp" style="text-decoration: none">Sign in</a></h6>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
