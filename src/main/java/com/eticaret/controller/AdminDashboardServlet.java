package com.eticaret.controller;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.dao.OrderDAO;
import com.eticaret.dao.ProductDAO;
import com.eticaret.dao.UserDAO;
import com.eticaret.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private OrderDAO orderDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int totalProducts = productDAO.getAllProducts().size();
        int totalCategories = categoryDAO.getAllCategories().size();
        int totalUsers = userDAO.countUsers();
        List<Order> allOrders = orderDAO.getAllOrders();
        int totalOrders = allOrders.size();
        long pendingOrders = allOrders.stream().filter(o -> "BEKLEMEDE".equals(o.getStatus())).count();

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);

        Map<String, Integer> statusCounts = orderDAO.countOrdersByStatus();
        Map<String, Integer> categoryCounts = productDAO.countProductsByCategory();
        request.setAttribute("statusLabels", toJsArray(statusCounts.keySet()));
        request.setAttribute("statusData", statusCounts.values());
        request.setAttribute("categoryLabels", toJsArray(categoryCounts.keySet()));
        request.setAttribute("categoryData", categoryCounts.values());

        request.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(request, response);
    }

    private String toJsArray(Iterable<String> items) {
        StringBuilder sb = new StringBuilder("[");
        boolean first = true;
        for (String s : items) {
            if (!first) sb.append(",");
            sb.append("\"").append(s.replace("\"", "\\\"")).append("\"");
            first = false;
        }
        return sb.append("]").toString();
    }
}