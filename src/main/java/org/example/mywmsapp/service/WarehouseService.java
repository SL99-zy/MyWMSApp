package org.example.mywmsapp.service;

import org.example.mywmsapp.dao.WarehouseDAO;
import org.example.mywmsapp.dao.ProductDAO;
import org.example.mywmsapp.model.Place;
import org.example.mywmsapp.model.Product;

import java.util.*;

public class WarehouseService {
    private final WarehouseDAO warehouseDAO = new WarehouseDAO();
    private final ProductDAO productDAO = new ProductDAO();

    /**
     * 📌 Récupère toutes les places disponibles dans l'entrepôt.
     */
    public List<Place> getAvailablePlaces() {
        List<Place> places = warehouseDAO.getAvailablePlaces();
        System.out.println("📌 Nombre total de places disponibles : " + places.size());
        return places;
    }

    /**
     * 🔍 Recherche les emplacements disponibles pour une catégorie spécifique.
     */
    public List<Place> getAvailablePlacesForCategory(int categoryId) {
        System.out.println("🔍 [WarehouseService] Recherche des emplacements disponibles pour la catégorie : " + categoryId);
        List<Place> places = warehouseDAO.getAvailablePlacesForCategory(categoryId);

        if (places == null) {
            System.out.println("⚠️ [WarehouseService] warehouseDAO.getAvailablePlacesForCategory() a retourné NULL !");
        } else {
            System.out.println("📌 [WarehouseService] Nombre de places trouvées : " + places.size());
        }

        return places;
    }


    /**
     * 🔍 Recherche un emplacement adapté à un produit en fonction de sa catégorie et de ses dimensions.
     */
    public List<Place> getAvailablePlacesForProduct(int categoryId, double width, double height, double depth) {
        System.out.println("🔍 Recherche des emplacements pour la catégorie " + categoryId + " avec une taille : "
                + width + "x" + height + "x" + depth);
        return warehouseDAO.getSuitablePlaces(categoryId, width, height, depth);
    }

    /**
     * 📦 Stocke un produit dans un emplacement et met à jour son stock.
     */
    public boolean storeProduct(String barcode, int placeId) {
        System.out.println("📦 Tentative de stockage du produit avec code-barres : " + barcode);

        // ✅ Récupérer le produit par code-barres
        Product product = productDAO.getProductByBarcode(barcode);
        if (product == null) {
            System.out.println("❌ Produit introuvable !");
            return false;
        }

        // ✅ Vérifier si l'emplacement est disponible
        Place place = warehouseDAO.getPlaceById(placeId);
        if (place == null) {
            System.out.println("❌ Emplacement non trouvé !");
            return false;
        }

        if (place.isOccupied()) {
            System.out.println("⚠️ L'emplacement ID " + placeId + " est déjà occupé.");
            return false;
        }

        // 🔄 Marquer la place comme occupée
        boolean stored = warehouseDAO.storeProductInPlace(placeId);
        if (!stored) {
            System.out.println("❌ Impossible de marquer l'emplacement comme occupé.");
            return false;
        }

        // 🔄 Mettre à jour le stock du produit
        boolean stockUpdated = productDAO.updateProductStock(barcode, (int) (product.getQuantity() - 1));
        if (stockUpdated) {
            System.out.println("✅ Stock mis à jour pour le produit : " + barcode);
            return true;
        } else {
            System.out.println("⚠️ L'emplacement est occupé, mais la mise à jour du stock a échoué.");
            return false;
        }
    }


    public Place findOptimalStoragePlace(Product product) {
        List<Place> availablePlaces = getAvailablePlacesForCategory(product.getCategory());

        if (availablePlaces.isEmpty()) {
            return null; // Aucun emplacement disponible
        }

        // 🔥 Paramètres de l'algorithme génétique
        int populationSize = 10;  // Taille de la population de solutions
        int generations = 50;      // Nombre d'itérations
        double mutationRate = 0.2; // Probabilité de mutation

        // 🔹 Générer la population initiale (aléatoire)
        List<Place> population = generateInitialPopulation(availablePlaces, populationSize);

        for (int gen = 0; gen < generations; gen++) {
            // 🔍 Évaluer la fitness des candidats
            List<Place> rankedPopulation = evaluateFitness(population, product);

            // 🔄 Sélectionner les meilleurs candidats (50%)
            List<Place> selectedParents = rankedPopulation.subList(0, populationSize / 2);

            // 🧬 Croisement et mutation
            population = crossoverAndMutate(selectedParents, availablePlaces, mutationRate);
        }

        // ✅ Retourner le meilleur emplacement trouvé
        Place optimalPlace = population.get(0);
        System.out.println("✅ Emplacement optimal trouvé : " + optimalPlace.getId());

        return optimalPlace;
    }

    private List<Place> generateInitialPopulation(List<Place> places, int size) {
        Collections.shuffle(places);
        return new ArrayList<>(places.subList(0, Math.min(size, places.size())));
    }

    private List<Place> evaluateFitness(List<Place> population, Product product) {
        population.sort(Comparator.comparingInt(place -> {
            int score = 0;

            // 🔍 Distance minimale (si des coordonnées existent)
            int refRow = 0; // Example: Entrance of the warehouse
            int refCol = 0;

            if (place != null) {
                score += (int) place.getDistance(refRow, refCol);
            }

            // 📦 Disponibilité (on favorise les emplacements les plus vides)
            score += place.isOccupied() ? 100 : 0;

            // 📊 Historique (si un produit similaire a été stocké ici, on favorise)
            if (place.getLastStoredProduct() != null && place.getLastStoredProduct().equals(product.getName())) {
                score -= 50; // Emplacement déjà utilisé pour ce produit
            }

            return score; // 🎯 Plus le score est bas, meilleur est l'emplacement
        }));

        return population;
    }

    public boolean freePlace(int placeId) {
        System.out.println("🔄 Tentative de libération de l'emplacement: " + placeId);
        return warehouseDAO.clearPlace(placeId);
    }


    private List<Place> crossoverAndMutate(List<Place> parents, List<Place> allPlaces, double mutationRate) {
        List<Place> newGeneration = new ArrayList<>(parents);

        Random rand = new Random();
        while (newGeneration.size() < parents.size() * 2) {
            Place parent1 = parents.get(rand.nextInt(parents.size()));
            Place parent2 = parents.get(rand.nextInt(parents.size()));

            // 🧬 Fusion des propriétés
            Place child = new Place(
                    parent1.getId(), // ID de l'un des parents
                    parent1.getRowIndex(), // Hérite des coordonnées d'un parent
                    parent2.getColIndex(), // Hérite des coordonnées de l'autre parent
                    parent1.isOccupied() && parent2.isOccupied() // Si les deux sont occupés, on marque aussi occupé
            );

            // 🎲 Mutation (on remplace aléatoirement certains emplacements)
            if (rand.nextDouble() < mutationRate) {
                child = allPlaces.get(rand.nextInt(allPlaces.size()));
            }

            newGeneration.add(child);
        }

        return newGeneration;
    }











    /**
     * 🔄 Libérer une place (si un produit est retiré).
     */
    public boolean releasePlace(int placeId) {
        System.out.println("🔄 Libération de l'emplacement ID : " + placeId);
        boolean released = warehouseDAO.releasePlace(placeId);
        if (released) {
            System.out.println("✅ Emplacement libéré avec succès.");
        } else {
            System.out.println("❌ Impossible de libérer l'emplacement.");
        }
        return released;
    }
}
