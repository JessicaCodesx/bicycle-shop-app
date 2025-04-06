<%@ page import="com.jessica.bicycleshopapp.dao.UserDAO, com.jessica.bicycleshopapp.model.User" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    User user = new UserDAO().getUserById(id);
%>
<html>
<%@ include file="navbar.jsp" %>
<head><title>Edit User</title></head>
<body>
<div class="wrapper">
    <h2>Edit User</h2>
    <form method="post" action="editUser">
        <input type="hidden" name="id" value="<%= user.getUserId() %>">
        Username: <input type="text" name="username" value="<%= user.getUsername() %>" required><br/>
        Password: <input type="password" name="password" placeholder="Leave blank to keep same"><br/>
        Role:
        <select name="role" required>
            <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
            <option value="owner" <%= "owner".equals(user.getRole()) ? "selected" : "" %>>Owner</option>
            <option value="clerk" <%= "clerk".equals(user.getRole()) ? "selected" : "" %>>Clerk</option>
        </select><br/>
        <input type="submit" value="Update User">
    </form>
</div>
</body>
</html>
