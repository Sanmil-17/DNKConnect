<%@page import="com.entity.Product"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.entity.ProductOrder"%>
<%@page import="com.dao.OrderDao"%>

<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>


<%@page import="java.util.List"%>
<%@page import="com.entity.User"%>
<%@page import="com.util.DBConnect"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User | Order</title>
<%@include file="component/css.jsp"%>

</head>
<body>
	<c:if test="${empty userObj }">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>
	<%@include file="component/navbar.jsp"%>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-12 card-sh">
				<p class="fs-3 text-center">Your Orders</p>
				<table class="shadow-sm table table-bordered ">
					<thead class="table-dark">
						<tr>
							<th class="text-center">Order Date</th>
							<th class="text-center">Order ID</th>
							<!-- <th>Delivery Address</th> -->
							<th>Product Details</th>
							<th>Quantity</th>
							<th class="text-center">Total Price</th>
							<th>Payment Type</th>
							<th>Status</th>
							<th>Track</th>
						</tr>
					</thead>
					<tbody>

						<%
						User user = (User) session.getAttribute("userObj");
						OrderDao dao = new OrderDao();
						ProductDao dao2 = new ProductDao();
						List<ProductOrder> list = dao.getOrderByUser(user.getId());

						for (ProductOrder o : list) {
							Product p = dao2.getProductByid(o.getProductid());
						%>
						<tr>
							<th><%=o.getOrderDate()%></th>
							<th scope="row"><%=o.getOrderId()%></th>
							<%-- <td><%=user.getFullName()%><br><%=user.getAddress()%><br><%=user.getCity()%>
								,<%=user.getState()%>,<%=user.getPin()%><br>Mob No: <%=user.getMobNo()%>

							</td> --%>
							<td><%=p.getTitle()%></td>
							<td><%=o.getQuantity()%></td>

							<td>
								<%
								double tprice = Double.parseDouble(p.getPrice()) * o.getQuantity();
								%> <%=tprice%>
							</td>
							<td><%=o.getPaymentType()%></td>
							<td><%=o.getOrderStatus()%></td>
							 <td>
						        <a href="dnk/user/dnk_user.jsp?orderId=<%=o.getOrderId()%>" class="btn btn-sm btn-primary">Track</a>
						    </td>
						</tr>
						<%
						}
						%>

					</tbody>
				</table>

			</div>
		</div>
	</div>
</body>
</html>