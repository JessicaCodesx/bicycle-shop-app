package com.jessica.bicycleshopapp.dao;

import com.jessica.bicycleshopapp.model.User;
import com.jessica.bicycleshopapp.util.DBUtil;
import com.jessica.bicycleshopapp.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public User validateUser(String username, String password) {
        String sql = "SELECT * FROM USERS WHERE Username = ? AND Password = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setRole(rs.getString("Role"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM USERS");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("UserID"));
                u.setUsername(rs.getString("Username"));
                u.setPassword(rs.getString("Password"));
                u.setRole(rs.getString("Role"));
                users.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public User getUserById(int id) {
        User u = null;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM USERS WHERE UserID = ?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new User();
                u.setUserId(rs.getInt("UserID"));
                u.setUsername(rs.getString("Username"));
                u.setPassword(rs.getString("Password"));
                u.setRole(rs.getString("Role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public void updateUser(User user) {
        try (Connection conn = DBUtil.getConnection()) {
            if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
                PreparedStatement ps = conn.prepareStatement(
                        "UPDATE USERS SET Username = ?, Password = ?, Role = ? WHERE UserID = ?"
                );
                String hashed = PasswordUtil.hash(user.getPassword());
                ps.setString(1, user.getUsername());
                ps.setString(2, hashed); // store hashed password
                ps.setString(3, user.getRole());
                ps.setInt(4, user.getUserId());
                ps.executeUpdate();
            } else {
                PreparedStatement ps = conn.prepareStatement(
                        "UPDATE USERS SET Username = ?, Role = ? WHERE UserID = ?"
                );
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getRole());
                ps.setInt(3, user.getUserId());
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void deleteUser(int id) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM USERS WHERE UserID = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
