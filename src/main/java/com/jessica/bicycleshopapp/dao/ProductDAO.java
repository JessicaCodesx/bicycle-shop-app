package com.jessica.bicycleshopapp.dao;

import com.jessica.bicycleshopapp.model.Product;
import com.jessica.bicycleshopapp.util.DBUtil;

import java.sql.*;
import java.util.*;

public class ProductDAO {
    public void addProduct(Product p, int initialQuantity) throws Exception {
        Connection conn = null;
        PreparedStatement psProduct = null, psInventory = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            String sqlProduct = "INSERT INTO PRODUCT (Name, Price, Category, SupplierID, Discontinued) VALUES (?, ?, ?, ?, ?)";
            psProduct = conn.prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS);
            psProduct.setString(1, p.getName());
            psProduct.setDouble(2, p.getPrice());
            psProduct.setString(3, p.getCategory());
            psProduct.setInt(4, p.getSupplierId());
            psProduct.setBoolean(5, p.isDiscontinued());
            psProduct.executeUpdate();

            rs = psProduct.getGeneratedKeys();
            if (rs.next()) {
                int productId = rs.getInt(1);
                String sqlInventory = "INSERT INTO INVENTORY (ProductID, Quantity) VALUES (?, ?)";
                psInventory = conn.prepareStatement(sqlInventory);
                psInventory.setInt(1, productId);
                psInventory.setInt(2, initialQuantity);
                psInventory.executeUpdate();
            }

            conn.commit();
        } catch (Exception e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (psInventory != null) psInventory.close();
            if (psProduct != null) psProduct.close();
            if (conn != null) conn.close();
        }
    }

    public List<Product> getAllProducts() throws Exception {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM PRODUCT";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setName(rs.getString("Name"));
                p.setPrice(rs.getDouble("Price"));
                p.setCategory(rs.getString("Category"));
                p.setSupplierId(rs.getInt("SupplierID"));
                p.setDiscontinued(rs.getBoolean("Discontinued"));
                list.add(p);
            }
        }
        return list;
    }
}
