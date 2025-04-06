package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ReceiveOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(req.getParameter("orderId"));

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            PreparedStatement getOrder = conn.prepareStatement(
                    "SELECT ProductID, Quantity FROM ORDERS WHERE OrderID = ?"
            );
            getOrder.setInt(1, orderId);
            ResultSet rs = getOrder.executeQuery();

            if (rs.next()) {
                int productId = rs.getInt("ProductID");
                int quantity = rs.getInt("Quantity");

                PreparedStatement updateInv = conn.prepareStatement(
                        "UPDATE INVENTORY SET Quantity = Quantity + ? WHERE ProductID = ?"
                );
                updateInv.setInt(1, quantity);
                updateInv.setInt(2, productId);
                updateInv.executeUpdate();

                conn.commit();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("receive-order.jsp");
    }
}
