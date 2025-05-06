<%@page import="com.eazydelzs.entities.Message"%>
<%@page import="com.eazydelzs.entities.User"%>
<%
User user1 = (User) session.getAttribute("activeUser");
if (user1 == null) {
    Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
    session.setAttribute("message", message);
    response.sendRedirect("login.jsp");
    return;
}
%>

<style>
    label {
        font-weight: bold;
    }
    .form-control {
        border-radius: 0.375rem;
    }
    .form-check-input {
        margin-right: 10px;
    }
    .form-group {
        margin-bottom: 1.5rem;
    }
    .btn-custom {
        width: 120px;
        margin: 5px;
    }
</style>

<div class="container px-3 py-3">
    <h3 class="mb-4">Personal Information</h3>
    <form id="update-user" action="UpdateUserServlet" method="post">
        <input type="hidden" name="operation" value="updateUser">
        
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="form-label">Your Name</label>
                    <input type="text" name="name" class="form-control" placeholder="First and last name" value="<%=user1.getUserName()%>">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" placeholder="Email address" value="<%=user1.getUserEmail()%>">
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="form-label">Mobile Number</label>
                    <input type="number" name="mobile_no" class="form-control" placeholder="Mobile number" value="<%=user1.getUserPhone()%>">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="form-label pe-3">Gender</label>
                    <div>
                        <input class="form-check-input" type="radio" name="gender" value="Male" <%=user1.getUserGender().equals("Male") ? "checked" : ""%>> 
                        <span class="form-check-label"> Male </span>
                        <input class="form-check-input" type="radio" name="gender" value="Female" <%=user1.getUserGender().equals("Female") ? "checked" : ""%>> 
                        <span class="form-check-label"> Female </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">Address</label>
            <input type="text" name="address" class="form-control" placeholder="Enter Address (Area and Street)" value="<%=user1.getUserAddress()%>">
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label class="form-label">City</label>
                    <input class="form-control" type="text" name="city" placeholder="City/District/Town" value="<%=user1.getUserCity()%>">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label class="form-label">Pincode</label>
                    <input class="form-control" type="number" name="pincode" placeholder="Pincode" maxlength="6" value="<%=user1.getUserPincode()%>">
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">State</label>
            <div class="input-group">
                <input class="form-control" type="text" value="<%=user1.getUserState()%>" readonly>
                <select name="state" id="state-list" class="form-select">
                    <option selected>--Select State--</option>
                    <option value="Andaman & Nicobar Islands">Andaman & Nicobar Islands</option>
                    <option value="Andhra Pradesh">Andhra Pradesh</option>
                    <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                    <option value="Assam">Assam</option>
                    <option value="Bihar">Bihar</option>
                    <option value="Chandigarh">Chandigarh</option>
                    <option value="Chhattisgarh">Chhattisgarh</option>
                    <option value="Dadra & Nagar Haveli & Daman & Diu">Dadra & Nagar Haveli & Daman & Diu</option>
                    <option value="Delhi">Delhi</option>
                    <option value="Goa">Goa</option>
                    <option value="Gujarat">Gujarat</option>
                    <option value="Haryana">Haryana</option>
                    <option value="Himachal Pradesh">Himachal Pradesh</option>
                    <option value="Jammu & Kashmir">Jammu & Kashmir</option>
                    <option value="Jharkhand">Jharkhand</option>
                    <option value="Karnataka">Karnataka</option>
                    <option value="Kerala">Kerala</option>
                    <option value="Ladakh">Ladakh</option>
                    <option value="Lakshadweep">Lakshadweep</option>
                    <option value="Madhya Pradesh">Madhya Pradesh</option>
                    <option value="Maharashtra">Maharashtra</option>
                    <option value="Manipur">Manipur</option>
                    <option value="Meghalaya">Meghalaya</option>
                    <option value="Mizoram">Mizoram</option>
                    <option value="Nagaland">Nagaland</option>
                    <option value="Odisha">Odisha</option>
                    <option value="Puducherry">Puducherry</option>
                    <option value="Punjab">Punjab</option>
                    <option value="Rajasthan">Rajasthan</option>
                    <option value="Sikkim">Sikkim</option>
                    <option value="Tamil Nadu">Tamil Nadu</option>
                    <option value="Telangana">Telangana</option>
                    <option value="Tripura">Tripura</option>
                    <option value="Uttarakhand">Uttarakhand</option>
                    <option value="Uttar Pradesh">Uttar Pradesh</option>
                    <option value="West Bengal">West Bengal</option>
                </select>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-outline-primary btn-custom">Update</button>
            <button type="reset" class="btn btn-outline-secondary btn-custom">Reset</button>
        </div>
    </form>
</div>
