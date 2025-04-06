<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.CustomerDAO, com.jessica.bicycleshopapp.model.Customer" %>
<%@ include file="head.jsp" %>
<%@ include file="navbar.jsp" %>
<%
    List<Customer> customers = new CustomerDAO().getAllCustomers();
    String role = ((com.jessica.bicycleshopapp.model.User) session.getAttribute("user")).getRole().toLowerCase();
%>

<html>
<body>
<div class="wrapper">
    <h2>Customer List</h2>
    <a href="add-customer.jsp">+ Add New Customer</a>
    <table border="1">
        <tr>
            <th>ID</th><th>Name</th><th>Phone</th><th>Email</th><th>Address</th>
            <% if ("admin".equals(role) || "owner".equals(role)) { %>
            <th>Action</th>
            <% } %>
        </tr>

        <% for (Customer c : customers) { %>
        <tr>
            <td><%= c.getCustomerId() %></td>
            <td><%= c.getFirstName() %> <%= c.getLastName() %></td>
            <td><%= c.getPhoneNumber() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getAddress() %></td>
            <% if ("admin".equals(role) || "owner".equals(role)) { %>
            <td>
                <form method="post" action="deleteCustomer" onsubmit="return confirm('Are you sure you want to delete this customer?');">
                    <input type="hidden" name="id" value="<%= c.getCustomerId() %>">
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
