<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.SupplierDAO, com.jessica.bicycleshopapp.model.Supplier" %>
<%
  List<Supplier> suppliers = new SupplierDAO().getAllSuppliers();
%>
<html>
<%@ include file="navbar.jsp" %>
<head><title>Add Product</title></head>
<body>
<h2>Add Product</h2>
<form method="post" action="addProduct">
  Name: <input type="text" name="name" required><br/>
  Price: <input type="number" name="price" step="0.01" required><br/>
  Category: <input type="text" name="category"><br/>
  Supplier:
  <select name="supplierId">
    <%
      for (Supplier s : suppliers) {
    %>
    <option value="<%= s.getSupplierId() %>"><%= s.getSupplierName() %></option>
    <% } %>
  </select><br/>
  Initial Stock: <input type="number" name="quantity" value="0"><br/>
  <input type="submit" value="Add Product">
</form>

<% if (request.getParameter("error") != null) { %>
<p style="color:red;">Error adding product.</p>
<% } %>
</body>
</html>
