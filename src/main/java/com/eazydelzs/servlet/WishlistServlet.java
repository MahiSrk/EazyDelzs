package com.eazydelzs.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.eazydelzs.dao.WishlistDao;
import com.eazydelzs.entities.Wishlist;
import com.eazydelzs.helper.ConnectionProvider;

public class WishlistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		int pid = Integer.parseInt(request.getParameter("pid"));
		String op = request.getParameter("op");

		WishlistDao wishlistDao = new WishlistDao(ConnectionProvider.getConnection());
		if (op.trim().equals("add")) {
			Wishlist wishlist = new Wishlist(uid, pid);
			wishlistDao.addToWishlist(wishlist);
			response.sendRedirect("products.jsp");
		} else if (op.trim().equals("remove")) {
			wishlistDao.deleteWishlist(uid, pid);
			response.sendRedirect("products.jsp");
		}else if(op.trim().equals("delete")) {
			wishlistDao.deleteWishlist(uid, pid);
			response.sendRedirect("profile.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
