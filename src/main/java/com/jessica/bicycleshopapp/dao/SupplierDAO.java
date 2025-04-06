package com.jessica.bicycleshopapp.dao;

import com.jessica.bicycleshopapp.model.Supplier;
import com.jessica.bicycleshopapp.util.DBUtil;

import java.sql.*;
import java.util.*;

public class SupplierDAO {
    public void addSupplier(Supplier s) throws Exception {
        String sql = "INSERT INTO SUPPLIER (SupplierName, SupplierEmail, SupplierPhone) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getSupplierName());
            ps.setString(2, s.getSupplierEmail());
            ps.setString(3, s.getSupplierPhone());
            ps.executeUpdate();
        }
    }

    public List<Supplier> getAllSuppliers() throws Exception {
        List<Supplier> list = new ArrayList<>();
        String sql = "SELECT * FROM SUPPLIER";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Supplier s = new Supplier();
                s.setSupplierId(rs.getInt("SupplierID"));
                s.setSupplierName(rs.getString("SupplierName"));
                s.setSupplierEmail(rs.getString("SupplierEmail"));
                s.setSupplierPhone(rs.getString("SupplierPhone"));
                list.add(s);
            }
        }
        return list;
    }

    public Supplier getSupplierById(int id) {
        Supplier supplier = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT * FROM SUPPLIER WHERE SupplierID = ?"
             )) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                supplier = new Supplier();
                supplier.setSupplierId(rs.getInt("SupplierID"));
                supplier.setSupplierName(rs.getString("SupplierName"));
                supplier.setSupplierEmail(rs.getString("SupplierEmail"));
                supplier.setSupplierPhone(rs.getString("SupplierPhone"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return supplier;
    }
}