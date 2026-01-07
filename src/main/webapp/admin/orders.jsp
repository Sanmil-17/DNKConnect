<%@page import="com.entity.Product"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.entity.User"%>
<%@page import="com.util.DBConnect"%>
<%@page import="com.dao.UserDAO"%>
<%@page import="com.entity.ProductOrder"%>
<%@page import="com.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="../component/css.jsp"%>
</head>
<body>
	<c:if test="${empty adminObj }">
		<c:redirect url="../login.jsp"></c:redirect>
	</c:if>
	<%@include file="navbar.jsp"%>
	<div class="container">
		<div class="row p-5 mt-3">
			<div class="card card-sh">
				<div class="card-header">
					<h3 class="text-center">Customer Orders</h3>
					<c:if test="${not empty errorMsg}">
						<p class="fs-4 text-center text-danger">${errorMsg}</p>
						<c:remove var="errorMsg" scope="session" />
					</c:if>
					<c:if test="${not empty succMsg}">
						<p class=" fs-4 text-center text-success">${succMsg}</p>
						<c:remove var="succMsg" scope="session" />
					</c:if>
				</div>
				<div class="card-body">
					<table class="table">
						<thead>
							<tr>
								<th class="text-center">Order Date</th>
								<th class="text-center">Order ID</th>
								<th>Delivery Address</th>
								<th>Product Details</th>
								<th>Payment Type</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>

							<%
							OrderDao dao = new OrderDao();
							UserDAO dao2 = new UserDAO(DBConnect.getConnection());
							ProductDao pdao = new ProductDao();
							List<ProductOrder> list = dao.getAllOrder();
							for (ProductOrder o : list) {
								User user = dao2.getUser(o.getUserId());
								Product p = pdao.getProductByid(o.getProductid());
							%>
							<tr>
								<th><%=o.getOrderDate()%></th>
								<th scope="row"><%=o.getOrderId()%></th>
								<td><%=user.getFullName()%><br><%=user.getAddress()%><br><%=user.getCity()%>
									,<%=user.getState()%>,<%=user.getPin()%><br>Mob No: <%=user.getMobNo()%>

								</td>
								<td><%=p.getTitle()%> <br>Quantity : <%=o.getQuantity()%>
									<br> <%
							 double tprice = Double.parseDouble(p.getPrice()) * o.getQuantity();
							 %> <%=tprice%></td>



								<td><%=o.getPaymentType()%></td>
								<td><%=o.getOrderStatus()%></td>
								
										</div>
									</form>
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
	</div>

</body>
</html>