package org.example.mywmsapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.mywmsapp.model.Product;
import org.example.mywmsapp.model.Place;
import org.example.mywmsapp.model.Section;
import org.example.mywmsapp.service.BarcodeService;
import org.example.mywmsapp.service.WarehouseService;
import org.example.mywmsapp.service.SectionService;

import java.io.IOException;
import java.util.List;

@WebServlet("/scan")
public class BarcodeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final BarcodeService barcodeService = new BarcodeService();
    private final WarehouseService warehouseService = new WarehouseService();
    private final SectionService sectionService = new SectionService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String barcode = request.getParameter("barcode");

        if (barcode == null || barcode.trim().isEmpty()) {
            request.setAttribute("error", "Aucun code-barres fourni !");
            request.getRequestDispatcher("scan.jsp").forward(request, response);
            return;
        }

        System.out.println("📡 [BarcodeServlet] Scanning product with barcode: " + barcode);

        // Search product in local database only
        Product product = barcodeService.scanProduct(barcode);

        if (product == null) {
            System.out.println("❌ [BarcodeServlet] Produit non trouvé en DB.");
            request.setAttribute("error", "Produit non trouvé ! Veuillez l'ajouter à la base de données.");
            request.getRequestDispatcher("scan.jsp").forward(request, response);
            return;
        }

        System.out.println("✅ Produit trouvé : " + product.getName());
        System.out.println("📦 Quantité : " + product.getQuantity());

        // Find section associated with product category
        Section section = sectionService.getSectionByCategory(product.getCategory());
        if (section == null) {
            System.out.println("⚠️ [BarcodeServlet] Aucune section trouvée pour la catégorie " + product.getCategory());
            request.setAttribute("error", "Aucune section trouvée pour la catégorie !");
            request.getRequestDispatcher("scan.jsp").forward(request, response);
            return;
        }

        // Find available places in this section
        List<Place> availablePlaces = warehouseService.getAvailablePlacesForCategory(section.getCategory());

        if (availablePlaces.isEmpty()) {
            System.out.println("⚠️ [BarcodeServlet] Aucune place disponible pour la section " + section.getId());
            request.setAttribute("error", "Aucune place disponible dans la section " + section.getId());
        }

        // Handle automatic storage request
        if ("autoStock".equals(request.getParameter("action"))) {
            Place optimalPlace = warehouseService.findOptimalStoragePlace(product);

            if (optimalPlace != null) {
                boolean stored = warehouseService.storeProduct(product.getBarcode(), optimalPlace.getId());

                if (stored) {
                    request.setAttribute("success", "Produit stocké automatiquement à l'emplacement " + optimalPlace.getId());
                } else {
                    request.setAttribute("error", "Échec du stockage automatique.");
                }
            } else {
                request.setAttribute("error", "Aucun emplacement optimal trouvé.");
            }

            request.setAttribute("product", product);
            request.setAttribute("places", warehouseService.getAvailablePlacesForCategory(product.getCategory()));
            request.getRequestDispatcher("scan.jsp").forward(request, response);
            return;
        }

        // Send information to scan.jsp
        request.setAttribute("product", product);
        request.setAttribute("section", section);
        request.setAttribute("places", availablePlaces);
        request.getRequestDispatcher("scan.jsp").forward(request, response);
    }
}