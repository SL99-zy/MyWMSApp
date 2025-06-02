package org.example.mywmsapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.mywmsapp.model.Product;
import org.example.mywmsapp.service.ProductService;

import java.io.IOException;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get parameters
            String barcode = request.getParameter("barcode");
            String confirmDelete = request.getParameter("confirmDelete");
            String redirectPage = request.getParameter("redirectPage");

            System.out.println("🗑️ [DeleteProductServlet] Tentative de suppression:");
            System.out.println("  - Barcode: " + barcode);
            System.out.println("  - Confirmation: " + confirmDelete);
            System.out.println("  - Page de redirection: " + redirectPage);

            // Validate parameters
            if (barcode == null || barcode.trim().isEmpty()) {
                System.out.println("❌ [DeleteProductServlet] Code-barres manquant");
                redirectWithError(request, response, redirectPage, "Code-barres manquant pour la suppression !");
                return;
            }

            // Check if product exists
            Product product = productService.getProductByBarcode(barcode.trim());
            if (product == null) {
                System.out.println("❌ [DeleteProductServlet] Produit non trouvé: " + barcode);
                redirectWithError(request, response, redirectPage, "Produit non trouvé !");
                return;
            }

            // Check confirmation
            if (!"true".equals(confirmDelete)) {
                System.out.println("⚠️ [DeleteProductServlet] Suppression non confirmée");
                redirectWithError(request, response, redirectPage, "Suppression annulée.");
                return;
            }

            // Perform deletion
            boolean deleted = productService.deleteProduct(barcode.trim());

            if (deleted) {
                System.out.println("✅ [DeleteProductServlet] Produit supprimé avec succès: " + product.getName());
                redirectWithSuccess(request, response, redirectPage,
                        "Produit '" + product.getName() + "' supprimé avec succès !");
            } else {
                System.out.println("❌ [DeleteProductServlet] Échec de la suppression");
                redirectWithError(request, response, redirectPage,
                        "Erreur lors de la suppression du produit. Veuillez réessayer.");
            }

        } catch (Exception e) {
            System.out.println("❌ [DeleteProductServlet] Exception: " + e.getMessage());
            e.printStackTrace();
            redirectWithError(request, response, null, "Erreur système: " + e.getMessage());
        }
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response,
                                   String redirectPage, String errorMessage) throws IOException {
        String targetPage = getTargetPage(redirectPage);
        response.sendRedirect(targetPage + "?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
    }

    private void redirectWithSuccess(HttpServletRequest request, HttpServletResponse response,
                                     String redirectPage, String successMessage) throws IOException {
        String targetPage = getTargetPage(redirectPage);
        response.sendRedirect(targetPage + "?success=" + java.net.URLEncoder.encode(successMessage, "UTF-8"));
    }

    private String getTargetPage(String redirectPage) {
        if ("product".equals(redirectPage)) {
            return "product.jsp";
        } else if ("scan".equals(redirectPage)) {
            return "scan.jsp";
        } else {
            return "index.jsp"; // Default fallback
        }
    }
}