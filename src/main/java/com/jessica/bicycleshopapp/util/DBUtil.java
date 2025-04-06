package com.jessica.bicycleshopapp.util;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/bike_shop_project_db";
    private static final String USER = "db_user";
    private static final String PASS = "db_pass";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}