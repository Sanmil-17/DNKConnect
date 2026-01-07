package com.dnk.servlet.user;

import com.dao.OrderDao;
import com.entity.ProductOrder;
import com.dnk.dao.DNKOrderDao;
import com.dnk.entity.DNKOrder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/dnk-tracking")
public class DNKUserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");

        try {
            DNKOrderDao dnkDao = new DNKOrderDao();
            OrderDao orderDao = new OrderDao();

            DNKOrder dnkOrder = dnkDao.getDNKOrderByOrderId(orderIdStr);
            ProductOrder order = orderDao.getOrderByOrderId(orderIdStr); // new addition

            if (dnkOrder != null && order != null) {
                request.setAttribute("dnkOrder", dnkOrder);
                request.setAttribute("order", order); // setting order attribute
                request.getRequestDispatcher("/user/dnk_tracking.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMsg", "Tracking info or order details not found.");
                request.getRequestDispatcher("/user/dnk_tracking.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Invalid order ID.");
            request.getRequestDispatcher("/user/dnk_tracking.jsp").forward(request, response);
        }
    }
}
