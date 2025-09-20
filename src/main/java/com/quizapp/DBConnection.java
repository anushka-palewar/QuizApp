package com.quizapp;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/servlet_jsp_quizdb"; // your DB name
    private static final String USER = "root"; // your MySQL username
    private static final String PASSWORD = "Lisha@15"; // your MySQL password

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}

