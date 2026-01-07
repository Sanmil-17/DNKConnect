
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<%@include file="component/css.jsp"%>

</head>
<body>
	<%@include file="component/navbar.jsp"%>

	<div class="container mt-5 p-5">
		<div class="row">



			<div class="col-md-6 p-5">
				<img alt="" src="data/img/ecom.png" width="100%" height="400px">
			</div>


			<div class="col-md-4 offset-md-1">
				<div class="card card-sh mt-5">
					<div class="card-header">
						<p class="fs-4 text-center">Login</p>
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


						<form action="login" method="post">
							<div class="mb-3">
								<label class="form-label">Email address</label> <input required
									name="email" type="email" class="form-control">
							</div>
							<div class="mb-3">
								<label class="form-label">Password</label> <input required
									name="password" type="password" class="form-control">
							</div>
							

							<button type="submit" class="btn bg-primary text-white col-md-12">Login</button>
						</form>




					</div>

					<div class="card-header text-center mt-2">
						<a href="forgot_password.jsp" class="text-decoration-none">Forgot
							Password</a> <br> Don't have an account?<a href="register.jsp"
							class="text-decoration-none"> create one</a>
					</div>
				</div>
			</div>

		</div>
	</div>

</body>
</html>