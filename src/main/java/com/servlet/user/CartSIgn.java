package com.servlet.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.dao.CartDAO;
import com.util.DBConnect;

@WebServlet("/cartin")
public class CartSIgn extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Get the parameters from the request
            String sign = req.getParameter("si");
            int cId = Integer.parseInt(req.getParameter("cid"));  // Add cId here
            double qu = Double.parseDouble(req.getParameter("qu"));
            int intQu = (int) qu;  // Cast to int after parsing

            CartDAO dao = new CartDAO();
            HttpSession session = req.getSession();

            if ("plus".equals(sign) && qu >= 1) {
                double val = qu + 1;
                String sql = "update cart set quantity='" + val + "' where id='" + cId + "'";
                dao.updateQuantity(sql);
                resp.sendRedirect("cart.jsp");

            } else if ("neg".equals(sign) && qu >= 1) {
                double val = qu - 1;
                String sql = "update cart set quantity='" + val + "' where id='" + cId + "'";

                if (val == 0) {
                    if (dao.deleteCart(cId)) {
                        session.setAttribute("succMsg", "Item Removed from cart");
                        resp.sendRedirect("cart.jsp");
                    }
                } else {
                    dao.updateQuantity(sql);
                    resp.sendRedirect("cart.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
