package com.jessica.bicycleshopapp.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    // Change this to "mysql" or "mssql" to switch between database types
    private static final String DB_TYPE = "mysql";

    // MySQL config
    private static final String MYSQL_URL = "jdbc:mysql://localhost:3306/bike_shop_project_db";
    private static final String MYSQL_USER = "db_user";
    private static final String MYSQL_PASS = "db_pass";

    // MS SQL config
    private static final String MSSQL_URL = "jdbc:sqlserver://localhost:1433;databaseName=bike_shop_project_db;encrypt=true;trustServerCertificate=true";
    private static final String MSSQL_USER = "db_user";
    private static final String MSSQL_PASS = "db_pass";

    public static Connection getConnection() throws Exception {
        if ("mysql".equalsIgnoreCase(DB_TYPE)) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(MYSQL_URL, MYSQL_USER, MYSQL_PASS);
        } else if ("mssql".equalsIgnoreCase(DB_TYPE)) {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(MSSQL_URL, MSSQL_USER, MSSQL_PASS);
        } else {
            throw new IllegalArgumentException("Unsupported DB_TYPE: " + DB_TYPE);
        }
    }
}
