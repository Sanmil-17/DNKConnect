<%@page import="com.entity.User"%>
<%@page import="com.dao.CartDAO"%>
<%@page import="com.entity.Product"%>
<%@page import="com.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="component/css.jsp"%>
</head>
<body>
	<%@include file="component/navbar.jsp"%>

	<%
	int id = Integer.parseInt(request.getParameter("id"));
	ProductDao dao = new ProductDao();
	Product p = dao.getProductByid(id);
	%>

	<div class="container card-sh" style="margin-top: 70px">
		<div class="row">
			<p class="fs-3 text-center">Product Details</p>

			<c:if test="${not empty succMsg}">
				<div class="alert alert-success text-center" role="alert">${succMsg }</div>
				<c:remove var="succMsg" scope="session" />
			</c:if>


			<div class="col-md-12 paint-card p-5">
				<div class="row">
					<div class="col-md-6 text-end">
						<img alt="" src="data/img/product_img/<%=p.getImage()%>"
							width="330px" height="400px">
					</div>

					<div class="col-md-6">


						<p class="fs-3"><%=p.getTitle()%></p>
						<p>
							<span class="fw-bold">Description : </span><br><%=p.getDescription()%>
						</p>
						<p>
							<span class="fw-bold"> Product Details: </span> <br>Status :
							<%
 if (p.getStock() > 0) {
 %>
							<span class="badge bg-success">Available</span>
							<%
							} else {
							%>
							<span class="badge bg-warning">out of stock</span>
							<%
							}
							%>


							<br> Category :
							<%=p.getCategory()%><br> Policy : 7 Days Replacement &
							Return

						</p>
						<p class="fs-5 fw-bold">
							Price :&nbsp; &nbsp; &nbsp; &nbsp;<i class="fas fa-dollar-sign"></i>
							<%=p.getPrice()%>
						</p>

						<div class="row">
							<div class="col-md-4 text-danger text-center p-2">
								<i class="fas fa-money-bill-wave fa-2x"></i>
								<p>Cash On Delivery</p>
							</div>
							<div class="col-md-4 text-danger text-center p-2">
								<i class="fas fa-undo-alt fa-2x"></i>
								<p>Return Available</p>
							</div>
							<div class="col-md-4 text-danger text-center p-2">
								<i class="fas fa-truck-moving fa-2x"></i>
								<p>Free Shipping</p>
							</div>
						</div>

						<c:if test="${not empty userObj }">
							<%
							User user = (User) session.getAttribute("userObj");
							CartDAO dao2 = new CartDAO();

							if (p.getStock() <= 0) {
							%>
							<button class="btn btn-warning col-md-12">Out of Stock</button>
							<%
							} else {

							if (dao2.checkCart(p.getId(), user.getId())) {
							%>
							<button disabled class="btn btn-danger col-md-12">Added
								To Cart</button>
							<%
							} else {
							%>
							<a href="cart?pid=<%=p.getId()%>&&uid=${userObj.id}"
								class="btn btn-danger col-md-12">Add To Cart</a>
							<%
							}
							}
							%>

						</c:if>
						<c:if test="${ empty userObj }">
							<%
							if (p.getStock() <= 0) {
							%><button class="btn btn-warning col-md-12">Out of Stock</button>
							<%
							} else {
							%>

							<a href="login.jsp" class="btn btn-danger col-md-12">Add To
								Cart</a>
							<%
							}
							%>

						</c:if>
					</div>
				</div>
			</div>

		</div>
	</div>
</body>
</html>