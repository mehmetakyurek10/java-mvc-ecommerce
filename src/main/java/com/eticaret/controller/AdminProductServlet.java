package com.eticaret.controller;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("products", productDAO.getAllProducts());
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.getRequestDispatcher("/WEB-INF/admin/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action) || "update".equals(action)) {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String name = request.getParameter("name");
            String desc = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            String imageUrl = request.getParameter("imageUrl");
            boolean isActive = request.getParameter("isActive") != null;

            if (name == null || name.trim().isEmpty() || price <= 0 || stock < 0) {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=invalid");
                return;
            }

            if ("add".equals(action)) {
                productDAO.addProduct(new Product(categoryId, name, desc, price, stock, imageUrl, isActive));
            } else {
                int id = Integer.parseInt(request.getParameter("id"));
                productDAO
                        .updateProduct(new Product(id, categoryId, name, desc, price, stock, imageUrl, isActive, null));
            }
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            productDAO.deleteProduct(id);
        } else if ("hardDelete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (productDAO.hasOrderItems(id)) {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=hasOrders");
                return;
            }
            if (productDAO.hardDeleteProduct(id)) {
                response.sendRedirect(request.getContextPath() + "/admin/products?msg=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=deleteFailed");
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}