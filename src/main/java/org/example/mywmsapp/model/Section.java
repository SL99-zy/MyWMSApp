package org.example.mywmsapp.model;

import java.util.List;

public class Section {
    private int id;
    private String name;
    private int category;  // 🔹 Catégorie de produit associée (1,2,3,4)
    private List<Place> places; // 🔹 Liste des emplacements de stockage

    public Section() {}

    public Section(int id, String name, int category, List<Place> places) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.places = places;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getCategory() { return category; }
    public void setCategory(int category) { this.category = category; }

    public List<Place> getPlaces() { return places; }
    public void setPlaces(List<Place> places) { this.places = places; }

    // 🔹 Retourne le nombre de places disponibles
    public long getAvailablePlaces() {
        return places.stream().filter(place -> !place.isOccupied()).count();
    }

    @Override
    public String toString() {
        return "Section{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", category=" + category +
                ", availablePlaces=" + getAvailablePlaces() +
                '}';
    }
}
