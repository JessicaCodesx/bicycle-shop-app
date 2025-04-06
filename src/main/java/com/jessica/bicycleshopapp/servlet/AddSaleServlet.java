package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AddSaleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int customerId = Integer.parseInt(req.getParameter("customerId"));
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            PreparedStatement checkInv = conn.prepareStatement(
                    "SELECT Quantity FROM INVENTORY WHERE ProductID = ?"
            );
            checkInv.setInt(1, productId);
            ResultSet invRs = checkInv.executeQuery();
            if (!invRs.next() || invRs.getInt("Quantity") < quantity) {
                resp.sendRedirect("add-sale.jsp?error=insufficient");
                return;
            }

            double price = 0.0;
            PreparedStatement priceStmt = conn.prepareStatement(
                    "SELECT Price FROM PRODUCT WHERE ProductID = ?"
            );
            priceStmt.setInt(1, productId);
            ResultSet rs = priceStmt.executeQuery();
            if (rs.next()) {
                price = rs.getDouble("Price");
            }

            PreparedStatement saleStmt = conn.prepareStatement(
                    "INSERT INTO SALES (CustomerID, SaleDate, Cost) VALUES (?, CURDATE(), ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            double cost = price * quantity;
            saleStmt.setInt(1, customerId);
            saleStmt.setDouble(2, cost);
            saleStmt.executeUpdate();

            ResultSet keys = saleStmt.getGeneratedKeys();
            int saleId = 0;
            if (keys.next()) {
                saleId = keys.getInt(1);
            }

            PreparedStatement detailStmt = conn.prepareStatement(
                    "INSERT INTO SALEDETAILS (SaleID, ProductID, Quantity) VALUES (?, ?, ?)"
            );
            detailStmt.setInt(1, saleId);
            detailStmt.setInt(2, productId);
            detailStmt.setInt(3, quantity);
            detailStmt.executeUpdate();

            PreparedStatement updateInv = conn.prepareStatement(
                    "UPDATE INVENTORY SET Quantity = Quantity - ? WHERE ProductID = ?"
            );
            updateInv.setInt(1, quantity);
            updateInv.setInt(2, productId);
            updateInv.executeUpdate();

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("sales.jsp");
    }
}
