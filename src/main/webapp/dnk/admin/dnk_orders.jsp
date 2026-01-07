<%@ page import="java.util.*, com.dnk.dao.DNKOrderDao, com.dnk.entity.DNKOrder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage DNK Orders</title>
    <style>
        table {
            width: 90%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            padding: 10px;
            border: 1px solid #aaa;
            text-align: center;
        }
        form {
            display: inline-block;
        }
        .success {
            color: green;
            text-align: center;
        }
        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">DNK Orders Management</h2>

<%
    String succMsg = (String) session.getAttribute("succMsg");
    String failedMsg = (String) session.getAttribute("failedMsg");
    if (succMsg != null) {
%>
    <p class="success"><%= succMsg %></p>
<%
        session.removeAttribute("succMsg");
    }
    if (failedMsg != null) {
%>
    <p class="error"><%= failedMsg %></p>
<%
        session.removeAttribute("failedMsg");
    }

    DNKOrderDao dnkDao = new DNKOrderDao();
    List<DNKOrder> dnkOrders = dnkDao.getAllDNKOrders();
%>

<table>
    <tr>
        <th>ID</th>
        <th>Order ID</th>
        <th>Courier</th>
        <th>Tracking #</th>
        <th>Status</th>
        <th>Created At</th>
        <th>Updated At</th>
        <th>Action</th>
    </tr>
<%
    for (DNKOrder o : dnkOrders) {
%>
    <tr>
        <form action="admin/update-dnk" method="post">
            <td><%= o.getId() %></td>
            <td>
                <input type="hidden" name="orderId" value="<%= o.getOrderId() %>"/>
                <%= o.getOrderId() %>
            </td>
            <td><input type="text" name="courierName" value="<%= o.getCourierName() != null ? o.getCourierName() : "" %>" required></td>
            <td><input type="text" name="trackingNumber" value="<%= o.getTrackingNumber() != null ? o.getTrackingNumber() : "" %>" required></td>
            <td>
                <select name="shippingStatus">
                    <option value="Pending" <%= "Pending".equals(o.getShippingStatus()) ? "selected" : "" %>>Pending</option>
                    <option value="Dispatched" <%= "Dispatched".equals(o.getShippingStatus()) ? "selected" : "" %>>Dispatched</option>
                    <option value="In Transit" <%= "In Transit".equals(o.getShippingStatus()) ? "selected" : "" %>>In Transit</option>
                    <option value="Delivered" <%= "Delivered".equals(o.getShippingStatus()) ? "selected" : "" %>>Delivered</option>
                </select>
            </td>
            <td><%= o.getCreatedAt() %></td>
            <td><%= o.getUpdatedAt() %></td>
            <td><button type="submit">Update</button></td>
        </form>
    </tr>
<%
    }
%>
</table>

</body>
</html>
