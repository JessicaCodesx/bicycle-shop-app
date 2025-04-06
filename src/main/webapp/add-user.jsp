<%@ include file="navbar.jsp" %>
<%@ page import="java.util.*" %>
<html>
<head><title>Add User</title></head>
<body>
<div class="wrapper">
    <h2>Add New User</h2>
    <form method="post" action="addUser">
        Username: <input type="text" name="username" required><br/>
        Password: <input type="password" name="password" required><br/>
        Role:
        <select name="role">
            <option value="admin">Admin</option>
            <option value="owner">Owner</option>
            <option value="clerk">Clerk</option>
        </select><br/>
        <input type="submit" value="Create User">
    </form>

    <% if ("1".equals(request.getParameter("error"))) { %>
    <p style="color:red;">Error: Username already exists or invalid input.</p>
    <% } else if ("success".equals(request.getParameter("status"))) { %>
    <p style="color:green;">User created successfully!</p>
    <% } %>
</div>
</body>
</html>
