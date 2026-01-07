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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">


</head>
<body>
	<c:if test="${empty adminObj }">
		<c:redirect url="../login.jsp"></c:redirect>
	</c:if>
	<%@include file="navbar.jsp"%>
	<div class="container">

		<div class="row p-5 mt-5">
			<h3 class="text-center mb-5">Admin Dashboard</h3>
			<div class="col-md-4 ">
				<a href="add_product.jsp" class="text-decoration-none">
					<div class="card card-sh">
						<div class="card-body text-center">
							<i class="fas fa-plus-square fa-3x text-primary"></i><br>
							<h4>Add Product</h4>
							-----------
						</div>
					</div>
				</a>
			</div>
			<div class="col-md-4">
				<a href="category.jsp" class="text-decoration-none">
					<div class="card card-sh">
						<div class="card-body text-center">
							<i class="fas fa-sign-out-alt fa-3x text-primary"></i><br>
							<h4>Category</h4>
							-----------
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4">
				<a href="view_product.jsp" class="text-decoration-none">
					<div class="card card-sh">
						<div class="card-body text-center">
							<i class="fas fa-book-open fa-3x text-danger"></i></i><br>
							<h4>View Product</h4>
							-----------
						</div>
					</div>
				</a>
			</div>


			<div class="col-md-4 mt-3">
				<a href="orders.jsp" class="text-decoration-none">
					<div class="card card-sh">
						<div class="card-body text-center">
							<i class="fas fa-box-open fa-3x text-warning"></i><br>
							<h4>Orders</h4>
							-----------
						</div>
					</div>
				</a>
			</div>
			
			<div class="col-md-4 mt-3">
				<a href="/Ecommerce_Store/admin/dnk-orders" class="text-decoration-none">
					<div class="card card-sh">
						<div class="card-body text-center">
							<i class="fas fa-truck-moving fa-3x text-success"></i><br>
							<h4>DNK Exports</h4>
							-----------
						</div>
					</div>
				</a>
			</div>
			
			<div class="col-md-4 mt-3">
				<a href="user.jsp" class="text-decoration-none">
					<div class="card card-sh">
						<div class="card-body text-center">
							<i class="fas fa-circle-user fa-3x text-primary"></i><br>
							<h4>User</h4>
							-----------
						</div>
					</div>
				</a>
			</div>
		</div>
	</div>
</body>
</html>