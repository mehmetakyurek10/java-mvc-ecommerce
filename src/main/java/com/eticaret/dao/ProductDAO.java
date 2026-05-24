package com.eticaret.dao;

import com.eticaret.model.Product;
import com.eticaret.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getActiveProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE is_active = true";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductsByCategoryId(int categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category_id = ? AND is_active = true";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, categoryId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (category_id, name, description, price, stock, image_url, is_active) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, product.getCategoryId());
            pstmt.setString(2, product.getName());
            pstmt.setString(3, product.getDescription());
            pstmt.setDouble(4, product.getPrice());
            pstmt.setInt(5, product.getStock());
            pstmt.setString(6, product.getImageUrl());
            pstmt.setBoolean(7, product.isActive());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET category_id = ?, name = ?, description = ?, price = ?, stock = ?, image_url = ?, is_active = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, product.getCategoryId());
            pstmt.setString(2, product.getName());
            pstmt.setString(3, product.getDescription());
            pstmt.setDouble(4, product.getPrice());
            pstmt.setInt(5, product.getStock());
            pstmt.setString(6, product.getImageUrl());
            pstmt.setBoolean(7, product.isActive());
            pstmt.setInt(8, product.getId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int id) {
        String sql = "UPDATE products SET is_active = false WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStock(int productId, int quantityToReduce, Connection conn) throws SQLException {
        String sql = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, quantityToReduce);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, quantityToReduce);

            return pstmt.executeUpdate() > 0;
        }
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setStock(rs.getInt("stock"));
        product.setImageUrl(rs.getString("image_url"));
        product.setActive(rs.getBoolean("is_active"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        return product;
    }
}