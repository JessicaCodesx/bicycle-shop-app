package com.jessica.bicycleshopapp.dao;

import com.jessica.bicycleshopapp.model.Inventory;
import com.jessica.bicycleshopapp.model.Order;
import com.jessica.bicycleshopapp.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO {

    public List<Inventory> getAllInventory() throws Exception {
        List<Inventory> list = new ArrayList<>();
        String sql = "SELECT i.InventoryID, i.ProductID, p.Name AS ProductName, i.Quantity " +
                "FROM INVENTORY i " +
                "JOIN PRODUCT p ON i.ProductID = p.ProductID";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Inventory inv = new Inventory();
                inv.setInventoryId(rs.getInt("InventoryID"));
                inv.setProductId(rs.getInt("ProductID"));
                inv.setProductName(rs.getString("ProductName"));
                inv.setQuantity(rs.getInt("Quantity"));
                list.add(inv);
            }
        }

        return list;
    }

    public void placeOrder(Order order) throws Exception {
        String sql = "INSERT INTO ORDERS (ProductID, SupplierID, Quantity, OrderDate, DeliveryDate) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, order.getProductId());
            stmt.setInt(2, order.getSupplierId());
            stmt.setInt(3, order.getQuantity());
            stmt.setDate(4, Date.valueOf(order.getOrderDate()));
            stmt.setDate(5, Date.valueOf(order.getDeliveryDate()));

            stmt.executeUpdate();
        }
    }

    public void receiveShipment(int productId, int quantity) throws Exception {
        String sql = "UPDATE INVENTORY SET Quantity = Quantity + ? WHERE ProductID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        }
    }
}
