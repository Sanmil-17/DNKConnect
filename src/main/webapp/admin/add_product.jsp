<%@page import="com.entity.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
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
			<div class="col-md-6 offset-md-3">
				<div class="card card-sh">
					<div class="card-header text-center">
						<h3 class="text-center">Add Product</h3>
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

						<form action="addProduct" method="post"
							enctype="multipart/form-data">
							<div class="mb-3">
								<label>Enter Title</label> <input type="text"
									class="form-control" name="title">
							</div>
							<div class="mb-3">
								<label>Enter Description</label>
								<textarea rows="3" cols="" name="description"
									class="form-control"></textarea>
							</div>

							<div class="mb-3">
								<label>Enter Category</label> <select class="form-control"
									name="category">
									<option>--select--</option>
									<%
									CategoryDao dao = new CategoryDao();
									List<Category> list = dao.getCategory();
									for (Category c : list) {
									%>
									<option><%=c.getCategoryName()%></option>
									<%
									}
									%>

								</select>
							</div>

							<div class="mb-3">
								<label>Enter Price</label> <input type="number"
									class="form-control" name="price">
							</div>
							<div class="row">
								<div class="col mb-3">
									<label>Stock</label> <input type="number" class="form-control"
										name="stock">
								</div>

								<div class="col mb-3">
									<label>Image</label> <input type="file" class="form-control"
										name="img">
								</div>
							</div>
							<button class="btn btn-primary col-md-12">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>