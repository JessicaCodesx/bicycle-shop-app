<%@ page import="com.jessica.bicycleshopapp.model.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect("login.jsp");
    return;
  }
  String role = user.getRole();
%>

<html>
<head><title>Dashboard</title></head>
<%@ include file="navbar.jsp" %>
<body>
<h2>Welcome, <%= user.getUsername() %>!</h2>
<p>Your role: <%= role %></p>

<h3>Navigation</h3>
<ul>
  <li><a href="customers.jsp">Manage Customers</a></li>
  <li><a href="suppliers.jsp">Manage Suppliers</a></li>
  <li><a href="products.jsp">Manage Products</a></li>
  <li><a href="inventory.jsp">View Inventory</a></li>
  <li><a href="sales.jsp">View Sales</a></li>
  <li><a href="add-sale.jsp">Record a Sale</a></li>
  <li><a href="returns.jsp">View Returns</a></li>
  <li><a href="add-return.jsp">Record a Return</a></li>
  <li><a href="repairs.jsp">View Repairs</a></li>
  <li><a href="add-repair.jsp">Log a Repair</a></li>
  <li><a href="sales-report.jsp">Sales Report</a></li>
  <li><a href="inventory-report.jsp">Inventory Report</a></li>
  <li><a href="repair-report.jsp">Repair Report</a></li>

  <% if ("admin".equalsIgnoreCase(role)) { %>
  <li><a href="user-report.jsp">User Account Report</a></li>
  <% } %>

  <li><a href="login.jsp">Log Out</a></li>
</ul>
</body>
</html>
