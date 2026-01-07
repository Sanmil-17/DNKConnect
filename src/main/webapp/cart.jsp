<%@page import="com.entity.Product"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.entity.Cart"%>
<%@page import="com.dao.CartDAO"%>
<%@page import="com.entity.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Cart Page</title>
    <%@include file="../component/css.jsp"%>
</head>
<body>
    <c:if test="${empty userObj }">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>
    <%@include file="../component/navbar.jsp"%>
    <div class="container p-5">
        <div class="row">
            <p class="text-center fs-4">Cart Page</p>
            <c:if test="${not empty succMsg}">
                <div class="alert alert-success text-center" role="alert">${succMsg}</div>
                <c:remove var="succMsg" scope="session" />
            </c:if>

            <c:if test="${not empty failedMsg}">
                <div class="alert alert-danger text-center" role="alert">${failedMsg}</div>
                <c:remove var="failedMsg" scope="session" />
            </c:if>

            <div class="col-md-8">
                <table class="table">
                    <thead class="text-center bg-light ">
                        <tr>
                            <th scope="col">Image</th>
                            <th scope="col">Name</th>
                            <th scope="col">Price</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Total Price</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <%
                        User user = (User) session.getAttribute("userObj");
                        CartDAO dao = new CartDAO();
                        ProductDao dao2 = new ProductDao();
                        List<Cart> list = dao.getCart(user.getId());
                        double totalBillingPrice = 0; // Changed to double to avoid type mismatch

                        for (Cart c : list) {
                            Product p = dao2.getProductByid(c.getPid());
                        %>
                        <tr>
                            <th scope="row">
                                <img src="data/img/product_img/<%=p.getImage()%>" width="50px" height="50px">
                            </th>
                            <td class="p-3">
                                <p class="fs-5"><%=p.getTitle()%></p>
                                <% if (p.getStock() < c.getQuantity()) out.print("<span class='text-danger'>(out of stock)<span>"); %>
                            </td>
                            <td class="p-3">
                                <p class="fs-5"><%=p.getPrice()%></p>
                            </td>
                            <td class="p-3">
                                <p class="fs-5">
                                    <a href="/Ecommerce_Store/cartin?qu=<%=c.getQuantity()%>&&cid=<%=c.getId()%>&&si=plus" class="text-decoration-none"><i class="fa-solid fa-plus"></i></a>
                                    [ <%=c.getQuantity()%> ] 
                                    <a href="/Ecommerce_Store/cartin?qu=<%=c.getQuantity()%>&&cid=<%=c.getId()%>&&si=neg" class="text-decoration-none"><i class="fa-solid fa-minus"></i></a>
                                </p>
                            </td>
                            <td class="p-3">
                                <%
                                double totalprice = Double.parseDouble(p.getPrice()) * c.getQuantity();
                                totalBillingPrice = totalBillingPrice + totalprice;
                                %>
                                <%= String.format("%.2f", totalprice) %> 
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="col-md-4">
                <div class="col-md-12">
                    <div class="card paint-card">
                        <div class="card-body">
                            <p class="fs-6 text-Secondary text-center">Delivery Address</p>
                            <p style="color: black;">
                                ${userObj.fullName } <br> ${userObj.address }<br>${userObj.city }, ${userObj.state }, ${userObj.pin } <br>Mobile No: ${userObj.mobNo }
                            </p>
                            <a class="fs-5 text-decoration-none" href="edit_profile.jsp">Change Address</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 mt-2">
                    <div class="card paint-card">
                        <div class="card-body">
                            <p class="fs-6 text-Secondary text-center">Payment</p>
                            <p class="fw-bold" style="color: black;">
                                Amount: &#36; <%=String.format("%.2f", totalBillingPrice)%><br> 
                                Shipping Charge:&#36; 1 <br> 
                                Tax: &#36; 1
                            </p>
                            <hr>
                            <p class="fw-bold">
                                Total Amount: &#36; <%=String.format("%.2f", totalBillingPrice + 2)%><br>
                            </p>

                     <form class="row g-3" action="order" method="post">
					    <div class="form-group">
					        <label class="form-label">Payment Mode</label>
					        <select name="payment" class="form-control form-control-sm">
					            <option value="noselect">--select--</option>
					            <option value="Debit card">Debit Card</option>
					            <option value="COD">Cash On Delivery</option>
					            <option value="PayPal">PayPal</option>
					        </select>
					    </div>
					    <input type="hidden" name="amt" value="<%=totalBillingPrice +1+1%>">
					    <input type="hidden" name="uid" value="${userObj.id}">
					    <% if (list.isEmpty()) { %>
					    <button class="btn btn-success col-md-12 text-white" disabled>Place Order</button>
					    <% } else { %>
					    <button class="btn btn-success col-md-12 text-white">Place Order</button>
					    <% } %>
					</form>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
