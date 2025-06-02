package org.example.mywmsapp.service;

import org.example.mywmsapp.dao.BarcodeDAO;
import org.example.mywmsapp.dao.ProductDAO;
import org.example.mywmsapp.model.Place;
import org.example.mywmsapp.model.Product;
import org.example.mywmsapp.model.Section;
import java.util.List;

public class BarcodeService {
    private static final ProductService productService = new ProductService();
    private static final WarehouseService warehouseService = new WarehouseService();
    private final SectionService sectionService = new SectionService();
    private static final ProductDAO productDAO = new ProductDAO();
    private static final BarcodeDAO barcodeDAO = new BarcodeDAO();

    // Validate barcode format
    private static boolean validateBarcode(String barcode) {
        return barcode != null && !barcode.trim().isEmpty();
    }

    // Process barcode scan and find available storage locations
    public List<Place> processBarcodeScan(String barcode) {
        if (!validateBarcode(barcode)) {
            System.out.println("❌ Code-barres invalide !");
            return null;
        }

        // Get product from local database
        Product product = productService.getProductByBarcode(barcode);
        if (product == null) {
            System.out.println("❌ Produit non trouvé pour ce code-barres !");
            return null;
        }

        // Get section associated with product category
        Section section = sectionService.getSectionByCategory(product.getCategory());
        if (section == null) {
            System.out.println("⚠️ Aucune section trouvée pour la catégorie " + product.getCategory());
            return null;
        }

        System.out.println("📌 Produit de catégorie " + product.getCategory() + " -> Stockage dans la section " + section.getName());

        // Find available places in this section
        return warehouseService.getAvailablePlacesForCategory(section.getCategory());
    }

    // Search for product by barcode
    public static Product scanProduct(String barcode) {
        if (!validateBarcode(barcode)) {
            System.out.println("❌ Code-barres invalide !");
            return null;
        }
        return productDAO.getProductByBarcode(barcode);
    }

    // Process barcode and return product information
    public Product processBarcode(String barcode) {
        if (!validateBarcode(barcode)) {
            System.out.println("❌ Code-barres invalide !");
            return null;
        }

        System.out.println("🔎 Scanne du produit : " + barcode);
        Product product = productService.getProductByBarcode(barcode);
        if (product != null) {
            System.out.println("✅ Produit trouvé : " + product.getName() + " | Catégorie : " + product.getCategory());
        } else {
            System.out.println("⚠️ Aucun produit trouvé pour ce code-barres.");
        }
        return product;
    }

    // Get warehouse ID for section (simplified)
    private static int getWarehouseIdForSection(int sectionId) {
        return 1; // Default warehouse ID
    }

    /**
     * Save a product into the database if it does not already exist.
     */
    public boolean saveProduct(Product product) {
        if (product == null) {
            System.out.println("❌ [BarcodeService] Impossible de sauvegarder un produit NULL.");
            return false;
        }

        // Check if product already exists
        Product existingProduct = productDAO.getProductByBarcode(product.getBarcode());
        if (existingProduct != null) {
            System.out.println("✅ [BarcodeService] Produit déjà existant dans la DB: " + product.getName());
            return true; // Already present, no need to insert
        }

        // Insert new product
        boolean inserted = productDAO.insertProduct(product);
        if (inserted) {
            System.out.println("✅ [BarcodeService] Produit sauvegardé avec succès: " + product.getName());
        } else {
            System.out.println("❌ [BarcodeService] Échec de l'enregistrement du produit: " + product.getName());
        }
        return inserted;
    }

    // Store product automatically after scan
    public static boolean storeProduct(String barcode, int placeId, int sectionId) {
        if (!validateBarcode(barcode)) {
            System.out.println("❌ Code-barres invalide !");
            return false;
        }

        System.out.println("📦 Tentative de stockage du produit avec code-barres : " + barcode);

        // Check if product exists
        Product product = productService.getProductByBarcode(barcode);
        if (product == null) {
            System.out.println("❌ Impossible de stocker : Produit non trouvé.");
            return false;
        }

        // Update database to mark place as occupied
        boolean stored = warehouseService.storeProduct(barcode, placeId);
        if (stored) {
            System.out.println("✅ Produit stocké à l'emplacement ID : " + placeId);
            int warehouseId = getWarehouseIdForSection(sectionId);
            barcodeDAO.saveScan(barcode, warehouseId, sectionId, placeId);
            return true;
        } else {
            System.out.println("❌ Échec du stockage du produit.");
            return false;
        }
    }
}