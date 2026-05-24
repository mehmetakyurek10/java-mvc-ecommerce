package com.eticaret.controller;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.dao.OrderDAO;
import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int totalProducts = productDAO.getAllProducts().size();
        int totalCategories = categoryDAO.getAllCategories().size();
        List<Order> allOrders = orderDAO.getAllOrders();
        int totalOrders = allOrders.size();
        long pendingOrders = allOrders.stream().filter(o -> "BEKLEMEDE".equals(o.getStatus())).count();

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);

        request.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(request, response);
    }
}