<%@page import="com.eazydelzs.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_exception.jsp"%>
<%@page import="com.eazydelzs.dao.UserDao"%>
<%@page import="com.eazydelzs.entities.Product"%>
<%@page import="com.eazydelzs.dao.ProductDao"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
    Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
    session.setAttribute("message", message);
    response.sendRedirect("adminlogin.jsp");
    return;
}
UserDao userDao = new UserDao(ConnectionProvider.getConnection());
ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Product's</title>
<%@include file="Component/css_js.jsp"%>

<!-- Custom CSS for improved UI -->
<style>
    /* Styling for the table and its cells */
    table {
        width: 100%;
        margin-top: 20px;
        border-collapse: collapse;
    }

    th, td {
        padding: 12px 15px;
        text-align: center;
        border: 1px solid #ddd;
    }

    th {
        background-color: #4CAF50;
        color: white;
        font-size: 18px;
    }

    td {
        background-color: #f9f9f9;
        font-size: 16px;
        color: #333;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    /* Styling for the table rows */
    .text-start {
        text-align: left;
    }

    .btn-secondary, .btn-danger {
        font-size: 14px;
        padding: 8px 16px;
        text-transform: uppercase;
        border-radius: 5px;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .btn-secondary {
        background-color: #6c757d;
        color: white;
        border: none;
    }

    .btn-danger {
        background-color: #dc3545;
        color: white;
        border: none;
    }

    /* Button hover effects */
    .btn-secondary:hover {
        background-color: #5a6268;
        transform: scale(1.05);
    }

    .btn-danger:hover {
        background-color: #c82333;
        transform: scale(1.05);
    }

    /* Styling for the product image */
    img {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 8px;
    }

    /* Add some spacing for overall body and tables */
    .container {
        padding: 20px;
    }

    /* Responsive table design */
    @media screen and (max-width: 768px) {
        table {
            font-size: 14px;
        }

        th, td {
            padding: 8px;
        }

        .btn {
            font-size: 12px;
            padding: 6px 12px;
        }

        img {
            width: 50px;
            height: 50px;
        }
    }
</style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Component/navbar.jsp"%>

    <!-- Update product -->
    <div class="container mt-3">
        <%@include file="Component/alertmessage.jsp"%>
        <table class="table table-hover">
            <tr class="table-primary text-center" style="font-size: 20px;">
                <th>Image</th>
                <th>Name</th>
                <th class="text-start">Category</th>
                <th>Price</th>
                <th class="text-start">Quantity</th>
                <th class="text-start">Discount</th>
                <th>Action</th>
            </tr>
            <%
            List<Product> productList = productDao.getAllProducts();
            for (Product prod : productList) {
                String category = catDao.getCategoryName(prod.getCategoryId());
            %>
            <tr class="text-center">
                <td><img src="Product_imgs\<%=prod.getProductImages()%>"></td>
                <td class="text-start"><%=prod.getProductName()%></td>
                <td><%=category%></td>
                <td>&#8377;<%=prod.getProductPriceAfterDiscount()%></td>
                <td><%=prod.getProductQunatity()%></td>
                <td><%=prod.getProductDiscount()%>%</td>
                <td>
                    <a href="update_product.jsp?pid=<%=prod.getProductId()%>" role="button" class="btn btn-secondary">Update</a>&emsp;
                    <a href="AddOperationServlet?pid=<%=prod.getProductId()%>&operation=deleteProduct" class="btn btn-danger" role="button">Delete</a>
                </td>
            </tr>
            <%
            }
            %>
        </table>
    </div>
</body>
</html>

