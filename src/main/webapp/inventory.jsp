<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.InventoryDAO, com.jessica.bicycleshopapp.model.Inventory" %>
<%
  List<Inventory> inventoryList = new InventoryDAO().getAllInventory();
%>
<html>
<%@ include file="navbar.jsp" %>
<head><title>Inventory</title></head>
<body>
<h2>Inventory Overview</h2>
<a href="products.jsp">← Back to Products</a>
<table border="1">
  <tr>
    <th>Inventory ID</th><th>Product Name</th><th>Product ID</th><th>Quantity</th>
  </tr>
  <%
    for (Inventory inv : inventoryList) {
  %>
  <tr>
    <td><%= inv.getInventoryId() %></td>
    <td><%= inv.getProductName() %></td>
    <td><%= inv.getProductId() %></td>
    <td><%= inv.getQuantity() %></td>
  </tr>
  <% } %>
</table>
</body>
</html>
