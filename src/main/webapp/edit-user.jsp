<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jessica.bicycleshopapp.dao.UserDAO, com.jessica.bicycleshopapp.model.User" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    User user = new UserDAO().getUserById(id);
%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User - Bike Shop System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-user-edit"></i> Edit User</h1>
            <a href="users.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Users
            </a>
        </div>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-user-cog"></i> User Details</h3>
            </div>
            <div class="card-body">
                <form method="post" action="editUser" id="editUserForm">
                    <input type="hidden" name="id" value="<%= user.getUserId() %>">

                    <div class="form-group">
                        <label for="username">Username <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-user text-muted mr-2"></i>
                            <input type="text" name="username" id="username" required value="<%= user.getUsername() %>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-lock text-muted mr-2"></i>
                            <input type="password" name="password" id="password" placeholder="Leave blank to keep current password">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="role">Role <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-user-tag text-muted mr-2"></i>
                            <select name="role" id="role" required>
                                <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                                <option value="owner" <%= "owner".equals(user.getRole()) ? "selected" : "" %>>Owner</option>
                                <option value="clerk" <%= "clerk".equals(user.getRole()) ? "selected" : "" %>>Clerk</option>
                            </select>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Update User
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const selects = document.querySelectorAll('select');
        selects.forEach(select => {
            select.addEventListener('change', function () {
                this.style.color = this.value ? 'var(--text-color)' : 'var(--light-text)';
            });

            select.style.color = select.value ? 'var(--text-color)' : 'var(--light-text)';
        });

        document.querySelectorAll('.mr-2').forEach(el => {
            el.style.marginRight = '10px';
        });
    });
</script>

</body>
</html>
