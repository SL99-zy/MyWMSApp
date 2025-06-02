<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.mywmsapp.model.Product" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MyWMS - Recherche de Produits</title>

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
      background: linear-gradient(135deg, var(--warning-color) 0%, #b45309 100%);
      color: white;
      padding: 2rem 0;
      box-shadow: var(--card-shadow);
    }

    .header-content {
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

    /* Main Container */
    .main-container {
      max-width: 900px;
      margin: 0 auto;
      padding: 2rem 1rem;
    }

    /* Search Section */
    .search-section {
      background: white;
      border-radius: var(--border-radius);
      padding: 2.5rem;
      box-shadow: var(--card-shadow);
      margin-bottom: 2rem;
      border: 1px solid #e2e8f0;
    }

    .search-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .search-header h2 {
      font-size: 1.5rem;
      font-weight: 600;
      color: #1e293b;
      margin-bottom: 0.5rem;
    }

    .search-header p {
      color: var(--secondary-color);
      margin: 0;
    }

    .search-form {
      max-width: 500px;
      margin: 0 auto;
    }

    .search-input-group {
      position: relative;
      margin-bottom: 1.5rem;
    }

    .search-input {
      width: 100%;
      padding: 1rem 1.5rem;
      font-size: 1.1rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      transition: var(--transition);
      background: white;
    }

    .search-input:focus {
      outline: none;
      border-color: var(--warning-color);
      box-shadow: 0 0 0 3px rgba(217, 119, 6, 0.1);
    }

    .search-button {
      width: 100%;
      padding: 1rem;
      background: linear-gradient(135deg, var(--warning-color), #b45309);
      color: white;
      border: none;
      border-radius: var(--border-radius);
      font-size: 1.1rem;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }

    .search-button:hover {
      transform: translateY(-2px);
      box-shadow: var(--card-shadow-hover);
    }

    .search-button:active {
      transform: translateY(0);
    }

    /* Alert Messages */
    .alert-custom {
      padding: 1rem 1.5rem;
      border-radius: var(--border-radius);
      margin: 1.5rem 0;
      border: 1px solid;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .alert-success {
      background: #f0fdf4;
      border-color: #bbf7d0;
      color: #166534;
    }

    .alert-danger {
      background: #fef2f2;
      border-color: #fecaca;
      color: #991b1b;
    }

    /* Product Display */
    .product-section {
      background: white;
      border-radius: var(--border-radius);
      padding: 2rem;
      box-shadow: var(--card-shadow);
      margin-bottom: 2rem;
      border: 1px solid #e2e8f0;
      animation: slideInUp 0.5s ease-out;
    }

    @keyframes slideInUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .product-header {
      text-align: center;
      margin-bottom: 2rem;
      padding-bottom: 1.5rem;
      border-bottom: 1px solid #e2e8f0;
    }

    .product-icon {
      width: 80px;
      height: 80px;
      background: linear-gradient(135deg, var(--warning-color), #b45309);
      color: white;
      border-radius: var(--border-radius);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2rem;
      margin: 0 auto 1rem;
    }

    .product-title {
      font-size: 2rem;
      font-weight: 700;
      color: #1e293b;
      margin-bottom: 0.5rem;
    }

    .product-subtitle {
      color: var(--secondary-color);
      font-size: 1.1rem;
    }

    /* Product Details Grid */
    .product-details {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 1.5rem;
      margin-bottom: 2rem;
    }

    .detail-card {
      background: var(--light-bg);
      padding: 1.5rem;
      border-radius: var(--border-radius);
      border: 1px solid #e2e8f0;
      text-align: center;
      transition: var(--transition);
    }

    .detail-card:hover {
      transform: translateY(-2px);
      box-shadow: var(--card-shadow);
    }

    .detail-icon {
      width: 50px;
      height: 50px;
      background: var(--primary-color);
      color: white;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 1rem;
      font-size: 1.25rem;
    }

    .detail-value {
      font-size: 1.5rem;
      font-weight: 700;
      color: #1e293b;
      margin-bottom: 0.5rem;
    }

    .detail-label {
      color: var(--secondary-color);
      font-weight: 500;
      text-transform: uppercase;
      font-size: 0.875rem;
      letter-spacing: 0.5px;
    }

    /* Category Badge */
    .category-badge {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      padding: 0.75rem 1.5rem;
      border-radius: 25px;
      font-weight: 600;
      font-size: 1rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .category-1 {
      background: linear-gradient(135deg, #dbeafe, #bfdbfe);
      color: #1e40af;
      border: 2px solid #3b82f6;
    }

    .category-2 {
      background: linear-gradient(135deg, #d1fae5, #a7f3d0);
      color: #065f46;
      border: 2px solid #10b981;
    }

    .category-3 {
      background: linear-gradient(135deg, #fed7aa, #fdba74);
      color: #9a3412;
      border: 2px solid #f97316;
    }

    .category-4 {
      background: linear-gradient(135deg, #fecaca, #fca5a5);
      color: #991b1b;
      border: 2px solid #ef4444;
    }

    /* Stock Status */
    .stock-status {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
      padding: 1rem;
      border-radius: var(--border-radius);
      font-weight: 600;
      font-size: 1.1rem;
      margin-top: 1rem;
    }

    .stock-ok {
      background: #f0fdf4;
      color: #166534;
      border: 1px solid #bbf7d0;
    }

    .stock-low {
      background: #fef2f2;
      color: #991b1b;
      border: 1px solid #fecaca;
    }

    /* Additional Info */
    .additional-info {
      background: var(--light-bg);
      padding: 1.5rem;
      border-radius: var(--border-radius);
      border: 1px solid #e2e8f0;
      margin-top: 2rem;
    }

    .info-title {
      font-size: 1.25rem;
      font-weight: 600;
      color: #1e293b;
      margin-bottom: 1rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .info-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 1rem;
    }

    .info-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0.75rem 0;
      border-bottom: 1px solid #e2e8f0;
    }

    .info-item:last-child {
      border-bottom: none;
    }

    .info-item-label {
      color: var(--secondary-color);
      font-weight: 500;
    }

    .info-item-value {
      font-weight: 600;
      color: #1e293b;
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

    /* Empty State */
    .empty-state {
      text-align: center;
      padding: 3rem;
      color: var(--secondary-color);
    }

    .empty-state i {
      font-size: 4rem;
      margin-bottom: 1rem;
      opacity: 0.5;
    }

    .empty-state h3 {
      font-size: 1.5rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
      color: #1e293b;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .header-text h1 {
        font-size: 2rem;
      }

      .search-section {
        padding: 1.5rem;
      }

      .product-details {
        grid-template-columns: 1fr;
      }

      .product-title {
        font-size: 1.5rem;
      }

      .product-icon {
        width: 60px;
        height: 60px;
        font-size: 1.5rem;
      }

      .info-grid {
        grid-template-columns: 1fr;
      }
    }

    /* Loading State */
    .loading-state {
      display: none;
      text-align: center;
      padding: 2rem;
      color: var(--secondary-color);
    }

    .loading-spinner {
      width: 40px;
      height: 40px;
      border: 3px solid #e2e8f0;
      border-top: 3px solid var(--warning-color);
      border-radius: 50%;
      animation: spin 1s linear infinite;
      margin: 0 auto 1rem;
    }

    /* Action Buttons */
    .action-buttons {
      margin-top: 2rem;
      padding: 1.5rem;
      background: var(--light-bg);
      border-radius: var(--border-radius);
      border: 1px solid #e2e8f0;
      text-align: center;
    }

    .action-buttons-grid {
      display: flex;
      gap: 1rem;
      justify-content: center;
      flex-wrap: wrap;
    }

    /* Single button centering */
    .action-buttons .action-btn {
      margin: 0 auto;
    }

    .action-btn {
      padding: 1rem 2rem;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
      font-size: 1rem;
      min-width: 180px;
    }

    .edit-btn {
      background: linear-gradient(135deg, var(--info-color), #0e7490);
      color: white;
    }

    .edit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(8, 145, 178, 0.3);
    }

    .delete-btn {
      background: linear-gradient(135deg, var(--danger-color), #b91c1c);
      color: white;
    }

    .delete-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(220, 38, 38, 0.3);
    }

    /* Modal Styles */
    .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.5);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 1000;
      opacity: 0;
      visibility: hidden;
      transition: var(--transition);
    }

    .modal-overlay.active {
      opacity: 1;
      visibility: visible;
    }

    .modal-content {
      background: white;
      border-radius: var(--border-radius);
      padding: 2rem;
      max-width: 500px;
      width: 90%;
      box-shadow: var(--card-shadow-hover);
      transform: scale(0.8);
      transition: var(--transition);
    }

    .modal-overlay.active .modal-content {
      transform: scale(1);
    }

    .modal-header {
      text-align: center;
      margin-bottom: 1.5rem;
    }

    .modal-header h3 {
      color: var(--danger-color);
      margin-bottom: 0.5rem;
      font-size: 1.5rem;
    }

    .modal-body {
      text-align: center;
      margin-bottom: 2rem;
      color: var(--secondary-color);
      line-height: 1.6;
    }

    .modal-actions {
      display: flex;
      gap: 1rem;
      justify-content: center;
    }

    .modal-btn {
      padding: 0.75rem 1.5rem;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
    }

    .modal-btn-cancel {
      background: var(--secondary-color);
      color: white;
    }

    .modal-btn-cancel:hover {
      background: #475569;
    }

    .modal-btn-confirm {
      background: var(--danger-color);
      color: white;
    }

    .modal-btn-confirm:hover {
      background: #b91c1c;
    }

    @media (max-width: 768px) {
      .action-buttons-grid {
        grid-template-columns: 1fr;
        max-width: 250px;
      }

      .modal-actions {
        flex-direction: column;
      }

      .modal-btn {
        width: 100%;
      }
    }
  </style>
</head>

<body>
<!-- Header -->
<header class="page-header">
  <div class="container">
    <div class="header-content">
      <div class="header-icon">
        <i class="fas fa-search"></i>
      </div>
      <div class="header-text">
        <h1>Recherche de Produits</h1>
        <p>Trouvez rapidement vos produits par code-barres</p>
      </div>
    </div>
  </div>
</header>

<!-- Main Content -->
<div class="main-container">
  <!-- Search Section -->
  <div class="search-section">
    <div class="search-header">
      <h2>Rechercher un Produit</h2>
      <p>Entrez le code-barres du produit pour afficher ses informations détaillées</p>
    </div>

    <form action="product" method="get" class="search-form" id="searchForm">
      <div class="search-input-group">
        <input type="text" name="barcode" class="search-input"
               placeholder="Entrez le code-barres du produit..." required autocomplete="off" autofocus>
      </div>
      <button type="submit" class="search-button" id="searchButton">
        <i class="fas fa-search"></i>
        Rechercher le Produit
      </button>
    </form>

    <!-- Loading State -->
    <div class="loading-state" id="loadingState">
      <div class="loading-spinner"></div>
      <p>Recherche en cours...</p>
    </div>

    <!-- Alert Messages -->
    <% String errorMessage = (String) request.getAttribute("error"); %>
    <% String errorParam = request.getParameter("error"); %>
    <% if (errorMessage != null || errorParam != null) { %>
    <div class="alert-custom alert-danger">
      <i class="fas fa-exclamation-triangle"></i>
      <%= (errorMessage != null) ? errorMessage : errorParam %>
    </div>
    <% } %>

    <% String successParam = request.getParameter("success"); %>
    <% if (successParam != null) { %>
    <div class="alert-custom alert-success">
      <i class="fas fa-check-circle"></i>
      <%= successParam %>
    </div>
    <% } %>
  </div>

  <!-- Product Display -->
  <% Product product = (Product) request.getAttribute("product"); %>
  <% if (product != null) { %>
  <div class="product-section">
    <!-- Product Header -->
    <div class="product-header">
      <div class="product-icon">
        <i class="fas fa-box"></i>
      </div>
      <h2 class="product-title"><%= product.getName() %></h2>
      <p class="product-subtitle">Informations détaillées du produit</p>
    </div>

    <!-- Product Details Grid -->
    <div class="product-details">
      <div class="detail-card">
        <div class="detail-icon">
          <i class="fas fa-barcode"></i>
        </div>
        <div class="detail-value"><%= product.getBarcode() %></div>
        <div class="detail-label">Code-Barres</div>
      </div>

      <div class="detail-card">
        <div class="detail-icon" style="background: var(--success-color);">
          <i class="fas fa-boxes"></i>
        </div>
        <div class="detail-value"><%= String.format("%.0f", product.getQuantity()) %></div>
        <div class="detail-label">Quantité en Stock</div>
      </div>

      <div class="detail-card">
        <div class="detail-icon" style="background: var(--info-color);">
          <i class="fas fa-ruler-combined"></i>
        </div>
        <div class="detail-value">
          <%= String.format("%.1f×%.1f×%.1f", product.getWidth(), product.getHeight(), product.getDepth()) %>
        </div>
        <div class="detail-label">Dimensions (cm)</div>
      </div>

      <div class="detail-card">
        <div class="detail-icon" style="background: var(--warning-color);">
          <i class="fas fa-exclamation-triangle"></i>
        </div>
        <div class="detail-value"><%= product.getMinStockThreshold() %></div>
        <div class="detail-label">Seuil d'Alerte</div>
      </div>
    </div>

    <!-- Category Information -->
    <div class="text-center">
      <%
        String categoryName = "";
        String categoryDescription = "";
        String categoryClass = "";
        switch(product.getCategory()) {
          case 1:
            categoryName = "Équipements Réseau";
            categoryDescription = "Matériel de communication et infrastructure réseau";
            categoryClass = "category-1";
            break;
          case 2:
            categoryName = "Serveurs & Infrastructure";
            categoryDescription = "Serveurs, stockage et équipements de centre de données";
            categoryClass = "category-2";
            break;
          case 3:
            categoryName = "Chiffrement & Authentification";
            categoryDescription = "Solutions de sécurité et authentification";
            categoryClass = "category-3";
            break;
          case 4:
            categoryName = "Monitoring & Analyse";
            categoryDescription = "Outils de surveillance et d'analyse";
            categoryClass = "category-4";
            break;
          default:
            categoryName = "Catégorie " + product.getCategory();
            categoryDescription = "Catégorie de produit";
            categoryClass = "category-1";
        }
      %>
      <div class="category-badge <%= categoryClass %>">
        <i class="fas fa-tag"></i>
        <%= categoryName %>
      </div>
      <p class="mt-2 text-muted"><%= categoryDescription %></p>
    </div>

    <!-- Stock Status -->
    <div class="stock-status <%= product.isStockLow() ? "stock-low" : "stock-ok" %>">
      <% if (product.isStockLow()) { %>
      <i class="fas fa-exclamation-triangle"></i>
      Stock Faible - Réapprovisionnement Recommandé
      <% } else { %>
      <i class="fas fa-check-circle"></i>
      Stock Suffisant
      <% } %>
    </div>

    <!-- Additional Information -->
    <div class="additional-info">
      <h3 class="info-title">
        <i class="fas fa-info-circle"></i>
        Informations Complémentaires
      </h3>
      <div class="info-grid">
        <div class="info-item">
          <span class="info-item-label">ID Produit</span>
          <span class="info-item-value">#<%= product.getId() %></span>
        </div>
        <div class="info-item">
          <span class="info-item-label">Volume</span>
          <span class="info-item-value">
              <%= String.format("%.2f cm³", product.getWidth() * product.getHeight() * product.getDepth()) %>
            </span>
        </div>
        <div class="info-item">
          <span class="info-item-label">Statut</span>
          <span class="info-item-value">
              <% if (product.getQuantity() > 0) { %>
                <span style="color: var(--success-color);">Disponible</span>
              <% } else { %>
                <span style="color: var(--danger-color);">Rupture</span>
              <% } %>
            </span>
        </div>
        <div class="info-item">
          <span class="info-item-label">Rotation</span>
          <span class="info-item-value">
              <% if (product.getQuantity() > product.getMinStockThreshold() * 2) { %>
                Faible
              <% } else if (product.getQuantity() > product.getMinStockThreshold()) { %>
                Moyenne
              <% } else { %>
                Élevée
              <% } %>
            </span>
        </div>
      </div>
    </div>

    <!-- Action Buttons -->
    <div class="action-buttons">
      <button type="button" class="action-btn delete-btn" onclick="confirmDelete('<%= product.getBarcode() %>', '<%= product.getName() %>')">
        <i class="fas fa-trash-alt"></i>
        Supprimer
      </button>
    </div>
  </div>

  <% } else if (request.getAttribute("error") == null) { %>
  <!-- Empty State -->
  <div class="search-section">
    <div class="empty-state">
      <i class="fas fa-search"></i>
      <h3>Recherchez un Produit</h3>
      <p>Utilisez le formulaire ci-dessus pour rechercher un produit par son code-barres</p>
    </div>
  </div>
  <% } %>

  <!-- Back Button -->
  <div class="text-center">
    <a href="index.jsp" class="back-button">
      <i class="fas fa-arrow-left"></i>
      Retour au Dashboard
    </a>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal-overlay" id="deleteModal">
  <div class="modal-content">
    <div class="modal-header">
      <h3><i class="fas fa-exclamation-triangle"></i> Confirmer la Suppression</h3>
    </div>
    <div class="modal-body">
      <p>Êtes-vous sûr de vouloir supprimer le produit <strong id="productToDelete"></strong> ?</p>
      <p style="color: var(--danger-color); font-weight: 600;">
        <i class="fas fa-warning"></i> Cette action est irréversible !
      </p>
    </div>
    <div class="modal-actions">
      <button type="button" class="modal-btn modal-btn-cancel" onclick="closeDeleteModal()">
        <i class="fas fa-times"></i> Annuler
      </button>
      <button type="button" class="modal-btn modal-btn-confirm" onclick="executeDelete()">
        <i class="fas fa-trash-alt"></i> Supprimer
      </button>
    </div>
  </div>
</div>

<!-- Hidden Form for Deletion -->
<form id="deleteForm" action="deleteProduct" method="POST" style="display: none;">
  <input type="hidden" name="barcode" id="deleteBarcode">
  <input type="hidden" name="confirmDelete" value="true">
  <input type="hidden" name="redirectPage" value="product">
</form>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  let currentDeleteBarcode = '';

  // Edit product function
  function editProduct(barcode) {
    window.location.href = 'editProduct?barcode=' + encodeURIComponent(barcode);
  }

  // Confirm delete function
  function confirmDelete(barcode, productName) {
    currentDeleteBarcode = barcode;
    document.getElementById('productToDelete').textContent = productName;
    document.getElementById('deleteModal').classList.add('active');
  }

  // Close delete modal
  function closeDeleteModal() {
    document.getElementById('deleteModal').classList.remove('active');
    currentDeleteBarcode = '';
  }

  // Execute deletion
  function executeDelete() {
    if (currentDeleteBarcode) {
      document.getElementById('deleteBarcode').value = currentDeleteBarcode;
      document.getElementById('deleteForm').submit();
    }
  }

  // Close modal on overlay click
  document.getElementById('deleteModal').addEventListener('click', function(e) {
    if (e.target === this) {
      closeDeleteModal();
    }
  });

  // Keyboard shortcuts
  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
      closeDeleteModal();
    }
  });
  // Auto-focus on search input
  document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.querySelector('.search-input');
    if (searchInput) {
      searchInput.focus();
    }
  });

  // Form submission handling
  document.getElementById('searchForm')?.addEventListener('submit', function(e) {
    const button = document.getElementById('searchButton');
    const loadingState = document.getElementById('loadingState');
    const searchSection = document.querySelector('.search-section');

    // Show loading state
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Recherche...';
    button.disabled = true;
    loadingState.style.display = 'block';

    // Hide any existing alerts
    const existingAlerts = document.querySelectorAll('.alert-custom');
    existingAlerts.forEach(alert => alert.style.display = 'none');

    // Reset after timeout (fallback)
    setTimeout(() => {
      button.innerHTML = '<i class="fas fa-search"></i> Rechercher le Produit';
      button.disabled = false;
      loadingState.style.display = 'none';
    }, 3000);
  });

  // Input validation and feedback
  document.querySelector('.search-input')?.addEventListener('input', function() {
    const value = this.value.trim();
    const button = document.getElementById('searchButton');

    if (value.length > 0) {
      this.style.borderColor = 'var(--success-color)';
      button.style.opacity = '1';
    } else {
      this.style.borderColor = '#e2e8f0';
      button.style.opacity = '0.7';
    }
  });

  // Enhanced visual feedback
  document.querySelector('.search-input')?.addEventListener('focus', function() {
    this.parentElement.style.transform = 'scale(1.02)';
  });

  document.querySelector('.search-input')?.addEventListener('blur', function() {
    this.parentElement.style.transform = 'scale(1)';
  });

  // Product card animations
  document.querySelectorAll('.detail-card').forEach((card, index) => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(20px)';

    setTimeout(() => {
      card.style.transition = 'all 0.5s ease';
      card.style.opacity = '1';
      card.style.transform = 'translateY(0)';
    }, index * 100);
  });

  // Category badge animation
  const categoryBadge = document.querySelector('.category-badge');
  if (categoryBadge) {
    categoryBadge.style.opacity = '0';
    categoryBadge.style.transform = 'scale(0.8)';

    setTimeout(() => {
      categoryBadge.style.transition = 'all 0.5s ease';
      categoryBadge.style.opacity = '1';
      categoryBadge.style.transform = 'scale(1)';
    }, 500);
  }

  // Enter key handling for better UX
  document.querySelector('.search-input')?.addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
      e.preventDefault();
      this.form.submit();
    }
  });

  // Clear input button (optional enhancement)
  const searchInput = document.querySelector('.search-input');
  if (searchInput && searchInput.value) {
    const clearButton = document.createElement('button');
    clearButton.type = 'button';
    clearButton.innerHTML = '<i class="fas fa-times"></i>';
    clearButton.className = 'btn btn-sm btn-outline-secondary position-absolute end-0 top-50 translate-middle-y me-2';
    clearButton.style.zIndex = '10';

    clearButton.addEventListener('click', function() {
      searchInput.value = '';
      searchInput.focus();
      this.remove();
    });

    searchInput.parentElement.style.position = 'relative';
    searchInput.parentElement.appendChild(clearButton);
  }
</script>
</body>
</html>