package org.example.mywmsapp.dao;

import org.example.mywmsapp.model.Section;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SectionDAO {

    // 🔹 Récupérer une section en fonction de la catégorie de produit
    public Section getSectionByCategory(int category) {
        String sql = "SELECT * FROM sections WHERE category = ? LIMIT 1"; // 🔹 Ajout de `LIMIT 1` pour éviter plusieurs résultats

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, category);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Section(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("category"),
                        new ArrayList<>()
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("❌ Aucune section trouvée pour la catégorie : " + category);
        return null; // 🔹 Retourne `null` si aucune section n'est trouvée
    }


    // 🔹 Récupérer toutes les sections de l'entrepôt
    public List<Section> getAllSections() {
        List<Section> sections = new ArrayList<>();
        String sql = "SELECT * FROM sections";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                sections.add(new Section(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("category"),
                        new ArrayList<>()
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sections;
    }

    // 🔹 Récupérer une section spécifique par son ID
    public Section getSectionById(int sectionId) {
        String sql = "SELECT * FROM sections WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, sectionId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Section(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("category"),
                        new ArrayList<>()
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
