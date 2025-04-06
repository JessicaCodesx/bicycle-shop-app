package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.util.DBUtil;
import com.jessica.bicycleshopapp.util.PasswordUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String rawPassword = req.getParameter("password");
        String role = req.getParameter("role");

        String hashedPassword = PasswordUtil.hashPasswordSHA256(rawPassword);

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO USERS (Username, Password, Role) VALUES (?, ?, ?)"
             )) {
            ps.setString(1, username);
            ps.setString(2, hashedPassword); // hashed password
            ps.setString(3, role.toLowerCase());
            ps.executeUpdate();

            resp.sendRedirect("add-user.jsp?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("add-user.jsp?error=1");
        }
    }
}
