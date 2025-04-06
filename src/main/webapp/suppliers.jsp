<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.SupplierDAO, com.jessica.bicycleshopapp.model.Supplier" %>
<%
    List<Supplier> suppliers = new SupplierDAO().getAllSuppliers();
    String role = ((com.jessica.bicycleshopapp.model.User) session.getAttribute("user")).getRole().toLowerCase();
%>
<html>
<%@ include file="navbar.jsp" %>
<head><title>Suppliers</title></head>
<body>
<div class="wrapper">
    <h2>Supplier List</h2>
    <a href="add-supplier.jsp">+ Add Supplier</a>
    <table border="1">
        <tr>
            <th>ID</th><th>Name</th><th>Email</th><th>Phone</th>
            <% if ("admin".equals(role) || "owner".equals(role)) { %>
            <th>Actions</th>
            <% } %>
        </tr>
        <% for (Supplier s : suppliers) { %>
        <tr>
            <td><%= s.getSupplierId() %></td>
            <td><%= s.getSupplierName() %></td>
            <td><%= s.getSupplierEmail() %></td>
            <td><%= s.getSupplierPhone() %></td>
            <% if ("admin".equals(role) || "owner".equals(role)) { %>
            <td>
                <form action="edit-supplier.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= s.getSupplierId() %>">
                    <input type="submit" value="Edit">
                </form>
                <form action="deleteSupplier" method="post" style="display:inline;"
                      onsubmit="return confirm('Are you sure you want to delete this supplier?');">
                    <input type="hidden" name="id" value="<%= s.getSupplierId() %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
            <% } %>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
