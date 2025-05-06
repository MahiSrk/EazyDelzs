<%@page import="com.eazydelzs.entities.Admin"%>
<%@page import="com.eazydelzs.entities.Cart"%>
<%@page import="com.eazydelzs.dao.CartDao"%>
<%@page import="com.eazydelzs.entities.User"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydelzs.entities.Category"%>
<%@page import="com.eazydelzs.helper.ConnectionProvider"%>
<%@page import="com.eazydelzs.dao.CategoryDao"%>
<%
User user = (User) session.getAttribute("activeUser");
Admin admin = (Admin) session.getAttribute("activeAdmin");

CategoryDao catDao = new CategoryDao(ConnectionProvider.getConnection());
List<Category> categoryList = catDao.getAllCategories();
%>

<style>
    .navbar {
        font-weight: 500;
        background-color: #003366; /* Deep Navy Blue */
    }

    .nav-link {
        color: #e0f7fa !important; /* Light Teal */
        padding: 10px 15px;
        transition: background-color 0.3s ease;
    }

    .nav-link:hover {
        background-color: #005f73; /* Dark Teal */
    }

    .dropdown-menu {
        background-color: #ffffff !important;
        border-color: #007b8a; /* Teal Border */
    }

    .dropdown-item {
        padding: 10px 20px;
    }

    .dropdown-item:hover {
        background-color: #007b8a !important; /* Teal */
        color: white;
    }

    .navbar-toggler-icon {
        color: #e0f7fa;
    }

    .navbar-nav .nav-item {
        margin-right: 10px;
    }

    .navbar-nav .nav-item.active {
        font-weight: bold;
    }

    .cart-count-badge {
        position: absolute;
        top: -5px;
        right: -10px;
        background-color: #ff6f61; /* Coral Red */
        color: white;
        font-size: 12px;
        padding: 5px 8px;
        border-radius: 50%;
    }

    .form-control {
        width: 300px;
        border-radius: 20px;
    }

    .btn-outline-light {
        border-radius: 20px;
        border-color: #e0f7fa;
        color: #e0f7fa;
    }

    .btn-outline-light:hover {
        background-color: #e0f7fa;
        color: #003366;
    }

    .navbar-brand {
        font-weight: bold;
        font-size: 24px;
        color: #e0f7fa !important;
    }
</style>

<nav class="navbar navbar-expand-lg">
    <!-- admin nav bar -->
    <%
    if (admin != null) {
    %>
    <div class="container">
        <a class="navbar-brand" href="admin_dashboard.jsp"><i class="fa-sharp fa-solid fa-house" style="color: #ffffff;"></i>&ensp;EazyDelzs</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <div class="container text-end">
                <ul class="navbar-nav justify-content-end">
                    <li class="nav-item"><button type="button" class="btn nav-link" data-bs-toggle="modal" data-bs-target="#add-category"><i class="fa-solid fa-plus fa-xs"></i>Add Category</button></li>
                    <li class="nav-item"><button type="button" class="btn nav-link" data-bs-toggle="modal" data-bs-target="#add-product"><i class="fa-solid fa-plus fa-xs"></i>Add Product</button></li>
                    <li class="nav-item"><a class="nav-link" aria-current="page" href="admin_dashboard.jsp"><%=admin.getName()%></a></li>
                    <li class="nav-item"><a class="nav-link" aria-current="page" href="LogoutServlet?user=admin"><i class="fa-solid fa-user-slash fa-sm" style="color: #fafafa;"></i>&nbsp;Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
    <%
    } else {
    %>
    <!-- For regular users -->
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><i class="fa-sharp fa-solid fa-house" style="color: #ffffff;"></i>&ensp;EazyDelzs</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="products.jsp">Products</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">Category</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="products.jsp?category=0">All Products</a></li>
                        <%
                        for (Category c : categoryList) {
                        %>
                        <li><a class="dropdown-item" href="products.jsp?category=<%=c.getCategoryId()%>"><%=c.getCategoryName()%></a></li>
                        <%
                        }
                        %>
                    </ul>
                </li>
            </ul>
            <form class="d-flex pe-5" role="search" action="products.jsp" method="get">
                <input name="search" class="form-control me-2" type="search" placeholder="Search for products" aria-label="Search">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </form>

            <!-- when user is logged in -->
            <%
            if (user != null) {
                CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                int cartCount = cartDao.getCartCountByUserId(user.getUserId());
            %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active pe-3">
                    <a class="nav-link position-relative" href="cart.jsp">
                        <i class="fa-solid fa-cart-shopping" style="color: #ffffff;"></i>
                        <span class="cart-count-badge"><%=cartCount%></span>
                    </a>
                </li>
                <li class="nav-item active pe-3"><a class="nav-link" href="profile.jsp"><%=user.getUserName()%></a></li>
                <li class="nav-item pe-3"><a class="nav-link" href="LogoutServlet?user=user"><i class="fa-solid fa-user-slash" style="color: #fafafa;"></i>&nbsp;Logout</a></li>
            </ul>
            <%
            } else {
            %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active pe-2"><a class="nav-link" href="register.jsp"><i class="fa-solid fa-user-plus" style="color: #ffffff;"></i>&nbsp;Register</a></li>
                <li class="nav-item pe-2"><a class="nav-link" href="login.jsp"><i class="fa-solid fa-user-lock" style="color: #fafafa;"></i>&nbsp;Login</a></li>
                <li class="nav-item pe-2"><a class="nav-link" href="admin_login.jsp">&nbsp;Admin</a></li>
            </ul>
            <%
            }
            %>
        </div>
    </div>
    <%
    }
    %>
</nav>
