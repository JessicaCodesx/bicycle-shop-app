<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.UserDAO, com.jessica.bicycleshopapp.model.User" %>
<%
  User sessionUser = (User) session.getAttribute("user");
  if (sessionUser == null || !"admin".equalsIgnoreCase(sessionUser.getRole())) {
    response.sendRedirect("dashboard.jsp");
    return;
  }

  List<User> users = new UserDAO().getAllUsers();
%>

<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>User Report - Bike Shop System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="container">
  <div class="wrapper">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h1><i class="fas fa-users-cog"></i> User Report</h1>
      <a href="add-user.jsp" class="btn btn-primary">
        <i class="fas fa-user-plus"></i> Add New User
      </a>
    </div>

    <div class="card">
      <div class="card-header">
        <h3><i class="fas fa-user-shield"></i> All System Users</h3>
      </div>
      <div class="card-body">
        <div class="table-responsive">
          <table class="table">
            <thead>
            <tr>
              <th>ID</th>
              <th>Username</th>
              <th>Role</th>
              <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (User u : users) { %>
            <tr>
              <td><%= u.getUserId() %></td>
              <td><%= u.getUsername() %></td>
              <td><%= u.getRole() %></td>
              <td>
                <a href="edit-user.jsp?id=<%= u.getUserId() %>" class="btn btn-sm btn-outline-info">
                  <i class="fas fa-edit"></i> Edit
                </a>
                <% if (!"admin".equalsIgnoreCase(u.getRole())) { %>
                <a href="delete-user?id=<%= u.getUserId() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this user?');">
                  <i class="fas fa-trash-alt"></i> Delete
                </a>
                <% } %>
              </td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
