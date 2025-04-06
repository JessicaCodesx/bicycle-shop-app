package com.jessica.bicycleshopapp.dao;

import com.jessica.bicycleshopapp.util.DBUtil;

import java.sql.*;

public class RepairDAO {
    public void addRepair(int customerId, int productId, double cost, Date repairDate, String description) throws Exception {
        String sql = "INSERT INTO REPAIRS (CustomerID, ProductID, Cost, RepairDate, Description) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ps.setDouble(3, cost);
            ps.setDate(4, repairDate);
            ps.setString(5, description);
            ps.executeUpdate();
        }
    }
}