package org.example.mywmsapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.mywmsapp.model.Product;
import org.example.mywmsapp.service.ProductService;

import java.io.IOException;

@WebServlet("/addProduct")
public class AddProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the add product form
        request.getRequestDispatcher("add-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form parameters
            String name = request.getParameter("name");
            String barcode = request.getParameter("barcode");
            String quantityStr = request.getParameter("quantity");
            String categoryStr = request.getParameter("category");
            String widthStr = request.getParameter("width");
            String heightStr = request.getParameter("height");
            String depthStr = request.getParameter("depth");
            String minThresholdStr = request.getParameter("minThreshold");

            System.out.println("🔍 [AddProductServlet] Paramètres reçus:");
            System.out.println("  - name: " + name);
            System.out.println("  - barcode: " + barcode);
            System.out.println("  - quantity: " + quantityStr);
            System.out.println("  - category: " + categoryStr);

            // Validate required fields
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("error", "Le nom du produit est requis !");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            if (barcode == null || barcode.trim().isEmpty()) {
                request.setAttribute("error", "Le code-barres est requis !");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            if (categoryStr == null || categoryStr.trim().isEmpty()) {
                request.setAttribute("error", "La catégorie est requise !");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            if (quantityStr == null || quantityStr.trim().isEmpty()) {
                request.setAttribute("error", "La quantité est requise !");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            // Check if product with this barcode already exists
            Product existingProduct = productService.getProductByBarcode(barcode.trim());
            if (existingProduct != null) {
                request.setAttribute("error", "Un produit avec ce code-barres existe déjà !");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            // Parse numeric values with default values
            double quantity = 0.0;
            int category = 1;
            double width = 0.0;
            double height = 0.0;
            double depth = 0.0;
            int minThreshold = 5; // Default threshold

            try {
                quantity = Double.parseDouble(quantityStr.trim());
                category = Integer.parseInt(categoryStr.trim());

                if (widthStr != null && !widthStr.trim().isEmpty()) {
                    width = Double.parseDouble(widthStr.trim());
                }
                if (heightStr != null && !heightStr.trim().isEmpty()) {
                    height = Double.parseDouble(heightStr.trim());
                }
                if (depthStr != null && !depthStr.trim().isEmpty()) {
                    depth = Double.parseDouble(depthStr.trim());
                }
                if (minThresholdStr != null && !minThresholdStr.trim().isEmpty()) {
                    minThreshold = Integer.parseInt(minThresholdStr.trim());
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Erreur dans les valeurs numériques. Vérifiez les champs.");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            // Validate category
            if (category < 1 || category > 4) {
                request.setAttribute("error", "Catégorie invalide ! Choisissez entre 1 et 4.");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            // Validate quantity
            if (quantity < 0) {
                request.setAttribute("error", "La quantité ne peut pas être négative !");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            // Create new product
            Product newProduct = new Product(
                    0, // ID will be auto-generated
                    name.trim(),
                    barcode.trim(),
                    width,
                    height,
                    depth,
                    quantity,
                    category,
                    minThreshold
            );

            System.out.println("🔄 [AddProductServlet] Création du produit: " + newProduct.toString());

            // Save product
            boolean saved = productService.saveProduct(newProduct);

            if (saved) {
                System.out.println("✅ [AddProductServlet] Produit ajouté avec succès : " + name);

                // Get category name for display
                String categoryName = getCategoryName(category);
                request.setAttribute("success",
                        "Produit '" + name + "' ajouté avec succès dans la catégorie " + categoryName + " !");

            } else {
                System.out.println("❌ [AddProductServlet] Échec de l'ajout du produit : " + name);
                request.setAttribute("error", "Erreur lors de l'ajout du produit. Veuillez réessayer.");
            }

        } catch (Exception e) {
            System.out.println("❌ [AddProductServlet] Exception : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur système : " + e.getMessage());
        }

        // Forward back to the form
        request.getRequestDispatcher("add-product.jsp").forward(request, response);
    }

    private String getCategoryName(int category) {
        switch (category) {
            case 1: return "Équipements Réseau";
            case 2: return "Serveurs & Infrastructure";
            case 3: return "Chiffrement & Authentication";
            case 4: return "Monitoring & Analyse";
            default: return "Catégorie " + category;
        }
    }
}