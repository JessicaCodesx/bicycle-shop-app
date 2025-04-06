package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        new UserDAO().deleteUser(id);
        resp.sendRedirect("user-report.jsp");
    }
}
