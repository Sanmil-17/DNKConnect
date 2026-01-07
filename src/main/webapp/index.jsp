
<%@page import="com.entity.Product"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.entity.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.CategoryDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
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

	<div id="carouselExampleCaptions" class="carousel slide mt-5"
		data-bs-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleCaptions"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleCaptions"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleCaptions"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="data/img/ecom1.png" class="d-block w-100" alt="..."
					height="350px">

				<div class="carousel-caption d-none d-md-block"></div>
			</div>
			<div class="carousel-item">
				<img src="data/img/ecom3.jpg" class="d-block w-100" alt="..."
					height="350px">
				<div class="carousel-caption d-none d-md-block"></div>
			</div>
			<div class="carousel-item">
				<img src="data/img/ecom2.jpg" class="d-block w-100" alt="..."
					height="350px">
				<div class="carousel-caption d-none d-md-block"></div>
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	<div class="container">
		<div class="row">
			<p class="text-center fs-4">Category</p>


			<%
			CategoryDao dao = new CategoryDao();
			List<Category> list = dao.getCategory();
			int i = 0;
			for (Category c : list) {
				i++;
				if (i <= 6) {
			%>
			<div class="col-md-2 ">
				<div class="card rounded-circle cat-div">
					<div class="card-body text-center"  >
					
						<img alt="" src="data/img/category_img/<%=c.getImageName()%> "
							class="" width="65%" height="140px"  > 
							
						<p class="text-center"><a class="" href="product.jsp?ca=<%=c.getCategoryName()%>">
                                <%=c.getCategoryName()%>
                            </a></p>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
		<br>
		<hr>
	</div>


	<div class="container-fluid bg-light p-3">
		<div class="row">
			<p class="text-center fs-4">Latest Product</p>
			<%
			ProductDao dao2 = new ProductDao();
			List<Product> list2 = dao2.getAllProduct();
			int ii = 0;
			for (Product p : list2) {
				ii++;
				if (ii <= 8) {
			%>
			<div class="col-md-3" >
				<div class="card cat-div" >
					<div class="card-body text-center" >
						<img alt="" src="data/img/product_img/<%=p.getImage()%>" class=""
							width="65%" height="140px">
						<p class="text-center"><a href="view_product.jsp?id=<%=p.getId()%>"><%=p.getTitle()%></a></p>
						
					</div>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<%
			}
			}
			%>
		</div>
	</div>








	<%@include file="component/footer.jsp"%>
</body>
</html>
