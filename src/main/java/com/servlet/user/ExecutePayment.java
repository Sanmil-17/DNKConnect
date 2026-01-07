package com.servlet.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.*;
import com.entity.*;
import com.paypal.base.rest.PayPalRESTException;
import com.util.PayPalClient;

import com.dnk.dao.DNKOrderDao;
import com.dnk.entity.DNKOrder;

@WebServlet("/ExecutePayment1")
public class ExecutePayment extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	System.out.println("ILAY HADE");
        String paymentId = req.getParameter("paymentId");
        String payerId = req.getParameter("PayerID");

        try {
            PayPalClient paypalClient = new PayPalClient();
            if (paypalClient.executePayment(paymentId, payerId) != null) {
                HttpSession session = req.getSession();
                User user = (User) session.getAttribute("userObj");

                if (user == null) {
                    resp.sendRedirect("login.jsp");
                    return;
                }

                CartDAO cartDao = new CartDAO();
                ProductDao pdao = new ProductDao();
                OrderDao odao = new OrderDao();

                List<Cart> plist = cartDao.getCart(user.getId());
                ArrayList<ProductOrder> orderList = new ArrayList<>();
                ArrayList<Product> outOfStock = new ArrayList<>();

                String baseOrderId = "PROD-ORD-" + System.currentTimeMillis(); // unique base ID

                for (Cart c : plist) {
                    Product p = pdao.getProductByid(c.getPid());

                    if (p.getStock() < c.getQuantity()) {
                        outOfStock.add(p);
                    } else {
                        ProductOrder o = new ProductOrder();
                        o.setUserId(user.getId());
                        o.setProductid(p.getId());
                        o.setOrderId(baseOrderId + "-" + p.getId()); // unique per product
                        o.setQuantity(c.getQuantity());
                        o.setPrice(p.getPrice());
                        o.setPaymentType("PayPal");
                        o.setOrderStatus("Order Processing");
                        orderList.add(o);
                    }
                }

                if (!outOfStock.isEmpty()) {
                    session.setAttribute("failedMsg", "Remove out-of-stock items first.");
                    resp.sendRedirect("cart.jsp");
                } else {
                    boolean f = odao.saveOrder(orderList);
                    System.out.println("✅ E-commerce order saved: " + f);

                    if (f) {
                        DNKOrderDao dnkDao = new DNKOrderDao();
                        Random rand = new Random();
                        for (ProductOrder po : orderList) {
                            DNKOrder dnk = new DNKOrder();
                            dnk.setOrderId(po.getOrderId());
                            String courierPlaceholder = "Auto-C-" + rand.nextInt(9000);
                            String trackingPlaceholder = "TRK-" + po.getOrderId();
                            dnk.setCourierName(courierPlaceholder);
                            dnk.setTrackingNumber(trackingPlaceholder);
                            dnk.setShippingStatus("Pending");

                            boolean inserted = dnkDao.insertDNKOrder(dnk);
                            System.out.println("➕ DNK Insert for " + dnk.getOrderId() + ": " + inserted);

                            if (!inserted) {
                                System.out.println("❌ Failed to insert DNK order for: " + dnk.getOrderId());
                            }
                        }

                        // ✅ Update stock
                        for (ProductOrder po : orderList) {
                            Product p = pdao.getProductByid(po.getProductid());
                            pdao.updateProductStock(p.getId(), p.getStock() - po.getQuantity());
                        }

                        // ✅ Clear cart
                        cartDao.clearCart(user.getId());

                        // ✅ Redirect
                        resp.sendRedirect("order_success.jsp");
                    } else {
                        session.setAttribute("failedMsg", "Order processing failed.");
                        resp.sendRedirect("cart.jsp");
                    }
                }

            } else {
                resp.sendRedirect("cart.jsp?error=PaymentFailed");
            }

        } catch (PayPalRESTException e) {
            e.printStackTrace();
            resp.sendRedirect("cart.jsp?error=PaymentException");
        }
    }
}
