package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.dao.UserDAO;
import com.jessica.bicycleshopapp.model.User;
import com.jessica.bicycleshopapp.util.PasswordUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = PasswordUtil.hashPasswordSHA256(req.getParameter("password"));

        UserDAO dao = new UserDAO();
        User user = dao.validateUser(username, password);

        System.out.println("Username: " + username);
        System.out.println("Raw password: " + req.getParameter("password"));
        System.out.println("Hashed password: " + password);
        System.out.println("User from DB: " + (user != null ? user.getUsername() : "null"));



        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect("dashboard.jsp");
        } else {
            resp.sendRedirect("login.jsp?error=1");
        }
    }
}