package org.example.mywmsapp.controller;

import org.example.mywmsapp.model.Product;
import org.example.mywmsapp.model.Section;
import org.example.mywmsapp.service.ProductService;
import org.example.mywmsapp.service.SectionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final SectionService sectionService = new SectionService(); // 🔹 Ajout de la gestion des sections

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String barcode = request.getParameter("barcode");

        if (barcode == null || barcode.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez entrer un code-barres.");
            request.getRequestDispatcher("/product.jsp").forward(request, response);
            return;
        }

        System.out.println("🔎 Recherche du produit avec le code-barres : " + barcode);

        // 🔍 Recherche du produit dans la base de données
        Product product = productService.getProductByBarcode(barcode);

        if (product == null) {
            request.setAttribute("error", "Aucun produit trouvé.");
            System.out.println("❌ Aucun produit trouvé pour ce code-barres.");
            request.getRequestDispatcher("/product.jsp").forward(request, response);
            return;
        }

        // 📌 Déterminer la section de stockage
        Section section = sectionService.getSectionByCategory(product.getCategory());
        if (section == null) {
            request.setAttribute("error", "Aucune section correspondante trouvée !");
            request.getRequestDispatcher("/product.jsp").forward(request, response);
            return;
        }

        // ✅ Envoi des données à la page JSP
        request.setAttribute("product", product);
        request.setAttribute("section", section);
        System.out.println("✅ Produit trouvé : " + product.getName() + " | Section : " + section.getName());

        request.getRequestDispatcher("/product.jsp").forward(request, response);
    }
}
