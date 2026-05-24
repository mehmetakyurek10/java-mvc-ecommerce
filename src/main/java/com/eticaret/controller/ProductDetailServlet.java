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

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {

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
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int productId = Integer.parseInt(idParam);
                Product product = productDAO.getProductById(productId);

                if (product != null) {
                    Category category = categoryDAO.getCategoryById(product.getCategoryId());
                    HttpSession session = request.getSession(false);
                    User user = session == null ? null : (User) session.getAttribute("user");
                    boolean isFav = user != null && favoriteDAO.isFavorite(user.getId(), productId);
                    request.setAttribute("product", product);
                    request.setAttribute("category", category);
                    request.setAttribute("isFavorite", isFav);
                    request.setAttribute("categories", categoryDAO.getAllCategories());
                    request.getRequestDispatcher("/WEB-INF/product-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/products");
    }
}