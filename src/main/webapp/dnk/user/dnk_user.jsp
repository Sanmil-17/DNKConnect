<%@ page import="java.util.*, com.entity.User, com.entity.ProductOrder, com.dnk.dao.DNKOrderDao, com.dnk.entity.DNKOrder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.dao.OrderDao" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delivery Tracking</title>
    <%@ include file="/component/css.jsp" %>
   <style>
    .tracking-step {
        display: inline-block;
        text-align: center;
        width: 120px;
        position: relative;
    }
    .tracking-step .circle {
        width: 20px;
        height: 20px;
        border-radius: 50%;
        background-color: #ccc; /* Grey by default */
        margin: 0 auto 5px;
    }
    .tracking-step.active .circle {
        background-color: orange; /* Yellow/Orange for active */
    }
    .tracking-step p {
        margin: 0;
        font-size: 12px;
    }
    .tracking-line {
        width: 100px;
        height: 4px;
        background-color: #ccc; /* Grey by default */
        position: absolute;
        top: 8px;
        left: 100%;
    }
    .tracking-step.active .tracking-line {
        background-color: orange; /* Orange for completed steps */
    }
    .tracking-step:last-child .tracking-line {
        display: none;
    }
</style>

</head>
<body>
    <%@ include file="/component/dnk_navbar.jsp" %>

    <div class="container mt-5">
        <h3 class="text-center mb-4">Delivery Tracking</h3>

        <%
            String orderId = request.getParameter("orderId");
            User user = (User) session.getAttribute("userObj");

            if (user == null || orderId == null) {
        %>
            <div class="alert alert-danger">Invalid session or order.</div>
        <%
            } else {
                OrderDao orderDao = new OrderDao();
                DNKOrderDao dnkDao = new DNKOrderDao();

                ProductOrder order = orderDao.getOrderByOrderId(orderId);
                DNKOrder dnk = dnkDao.getDNKOrderByOrderId(orderId);

                if (order == null) {
        %>
                    <div class="alert alert-danger">Order not found with ID: <%= orderId %></div>
        <%
                } else {
                    String shippingStatus = dnk != null ? dnk.getShippingStatus() : "Order Placed";
                    Map<String, String> trackingMap = new LinkedHashMap<>();
                    trackingMap.put("Order Placed", "Order details shared with the courier");
                    trackingMap.put("Received", "Package received by courier");
                    trackingMap.put("Dispatched", "Package has left the courier facility");
                    trackingMap.put("In Transit", "Package is in transit");
                    trackingMap.put("Out for Delivery", "Out for delivery");
                    trackingMap.put("Delivered", "Package delivered");
        %>

        <div class="p-4 shadow rounded bg-light">
            <h5>Order ID: <%= order.getOrderId() %></h5>
            <h6>Expected Delivery: <span class="text-success fw-bold">Within 7-10 days</span></h6>
            <p class="text-muted">Your package status: <strong><%= shippingStatus %></strong></p>

			<div class="d-flex justify-content-between mt-4 mb-4">
			    <%
			        boolean foundCurrent = false; // false until current shipping status is found
			        for (String step : trackingMap.keySet()) {
			            String cssClass = (!foundCurrent) ? "active" : "";
			            if (step.equalsIgnoreCase(shippingStatus)) {
			                foundCurrent = true; // from this step onwards, steps are inactive
			            }
			    %>
			        <div class="tracking-step <%= cssClass %>">
			            <div class="circle"></div>
			            <p><%= step %></p>
			            <div class="tracking-line"></div>
			        </div>
			    <%
			        }
			    %>
			</div>
	
            <div class="accordion" id="trackingDetails">
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTracking">
                            Tracking Details
                        </button>
                    </h2>
                    <div id="collapseTracking" class="accordion-collapse collapse show">
                        <div class="accordion-body">
                            <ul class="list-group">
                                <li class="list-group-item">5 April 2025, 4:00 PM - Mumbai MH IN — Package arrived at a courier facility</li>
                                <li class="list-group-item">4 April 2025, 2:30 AM - Mumbai MH IN — Package has left the courier facility</li>
                                <li class="list-group-item">3 April 2025, 11:00 PM - Pune MH IN — Package received by courier</li>
                                <li class="list-group-item">3 April 2025, 9:00 PM - Pune MH IN — Order details shared with the courier</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
                } // end else order != null
            } // end else session and orderId valid
        %>
    </div>
</body>
</html>
