package com.servlet.admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.dao.ProductDao;
import com.entity.Product;

@WebServlet("/admin/addProduct")
@MultipartConfig
public class AddProduct extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			String title = req.getParameter("title").trim();
			String description = req.getParameter("description").trim();
			String category = req.getParameter("category").trim();
			String price = req.getParameter("price").trim();
			int stock = Integer.parseInt(req.getParameter("stock").trim());

			Part p = req.getPart("img");
			String image = p.getSubmittedFileName();

			Product product = new Product(title, description, category, price, stock, image);

			ProductDao dao = new ProductDao();
			HttpSession session = req.getSession();

			if (dao.addProduct(product)) {
				String path = req.getServletContext().getRealPath("") + "data" + File.separator + "img" + File.separator
						+ "product_img" + File.separator + image;
				// System.out.println(path);
				File file = new File(path);
				p.write(path);
				session.setAttribute("succMsg", "Added successfully");
				resp.sendRedirect("add_product.jsp");
			} else {
				session.setAttribute("errorMsg", "something wrong on server");
				resp.sendRedirect("add_product.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("view_product.jsp");
		}
	}
}
