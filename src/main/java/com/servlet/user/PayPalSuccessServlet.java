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
import com.dnk.dao.DNKOrderDao;
import com.dnk.entity.DNKOrder;
import com.entity.Cart;
import com.entity.Product;
import com.entity.ProductOrder;
import com.entity.User;
import com.paypal.api.payments.Payment;
import com.util.PayPalClient;

@WebServlet("/execute_payment")
public class PayPalSuccessServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userObj");

        if (paymentId == null || payerId == null || user == null) {
            response.sendRedirect("cart.jsp?error=MissingDetails");
            return;
        }

        try {
            PayPalClient paypalClient = new PayPalClient();
            Payment payment = paypalClient.executePayment(paymentId, payerId);

            if ("approved".equalsIgnoreCase(payment.getState())) {
                // Retrieve cart items
                CartDAO dao = new CartDAO();
                ProductDao pdao = new ProductDao();
                OrderDao odao = new OrderDao();

                List<Cart> plist = dao.getCart(user.getId());
                ArrayList<ProductOrder> orderList = new ArrayList<>();
                Random r = new Random();

                for (Cart c : plist) {
                    Product p = pdao.getProductByid(c.getPid());
                    if (p.getStock() >= c.getQuantity()) {
                        ProductOrder o = new ProductOrder();
                        o.setUserId(user.getId());
                        o.setProductid(p.getId());
                        o.setOrderId("PROD-ORD-00" + r.nextInt(1000));
                        o.setQuantity(c.getQuantity());
                        o.setPrice(p.getPrice());
                        o.setPaymentType("PayPal");
                        o.setOrderStatus("Order Placed");
                        orderList.add(o);
                    }
                }

                boolean saved = odao.saveOrder(orderList);
                
                

                if (saved) {
                    for (ProductOrder po : orderList) {
                        Product p = pdao.getProductByid(po.getProductid());
                        pdao.updateProductStock(p.getId(), p.getStock() - po.getQuantity());
                    }
                    
                    if (saved) {
                        DNKOrderDao dnkDao = new DNKOrderDao();
                        Random rand = new Random();
                        for (ProductOrder po : orderList) {
                            DNKOrder dnk = new DNKOrder();
                            dnk.setOrderId(po.getOrderId());
                            String courierPlaceholder = "Auto-C-" + rand.nextInt(9000);
                            String trackingPlaceholder = "TRK-" + po.getOrderId();
                            dnk.setCourierName(courierPlaceholder);
                            dnk.setTrackingNumber(trackingPlaceholder);
                            dnk.setShippingStatus("Order Placed");

                            boolean inserted = dnkDao.insertDNKOrder(dnk);
                            System.out.println("➕ DNK Insert for " + dnk.getOrderId() + ": " + inserted);

                            if (!inserted) {
                                System.out.println("❌ Failed to insert DNK order for: " + dnk.getOrderId());
                            }
                        }

                    // Clear cart if needed
            
                    response.sendRedirect("order_success.jsp");
                } else {
                    session.setAttribute("failedMsg", "Failed to save PayPal order.");
                    response.sendRedirect("cart.jsp");
                }
            } else {
                response.sendRedirect("cart.jsp?error=PaymentNotApproved");
            }
                }
            }catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=PaymentExecutionFailed");
        }
    }
}

