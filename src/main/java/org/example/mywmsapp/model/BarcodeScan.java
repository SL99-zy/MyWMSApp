package org.example.mywmsapp.model;

import java.util.Date;

public class BarcodeScan {
    private int id;
    private String barcode;
    private Date scanDate;
    private int warehouseId;
    private int sectionId;  // 🔹 Nouvelle information : section associée
    private int placeId;    // 🔹 Nouvelle information : emplacement exact

    public BarcodeScan() {}

    public BarcodeScan(int id, String barcode, Date scanDate, int warehouseId, int sectionId, int placeId) {
        this.id = id;
        this.barcode = barcode;
        this.scanDate = scanDate;
        this.warehouseId = warehouseId;
        this.sectionId = sectionId;
        this.placeId = placeId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getBarcode() { return barcode; }
    public void setBarcode(String barcode) { this.barcode = barcode; }

    public Date getScanDate() { return scanDate; }
    public void setScanDate(Date scanDate) { this.scanDate = scanDate; }

    public int getWarehouseId() { return warehouseId; }
    public void setWarehouseId(int warehouseId) { this.warehouseId = warehouseId; }

    public int getSectionId() { return sectionId; }  // 🔹 Getter pour section
    public void setSectionId(int sectionId) { this.sectionId = sectionId; }

    public int getPlaceId() { return placeId; }  // 🔹 Getter pour emplacement
    public void setPlaceId(int placeId) { this.placeId = placeId; }

    @Override
    public String toString() {
        return "BarcodeScan{" +
                "id=" + id +
                ", barcode='" + barcode + '\'' +
                ", scanDate=" + scanDate +
                ", warehouseId=" + warehouseId +
                ", sectionId=" + sectionId +  // 🔹 Affichage de la section
                ", placeId=" + placeId +      // 🔹 Affichage de l’emplacement
                '}';
    }
}
