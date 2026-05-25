package com.eticaret.controller;

import com.eticaret.dao.CategoryDAO;
import com.eticaret.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.getRequestDispatcher("/WEB-INF/admin/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String desc = request.getParameter("description");
            boolean isActive = request.getParameter("isActive") != null;
            if (name == null || name.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?error=invalid");
                return;
            }
            categoryDAO.addCategory(new Category(name.trim(), desc, isActive));
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String desc = request.getParameter("description");
            boolean isActive = request.getParameter("isActive") != null;
            if (name == null || name.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?error=invalid");
                return;
            }
            categoryDAO.updateCategory(new Category(id, name.trim(), desc, isActive));
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.deleteCategory(id);
        } else if ("hardDelete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (categoryDAO.hasProducts(id)) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?error=hasProducts");
                return;
            }
            if (categoryDAO.hardDeleteCategory(id)) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?msg=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/categories?error=deleteFailed");
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}