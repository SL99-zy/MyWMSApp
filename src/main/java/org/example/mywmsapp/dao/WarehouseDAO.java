package org.example.mywmsapp.dao;

import org.example.mywmsapp.model.Place;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO {

    /**
     * 🔹 Récupérer toutes les places (libres et occupées) dans l'entrepôt.
     */
    public List<Place> getAllPlaces() {
        List<Place> places = new ArrayList<>();
        String sql = "SELECT * FROM warehouse_places ORDER BY category_id, row_index, col_index";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                places.add(new Place(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getInt("row_index"),
                        rs.getInt("col_index"),
                        rs.getBoolean("is_occupied")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("📌 Total des emplacements récupérés : " + places.size());
        return places;
    }

    /**
     * 🔹 Récupérer uniquement les places disponibles dans l'entrepôt.
     */
    public List<Place> getAvailablePlaces() {
        List<Place> places = new ArrayList<>();
        String sql = "SELECT * FROM warehouse_places WHERE is_occupied = false ORDER BY category_id, row_index, col_index";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                places.add(new Place(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getInt("row_index"),
                        rs.getInt("col_index"),
                        rs.getBoolean("is_occupied")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("📌 Nombre de places disponibles : " + places.size());
        return places;
    }

    /**
     * 🔹 Récupérer les places disponibles pour une catégorie spécifique.
     */
    public List<Place> getAvailablePlacesForCategory(int categoryId) {
        List<Place> places = new ArrayList<>();
        String sql = "SELECT * FROM warehouse_places WHERE category_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                boolean occupied = rs.getBoolean("is_occupied"); // Make sure this returns true/false
                places.add(new Place(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getInt("row_index"),
                        rs.getInt("col_index"),
                        occupied  // 🔥 Now correctly setting occupied status
                ));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("📌 Debug WarehouseDAO : Catégorie " + categoryId + " -> " + places.size() + " places trouvées.");
        return places;
    }

    public boolean clearPlace(int placeId) {
        String sql = "UPDATE warehouse_places SET is_occupied = FALSE, stored_product_id = NULL WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, placeId);
            int updatedRows = stmt.executeUpdate();

            if (updatedRows > 0) {
                System.out.println("✅ Emplacement libéré: " + placeId);
                return true;
            } else {
                System.out.println("❌ Aucune ligne mise à jour pour placeId: " + placeId);
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }






    /**
     * 🔹 Marquer un emplacement comme occupé après stockage d'un produit.
     */
    public boolean storeProductInPlace(int placeId) {
        String sql = "UPDATE warehouse_places SET is_occupied = TRUE WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, placeId);
            int updatedRows = stmt.executeUpdate();
            System.out.println("✅ Stockage mis à jour pour l'emplacement ID : " + placeId);
            return updatedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 🔹 Libérer une place lorsqu'un produit est retiré.
     */
    public boolean releasePlace(int placeId) {
        String sql = "UPDATE warehouse_places SET is_occupied = FALSE WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, placeId);
            int updatedRows = stmt.executeUpdate();
            System.out.println("✅ Emplacement libéré ID : " + placeId);
            return updatedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 🔹 Récupérer une place spécifique par son ID.
     */
    public Place getPlaceById(int placeId) {
        String sql = "SELECT * FROM warehouse_places WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, placeId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Place(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getInt("row_index"),
                        rs.getInt("col_index"),
                        rs.getBoolean("is_occupied")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("❌ Aucun emplacement trouvé pour l'ID : " + placeId);
        return null; // Retourne null si l'emplacement n'existe pas
    }



    /**
     * 🔹 Récupérer les emplacements adaptés pour un produit en fonction de la catégorie et des dimensions.
     */
    public List<Place> getSuitablePlaces(int categoryId, double width, double height, double depth) {
        List<Place> places = new ArrayList<>();
        String sql = "SELECT * FROM warehouse_places " +
                "WHERE category_id = ? AND is_occupied = FALSE " +
                "AND max_width >= ? AND max_height >= ? AND max_depth >= ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            stmt.setDouble(2, width);
            stmt.setDouble(3, height);
            stmt.setDouble(4, depth);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                places.add(new Place(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getInt("row_index"),
                        rs.getInt("col_index"),
                        rs.getBoolean("is_occupied")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("📌 Nombre de places adaptées pour la catégorie " + categoryId + " : " + places.size());
        return places;
    }


}
