package com.dnk.servlet.admin;

import com.dnk.dao.DNKOrderDao;
import com.dnk.entity.DNKOrder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dnk-orders")
public class DNKAdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // This will handle showing all DNK orders (for dnk_orders.jsp)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DNKOrderDao dao = new DNKOrderDao();
            List<DNKOrder> list = dao.getAllDNKOrders();

            request.setAttribute("orders", list);
            request.getRequestDispatcher("/dnk/admin/dnk_admin.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/Ecommerce_Store/dnk/admin/dnk_admin.jsp?error=Exception");
        }
    }

    // This will handle updating shipping status when clicking "Update" button
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String orderId = request.getParameter("orderId");
            String shippingStatus = request.getParameter("shippingStatus");

            DNKOrderDao dnkDao = new DNKOrderDao();
            DNKOrder existingOrder = dnkDao.getDNKOrderByOrderId(orderId);

            HttpSession session = request.getSession();

            if (existingOrder != null) {
                boolean dnkUpdated = dnkDao.updateShippingStatus(existingOrder.getId(), shippingStatus);

                if (dnkUpdated) {
                    // Update E-commerce order status also
                    com.dao.OrderDao orderDao = new com.dao.OrderDao(); // <-- your Ecom OrderDao class
                    boolean orderUpdated = orderDao.updateOrderStatus(orderId, shippingStatus);

                    if (orderUpdated) {
                        session.setAttribute("succMsg", "Shipping status updated in DNK and E-commerce successfully!");
                    } else {
                        session.setAttribute("failedMsg", "DNK updated but failed to update E-commerce order.");
                    }
                } else {
                    session.setAttribute("failedMsg", "Failed to update shipping status in DNK.");
                }
            } else {
                session.setAttribute("failedMsg", "Order not found in DNK!");
            }

            response.sendRedirect("/Ecommerce_Store/admin/dnk-orders");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/Ecommerce_Store/dnk/admin/dnk_admin.jsp?error=Exception");
        }
    }
}
