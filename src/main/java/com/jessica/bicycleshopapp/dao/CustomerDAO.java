package com.jessica.bicycleshopapp.dao;

import com.jessica.bicycleshopapp.model.Customer;
import com.jessica.bicycleshopapp.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    public void addCustomer(Customer c) throws Exception {
        String sql = "INSERT INTO CUSTOMER (FirstName, LastName, PhoneNumber, Email, Address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getFirstName());
            ps.setString(2, c.getLastName());
            ps.setString(3, c.getPhoneNumber());
            ps.setString(4, c.getEmail());
            ps.setString(5, c.getAddress());
            ps.executeUpdate();
        }
    }

    public List<Customer> getAllCustomers() throws Exception {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM CUSTOMER";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerId(rs.getInt("CustomerID"));
                c.setFirstName(rs.getString("FirstName"));
                c.setLastName(rs.getString("LastName"));
                c.setPhoneNumber(rs.getString("PhoneNumber"));
                c.setEmail(rs.getString("Email"));
                c.setAddress(rs.getString("Address"));
                list.add(c);
            }
        }
        return list;
    }
}