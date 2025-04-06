package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AddOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String deliveryDate = req.getParameter("delivery");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO ORDERS (ProductID, OrderDate, SupplierID, Quantity, DeliveryDate) " +
                             "SELECT ?, CURDATE(), SupplierID, ?, ? FROM PRODUCT WHERE ProductID = ?"
             )) {
            ps.setInt(1, productId);
            ps.setInt(2, quantity);
            ps.setDate(3, Date.valueOf(deliveryDate));
            ps.setInt(4, productId);
            ps.executeUpdate();
            resp.sendRedirect("add-order.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("add-order.jsp?error=1");
        }
    }
}
