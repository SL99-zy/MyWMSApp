package org.example.mywmsapp.service;

import org.example.mywmsapp.dao.ProductDAO;
import org.example.mywmsapp.model.Product;
import java.util.List;

public class ProductService {
    private final ProductDAO productDAO = new ProductDAO();

    public Product getProductByBarcode(String barcode) {
        System.out.println("🔍 Recherche du produit avec le code-barres : " + barcode);

        // Search only in local database
        Product product = productDAO.getProductByBarcode(barcode);

        if (product != null) {
            System.out.println("✅ Produit trouvé en base de données : " + product.getName());
        } else {
            System.out.println("❌ Aucun produit trouvé pour ce code-barres !");
        }

        return product;
    }

    /**
     * Update product category if needed
     */
    public boolean updateProductCategory(String barcode, int newCategory) {
        System.out.println("🔄 Mise à jour de la catégorie du produit avec code-barres : " + barcode);

        // Check if product exists in database
        Product existingProduct = productDAO.getProductByBarcode(barcode);
        if (existingProduct == null) {
            System.out.println("❌ Produit introuvable. Impossible de mettre à jour la catégorie.");
            return false;
        }

        // Check if category is actually different
        if (existingProduct.getCategory() == newCategory) {
            System.out.println("✅ La catégorie est déjà correcte. Aucune mise à jour nécessaire.");
            return true;
        }

        // Update category in database
        boolean updated = productDAO.updateProductCategory(barcode, newCategory);
        if (updated) {
            System.out.println("✅ Catégorie mise à jour avec succès pour le produit : " + barcode);
        } else {
            System.out.println("❌ Échec de la mise à jour de la catégorie.");
        }

        return updated;
    }

    public boolean saveProduct(Product product) {
        if (product == null) {
            System.out.println("❌ Impossible de sauvegarder un produit NULL.");
            return false;
        }

        // Check if product already exists
        Product existingProduct = productDAO.getProductByBarcode(product.getBarcode());
        if (existingProduct != null) {
            System.out.println("✅ Produit déjà existant dans la DB: " + product.getName());
            return true; // Already present, no need to insert
        }

        // Insert new product
        boolean inserted = productDAO.insertProduct(product);
        if (inserted) {
            System.out.println("✅ Produit sauvegardé avec succès: " + product.getName());
        } else {
            System.out.println("❌ Échec de l'enregistrement du produit: " + product.getName());
        }
        return inserted;
    }

    public boolean updateStock(String barcode, double quantity) {
        System.out.println("🔄 Mise à jour du stock pour le produit : " + barcode);
        return productDAO.updateProductStock(barcode, quantity);
    }

    public List<Product> searchProducts(String query) {
        return productDAO.findProductsByNameOrBarcode(query);
    }

    public List<Product> searchProductsByBarcode(String barcode) {
        return productDAO.findProductByBarcode(barcode);
    }
    public boolean deleteProduct(String barcode) {
        System.out.println("🗑️ [ProductService] Suppression du produit avec code-barres : " + barcode);
        return productDAO.deleteProduct(barcode);
    }


}