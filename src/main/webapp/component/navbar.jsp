<%@page import="com.dao.CartDAO"%>
<%@page import="com.entity.User"%>
<%@page import="com.entity.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.CategoryDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp"><i class="fa-solid fa-cart-shopping"></i>DNK Connect</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="index.jsp"><i
                            class="fas fa-home"></i> HOME</a></li>
                <li class="nav-item"><a class="nav-link active" href="product.jsp?ca=all">Products</a></li>
                <li class="nav-item dropdown"><a class="nav-link dropdown-toggle active" href="#"
                        id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">Category</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <% 
                            CategoryDao daox = new CategoryDao();
                            List<Category> listx = daox.getCategory();
                            for (Category c : listx) { 
                        %>
                        <li><a class="dropdown-item" href="product.jsp?ca=<%=c.getCategoryName()%>">
                                <%=c.getCategoryName()%>
                            </a></li>
                        <% } %>
                    </ul>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <!-- Check if an admin is logged in -->


                <!-- Check if a user is logged in -->
                <c:if test="${not empty userObj}">
                    <% 
                        User user = (User) session.getAttribute("userObj");
                        CartDAO cdaox = new CartDAO();
                        int cartSize = cdaox.getCart(user.getId()).size();
                    %>
                    <li class="nav-item"><a class="nav-link active" href="cart.jsp">[ <%=cartSize%> ] CART</a></li>
                    <li class="nav-item"><a class="nav-link active" href="orders.jsp">ORDERS</a></li>
                    <li class="nav-item dropdown"><a class="nav-link active dropdown-toggle" href="#" id="navbarDropdownMenuLink"
                            role="button" data-bs-toggle="dropdown" aria-expanded="false"><i
                                class="fas fa-user-circle"></i> ${userObj.fullName}</a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <li><a class="dropdown-item" href="edit_profile.jsp">View Profile</a></li>
                            <li><a class="dropdown-item" href="ulogout">Logout</a></li>
                        </ul>
                    </li>
                </c:if>

                <!-- If no user or admin is logged in -->
                <c:if test="${empty userObj && empty adminObj}">
                    <li class="nav-item"><a class="nav-link active" href="login.jsp"><i class="fas fa-sign-in-alt"></i> LOGIN</a></li>
                    <li class="nav-item"><a class="nav-link active" href="register.jsp">REGISTER</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>