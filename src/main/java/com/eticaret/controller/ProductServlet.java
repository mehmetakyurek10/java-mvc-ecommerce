package com.eticaret.controller;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.dao.FavoriteDAO;
import com.eticaret.dao.ProductDAO;
import com.eticaret.model.Category;
import com.eticaret.model.Product;
import com.eticaret.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private static final int PAGE_SIZE = 8;

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private FavoriteDAO favoriteDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        favoriteDAO = new FavoriteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryParam = request.getParameter("category");
        int page = parsePage(request.getParameter("page"));
        int offset = (page - 1) * PAGE_SIZE;

        List<Product> productList;
        Category selectedCategory = null;
        int total;

        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryParam);
                productList = productDAO.getProductsByCategoryIdPaged(categoryId, offset, PAGE_SIZE);
                total = productDAO.countProductsByCategoryId(categoryId);
                selectedCategory = categoryDAO.getCategoryById(categoryId);
            } catch (NumberFormatException e) {
                productList = productDAO.getAllProductsPaged(offset, PAGE_SIZE);
                total = productDAO.countAllProducts();
            }
        } else {
            productList = productDAO.getAllProductsPaged(offset, PAGE_SIZE);
            total = productDAO.countAllProducts();
        }

        int totalPages = Math.max(1, (int) Math.ceil(total / (double) PAGE_SIZE));

        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");
        request.setAttribute("favoriteIds",
                user != null ? favoriteDAO.getFavoriteIds(user.getId()) : Collections.emptySet());

        request.setAttribute("products", productList);
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("selectedCategory", selectedCategory);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", total);
        request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response);
    }

    private int parsePage(String raw) {
        if (raw == null) return 1;
        try {
            int p = Integer.parseInt(raw);
            return p < 1 ? 1 : p;
        } catch (NumberFormatException e) {
            return 1;
        }
    }
}
