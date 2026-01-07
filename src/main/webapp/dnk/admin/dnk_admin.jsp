<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*, com.entity.User, com.entity.ProductOrder, com.dnk.dao.DNKOrderDao, com.dnk.entity.DNKOrder" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.OrderDao" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - DNK Orders</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: left;
        }

        th {
            background-color: #f3f3f3;
        }

        select {
            width: 100%;
            padding: 6px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            padding: 8px 16px;
            background-color: #2e8b57;
            color: white;
            border: none;
            cursor: pointer;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
        }

        .message {
            text-align: center;
            margin: 10px 0;
        }

        .message.success {
            color: green;
        }

        .message.error {
            color: red;
        }
    </style>
</head>
<body>
<%@ include file="/component/dnk_admin_navbar.jsp" %>


<h2>DNK ORDERS</h2>

<!-- Display success or error messages -->
<c:if test="${not empty succMsg}">
    <p class="message success">${succMsg}</p>
</c:if>
<c:if test="${not empty failedMsg}">
    <p class="message error">${failedMsg}</p>
</c:if>

<!-- Orders Table -->
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Order ID</th>
            <th>Courier Name</th>
            <th>Tracking Number</th>
            <th>Shipping Status</th>
            <th>Last Updated</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <!-- Loop through each order and display details -->
        <c:forEach var="order" items="${orders}">
            <tr>
                <form action="dnk-orders" method="post">

                    <td>${order.id}</td>
                    <td>
                        ${order.orderId}
                        <input type="hidden" name="orderId" value="${order.orderId}" />
                    </td>
                    <td>${order.courierName}</td>
                    <td>${order.trackingNumber}</td>
                    <td>
                        <select name="shippingStatus">
                            <option value="Order Placed" ${order.shippingStatus == 'Order Placed' ? 'selected' : ''}>Order Placed</option>
                             <option value="Received" ${order.shippingStatus == 'Received' ? 'selected' : ''}>Received</option>
                            <option value="Dispatched" ${order.shippingStatus == 'Dispatched' ? 'selected' : ''}>Dispatched</option>
                            <option value="In Transit" ${order.shippingStatus == 'In Transit' ? 'selected' : ''}>In Transit</option>
                             <option value="Out for Delivery" ${order.shippingStatus == 'Out for Delivery' ? 'selected' : ''}>Out for Delivery</option>
                            <option value="Delivered" ${order.shippingStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
                            <option value="Cancelled" ${order.shippingStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                            <option value="Returned" ${order.shippingStatus == 'Returned' ? 'selected' : ''}>Returned</option>
                        </select>
                    </td>
                <td>
				    <c:choose>
				        <c:when test="${not empty order.updatedAt}">
				            <fmt:formatDate value="${order.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
				        </c:when>
				        <c:otherwise>
				            N/A
				        </c:otherwise>
				    </c:choose>
				</td>
				<td><input type="submit" value="Update" /></td>	
                </form>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
