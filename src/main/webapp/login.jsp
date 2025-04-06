<html>
<head><title>Login</title></head>
<body>
<h2>Login</h2>
<form method="post" action="login">
    <label>Username:</label><input type="text" name="username"/><br/>
    <label>Password:</label><input type="password" name="password"/><br/>
    <input type="submit" value="Login"/>
</form>

<% if ("1".equals(request.getParameter("error"))) { %>
<p style="color:red;">Invalid credentials</p>
<% } %>
</body>
</html>
