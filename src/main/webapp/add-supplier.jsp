<html>
<%@ include file="navbar.jsp" %>
<head><title>Add Supplier</title></head>
<body>
<h2>Add Supplier</h2>
<form method="post" action="addSupplier">
  Name: <input type="text" name="supplierName" required><br/>
  Email: <input type="email" name="supplierEmail"><br/>
  Phone: <input type="text" name="supplierPhone"><br/>
  <input type="submit" value="Add Supplier">
</form>

<% if (request.getParameter("error") != null) { %>
<p style="color:red;">Error adding supplier.</p>
<% } %>
</body>
</html>
