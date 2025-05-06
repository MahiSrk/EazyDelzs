<%@page import="com.eazydelzs.dao.WishlistDao"%>
<%@page import="com.eazydelzs.entities.User"%>
<%@page import="com.eazydelzs.dao.CategoryDao"%>
<%@page import="com.eazydelzs.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydelzs.helper.ConnectionProvider"%>
<%@page import="com.eazydelzs.dao.ProductDao"%>
<%
User u = (User) session.getAttribute("activeUser");
WishlistDao wishlistDao = new WishlistDao(ConnectionProvider.getConnection());

String searchKey = request.getParameter("search");
String catId = request.getParameter("category");
CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
String message = "";

ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
List<Product> prodList = null;
if (searchKey != null) {
	if (!searchKey.isEmpty()) {
		message = "Showing results for \"" + searchKey + "\"";
	}else{
		message = "No product found!";
	}
	prodList = productDao.getAllProductsBySearchKey(searchKey);

} else if (catId != null && !(catId.trim().equals("0"))) {
	prodList = productDao.getAllProductsByCategoryId(Integer.parseInt(catId.trim()));
	message = "Showing results for \"" + categoryDao.getCategoryName(Integer.parseInt(catId.trim())) + "\"";
} else {
	prodList = productDao.getAllProducts();
	message = "All Products";
}

if (prodList != null && prodList.size() == 0) {
	message = "No items are available for \"" + (searchKey != null ? searchKey : categoryDao.getCategoryName(Integer.parseInt(catId.trim()))) + "\"";
	prodList = productDao.getAllProducts();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Products</title>
<%@include file="Component/css_js.jsp"%>
<style>
	body {
		background: linear-gradient(to right, #f8f9fa, #e0f7fa);
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	}

	h4.text-center {
		color: #007b83;
		font-weight: 600;
		margin-top: 20px;
	}

	.card {
		border: none;
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		transition: transform 0.2s;
		border-radius: 15px;
		background-color: #ffffff;
	}

	.card:hover {
		transform: scale(1.02);
		box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
	}

	.card-img-top {
		border-radius: 10px;
		object-fit: contain;
		background-color: #f1f1f1;
		padding: 10px;
		max-height: 200px;
	}

	.real-price {
		font-size: 22px !important;
		font-weight: 700;
		color: #2c3e50;
	}

	.product-price {
		font-size: 16px !important;
		text-decoration: line-through;
		color: #a4a4a4;
	}

	.product-discount {
		font-size: 15px !important;
		color: #28a745;
		font-weight: 600;
	}

	.wishlist-icon {
		cursor: pointer;
		position: absolute;
		right: 10px;
		top: 10px;
		width: 36px;
		height: 36px;
		border-radius: 50%;
		background: #fff;
		box-shadow: 0 2px 6px rgba(0, 0, 0, .1);
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.btn-primary {
		background-color: #007b83;
		border-color: #007b83;
		border-radius: 30px;
		padding: 6px 18px;
	}

	.btn-primary:hover {
		background-color: #005f63;
		border-color: #005f63;
	}

	.container-fluid {
		margin-top: 20px;
	}
</style>
</head>
<body>
	<%@include file="Component/navbar.jsp"%>

	<h4 class="text-center"><%=message%></h4>
	<div class="container-fluid px-5 pb-4">
		<div class="row row-cols-1 row-cols-md-4 g-4">
			<%
			for (Product p : prodList) {
			%>
			<div class="col">
				<div class="card h-100 px-2 py-3 position-relative">
					<div class="container text-center">
						<img src="Product_imgs/<%=p.getProductImages()%>" class="card-img-top">
						<div class="wishlist-icon">
							<%
							if (u != null) {
								if (wishlistDao.getWishlist(u.getUserId(), p.getProductId())) {
							%>
							<button
								onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=remove', '_self')"
								class="btn btn-link" type="submit">
								<i class="fa-sharp fa-solid fa-heart" style="color: #ff0303;"></i>
							</button>
							<%
							} else {
							%>
							<button type="submit"
								onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=add', '_self')"
								class="btn btn-link">
								<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
							</button>
							<%
							}
							} else {
							%>
							<button onclick="window.open('login.jsp', '_self')"
								class="btn btn-link" type="submit">
								<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
							</button>
							<%
							}
							%>
						</div>

						<h5 class="card-title mt-2"><%=p.getProductName()%></h5>
						<div class="container text-center">
							<span class="real-price">&#8377;<%=p.getProductPriceAfterDiscount()%></span>&ensp;
							<span class="product-price">&#8377;<%=p.getProductPrice()%></span>&ensp;
							<span class="product-discount"><%=p.getProductDiscount()%>&#37; off</span>
						</div>
						<div class="container text-center mt-3">
							<button type="button"
								onclick="window.open('viewProduct.jsp?pid=<%=p.getProductId()%>', '_self')"
								class="btn btn-primary text-white">View Details</button>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>
