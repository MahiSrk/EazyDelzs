package com.eazydelzs.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.eazydelzs.dao.OrderDao;
import com.eazydelzs.dao.UserDao;
import com.eazydelzs.entities.Order;
import com.eazydelzs.helper.ConnectionProvider;
import com.eazydelzs.helper.MailMessenger;

public class UpdateOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int oid = Integer.parseInt(request.getParameter("oid"));
		String status = request.getParameter("status");
		OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
		orderDao.updateOrderStatus(oid, status);
		if (status.trim().equals("Shipped") || status.trim().equals("Out For Delivery")) {
			Order order = orderDao.getOrderById(oid);
			UserDao userDao = new UserDao(ConnectionProvider.getConnection());
			MailMessenger.orderShipped(userDao.getUserName(order.getUserId()), userDao.getUserEmail(order.getUserId()),
					order.getOrderId(), order.getDate().toString());
		}
		response.sendRedirect("display_orders.jsp");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}
