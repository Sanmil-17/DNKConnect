package com.servlet.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.paypal.base.rest.PayPalRESTException;
import com.util.PayPalClient;

@WebServlet("/PayPalProcessing")
public class PayPalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Handles GET requests (from OrderServlet redirect)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String amountStr = request.getParameter("amt");

        if (amountStr == null || amountStr.trim().isEmpty()) {
            response.sendRedirect("cart.jsp?error=InvalidAmount");
            return;
        }

        try {
            double amount = Double.parseDouble(amountStr);

            PayPalClient paypalClient = new PayPalClient();
            String approvalLink = paypalClient.createPayment(amount);

            response.sendRedirect(approvalLink);
        } catch (NumberFormatException | PayPalRESTException e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=PayPalError");
        }
    }

    // Optional: Handles POST requests directly to PayPal servlet
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentMode = request.getParameter("payment");
        String amountStr = request.getParameter("amt");

        if (amountStr == null || amountStr.trim().isEmpty()) {
            response.sendRedirect("cart.jsp?error=InvalidAmount");
            return;
        }

        try {
            double amount = Double.parseDouble(amountStr);

            if ("PayPal".equalsIgnoreCase(paymentMode)) {
                PayPalClient paypalClient = new PayPalClient();
                String approvalLink = paypalClient.createPayment(amount);
                response.sendRedirect(approvalLink);
            } else {
                response.sendRedirect("order_success.jsp");
            }
        } catch (NumberFormatException | PayPalRESTException e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=PayPalError");
        }
    }
}
