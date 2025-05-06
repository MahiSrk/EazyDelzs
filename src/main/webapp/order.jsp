<%@page import="com.eazydelzs.entities.Message"%>
<%@page import="com.eazydelzs.entities.OrderedProduct"%>
<%@page import="com.eazydelzs.entities.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydelzs.dao.OrderedProductDao"%>
<%@page import="com.eazydelzs.dao.OrderDao"%>
<%@page import="com.eazydelzs.helper.ConnectionProvider"%>
<%@page import="com.eazydelzs.entities.User"%>
<%@page errorPage="error_exception.jsp"%>

<%
    User u2 = (User) session.getAttribute("activeUser");
    if (u2 == null) {
        Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("login.jsp");
        return;
    }

    OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
    OrderedProductDao ordProdDao = new OrderedProductDao(ConnectionProvider.getConnection());

    List<Order> orderList = orderDao.getAllOrderByUserId(u2.getUserId());
%>

<div class="container-fluid px-3 py-3">
    <% 
        if (orderList == null || orderList.size() == 0) {
    %>
        <div class="container mt-5 mb-5 text-center">
            <img src="Images/empty-cart.png" style="max-width: 200px;" class="img-fluid">
            <h4 class="mt-3">Zero Orders Found</h4>
            Looks like you haven't placed any orders yet!
        </div>
    <%
        } else {
    %>
        <h4>My Orders</h4>
        <hr>
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="table-secondary text-center">
                    <tr>
                        <th>Product</th>
                        <th>Order ID</th>
                        <th>Name</th>
                        <th>Quantity</th>
                        <th>Total Price</th>
                        <th>Date and Time</th>
                        <th>Payment Type</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Order order : orderList) {
                            List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
                            for (OrderedProduct orderProduct : ordProdList) {
                    %>
                    <tr class="text-center">
                        <td><img src="Product_imgs/<%= orderProduct.getImage() %>" 
                                 style="max-width: 50px; height: auto;" class="img-fluid"></td>
                        <td class="text-start"><%= order.getOrderId() %></td>
                        <td class="text-start"><%= orderProduct.getName() %></td>
                        <td><%= orderProduct.getQuantity() %></td>
                        <td>&#8377; <%= orderProduct.getPrice() * orderProduct.getQuantity() %></td>
                        <td><%= order.getDate() %></td>
                        <td><%= order.getPayementType() %></td>
                        <td class="fw-semibold 
                                  <%= order.getStatus().equals("Completed") ? "text-success" : 
                                        (order.getStatus().equals("Processing") ? "text-warning" : "text-danger") %>">
                            <%= order.getStatus() %>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    <%
        }
    %>
</div>

<!-- Optional SweetAlert for displaying messages -->
<%
    Message orderMessage = (Message) session.getAttribute("message");
    if (orderMessage != null) {
        String messageType = orderMessage.getMessageType();
        String cssClass = orderMessage.getCssClass();
        String messageText = orderMessage.getMessage();  
        session.removeAttribute("message");
%>
<script>
    Swal.fire({
        icon: '<%= messageType %>',
        title: '<%= messageText %>',  
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


