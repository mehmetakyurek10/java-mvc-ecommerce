package com.eticaret.controller;

import com.eticaret.dao.OrderDAO;
import com.eticaret.dao.OrderItemDAO;
import com.eticaret.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = { "/admin/orders", "/admin/order-detail" })
public class AdminOrderServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/admin/order-detail".equals(path)) {
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    Order order = orderDAO.getOrderById(id);
                    if (order != null) {
                        request.setAttribute("order", order);
                        request.setAttribute("items", orderItemDAO.getOrderItemsByOrderId(id));
                        request.getRequestDispatcher("/WEB-INF/admin/order-detail.jsp")
                                .forward(request, response);
                        return;
                    }
                } catch (NumberFormatException ignored) {
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        request.setAttribute("orders", orderDAO.getAllOrders());
        request.getRequestDispatcher("/WEB-INF/admin/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            orderDAO.updateOrderStatus(orderId, status);
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
