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
					<h3 class="text-center">User Details</h3>
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
								<th class="text-center">Images</th>
								<th class="text-center">Full name</th>
								<th class="text-center">Email</th>
								<th>Mobile No</th>
								<th>Address</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>

							<%
							UserDAO dao = new UserDAO(DBConnect.getConnection());
							List<User> list = dao.getAllUser();
							for (User user : list) {
							%>
							<tr>
								<th><img src="<%= request.getContextPath() %>/data/img/profile_img/<%= user.getImage() %>" width="50px" height="50px"></th>
								<th><%=user.getFullName()%></th>
								<th scope="row"><%=user.getEmail()%></th>
								<th scope="row"><%=user.getMobNo()%></th>
								<td><%=user.getFullName()%><br><%=user.getAddress()%><br><%=user.getCity()%>
									,<%=user.getState()%>,<%=user.getPin()%><br>Mob No: <%=user.getMobNo()%>

								</td>
								<td><a href="deleteUser?id=<%=user.getId()%>"
									class="btn btn-danger">Delete</a></td>
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