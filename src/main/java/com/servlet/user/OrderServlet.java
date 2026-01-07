package com.servlet.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CartDAO;
import com.dao.OrderDao;
import com.dao.ProductDao;
import com.entity.Cart;
import com.entity.Product;
import com.entity.ProductOrder;
import com.entity.User;

import com.dnk.dao.DNKOrderDao;
import com.dnk.entity.DNKOrder;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
System.out.println("POPOPOPOPOPOPOPOPOP");
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("userObj");
            String paymentType = req.getParameter("payment");
            String totalPrice = req.getParameter("totalPrice");
            String amt = req.getParameter("amt");

            CartDAO dao = new CartDAO();
            ProductDao pdao = new ProductDao();
            OrderDao odao = new OrderDao();

            List<Cart> plist = dao.getCart(user.getId());

            ArrayList<ProductOrder> orderList = new ArrayList<>();
            ArrayList<Product> outOfStockProduct = new ArrayList<>();

            Random r = new Random();

            for (Cart c : plist) {
                Product p = pdao.getProductByid(c.getPid());
                if (p.getStock() < c.getQuantity()) {
                    outOfStockProduct.add(p);
                } else {
                    ProductOrder o = new ProductOrder();
                    o.setUserId(user.getId());
                    o.setProductid(p.getId());
                    o.setOrderId("PROD-ORD-00" + r.nextInt(1000));
                    o.setQuantity(c.getQuantity());
                    o.setPrice(p.getPrice());
                    o.setPaymentType("COD");
                    o.setOrderStatus("Order Placed");
                    orderList.add(o);
                }
            }

            if (!outOfStockProduct.isEmpty()) {
                session.setAttribute("failedMsg", "Please remove out-of-stock product(s)");
                resp.sendRedirect("cart.jsp");
                return;
            }
            
            System.out.println("_____________" + paymentType);

            if ("COD".equals(paymentType)) {
                boolean f = odao.saveOrder(orderList);

                if (f) {
                    // ✅ Insert DNK order records automatically
                    DNKOrderDao dnkDao = new DNKOrderDao();
                    Random rand = new Random();

                    for (ProductOrder po : orderList) {
                        DNKOrder dnk = new DNKOrder();
                        dnk.setOrderId(po.getOrderId());
                        dnk.setCourierName("Auto-C-" + rand.nextInt(9000)); // Placeholder
                        dnk.setTrackingNumber("TRK-" + po.getOrderId());   // Placeholder
                        dnk.setShippingStatus("Order Placed");

                        dnkDao.insertDNKOrder(dnk);
                    }

                    // ✅ Update stock
                    for (ProductOrder po : orderList) {
                        Product p = pdao.getProductByid(po.getProductid());
                        pdao.updateProductStock(p.getId(), p.getStock() - po.getQuantity());
                    }

                    resp.sendRedirect("order_success.jsp");
                } else {
                    session.setAttribute("failedMsg", "Your order failed");
                    resp.sendRedirect("cart.jsp");
                }

            } else if ("noselect".equals(paymentType)) {
                session.setAttribute("failedMsg", "Choose Payment Method");
                resp.sendRedirect("cart.jsp");
            } else if ("PayPal".equals(paymentType)) {
                resp.sendRedirect("PayPalProcessing?amt=" + amt + "&uid=" + user.getId());
            } else {
                resp.sendRedirect("card_payment.jsp?amt=" + amt);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
