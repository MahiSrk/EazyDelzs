<%@page import="com.eazydelzs.dao.ProductDao"%>
<%@page import="com.eazydelzs.entities.Product"%>
<%@page import="com.eazydelzs.helper.ConnectionProvider"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
    List<Product> productList = productDao.getAllLatestProducts();
    List<Product> topDeals = productDao.getDiscountedProducts();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - EasyDelzs</title>
    <%@include file="Component/css_js.jsp"%>
    <style>
        .cus-card {
            border-radius: 15px;
            border-color: transparent;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .cus-card:hover {
            transform: translateY(-10px);
        }

        .real-price {
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }

        .product-price {
            font-size: 17px;
            text-decoration: line-through;
            color: #999;
        }

        .product-discount {
            font-size: 15px;
            color: #27ae60;
        }

        .carousel-inner img {
            width: 100%;
            height: auto;
        }

        .category-card img {
            max-width: 100%;
            max-height: 120px;
            object-fit: contain;
        }

        .category-card h6 {
            font-size: 16px;
            margin-top: 10px;
        }

        body {
            background: #e3f2fd; /* Light Blue background */
        }

        .category-card {
            background-color: #f9f9f9; /* Light grey background for categories */
            border-radius: 15px;
        }

        h2 {
            color: #6f42c1; /* Light Purple */
            font-weight: 600;
            letter-spacing: 1px;
        }
        
    </style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Component/navbar.jsp"%>

    <!-- Category List -->
    <div class="container-fluid py-5 bg-light">
        <div class="row row-cols-2 row-cols-md-4 g-4">
            <%
                for (Category c : categoryList) {
            %>
            <div class="col">
                <a href="products.jsp?category=<%=c.getCategoryId()%>" class="text-decoration-none">
                    <div class="card cus-card category-card">
                        <img src="Product_imgs/<%=c.getCategoryImage()%>" alt="<%=c.getCategoryName()%>">
                        <h6 class="text-center"><%=c.getCategoryName()%></h6>
                    </div>
                </a>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Carousel -->
    <div id="carouselAutoplaying" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="Images/scroll_img2.png" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="Images/scroll_img1.png" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="Images/scroll_img3.png" class="d-block w-100" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselAutoplaying" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselAutoplaying" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <!-- Latest Products Section -->
    <div class="container py-5">
        <h2 class="text-center mb-4">Latest Products</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <%
                for (int i = 0; i < Math.min(3, productList.size()); i++) {
            %>
            <div class="col">
                <a href="viewProduct.jsp?pid=<%=productList.get(i).getProductId()%>" class="text-decoration-none">
                    <div class="card cus-card">
                        <img src="Product_imgs/<%=productList.get(i).getProductImages()%>" class="card-img-top" alt="<%=productList.get(i).getProductName()%>">
                        <div class="card-body">
                            <h5 class="card-title text-center"><%=productList.get(i).getProductName()%></h5>
                            <div class="text-center">
                                <span class="real-price">&#8377;<%=productList.get(i).getProductPriceAfterDiscount()%></span>
                                <span class="product-price">&#8377;<%=productList.get(i).getProductPrice()%></span>
                                <span class="product-discount"><%=productList.get(i).getProductDiscount()%>&#37; off</span>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Hot Deals Section -->
    <div class="container py-5 bg-light">
        <h2 class="text-center mb-4">Hot Deals</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <%
                for (int i = 0; i < Math.min(4, topDeals.size()); i++) {
            %>
            <div class="col">
                <a href="viewProduct.jsp?pid=<%=topDeals.get(i).getProductId()%>" class="text-decoration-none">
                    <div class="card cus-card">
                        <img src="Product_imgs/<%=topDeals.get(i).getProductImages()%>" class="card-img-top" alt="<%=topDeals.get(i).getProductName()%>">
                        <div class="card-body">
                            <h5 class="card-title text-center"><%=topDeals.get(i).getProductName()%></h5>
                            <div class="text-center">
                                <span class="real-price">&#8377;<%=topDeals.get(i).getProductPriceAfterDiscount()%></span>
                                <span class="product-price">&#8377;<%=topDeals.get(i).getProductPrice()%></span>
                                <span class="product-discount"><%=topDeals.get(i).getProductDiscount()%>&#37; off</span>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Success Order Confirmation Message -->
    <%
        String order = (String) session.getAttribute("order");
        if (order != null) {
    %>
    <script type="text/javascript">
        Swal.fire({
            icon: 'success',
            title: 'Order Placed, Thank you!',
            text: 'Confirmation will be sent to <%=user.getUserEmail()%>',
            width: 600,
            padding: '3em',
            showConfirmButton: false,
            timer: 3500,
            backdrop: 'rgba(0,0,123,0.4)'
        });
    </script>
    <%
        }
        session.removeAttribute("order");
    %>
</body>
</html>
