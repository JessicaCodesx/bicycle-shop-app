package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AddReturnServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String saleIdStr = req.getParameter("saleId");
        String productIdStr = req.getParameter("productId");
        String quantityStr = req.getParameter("quantity");
        String reason = req.getParameter("reason");

        if (saleIdStr == null || productIdStr == null || quantityStr == null ||
                saleIdStr.isEmpty() || productIdStr.isEmpty() || quantityStr.isEmpty()) {
            resp.sendRedirect("add-return.jsp?error=1");
            return;
        }

        try {
            int saleId = Integer.parseInt(saleIdStr);
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            try (Connection conn = DBUtil.getConnection()) {
                conn.setAutoCommit(false);

                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO RETURNS (SaleID, ProductID, Quantity, ReturnDate, Reason) VALUES (?, ?, ?, CURDATE(), ?)"
                );
                ps.setInt(1, saleId);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);
                ps.setString(4, reason);
                ps.executeUpdate();

                PreparedStatement updateInv = conn.prepareStatement(
                        "UPDATE INVENTORY SET Quantity = Quantity + ? WHERE ProductID = ?"
                );
                updateInv.setInt(1, quantity);
                updateInv.setInt(2, productId);
                updateInv.executeUpdate();

                conn.commit();
            }

            resp.sendRedirect("returns.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect("add-return.jsp?error=1");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("add-return.jsp?error=1");
        }
    }
}
