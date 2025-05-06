<%@page import="com.eazydelzs.entities.Message"%>
<%@page import="com.eazydelzs.entities.Category"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_exception.jsp"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
    Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
    session.setAttribute("message", message);
    response.sendRedirect("admin_login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Dashboard</title>
    <%@include file="Component/css_js.jsp"%>
</head>
<body>

    <%@include file="Component/navbar.jsp"%>

    <div class="container my-5">
        <%@include file="Component/alertmessage.jsp"%>

        <div class="text-center mb-4">
            <img src="Images/administrator.webp" class="img-fluid rounded-circle mb-3" style="max-width: 150px;">
            <h3 class="fw-bold">Welcome, "<%=activeAdmin.getName()%>"</h3>
        </div>

        <div class="row g-4 justify-content-center">
            <div class="col-md-3">
                <a href="view_category.jsp" class="text-decoration-none">
                    <div class="card text-center p-3">
                        <img src="Images/categories.png" class="img-fluid mx-auto mb-2" style="width: 80px;">
                        <h5 class="fw-semibold">Category</h5>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="view_products.jsp" class="text-decoration-none">
                    <div class="card text-center p-3">
                        <img src="Images/products.png" class="img-fluid mx-auto mb-2" style="width: 80px;">
                        <h5 class="fw-semibold">Products</h5>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="view_orders.jsp" class="text-decoration-none">
                    <div class="card text-center p-3">
                        <img src="Images/order.png" class="img-fluid mx-auto mb-2" style="width: 80px;">
                        <h5 class="fw-semibold">Orders</h5>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="view_users.jsp" class="text-decoration-none">
                    <div class="card text-center p-3">
                        <img src="Images/users.png" class="img-fluid mx-auto mb-2" style="width: 80px;">
                        <h5 class="fw-semibold">Users</h5>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="view_admin.jsp" class="text-decoration-none">
                    <div class="card text-center p-3">
                        <img src="Images/addadmin.jpg" class="img-fluid mx-auto mb-2" style="width: 80px;">
                        <h5 class="fw-semibold">Admin</h5>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <!-- Add Category Modal -->
    <div class="modal fade" id="add-category" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content rounded">
                <div class="modal-header">
                    <h5 class="modal-title">Add Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="AddOperationServlet" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" name="operation" value="addCategory">
                        <div class="mb-3">
                            <label class="form-label">Category Name</label>
                            <input type="text" name="category_name" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category Image</label>
                            <input type="file" name="category_img" class="form-control" id="formFile">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Category</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Product Modal -->
    <div class="modal fade" id="add-product" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content rounded">
                <div class="modal-header">
                    <h5 class="modal-title">Add Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="AddOperationServlet" method="post" name="addProductForm" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" name="operation" value="addProduct">
                        <div class="mb-3">
                            <label class="form-label">Product Name</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Product Description</label>
                            <textarea name="description" class="form-control" rows="3"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Unit Price</label>
                                <input type="number" name="price" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Discount</label>
                                <input type="number" name="discount" class="form-control" onblur="validate()">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Product Quantity</label>
                                <input type="number" name="quantity" class="form-control">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Select Category</label>
                                <select name="categoryType" class="form-select">
                                    <option value="0">--Select Category--</option>
                                    <%
                                    for (Category c : categoryList) {
                                    %>
                                    <option value="<%=c.getCategoryId()%>"><%=c.getCategoryName()%></option>
                                    <%
                                    }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Product Image</label>
                            <input type="file" name="photo" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Product</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function validate() {
            var dis = document.addProductForm.discount.value;
            if (dis > 100 || dis < 0) {
                alert("Discount must be between 0 and 100!");
                return false;
            }
        }
    </script>
</body>
</html>
