package org.example.mywmsapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.mywmsapp.model.Product;
import org.example.mywmsapp.service.BarcodeService;
import org.example.mywmsapp.service.WarehouseService;
import org.example.mywmsapp.service.ProductService;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/storeProduct")
public class StoreProductServlet extends HttpServlet {
    private final WarehouseService warehouseService = new WarehouseService();
    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔎 Récupération des paramètres
        String barcode = request.getParameter("barcode");
        String placeIdStr = request.getParameter("placeId");
        String sectionIdStr = request.getParameter("sectionId");

        System.out.println("📦 Stockage : Barcode=" + barcode + ", PlaceID=" + placeIdStr + ", SectionID=" + sectionIdStr);

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        Product product = BarcodeService.scanProduct(barcode);


        try {
            // 🛑 Vérification si les paramètres sont bien remplis
            if (barcode == null || barcode.trim().isEmpty()) {
                System.out.println("❌ Erreur : Code-barres manquant.");
                response.sendRedirect("warehouse.jsp?error=barcodeVide");
                return;
            }
            if (placeIdStr == null || placeIdStr.trim().isEmpty()) {
                System.out.println("❌ Erreur : PlaceID manquant.");
                response.sendRedirect("warehouse.jsp?error=placeIdVide");
                return;
            }
            if (sectionIdStr == null || sectionIdStr.trim().isEmpty()) {
                System.out.println("❌ Erreur : SectionID manquant.");
                response.sendRedirect("warehouse.jsp?error=sectionIdVide");
                return;
            }

            // ✅ Conversion en entier
            int placeId = Integer.parseInt(placeIdStr);
            int sectionId = Integer.parseInt(sectionIdStr);

            // 🔥 Stockage du produit
            boolean success = BarcodeService.storeProduct(barcode, placeId, sectionId);

            if (success) {
                System.out.println("✅ Produit stocké avec succès !");
                request.setAttribute("product", product);
                request.setAttribute("places", warehouseService.getAvailablePlacesForCategory(product.getCategory()));
                request.getRequestDispatcher("scan.jsp").forward(request, response);
            } else {
                System.out.println("❌ Erreur : Stockage impossible.");
                response.sendRedirect("warehouse.jsp?error=stockageEchoue");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("warehouse.jsp?error=exception&message=" + e.getMessage());
        }
    }
}
