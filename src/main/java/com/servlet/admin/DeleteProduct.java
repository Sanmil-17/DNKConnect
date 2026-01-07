package com.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.ProductDao;

@WebServlet("/admin/deleteProduct")
public class DeleteProduct extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int id = Integer.parseInt(req.getParameter("id"));

		ProductDao dao = new ProductDao();

		HttpSession session = req.getSession();

		if (dao.deleteProduct(id)) {

			session.setAttribute("succMsg", "Delete sucesfully");
			resp.sendRedirect("view_product.jsp");

		} else {
			session.setAttribute("errorMsg", "something wrong on server");
			resp.sendRedirect("view_product.jsp");
		}

	}

}
