package com.jessica.bicycleshopapp.util;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtilMSSQL {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=bike_shop_project_db;encrypt=true;trustServerCertificate=true";
    private static final String USER = "db_user";
    private static final String PASS = "db_pass";

    public static Connection getConnection() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
