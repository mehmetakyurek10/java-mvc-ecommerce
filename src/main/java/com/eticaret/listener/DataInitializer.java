package com.eticaret.listener;

import com.eticaret.dao.UserDAO;
import com.eticaret.model.User;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DataInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        UserDAO userDAO = new UserDAO();
        ensureUser(userDAO, "Admin User", "admin@eticaret.com", "admin123",
                "5551234567", "Yönetim Merkezi", "ADMIN");
        ensureUser(userDAO, "Ahmet Yılmaz", "ahmet@example.com", "user123",
                "5559876543", "İstanbul", "CUSTOMER");
    }

    private void ensureUser(UserDAO userDAO, String fullName, String email, String password,
            String phone, String address, String role) {
        if (!userDAO.isEmailExists(email)) {
            userDAO.registerUser(new User(fullName, email, password, phone, address, role));
            return;
        }
        String stored = userDAO.getStoredPassword(email);
        if (stored == null || !stored.startsWith("$2")) {
            userDAO.resetPassword(email, password, role);
        }
    }
}
