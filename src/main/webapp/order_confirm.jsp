
<%@page import="com.entity.Product"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.entity.ProductOrder"%>
<%@page import="com.entity.Cart"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.OrderDao"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.dao.CartDAO"%>
<%@page import="com.entity.User"%>
<%
try {

	User user = (User) session.getAttribute("userObj");
	String totalPrice = request.getParameter("amt");

	CartDAO dao = new CartDAO();
	ProductDao pdao = new ProductDao();
	OrderDao odao = new OrderDao();

	List<Cart> plist = dao.getCart(user.getId());

	ProductOrder o = null;

	ArrayList<ProductOrder> orderList = new ArrayList<ProductOrder>();
	Random r = new Random();

	for (Cart c : plist) {
		o = new ProductOrder();
		Product p = pdao.getProductByid(c.getPid());
		o.setUserId(user.getId());
		o.setProductid(p.getId());
		o.setOrderId("PROD-ORD-00" + r.nextInt(1000));
		o.setQuantity(c.getQuantity());
		o.setPrice(p.getPrice());
		o.setPaymentType("Card Payment");
		o.setOrderStatus("Order Processing");
		orderList.add(o);

	}

	boolean f = odao.saveOrder(orderList);

	if (f) {
		for (ProductOrder po : orderList) {
	Product p = pdao.getProductByid(po.getProductid());
	pdao.updateProductStock(p.getId(), p.getStock() - po.getQuantity());
		}
		response.sendRedirect("order_success.jsp");
	} else {
		session.setAttribute("failedMsg", "Your Order Failed");
		response.sendRedirect("cart.jsp");
	}

} catch (Exception e) {
	e.printStackTrace();
}
%>