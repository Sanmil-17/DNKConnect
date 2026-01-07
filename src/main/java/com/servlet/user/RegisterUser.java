package com.servlet.user;

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

import com.dao.UserDAO;
import com.entity.User;
import com.util.DBConnect;

@WebServlet("/registerUser")
@MultipartConfig
public class RegisterUser extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String fn = req.getParameter("fullname");
			String em = req.getParameter("email");
			String mb = req.getParameter("mobno");
			String ps = req.getParameter("password");
			String ad = req.getParameter("address");
			String ci = req.getParameter("city");
			String st = req.getParameter("state");
			String pin = req.getParameter("pincode");

			Part p = req.getPart("img");
			String img = p.getSubmittedFileName();

			User user = new User(fn, em, mb, ps, ad, ci, st, pin);
			user.setImage(img);
			
			UserDAO dao = new UserDAO(DBConnect.getConnection());
			HttpSession session = req.getSession();

			if (dao.checkEmail(em)) {

				if (dao.addUser(user)) {

					String path = req.getServletContext().getRealPath("") + "data" + File.separator + "img"
							+ File.separator + "profile_img" + File.separator + img;
					//System.out.println(path);
					File file = new File(path);
					p.write(path);

					session.setAttribute("succMsg", "Register successfully");
					resp.sendRedirect("login.jsp");
				} else {
					session.setAttribute("errorMsg", "something wrong on server");
					resp.sendRedirect("register.jsp");
				}

			} else {
				session.setAttribute("errorMsg", "Email id already exist");
				resp.sendRedirect("register.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("login.jsp");
		}
	}

}
