package org.example.mywmsapp.model;

public class Product {
    private int id;
    private String name;
    private String barcode;
    private double width;
    private double height;
    private double depth;
    private double quantity;
    private int category;
    private int minStockThreshold;

    public Product() {}

    public Product(int id, String name, String barcode, double width, double height, double depth, double quantity, int category, int minStockThreshold) {
        this.id = id;
        this.name = name;
        this.barcode = barcode;
        this.width = width;
        this.height = height;
        this.depth = depth;
        this.quantity = quantity;
        this.category = category;
        this.minStockThreshold = minStockThreshold;
    }

    // Basic constructor for simple product creation
    public Product(String name, String barcode, int category) {
        this.name = name;
        this.barcode = barcode;
        this.category = category;
        this.width = 0.0;
        this.height = 0.0;
        this.depth = 0.0;
        this.quantity = 0.0;
        this.minStockThreshold = 5; // Default threshold
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBarcode() { return barcode; }
    public void setBarcode(String barcode) { this.barcode = barcode; }

    public double getWidth() { return width; }
    public void setWidth(double width) { this.width = width; }

    public double getHeight() { return height; }
    public void setHeight(double height) { this.height = height; }

    public double getDepth() { return depth; }
    public void setDepth(double depth) { this.depth = depth; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    public int getCategory() { return category; }
    public void setCategory(int category) { this.category = category; }

    public int getMinStockThreshold() { return minStockThreshold; }
    public void setMinStockThreshold(int minStockThreshold) { this.minStockThreshold = minStockThreshold; }

    // Check if stock is below threshold
    public boolean isStockLow() {
        return quantity <= minStockThreshold;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", barcode='" + barcode + '\'' +
                ", width=" + width +
                ", height=" + height +
                ", depth=" + depth +
                ", quantity=" + quantity +
                ", category=" + category +
                ", minStockThreshold=" + minStockThreshold +
                '}';
    }
}