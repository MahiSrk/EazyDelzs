<%@page import="com.eazydelzs.entities.Message"%>
<%@page import="com.eazydelzs.entities.Product"%>
<%@page import="com.eazydelzs.dao.ProductDao"%>
<%@page import="com.eazydelzs.entities.Wishlist"%>
<%@page import="java.util.List"%>
<%@page errorPage="error_exception.jsp"%>
<%@page import="com.eazydelzs.entities.User"%>
<%@page import="com.eazydelzs.helper.ConnectionProvider"%>
<%@page import="com.eazydelzs.dao.WishlistDao"%>

<%
    // Check if the user is logged in
    User u1 = (User) session.getAttribute("activeUser");
    if (u1 == null) {
        Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("login.jsp");
        return;  
    }

    // Get the wishlist for the logged-in user
    WishlistDao wishListDao = new WishlistDao(ConnectionProvider.getConnection());
    List<Wishlist> wlist = wishListDao.getListByUserId(u1.getUserId());
    
    // ProductDao to fetch product details
    ProductDao pDao = new ProductDao(ConnectionProvider.getConnection());
%>

<div class="container px-3 py-3">
    <%
        // Check if the wishlist is empty
        if (wlist == null || wlist.isEmpty()) {
    %>
        <div class="container mt-5 mb-5 text-center">
            <img src="Images/wishlist.png" style="max-width: 200px;" class="img-fluid">
            <h4 class="mt-3">Empty Wishlist</h4>
            You have no items in your wishlist. Start adding!
        </div>
    <%
        } else {
    %>
        <h4 class="mb-4">
            My Wishlist (<%= wlist.size() %>)
        </h4>
        <hr>
        <div class="row">
            <%
                // Loop through the wishlist and display the products in a card layout
                for (Wishlist w : wlist) {
                    Product p = pDao.getProductsByProductId(w.getProductId());
            %>
            <div class="col-md-4 mb-4">
                <div class="card border-0 shadow-sm">
                    <img src="Product_imgs/<%= p.getProductImages() %>" class="card-img-top" alt="<%= p.getProductName() %>" style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title"><%= p.getProductName() %></h5>
                        <p class="card-text">Price: &#8377;<%= p.getProductPriceAfterDiscount() %></p>
                        <a href="WishlistServlet?uid=<%= u1.getUserId() %>&pid=<%= p.getProductId() %>&op=delete" class="btn btn-danger w-100">Remove from Wishlist</a>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    <%
        }
    %>
</div>

<!-- Optional: Add SweetAlert or Toast notifications for better UX -->
<%
    Message msg = (Message) session.getAttribute("message");
    if (msg != null) {
        String messageType = msg.getMessageType();
        String cssClass = msg.getCssClass();
        String message = msg.getMessage();
        session.removeAttribute("message");
%>
<script>
    Swal.fire({
        icon: '<%= messageType %>',
        title: '<%= message %>',
        showConfirmButton: false,
        timer: 2000,
        toast: true,
        position: 'top-end',
        customClass: {
            popup: '<%= cssClass %>'
        }
    });
</script>
<%
    }
%>
