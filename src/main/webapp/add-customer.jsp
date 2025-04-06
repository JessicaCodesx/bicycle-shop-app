<html>
<%@ include file="navbar.jsp" %>
<head><title>Add Customer</title></head>
<body>
<h2>Add New Customer</h2>
<form method="post" action="addCustomer">
    First Name: <input type="text" name="firstName" required><br/>
    Last Name: <input type="text" name="lastName" required><br/>
    Phone: <input type="text" name="phoneNumber"><br/>
    Email: <input type="email" name="email"><br/>
    Address: <input type="text" name="address"><br/>
    <input type="submit" value="Add Customer">
</form>

<% if (request.getParameter("error") != null) { %>
<p style="color:red;">Error adding customer.</p>
<% } %>
</body>
</html>
