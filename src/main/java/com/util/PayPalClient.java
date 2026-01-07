package com.util;

import java.util.ArrayList;
import java.util.List;

import com.paypal.api.payments.*;
import com.paypal.base.rest.*;

public class PayPalClient {
    private static final String CLIENT_ID = "AdJlHoMeQv-IqHw6lDQyt7I77LLL8cEi1kJAz_O51ZUS_kAo_p4Zhv725SyFyCHTDL5FiHMsi-p3z07c"; // Replace with your actual PayPal Client ID
    private static final String CLIENT_SECRET = "EIOCWxwe6EtK1L4c6D_jgZvtmqQ7HV0CSyZYQBimu4zBgIZG3ZU7ybbMqwylHC6LhBjYPNT9lrr79QVo"; // Replace with your actual PayPal Client Secret
    private static final String MODE = "sandbox"; // Change to "live" in production

    public String createPayment(double amount) throws PayPalRESTException {
        Amount paymentAmount = new Amount();
        paymentAmount.setCurrency("USD"); // Ensure this matches your PayPal account currency
        paymentAmount.setTotal(String.format("%.2f", amount));

        Transaction transaction = new Transaction();
        transaction.setAmount(paymentAmount);
        transaction.setDescription("E-commerce Store Purchase");

        List<Transaction> transactions = new ArrayList<Transaction>();
        transactions.add(transaction);

        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8080/Ecommerce_Store/cart.jsp");
        redirectUrls.setReturnUrl("http://localhost:8080/Ecommerce_Store/execute_payment");

        Payment payment = new Payment();
        payment.setIntent("sale");
        payment.setPayer(payer);
        payment.setTransactions(transactions);
        payment.setRedirectUrls(redirectUrls);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        Payment createdPayment = payment.create(apiContext);

        for (Links link : createdPayment.getLinks()) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                return link.getHref();
            }
        }
        return null;
    }
    public Payment executePayment(String paymentId, String payerId) throws PayPalRESTException {
        Payment payment = new Payment();
        payment.setId(paymentId);

        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return payment.execute(apiContext, paymentExecution);
    }

}
