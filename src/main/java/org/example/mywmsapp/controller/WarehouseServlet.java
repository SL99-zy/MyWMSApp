package org.example.mywmsapp.controller;

import org.example.mywmsapp.model.Place;
import org.example.mywmsapp.model.Section;
import org.example.mywmsapp.service.WarehouseService;
import org.example.mywmsapp.service.SectionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/warehouse")
public class WarehouseServlet extends HttpServlet {
    private final WarehouseService warehouseService = new WarehouseService();
    private final SectionService sectionService = new SectionService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🔍 [WarehouseServlet] Début récupération des sections...");

        List<Section> sections = sectionService.getAllSections();
        if (sections == null || sections.isEmpty()) {
            request.setAttribute("error", "Aucune section trouvée.");
            request.getRequestDispatcher("warehouse.jsp").forward(request, response);
            return;
        }

        Map<Integer, List<Place>> sectionPlacesMap = new HashMap<>();
        int totalPlaces = 0;

        for (Section section : sections) {
            System.out.println("🔍 [WarehouseServlet] Récupération des emplacements pour la catégorie : " + section.getCategory());
            List<Place> places = warehouseService.getAvailablePlacesForCategory(section.getCategory());
            sectionPlacesMap.put(section.getCategory(), places);
            totalPlaces += places.size();
            System.out.println("📌 [WarehouseServlet] Catégorie " + section.getCategory() + " -> " + places.size() + " places disponibles.");
        }

        System.out.println("📌 [WarehouseServlet] Nombre total de sections : " + sections.size());
        System.out.println("📌 [WarehouseServlet] Nombre total d'emplacements trouvés : " + totalPlaces);

        request.setAttribute("sections", sections);
        request.setAttribute("sectionPlacesMap", sectionPlacesMap);
        request.getRequestDispatcher("warehouse.jsp").forward(request, response);
    }
}
