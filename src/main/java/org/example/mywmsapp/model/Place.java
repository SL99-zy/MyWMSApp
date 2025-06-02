package org.example.mywmsapp.model;

public class Place {
    private int id;
    private int categoryId;   // 🔹 Catégorie associée à l’emplacement (1,2,3,4)
    private int rowIndex;     // 🔹 Ligne dans la matrice (0 à 3)
    private int colIndex;     // 🔹 Colonne dans la matrice (0 à 24)
    private boolean isOccupied;

    public Place() {}

    public Place(int id, int categoryId, int rowIndex, int colIndex, boolean isOccupied) {
        this.id = id;
        this.categoryId = categoryId;
        this.rowIndex = rowIndex;
        this.colIndex = colIndex;
        this.isOccupied = isOccupied;
    }

    // ✅ Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public int getRowIndex() { return rowIndex; }
    public void setRowIndex(int rowIndex) { this.rowIndex = rowIndex; }

    public int getColIndex() { return colIndex; }
    public void setColIndex(int colIndex) { this.colIndex = colIndex; }

    public boolean isOccupied() { return isOccupied; }
    public void setOccupied(boolean occupied) { isOccupied = occupied; }

    // ✅ Retourne le nom de l’emplacement sous forme "Catégorie X - Ligne Y, Colonne Z"
    public String getName() {
        return "Catégorie " + categoryId + " - Ligne " + rowIndex + ", Colonne " + colIndex;
    }

    // ✅ Indique si un produit de cette catégorie peut être stocké ici
    public boolean canStoreProduct(int productCategoryId) {
        return !isOccupied && productCategoryId == this.categoryId;
    }

    public int getSectionId() {
        return categoryId;  // 📌 Retourne la catégorie qui est équivalente à une section
    }

    public double getDistance(int refRow, int refCol) {
        // Calcul de la distance euclidienne
        return Math.sqrt(Math.pow(this.rowIndex - refRow, 2) + Math.pow(this.colIndex - refCol, 2));
    }

    private String lastStoredProduct; // Stocke le dernier produit

    public String getLastStoredProduct() {
        return lastStoredProduct;
    }

    public void setLastStoredProduct(String productName) {
        this.lastStoredProduct = productName;
    }

    public Place(int id, int rowIndex, int colIndex, boolean occupied) {
        this.id = id;
        this.rowIndex = rowIndex;
        this.colIndex = colIndex;
        this.isOccupied = true;
        this.lastStoredProduct = null; // Par défaut, aucun produit stocké
    }




    @Override
    public String toString() {
        return "Place{" +
                "id=" + id +
                ", categoryId=" + categoryId +
                ", rowIndex=" + rowIndex +
                ", colIndex=" + colIndex +
                ", isOccupied=" + isOccupied +
                '}';
    }
}
