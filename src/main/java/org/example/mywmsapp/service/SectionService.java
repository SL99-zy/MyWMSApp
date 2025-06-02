package org.example.mywmsapp.service;

import org.example.mywmsapp.dao.SectionDAO;
import org.example.mywmsapp.model.Section;
import java.util.List;

public class SectionService {
    private final SectionDAO sectionDAO = new SectionDAO();

    // 🔹 Récupérer une section en fonction de la catégorie de produit
    public Section getSectionByCategory(int category) {
        System.out.println("🔍 Recherche de la section pour la catégorie de produit : " + category);
        return sectionDAO.getSectionByCategory(category);
    }

    // 🔹 Récupérer toutes les sections existantes
    public List<Section> getAllSections() {
        System.out.println("🔍 Récupération de toutes les sections de l'entrepôt...");
        return sectionDAO.getAllSections();
    }

    // 🔹 Récupérer une section spécifique par son ID
    public Section getSectionById(int sectionId) {
        System.out.println("🔍 Recherche de la section avec l'ID : " + sectionId);
        return sectionDAO.getSectionById(sectionId);
    }
}
