package com.jessica.bicycleshopapp.dao;


import com.jessica.bicycleshopapp.util.DBUtil;

import java.sql.*;

public class ReturnDAO {
    public void recordReturn(int saleId, int productId, int quantity, String reason) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            String insertReturn = "INSERT INTO RETURNS (SaleID, ProductID, Quantity, ReturnDate, Reason) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertReturn)) {
                ps.setInt(1, saleId);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);
                ps.setDate(4, new Date(System.currentTimeMillis()));
                ps.setString(5, reason);
                ps.executeUpdate();
            }

            String updateInventory = "UPDATE INVENTORY SET Quantity = Quantity + ? WHERE ProductID = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateInventory)) {
                ps.setInt(1, quantity);
                ps.setInt(2, productId);
                ps.executeUpdate();
            }

            conn.commit();
        }
    }
}