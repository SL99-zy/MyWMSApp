package org.example.mywmsapp.model;

import java.util.List;

public class Warehouse {
    private int id;
    private String name;
    private String location;
    private List<Place> places;
    private List<Section> sections;  // 🔹 Nouvelle info : les sections de l’entrepôt
    private int totalCapacity;       // 🔹 Nouvelle info : capacité totale de stockage

    public Warehouse() {}

    public Warehouse(int id, String name, String location, List<Place> places, List<Section> sections, int totalCapacity) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.places = places;
        this.sections = sections;
        this.totalCapacity = totalCapacity;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public List<Place> getPlaces() { return places; }
    public void setPlaces(List<Place> places) { this.places = places; }

    public List<Section> getSections() { return sections; }
    public void setSections(List<Section> sections) { this.sections = sections; }

    public int getTotalCapacity() { return totalCapacity; }
    public void setTotalCapacity(int totalCapacity) { this.totalCapacity = totalCapacity; }

    // 🔹 Méthode pour calculer la capacité restante
    public int getRemainingCapacity() {
        int occupied = (int) places.stream().filter(Place::isOccupied).count();
        return totalCapacity - occupied;
    }

    @Override
    public String toString() {
        return "Warehouse{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", location='" + location + '\'' +
                ", totalCapacity=" + totalCapacity +
                ", remainingCapacity=" + getRemainingCapacity() +  // 🔹 Affichage de la capacité restante
                ", sections=" + sections +
                '}';
    }
}
