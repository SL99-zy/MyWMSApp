<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map, org.example.mywmsapp.model.Place, org.example.mywmsapp.model.Product" %>
<%
  Object sectionPlacesMapObj = request.getAttribute("sectionPlacesMap");
  Map<Integer, List<Place>> sectionPlacesMap = null;
  if (sectionPlacesMapObj instanceof Map<?, ?>) {
    sectionPlacesMap = (Map<Integer, List<Place>>) sectionPlacesMapObj;
  }
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MyWMS - Gestion d'Entrepôt</title>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-color: #2563eb;
      --secondary-color: #64748b;
      --success-color: #059669;
      --warning-color: #d97706;
      --danger-color: #dc2626;
      --info-color: #0891b2;
      --light-bg: #f8fafc;
      --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      --card-shadow-hover: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
      --border-radius: 12px;
      --transition: all 0.3s ease;
    }

    body {
      font-family: 'Inter', sans-serif;
      background-color: var(--light-bg);
      color: #1e293b;
      line-height: 1.6;
    }

    /* Header */
    .page-header {
      background: linear-gradient(135deg, var(--primary-color) 0%, #1d4ed8 100%);
      color: white;
      padding: 2rem 0;
      box-shadow: var(--card-shadow);
    }

    .header-content {
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
      gap: 1rem;
    }

    .header-left {
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .header-icon {
      background: rgba(255, 255, 255, 0.2);
      padding: 1rem;
      border-radius: var(--border-radius);
      font-size: 2rem;
    }

    .header-text h1 {
      font-size: 2.5rem;
      font-weight: 700;
      margin: 0;
    }

    .header-text p {
      font-size: 1.1rem;
      margin: 0;
      opacity: 0.9;
    }

    .header-stats {
      display: flex;
      gap: 1.5rem;
      flex-wrap: wrap;
    }

    .stat-item {
      text-align: center;
      background: rgba(255, 255, 255, 0.1);
      padding: 1rem;
      border-radius: var(--border-radius);
      min-width: 100px;
    }

    .stat-number {
      font-size: 1.8rem;
      font-weight: 700;
      display: block;
    }

    .stat-label {
      font-size: 0.875rem;
      opacity: 0.9;
    }

    /* Main Container */
    .main-container {
      max-width: 1400px;
      margin: 0 auto;
      padding: 2rem 1rem;
    }

    /* Alert */
    .alert-custom {
      background: #fef2f2;
      border: 1px solid #fecaca;
      color: #991b1b;
      padding: 1rem 1.5rem;
      border-radius: var(--border-radius);
      margin-bottom: 2rem;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    /* Legend */
    .legend-section {
      background: white;
      border-radius: var(--border-radius);
      padding: 1.5rem;
      box-shadow: var(--card-shadow);
      margin-bottom: 2rem;
      border: 1px solid #e2e8f0;
    }

    .legend-grid {
      display: flex;
      justify-content: center;
      gap: 2rem;
      flex-wrap: wrap;
    }

    .legend-item {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      padding: 0.75rem 1.5rem;
      background: var(--light-bg);
      border-radius: 8px;
      border: 1px solid #e2e8f0;
    }

    .legend-color {
      width: 20px;
      height: 20px;
      border-radius: 4px;
      border: 2px solid;
    }

    .legend-free {
      background: #d1fae5;
      border-color: #10b981;
    }

    .legend-occupied {
      background: #fecaca;
      border-color: #ef4444;
    }

    .legend-text {
      font-weight: 600;
      color: #1e293b;
    }

    /* Section Container */
    .section-container {
      background: white;
      border-radius: var(--border-radius);
      margin-bottom: 2rem;
      box-shadow: var(--card-shadow);
      border: 1px solid #e2e8f0;
      overflow: hidden;
    }

    .section-header {
      background: linear-gradient(135deg, var(--light-bg), #f1f5f9);
      padding: 1.5rem 2rem;
      border-bottom: 1px solid #e2e8f0;
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
      gap: 1rem;
    }

    .section-title-group {
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .section-icon {
      width: 50px;
      height: 50px;
      background: var(--primary-color);
      color: white;
      border-radius: var(--border-radius);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.25rem;
    }

    .section-title {
      font-size: 1.5rem;
      font-weight: 600;
      color: #1e293b;
      margin: 0;
    }

    .section-subtitle {
      color: var(--secondary-color);
      font-size: 0.875rem;
      margin: 0;
    }

    /* Section Stats */
    .section-stats {
      display: flex;
      gap: 1.5rem;
      flex-wrap: wrap;
    }

    .section-stat {
      text-align: center;
      padding: 0.75rem;
      background: white;
      border-radius: 8px;
      border: 1px solid #e2e8f0;
      min-width: 80px;
    }

    .section-stat-value {
      font-size: 1.25rem;
      font-weight: 700;
      color: var(--primary-color);
      display: block;
    }

    .section-stat-label {
      font-size: 0.75rem;
      color: var(--secondary-color);
      text-transform: uppercase;
      font-weight: 600;
      letter-spacing: 0.5px;
    }

    /* Grid Container */
    .grid-container {
      padding: 2rem;
    }

    .grid-wrapper {
      background: var(--light-bg);
      border-radius: var(--border-radius);
      padding: 1.5rem;
      border: 1px solid #e2e8f0;
    }

    .row-container {
      display: flex;
      justify-content: center;
      gap: 4px;
      margin-bottom: 6px;
      flex-wrap: wrap;
    }

    /* Place Boxes */
    .place {
      width: 40px;
      height: 40px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 0.7rem;
      font-weight: 600;
      border-radius: 6px;
      cursor: pointer;
      transition: var(--transition);
      border: 2px solid;
      position: relative;
    }

    .place.occupied {
      background: #fecaca;
      color: #991b1b;
      border-color: #ef4444;
    }

    .place.free {
      background: #d1fae5;
      color: #065f46;
      border-color: #10b981;
    }

    .place:hover {
      transform: scale(1.15);
      z-index: 10;
      box-shadow: var(--card-shadow-hover);
    }

    /* Empty State */
    .empty-state {
      text-align: center;
      padding: 3rem;
      color: var(--secondary-color);
    }

    .empty-state i {
      font-size: 3rem;
      margin-bottom: 1rem;
      opacity: 0.5;
    }

    /* Modal */
    .modal-content {
      border-radius: var(--border-radius);
      border: none;
      box-shadow: var(--card-shadow-hover);
    }

    .modal-header {
      background: var(--light-bg);
      border-bottom: 1px solid #e2e8f0;
      border-radius: var(--border-radius) var(--border-radius) 0 0;
    }

    .modal-title {
      font-weight: 600;
      color: #1e293b;
    }

    .modal-body {
      padding: 2rem;
    }

    .modal-info-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 1rem;
      margin-bottom: 1.5rem;
    }

    .modal-info-item {
      background: var(--light-bg);
      padding: 1rem;
      border-radius: 8px;
      border: 1px solid #e2e8f0;
    }

    .modal-info-label {
      font-size: 0.875rem;
      color: var(--secondary-color);
      margin-bottom: 0.25rem;
      font-weight: 600;
    }

    .modal-info-value {
      font-size: 1.125rem;
      font-weight: 600;
      color: #1e293b;
    }

    .status-badge {
      padding: 0.5rem 1rem;
      border-radius: 20px;
      font-size: 0.875rem;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .status-free {
      background: #d1fae5;
      color: #065f46;
    }

    .status-occupied {
      background: #fecaca;
      color: #991b1b;
    }

    .btn-custom {
      padding: 0.75rem 1.5rem;
      border-radius: 8px;
      font-weight: 500;
      transition: var(--transition);
      border: none;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    .btn-primary-custom {
      background: var(--primary-color);
      color: white;
    }

    .btn-primary-custom:hover {
      background: #1d4ed8;
    }

    .btn-danger-custom {
      background: var(--danger-color);
      color: white;
    }

    .btn-danger-custom:hover {
      background: #b91c1c;
    }

    .btn-secondary-custom {
      background: var(--secondary-color);
      color: white;
    }

    .btn-secondary-custom:hover {
      background: #475569;
    }

    /* Back Button */
    .back-button {
      background: var(--secondary-color);
      color: white;
      border: none;
      padding: 1rem 2rem;
      border-radius: var(--border-radius);
      font-weight: 500;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      transition: var(--transition);
      margin-top: 2rem;
    }

    .back-button:hover {
      background: #475569;
      color: white;
      text-decoration: none;
      transform: translateY(-2px);
    }

    /* Responsive */
    @media (max-width: 768px) {
      .header-text h1 {
        font-size: 2rem;
      }

      .header-stats {
        justify-content: center;
        width: 100%;
      }

      .section-header {
        flex-direction: column;
        text-align: center;
      }

      .section-stats {
        justify-content: center;
      }

      .modal-info-grid {
        grid-template-columns: 1fr;
      }

      .place {
        width: 32px;
        height: 32px;
        font-size: 0.6rem;
      }
    }

    @media (max-width: 480px) {
      .legend-grid {
        flex-direction: column;
        align-items: center;
      }

      .place {
        width: 28px;
        height: 28px;
        font-size: 0.55rem;
      }
    }

    /* Animation */
    .fade-in {
      opacity: 0;
      transform: translateY(20px);
      animation: fadeInUp 0.6s ease forwards;
    }

    @keyframes fadeInUp {
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
  </style>
</head>

<body>
<!-- Header -->
<header class="page-header">
  <div class="container">
    <div class="header-content">
      <div class="header-left">
        <div class="header-icon">
          <i class="fas fa-warehouse"></i>
        </div>
        <div class="header-text">
          <h1>Gestion d'Entrepôt</h1>
          <p>Vue d'ensemble de tous les emplacements</p>
        </div>
      </div>

      <div class="header-stats">
        <div class="stat-item">
          <span class="stat-number">4</span>
          <span class="stat-label">Sections</span>
        </div>
        <div class="stat-item">
          <span class="stat-number" id="totalPlaces">---</span>
          <span class="stat-label">Emplacements</span>
        </div>
        <div class="stat-item">
          <span class="stat-number" id="occupancyRate">---%</span>
          <span class="stat-label">Occupation</span>
        </div>
      </div>
    </div>
  </div>
</header>

<div class="main-container">
  <!-- Error Message -->
  <% if (error != null) { %>
  <div class="alert-custom">
    <i class="fas fa-exclamation-triangle"></i>
    <%= error %>
  </div>
  <% } %>

  <!-- Legend -->
  <div class="legend-section fade-in">
    <div class="legend-grid">
      <div class="legend-item">
        <div class="legend-color legend-free"></div>
        <span class="legend-text">Emplacement Libre</span>
      </div>
      <div class="legend-item">
        <div class="legend-color legend-occupied"></div>
        <span class="legend-text">Emplacement Occupé</span>
      </div>
    </div>
  </div>

  <!-- No Storage Available -->
  <% if (sectionPlacesMap == null || sectionPlacesMap.isEmpty()) { %>
  <div class="section-container fade-in">
    <div class="empty-state">
      <i class="fas fa-exclamation-triangle"></i>
      <h3>Aucun emplacement disponible</h3>
      <p>Veuillez vérifier la configuration de votre entrepôt.</p>
    </div>
  </div>
  <% } else { %>

  <!-- Loop Through Sections -->
  <%
    String[] sectionNames = {"Équipements Réseau", "Serveurs & Infrastructure", "Chiffrement & Authentification", "Monitoring & Analyse"};
    String[] sectionIcons = {"fa-network-wired", "fa-server", "fa-shield-halved", "fa-chart-line"};

    for (int categoryId = 1; categoryId <= 4; categoryId++) {
      List<Place> places = sectionPlacesMap.get(categoryId);
      String sectionName = sectionNames[categoryId - 1];
      String sectionIcon = sectionIcons[categoryId - 1];
  %>

  <div class="section-container fade-in" style="animation-delay: <%= (categoryId - 1) * 0.1 %>s">
    <div class="section-header">
      <div class="section-title-group">
        <div class="section-icon">
          <i class="fas <%= sectionIcon %>"></i>
        </div>
        <div>
          <h2 class="section-title">Section <%= categoryId %></h2>
          <p class="section-subtitle"><%= sectionName %></p>
        </div>
      </div>

      <% if (places != null && !places.isEmpty()) {
        int totalPlaces = places.size();
        int occupiedPlaces = 0;
        for (Place p : places) {
          if (p.isOccupied()) occupiedPlaces++;
        }
        int freePlaces = totalPlaces - occupiedPlaces;
        double occupancyPercentage = totalPlaces > 0 ? (double) occupiedPlaces / totalPlaces * 100 : 0;
      %>

      <div class="section-stats">
        <div class="section-stat">
          <span class="section-stat-value"><%= totalPlaces %></span>
          <span class="section-stat-label">Total</span>
        </div>
        <div class="section-stat">
          <span class="section-stat-value" style="color: var(--success-color);"><%= freePlaces %></span>
          <span class="section-stat-label">Libres</span>
        </div>
        <div class="section-stat">
          <span class="section-stat-value" style="color: var(--danger-color);"><%= occupiedPlaces %></span>
          <span class="section-stat-label">Occupés</span>
        </div>
        <div class="section-stat">
          <span class="section-stat-value"><%= String.format("%.1f%%", occupancyPercentage) %></span>
          <span class="section-stat-label">Taux</span>
        </div>
      </div>
      <% } %>
    </div>

    <div class="grid-container">
      <% if (places != null && !places.isEmpty()) { %>
      <div class="grid-wrapper">
        <%
          int placesPerRow = 25;
          int currentIndex = 0;
        %>

        <div class="row-container">
          <% for (Place place : places) { %>
          <div class="place <%= place.isOccupied() ? "occupied" : "free" %>"
               title="Section <%= place.getSectionId() %> | Rangée: <%= place.getRowIndex() %> | Colonne: <%= place.getColIndex() %> | <%= place.isOccupied() ? "Occupé" : "Libre" %>"
               onclick="showPlaceDetails('<%= place.getId() %>', '<%= place.getRowIndex() %>-<%= place.getColIndex() %>', <%= place.isOccupied() ? 1 : 0 %>, '<%= sectionName %>')">
            <%= place.getRowIndex() %>-<%= place.getColIndex() %>
          </div>
          <%
            currentIndex++;
            if (currentIndex % placesPerRow == 0 && currentIndex < places.size()) {
          %>
        </div>
        <div class="row-container">
          <% } %>
          <% } %>
        </div>
      </div>
      <% } else { %>
      <div class="empty-state">
        <i class="fas fa-info-circle"></i>
        <h4>Aucun emplacement</h4>
        <p>Cette section ne contient aucun emplacement de stockage.</p>
      </div>
      <% } %>
    </div>
  </div>

  <% } %>
  <% } %>

  <!-- Back Button -->
  <div class="text-center">
    <a href="index.jsp" class="back-button">
      <i class="fas fa-arrow-left"></i>
      Retour au Dashboard
    </a>
  </div>
</div>

<!-- Modal for Place Details -->
<div class="modal fade" id="placeModal" tabindex="-1" aria-labelledby="placeModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="placeModalLabel">
          <i class="fas fa-map-marker-alt"></i>
          Détails de l'Emplacement
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="modal-info-grid">
          <div class="modal-info-item">
            <div class="modal-info-label">Position</div>
            <div class="modal-info-value" id="placePosition">---</div>
          </div>
          <div class="modal-info-item">
            <div class="modal-info-label">Section</div>
            <div class="modal-info-value" id="placeSection">---</div>
          </div>
          <div class="modal-info-item">
            <div class="modal-info-label">Identifiant</div>
            <div class="modal-info-value" id="placeId">---</div>
          </div>
          <div class="modal-info-item">
            <div class="modal-info-label">Statut</div>
            <div class="modal-info-value" id="placeStatus">---</div>
          </div>
        </div>

        <div id="occupiedAlert" style="display: none;">
          <div class="alert alert-warning" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <strong>Attention !</strong> Cet emplacement est actuellement occupé par un produit.
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn-custom btn-secondary-custom" data-bs-dismiss="modal">
          <i class="fas fa-times"></i>
          Fermer
        </button>
        <form id="freePlaceForm" action="freePlace" method="POST" style="display: none;">
          <input type="hidden" name="placeId" id="placeIdInput">
          <button type="submit" class="btn-custom btn-danger-custom" id="freePlaceButton">
            <i class="fas fa-trash-alt"></i>
            Libérer l'Emplacement
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Show place details in modal
  function showPlaceDetails(placeId, placePosition, isOccupied, sectionName) {
    document.getElementById("placePosition").textContent = placePosition;
    document.getElementById("placeSection").textContent = sectionName;
    document.getElementById("placeId").textContent = placeId;
    document.getElementById("placeIdInput").value = placeId;

    const statusElement = document.getElementById("placeStatus");
    const occupiedAlert = document.getElementById("occupiedAlert");
    const freePlaceForm = document.getElementById("freePlaceForm");

    if (isOccupied) {
      statusElement.innerHTML = '<span class="status-badge status-occupied"><i class="fas fa-times-circle me-1"></i>Occupé</span>';
      occupiedAlert.style.display = 'block';
      freePlaceForm.style.display = 'inline';
    } else {
      statusElement.innerHTML = '<span class="status-badge status-free"><i class="fas fa-check-circle me-1"></i>Libre</span>';
      occupiedAlert.style.display = 'none';
      freePlaceForm.style.display = 'none';
    }

    const modal = new bootstrap.Modal(document.getElementById('placeModal'));
    modal.show();
  }

  // Calculate and update global stats
  function updateGlobalStats() {
    const sections = document.querySelectorAll('.section-container');
    let totalPlaces = 0;
    let totalOccupied = 0;

    sections.forEach(section => {
      const places = section.querySelectorAll('.place');
      totalPlaces += places.length;

      places.forEach(place => {
        if (place.classList.contains('occupied')) {
          totalOccupied++;
        }
      });
    });

    const occupancyRate = totalPlaces > 0 ? (totalOccupied / totalPlaces * 100) : 0;

    document.getElementById('totalPlaces').textContent = totalPlaces;
    document.getElementById('occupancyRate').textContent = Math.round(occupancyRate) + '%';
  }

  // Enhanced place hover effects
  function initializePlaceEffects() {
    document.querySelectorAll('.place').forEach(place => {
      place.addEventListener('mouseenter', function() {
        this.style.transform = 'scale(1.2)';
        this.style.zIndex = '10';
      });

      place.addEventListener('mouseleave', function() {
        this.style.transform = 'scale(1)';
        this.style.zIndex = '1';
      });

      place.addEventListener('click', function() {
        // Add click ripple effect
        this.style.transform = 'scale(1.3)';
        setTimeout(() => {
          this.style.transform = 'scale(1.2)';
        }, 150);
      });
    });
  }

  // Initialize animations
  function initializeAnimations() {
    const elements = document.querySelectorAll('.fade-in');
    elements.forEach((element, index) => {
      setTimeout(() => {
        element.style.opacity = '1';
        element.style.transform = 'translateY(0)';
      }, index * 100);
    });
  }

  // Initialize on page load
  document.addEventListener('DOMContentLoaded', function() {
    updateGlobalStats();
    initializePlaceEffects();
    initializeAnimations();

    // Form submission handling
    document.getElementById('freePlaceForm')?.addEventListener('submit', function() {
      const button = this.querySelector('button[type="submit"]');
      button.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Libération...';
      button.disabled = true;
    });
  });

  // Auto-refresh stats every 30 seconds
  setInterval(() => {
    updateGlobalStats();
  }, 30000);
</script>
</body>
</html>