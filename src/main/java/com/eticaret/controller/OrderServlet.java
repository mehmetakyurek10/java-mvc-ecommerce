package com.eticaret.controller;

import com.eticaret.dao.OrderDAO;
import com.eticaret.dao.OrderItemDAO;
import com.eticaret.dao.ProductDAO;
import com.eticaret.model.CartItem;
import com.eticaret.model.Order;
import com.eticaret.model.OrderItem;
import com.eticaret.model.User;
import com.eticaret.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = { "/order", "/my-orders" })
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        if ("/my-orders".equals(path)) {
            List<Order> myOrders = orderDAO.getOrdersByUserId(user.getId());
            request.setAttribute("orders", myOrders);
            request.getRequestDispatcher("/WEB-INF/my-orders.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        double totalAmount = 0;
        for (CartItem item : cart) {
            totalAmount += item.getSubtotal();
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            Order order = new Order(user.getId(), totalAmount, "BEKLEMEDE");
            int orderId = orderDAO.createOrder(order, conn);

            if (orderId > 0) {
                for (CartItem item : cart) {
                    OrderItem orderItem = new OrderItem(
                            orderId,
                            item.getProduct().getId(),
                            item.getQuantity(),
                            item.getProduct().getPrice(),
                            item.getSubtotal());
                    orderItemDAO.addOrderItem(orderItem, conn);
                    productDAO.updateStock(item.getProduct().getId(), item.getQuantity(), conn);
                }
                conn.commit();
                session.removeAttribute("cart");
                response.sendRedirect(request.getContextPath() + "/my-orders?success=true");
            } else {
                conn.rollback();
                response.sendRedirect(request.getContextPath() + "/cart?error=order_failed");
            }

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart?error=system_error");
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}