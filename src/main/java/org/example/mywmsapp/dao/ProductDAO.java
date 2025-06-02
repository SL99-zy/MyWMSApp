package org.example.mywmsapp.dao;

import org.example.mywmsapp.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public Product getProductByBarcode(String barcode) {
        String query = "SELECT id, name, barcode, width, height, depth, quantity, category FROM products WHERE barcode = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, barcode);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("barcode"),
                        rs.getDouble("width"),
                        rs.getDouble("height"),
                        rs.getDouble("depth"),
                        rs.getDouble("quantity"),  // 🔥 Vérifier que c'est bien récupéré en `double`
                        rs.getInt("category"),
                        5  // Seuil de stock par défaut
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    public boolean insertProduct(Product product) {
        String sql = "INSERT INTO products (name, barcode, width, height, depth, quantity, category) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getName());
            stmt.setString(2, product.getBarcode());
            stmt.setDouble(3, product.getWidth());
            stmt.setDouble(4, product.getHeight());
            stmt.setDouble(5, product.getDepth());
            stmt.setDouble(6, product.getQuantity());
            stmt.setInt(7, product.getCategory()); // 🔹 Ajout de la catégorie

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProductCategory(String barcode, int newCategory) {
        String sql = "UPDATE products SET category = ? WHERE barcode = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, newCategory);
            stmt.setString(2, barcode);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProductStock(String barcode, double newQuantity) {
        String query = "UPDATE products SET quantity = ? WHERE barcode = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDouble(1, newQuantity);  // 🔥 Assurer que c'est bien un `double`
            stmt.setString(2, barcode);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public List<Product> findProductsByNameOrBarcode(String query) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? OR barcode LIKE ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + query + "%");
            stmt.setString(2, "%" + query + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("barcode"),
                        rs.getDouble("width"),
                        rs.getDouble("height"),
                        rs.getDouble("depth"),
                        rs.getDouble("quantity"),
                        rs.getInt("category"),
                        5// 🔹 Ajout de la catégorie
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> findProductByBarcode(String barcode) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE barcode = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, barcode);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("barcode"),
                        rs.getDouble("width"),
                        rs.getDouble("height"),
                        rs.getDouble("depth"),
                        rs.getDouble("quantity"),
                        rs.getInt("category"),
                        5// 🔹 Ajout de la catégorie
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Ajoutez cette méthode dans votre ProductDAO.java existant

    /**
     * Supprime un produit de la base de données par son code-barres
     * @param barcode Code-barres du produit à supprimer
     * @return true si la suppression a réussi, false sinon
     */
    public boolean deleteProduct(String barcode) {
        String sql = "DELETE FROM products WHERE barcode = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, barcode);
            int deletedRows = stmt.executeUpdate();

            if (deletedRows > 0) {
                System.out.println("✅ [ProductDAO] Produit supprimé avec succès: " + barcode);
                return true;
            } else {
                System.out.println("⚠️ [ProductDAO] Aucun produit trouvé pour suppression: " + barcode);
                return false;
            }

        } catch (SQLException e) {
            System.out.println("❌ [ProductDAO] Erreur lors de la suppression: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


}
