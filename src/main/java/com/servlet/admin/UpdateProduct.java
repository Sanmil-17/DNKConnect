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

@WebServlet("/admin/updateProduct")
@MultipartConfig
public class UpdateProduct extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			String title = req.getParameter("title").trim();
			String description = req.getParameter("description").trim();
			String category = req.getParameter("category").trim();
			String price = req.getParameter("price").trim();
			int stock = Integer.parseInt(req.getParameter("stock").trim());
			int id = Integer.parseInt(req.getParameter("id").trim());
			Part p = req.getPart("img");
			String image = "";

			ProductDao dao = new ProductDao();

			if (p.getSubmittedFileName().isEmpty()) {
				image = dao.getProductByid(id).getImage();
			} else {
				image = p.getSubmittedFileName();
			}

			Product product = new Product(id, title, description, category, price, stock, image);

			HttpSession session = req.getSession();

			if (dao.updateProduct(product)) {
				if (!p.getSubmittedFileName().isEmpty()) {
					String path = req.getServletContext().getRealPath("") + "data" + File.separator + "img"
							+ File.separator + "product_img" + File.separator + image;
					// System.out.println(path);
					File file = new File(path);
					p.write(path);
				}

				session.setAttribute("succMsg", "update successfully");
				resp.sendRedirect("view_product.jsp");
			} else {
				session.setAttribute("errorMsg", "something wrong on server");
				resp.sendRedirect("view_product.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("view_product.jsp");
		}
	}
}
