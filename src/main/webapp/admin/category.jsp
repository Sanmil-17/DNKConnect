
<%@page import="com.entity.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.CategoryDao"%>
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
<title>Admin | Category</title>
<%@include file="../component/css.jsp"%>
</head>
<body>
	<c:if test="${empty adminObj }">
		<c:redirect url="../login.jsp"></c:redirect>
	</c:if>
	<%@include file="navbar.jsp"%>

	<div class="container-fluid " style="margin-top: 100px;">
		<div class="row">
			<div class="col-md-4">
				<div class="card card-sh">
					<div class="card-body">
						<p class="fs-4 text-center">Category Add</p>
						<c:if test="${not empty errorMsg}">
							<p class="fs-4 text-center text-danger">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<c:if test="${not empty succMsg}">
							<p class=" fs-4 text-center text-success">${succMsg}</p>
							<c:remove var="succMsg" scope="session" />
						</c:if>
						<form action="add_cat" method="post" enctype="multipart/form-data">
							<div class="mb-3">
								<label class="form-label">Title</label> <input name="title"
									required type="text" class="form-control">
							</div>
							<div class="mb-3">
								<label class="form-label">Image</label> <input type="file"
									required name="img" class="form-control">
							</div>

							<button type="submit" class="btn bg-primary text-white col-md-12">Add</button>
						</form>

					</div>
				</div>
			</div>

			<div class="col-md-8">
				<div class="card card-sh">
					<div class="card-body">
						<p class="fs-4 text-center">Category Details</p>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Category Name</th>
									<th scope="col">Image</th>
									<th scope="col">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								CategoryDao dao = new CategoryDao();
								List<Category> list = dao.getCategory();
								for (Category c : list) {
								%>
								<tr>
									<th scope="row"><%=c.getCategoryName()%></th>
									<td><img
										src="../data/img/category_img/<%=c.getImageName()%>"
										width="50px" height="50px"></td>
									<td><a href="edit_category.jsp?id=<%=c.getId()%>"
										class="btn btn-sm btn-primary">Edit</a> <a
										href="deleteCategory?id=<%=c.getId()%>"
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
	</div>


</body>
</html>