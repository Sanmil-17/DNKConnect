<%@page import="com.dao.OrderDao"%>

<%
String st = request.getParameter("st");
if (st != null) {
    int id = Integer.parseInt(request.getParameter("id"));
    OrderDao dao2 = new OrderDao();
    boolean f = dao2.updateStatus(st, String.valueOf(id));  // Convert id to String if needed
    if (f) {
        session.setAttribute("succMsg", "Order status updated");
        response.sendRedirect("orders.jsp");
    }
}
%>
