<%@ page import="com.jessica.bicycleshopapp.dao.SupplierDAO, com.jessica.bicycleshopapp.model.Supplier" %>
<%
  int id = Integer.parseInt(request.getParameter("id"));
  Supplier s = new SupplierDAO().getSupplierById(id);
%>
<%@ include file="navbar.jsp" %>
<html>
<head><title>Edit Supplier</title></head>
<body>
<div class="wrapper">
  <h2>Edit Supplier</h2>
  <form method="post" action="editSupplier">
    <input type="hidden" name="id" value="<%= s.getSupplierId() %>">
    Name: <input type="text" name="name" value="<%= s.getSupplierName() %>" required><br/>
    Email: <input type="email" name="email" value="<%= s.getSupplierEmail() %>"><br/>
    Phone: <input type="text" name="phone" value="<%= s.getSupplierPhone() %>"><br/>
    <input type="submit" value="Update Supplier">
  </form>
</div>
</body>
</html>
