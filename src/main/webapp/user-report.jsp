<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.UserDAO, com.jessica.bicycleshopapp.model.User" %>
<%
  User sessionUser = (User) session.getAttribute("user");
  if (sessionUser == null || !"admin".equalsIgnoreCase(sessionUser.getRole())) {
    response.sendRedirect("dashboard.jsp");
    return;
  }

  List<User> users = new UserDAO().getAllUsers();
%>

<html>
<%@ include file="navbar.jsp" %>
<head><title>User Report</title></head>
<body>
<div class="wrapper">
  <h2>User Report</h2>
  <a href="add-user.jsp">+ Add New User</a>
  <table border="1">
    <tr>
      <th>ID</th><th>Username</th><th>Role</th><th>Actions</th>
    </tr>
    <% for (User u : users) { %>
    <tr>
      <td><%= u.getUserId() %></td>
      <td><%= u.getUsername() %></td>
      <td><%= u.getRole() %></td>
      <td>
        <a href="edit-user.jsp?id=<%= u.getUserId() %>">Edit</a>
        <% if (!"admin".equalsIgnoreCase(u.getRole())) { %>
        | <a href="delete-user?id=<%= u.getUserId() %>" onclick="return confirm('Are you sure?');">Delete</a>
        <% } %>
      </td>
    </tr>
    <% } %>
  </table>
</div>
</body>
</html>
