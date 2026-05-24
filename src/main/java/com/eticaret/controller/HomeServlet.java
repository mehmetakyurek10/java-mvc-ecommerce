package com.eticaret.controller;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Category;
import com.eticaret.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { "", "/home", "/index" })
public class HomeServlet extends HttpServlet {

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
        List<Product> recentProducts = productDAO.getActiveProducts();
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", recentProducts);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }
}