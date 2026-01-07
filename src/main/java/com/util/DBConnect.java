package com.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    public static Connection conn = null;

    public static Connection getConnection() {
        try {
            // Check if the connection is closed or null
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecom_db", "root", "password");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
