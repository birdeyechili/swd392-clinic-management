package com.example.swd392_clinic_management.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {
    private Connection connection;

    public DBUtil(){
        Properties properties = new Properties();

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            properties.load(DBUtil.class.getResourceAsStream("/dbConfig.properties"));
            String url = properties.getProperty("url");
            String userName = properties.getProperty("userName");
            String password = properties.getProperty("password");
            connection = DriverManager.getConnection(url, userName, password);
        } catch (SQLException | ClassNotFoundException | IOException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection(){
        return connection;
    }
}
