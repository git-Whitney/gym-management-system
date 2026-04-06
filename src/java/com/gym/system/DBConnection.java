package com.gym.system;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/gym_management";
   private static final String USER = "gymuser";
private static final String PASSWORD = "1234"; 

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
             System.out.println("❌ DATABASE CONNECTION FAILED");
            e.printStackTrace();
        }
        return conn;
    }
}