<%@ page import="com.jessica.bicycleshopapp.model.User" %>
<%
  // Assume 'user' is already defined — just use it
  String navbarRole = "";
  if (session.getAttribute("user") instanceof User) {
    navbarRole = ((User) session.getAttribute("user")).getRole();
  }
%>

<div style="background:#eee;padding:10px;">
  <strong>Bike Shop Admin</strong> |
  <a href="dashboard.jsp">Dashboard</a> |
  <a href="customers.jsp">Customers</a> |
  <a href="suppliers.jsp">Suppliers</a> |
  <a href="products.jsp">Products</a> |
  <a href="inventory.jsp">Inventory</a> |
  <a href="sales.jsp">Sales</a> |
  <a href="returns.jsp">Returns</a> |
  <a href="repairs.jsp">Repairs</a> |
  <a href="sales-report.jsp">Sales Report</a> |
  <a href="inventory-report.jsp">Inventory Report</a> |
  <a href="repair-report.jsp">Repair Report</a>
  <% if ("admin".equalsIgnoreCase(navbarRole) || "owner".equalsIgnoreCase(navbarRole)) { %>
  | <a href="order-product.jsp">Order Inventory</a>
  | <a href="receive-shipment.jsp">Receive Shipment</a>
  <% } %>
  <% if ("admin".equalsIgnoreCase(navbarRole)) { %>
  | <a href="user-report.jsp">User Report</a>
  | <a href="add-user.jsp">Add User</a>
  <% } %>
  | <a href="logout.jsp">Logout</a>
</div>
<hr>
