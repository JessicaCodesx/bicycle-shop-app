<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Bike Shop System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: var(--light-bg);
            background-image: linear-gradient(to bottom right, #2c3e50, #3498db);
            background-attachment: fixed;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            animation: fadeIn 0.8s;
        }

        .login-header-image {
            text-align: center;
            margin-bottom: 20px;
        }

        .login-header-image i {
            font-size: 4rem;
            color: var(--primary-color);
            background: white;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .error-shake {
            animation: shake 0.5s;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-header-image">
        <i class="fas fa-bicycle"></i>
    </div>

    <div class="login-logo">
        <h1>Bike Shop System</h1>
        <p>Please login to continue</p>
    </div>

    <% if ("1".equals(request.getParameter("error"))) { %>
    <div class="alert alert-danger error-shake">
        Invalid username or password. Please try again.
    </div>
    <% } %>

    <form method="post" action="login" class="login-form">
        <div class="form-group">
            <label for="username"><i class="fas fa-user"></i> Username</label>
            <input type="text" id="username" name="username" placeholder="Enter your username" required autofocus>
        </div>

        <div class="form-group">
            <label for="password"><i class="fas fa-lock"></i> Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="btn btn-block">
            <i class="fas fa-sign-in-alt"></i> Login
        </button>
    </form>

    <div class="text-center mt-4 text-muted">
        <small>&copy; 2025 Bike Shop System</small>
    </div>
</div>
</body>
</html>