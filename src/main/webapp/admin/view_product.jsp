<%@page import="com.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.ProductDao"%>
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
					<h3 class="text-center">View Product</h3>
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
								<th scope="col">Image</th>
								<th scope="col">Title</th>
								<th scope="col">Stock</th>
								<th scope="col">Category</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody>
							<%
							ProductDao dao = new ProductDao();
							List<Product> list = dao.getAllProduct();
							for (Product p : list) {
							%><tr>
								<th scope="row"><img alt="img"
									src="../data/img/product_img/<%=p.getImage()%>" width="50px"
									height="50px"></th>
								<td><%=p.getTitle()%></td>
								<td><%=p.getStock()%></td>
								<td><%=p.getCategory()%></td>
								<td><a href="edit_product.jsp?id=<%=p.getId()%>"
									class="btn btn-sm btn-primary">Edit</a> <a
									href="deleteProduct?id=<%=p.getId()%>"
									class="btn btn-sm btn-danger">Delete</a></td>
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