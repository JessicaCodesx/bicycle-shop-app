<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="navbar.jsp" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New User - Bike Shop System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-user-plus"></i> Add New User</h1>
            <a href="users.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Users
            </a>
        </div>

        <% if ("1".equals(request.getParameter("error"))) { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> Username already exists or input was invalid.
        </div>
        <% } else if ("success".equals(request.getParameter("status"))) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> User created successfully!
        </div>
        <% } %>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-user-cog"></i> User Details</h3>
            </div>
            <div class="card-body">
                <form method="post" action="addUser" id="userForm">
                    <div class="form-group">
                        <label for="username">Username <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-user text-muted mr-2"></i>
                            <input type="text" name="username" id="username" required placeholder="Enter username">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Password <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-lock text-muted mr-2"></i>
                            <input type="password" name="password" id="password" required placeholder="Enter password">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="role">Role <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-user-tag text-muted mr-2"></i>
                            <select name="role" id="role" required>
                                <option value="">-- Select Role --</option>
                                <option value="admin">Admin</option>
                                <option value="owner">Owner</option>
                                <option value="clerk">Clerk</option>
                            </select>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Create User
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
