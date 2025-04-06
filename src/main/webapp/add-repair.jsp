<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.CustomerDAO, com.jessica.bicycleshopapp.dao.ProductDAO, com.jessica.bicycleshopapp.model.Customer, com.jessica.bicycleshopapp.model.Product" %>
<%
    List<Customer> customers = new CustomerDAO().getAllCustomers();
    List<Product> products = new ProductDAO().getAllProducts();
%>
<html>
<%@ include file="navbar.jsp" %>
<head><title>Log Repair</title></head>
<body>
<h2>Log Repair</h2>
<form method="post" action="addRepair">
    Customer:
    <select name="customerId">
        <% for (Customer c : customers) { %>
        <option value="<%= c.getCustomerId() %>"><%= c.getFirstName() %> <%= c.getLastName() %></option>
        <% } %>
    </select><br/>

    Product:
    <select name="productId">
        <% for (Product p : products) { %>
        <option value="<%= p.getProductId() %>"><%= p.getName() %></option>
        <% } %>
    </select><br/>

    Cost: <input type="number" step="0.01" name="cost" required><br/>
    Description: <input type="text" name="description"><br/>
    <input type="submit" value="Submit Repair">
</form>

<% if (request.getParameter("error") != null) { %>
<p style="color:red;">Error logging repair.</p>
<% } %>
</body>
</html>
