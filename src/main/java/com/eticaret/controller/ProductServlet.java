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

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

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
        String categoryIdParam = request.getParameter("category");
        List<Product> products;

        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdParam);
                products = productDAO.getProductsByCategoryId(categoryId);
            } catch (NumberFormatException e) {
                products = productDAO.getActiveProducts(); // Hatalı parametre gelirse tümünü getir
            }
        } else {
            products = productDAO.getActiveProducts();
        }

        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
    }
}