package com.jessica.bicycleshopapp.dao;

import com.jessica.bicycleshopapp.model.Sale;
import com.jessica.bicycleshopapp.util.DBUtil;

import java.sql.*;

public class SaleDAO {
    public int addSale(int customerId, Date saleDate, double cost) throws Exception {
        String sql = "INSERT INTO SALES (CustomerID, SaleDate, Cost) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, customerId);
            ps.setDate(2, saleDate);
            ps.setDouble(3, cost);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        }
        return -1;
    }

    public void addSaleDetail(int saleId, int productId, int quantity) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            String detailSQL = "INSERT INTO SALEDETAILS (SaleID, ProductID, Quantity) VALUES (?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(detailSQL)) {
                ps.setInt(1, saleId);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);
                ps.executeUpdate();
            }

            String updateStock = "UPDATE INVENTORY SET Quantity = Quantity - ? WHERE ProductID = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateStock)) {
                ps.setInt(1, quantity);
                ps.setInt(2, productId);
                ps.executeUpdate();
            }

            conn.commit();
        }
    }
}
