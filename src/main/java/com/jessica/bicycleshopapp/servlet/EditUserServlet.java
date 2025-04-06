package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.dao.UserDAO;
import com.jessica.bicycleshopapp.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class EditUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        User updatedUser = new User();
        updatedUser.setUserId(id);
        updatedUser.setUsername(username);
        updatedUser.setRole(role);

        if (password != null && !password.trim().isEmpty()) {
            updatedUser.setPassword(password); // You should hash this if you are hashing on insert
        }

        new UserDAO().updateUser(updatedUser);
        resp.sendRedirect("user-report.jsp");
    }
}
