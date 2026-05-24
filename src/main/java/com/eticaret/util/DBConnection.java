package com.eticaret.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static String url;
    private static String user;
    private static String password;

    static {
        try (InputStream input = DBConnection.class
                .getClassLoader()
                .getResourceAsStream("db.properties")) {

            if (input == null) {
                throw new RuntimeException("db.properties dosyası bulunamadı!");
            }

            Properties props = new Properties();
            props.load(input);

            url = props.getProperty("db.url");
            user = props.getProperty("db.user");
            password = props.getProperty("db.password");
            String driver = props.getProperty("db.driver");
            Class.forName(driver);

        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("Veritabanı yapılandırması yüklenemedi", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}