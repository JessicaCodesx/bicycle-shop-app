package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.dao.RepairDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class AddRepairServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(req.getParameter("customerId"));
            int productId = Integer.parseInt(req.getParameter("productId"));
            double cost = Double.parseDouble(req.getParameter("cost"));
            String description = req.getParameter("description");

            Date today = new Date(System.currentTimeMillis());

            new RepairDAO().addRepair(customerId, productId, cost, today, description);
            resp.sendRedirect("repairs.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("add-repair.jsp?error=1");
        }
    }
}
