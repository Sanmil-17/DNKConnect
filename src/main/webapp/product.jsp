<%@page import="com.entity.Category"%>
<%@page import="com.dao.CategoryDao"%>
<%@page import="com.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ecom : Product Page</title>
<%@include file="component/css.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
	<%@include file="component/navbar.jsp"%>
	<section>
		<div class="container-fluid p-4 mt-5 bg-custom">
			<div class="row">
				<div class="col-md-8 offset-md-2">
					<form action="search.jsp" method="post">
						<div class="input-group">
							<input type="text" class="form-control" name="ch">
							<button class="btn bg-primary ms-2 col-md-2 text-light">
								<i class="fa-solid fa-magnifying-glass"></i> Search
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>


		<div class="container-fluid mt-1">
			<div class="row">

				<div class="col-md-2">
					<div class="card">
						<div class="card-body">
							<p class="fs-5 text-center">Categories</p>
							<div class="list-group" style="width: 100%;">
								<a href="product.jsp?ca=all"
									class="list-group-item list-group-item-action "
									aria-current="true"> All </a>

								<%
								CategoryDao dao = new CategoryDao();
								List<Category> list = dao.getCategory();

								for (Category c : list) {
								%>
								<a href="product.jsp?ca=<%=c.getCategoryName()%>"
									class="list-group-item list-group-item-action"><%=c.getCategoryName()%>
								</a>
								<%
								}
								%>

							</div>
						</div>
					</div>
				</div>

				<div class="col-md-10 p-0">
					<div class="card">
						<div class="card-body">
							<p class="fs-3 text-center">Product</p>
							<div class="row">

								<%
								String ca = request.getParameter("ca");
								ProductDao dao2 = new ProductDao();
								List<Product> list2 = dao2.getProductByCategory(ca);
								for (Product p : list2) {
								%>
								<div class="col-md-3">
									<div class="card card-sh">
										<div class="card-body">
											<img src="data/img/product_img/<%=p.getImage()%>"
												width="100%" height="150px">
											<p class="fs-5 text-center">
												<%=p.getTitle()%></p>
											<div class="row">
												<a href="view_product.jsp?id=<%=p.getId()%>"
													class="btn btn-sm btn-primary col-md-6 ms-3">View
													Details</a> <a href="#"
													class="btn btn-sm btn-danger col-md-4 ms-1">&#36; <%=p.getPrice() %></a>
											</div>
										</div>
									</div>
								</div>
								<%
								}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>