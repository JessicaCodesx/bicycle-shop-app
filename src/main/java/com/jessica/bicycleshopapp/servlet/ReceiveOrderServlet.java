package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ReceiveOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(req.getParameter("orderId"));

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            PreparedStatement getOrder = conn.prepareStatement(
                    "SELECT ProductID, Quantity FROM ORDERS WHERE OrderID = ? AND Received = FALSE"
            );
            getOrder.setInt(1, orderId);
            ResultSet rs = getOrder.executeQuery();

            if (rs.next()) {
                int productId = rs.getInt("ProductID");
                int quantity = rs.getInt("Quantity");

                PreparedStatement updateInventory = conn.prepareStatement(
                        "UPDATE INVENTORY SET Quantity = Quantity + ? WHERE ProductID = ?"
                );
                updateInventory.setInt(1, quantity);
                updateInventory.setInt(2, productId);
                updateInventory.executeUpdate();

                PreparedStatement markReceived = conn.prepareStatement(
                        "UPDATE ORDERS SET Received = TRUE WHERE OrderID = ?"
                );
                markReceived.setInt(1, orderId);
                markReceived.executeUpdate();

                conn.commit();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("receive-orders.jsp");
    }
}
