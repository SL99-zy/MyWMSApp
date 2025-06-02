<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.mywmsapp.model.Product, org.example.mywmsapp.model.Place, java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MyWMS - Scanner de Produits</title>

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
      min-height: 100vh;
    }

    /* Header */
    .page-header {
      background: linear-gradient(135deg, var(--success-color) 0%, #047857 100%);
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
      gap: 1rem;
    }

    .stat-badge {
      background: rgba(255, 255, 255, 0.1);
      padding: 0.5rem 1rem;
      border-radius: 20px;
      font-size: 0.875rem;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    /* Main Container */
    .main-container {
      max-width: 1000px;
      margin: 0 auto;
      padding: 2rem 1rem;
    }

    /* Scanner Section */
    .scanner-section {
      background: white;
      border-radius: var(--border-radius);
      padding: 2.5rem;
      box-shadow: var(--card-shadow);
      margin-bottom: 2rem;
      border: 1px solid #e2e8f0;
      position: relative;
    }

    .scanner-section::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, var(--success-color), var(--primary-color));
      border-radius: var(--border-radius) var(--border-radius) 0 0;
    }

    .scanner-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .scanner-header h2 {
      font-size: 1.75rem;
      font-weight: 600;
      color: #1e293b;
      margin-bottom: 0.5rem;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.75rem;
    }

    .scanner-header p {
      color: var(--secondary-color);
      margin: 0;
      font-size: 1.1rem;
    }

    .scanner-form {
      max-width: 500px;
      margin: 0 auto;
    }

    .scanner-input-group {
      position: relative;
      margin-bottom: 1.5rem;
    }

    .scanner-input {
      width: 100%;
      padding: 1.25rem 1.5rem;
      font-size: 1.125rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      transition: var(--transition);
      background: white;
      font-weight: 500;
    }

    .scanner-input:focus {
      outline: none;
      border-color: var(--success-color);
      box-shadow: 0 0 0 4px rgba(5, 150, 105, 0.1);
      background: #f0fdf4;
    }

    .scanner-input::placeholder {
      color: #94a3b8;
      font-weight: 400;
    }

    .scan-button {
      width: 100%;
      padding: 1.25rem;
      background: linear-gradient(135deg, var(--success-color), #047857);
      color: white;
      border: none;
      border-radius: var(--border-radius);
      font-size: 1.125rem;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.75rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .scan-button:hover {
      transform: translateY(-2px);
      box-shadow: var(--card-shadow-hover);
      background: linear-gradient(135deg, #047857, #065f46);
    }

    .scan-button:active {
      transform: translateY(0);
    }

    .scan-button:disabled {
      opacity: 0.6;
      cursor: not-allowed;
      transform: none;
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
      font-weight: 500;
      animation: slideInDown 0.5s ease-out;
    }

    @keyframes slideInDown {
      from {
        opacity: 0;
        transform: translateY(-20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
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
      animation: slideInUp 0.6s ease-out;
      position: relative;
    }

    .product-section::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, var(--success-color), var(--warning-color));
      border-radius: var(--border-radius) var(--border-radius) 0 0;
    }

    @keyframes slideInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .product-header {
      display: flex;
      align-items: center;
      gap: 1.5rem;
      margin-bottom: 2rem;
      padding-bottom: 1.5rem;
      border-bottom: 1px solid #e2e8f0;
    }

    .product-icon {
      width: 70px;
      height: 70px;
      background: linear-gradient(135deg, var(--success-color), #047857);
      color: white;
      border-radius: var(--border-radius);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.75rem;
      flex-shrink: 0;
    }

    .product-info h3 {
      font-size: 1.75rem;
      font-weight: 700;
      color: #1e293b;
      margin: 0 0 0.5rem 0;
    }

    .product-info p {
      color: var(--secondary-color);
      margin: 0;
      font-size: 1rem;
    }

    /* Product Details Grid */
    .product-details {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
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
      position: relative;
    }

    .detail-card:hover {
      transform: translateY(-3px);
      box-shadow: var(--card-shadow);
      border-color: var(--primary-color);
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
      margin: 1rem 0;
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

    /* Action Buttons */
    .action-section {
      background: var(--light-bg);
      border-radius: var(--border-radius);
      padding: 2rem;
      border: 1px solid #e2e8f0;
      margin-bottom: 2rem;
    }

    .action-header {
      text-align: center;
      margin-bottom: 1.5rem;
    }

    .action-header h4 {
      color: #1e293b;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }

    .action-buttons-row {
      display: flex;
      gap: 1rem;
      justify-content: center;
      flex-wrap: wrap;
    }

    .action-btn {
      padding: 1rem 2rem;
      border: none;
      border-radius: var(--border-radius);
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      display: inline-flex;
      align-items: center;
      gap: 0.75rem;
      font-size: 1rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      min-width: 180px;
      justify-content: center;
    }

    .auto-stock-btn {
      background: linear-gradient(135deg, var(--primary-color), #1d4ed8);
      color: white;
    }

    .auto-stock-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(37, 99, 235, 0.3);
    }

    .delete-product-btn {
      background: linear-gradient(135deg, var(--danger-color), #b91c1c);
      color: white;
    }

    .delete-product-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(220, 38, 38, 0.3);
    }

    /* Storage Section */
    .storage-section {
      background: white;
      border-radius: var(--border-radius);
      padding: 2rem;
      box-shadow: var(--card-shadow);
      margin-bottom: 2rem;
      border: 1px solid #e2e8f0;
      position: relative;
    }

    .storage-section::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, var(--info-color), var(--primary-color));
      border-radius: var(--border-radius) var(--border-radius) 0 0;
    }

    .storage-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .storage-header h3 {
      font-size: 1.5rem;
      font-weight: 600;
      color: #1e293b;
      margin-bottom: 0.5rem;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.75rem;
    }

    /* Places Grid */
    .places-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      justify-content: center;
      margin: 2rem 0;
      padding: 2rem;
      background: var(--light-bg);
      border-radius: var(--border-radius);
      border: 1px solid #e2e8f0;
    }

    .place-box {
      width: 50px;
      height: 50px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 8px;
      font-weight: 600;
      font-size: 0.75rem;
      cursor: pointer;
      transition: var(--transition);
      border: 2px solid;
      position: relative;
    }

    .place-box.free {
      background: #d1fae5;
      color: #065f46;
      border-color: #10b981;
    }

    .place-box.occupied {
      background: #fecaca;
      color: #991b1b;
      border-color: #ef4444;
    }

    .place-box:hover {
      transform: scale(1.15);
      z-index: 10;
      box-shadow: var(--card-shadow-hover);
    }

    /* Storage Table */
    .storage-table {
      background: white;
      border-radius: var(--border-radius);
      overflow: hidden;
      border: 1px solid #e2e8f0;
      box-shadow: var(--card-shadow);
    }

    .storage-table table {
      width: 100%;
      margin: 0;
    }

    .storage-table th {
      background: var(--light-bg);
      color: #1e293b;
      font-weight: 600;
      padding: 1rem;
      border-bottom: 1px solid #e2e8f0;
      text-align: center;
      font-size: 0.875rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .storage-table td {
      padding: 1rem;
      border-bottom: 1px solid #f1f5f9;
      text-align: center;
      vertical-align: middle;
    }

    .storage-table tbody tr {
      transition: var(--transition);
    }

    .storage-table tbody tr:hover {
      background: var(--light-bg);
    }

    .store-btn {
      background: var(--success-color);
      color: white;
      border: none;
      padding: 0.75rem 1.5rem;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      font-size: 0.875rem;
    }

    .store-btn:hover {
      background: #047857;
      transform: translateY(-1px);
      box-shadow: 0 4px 12px rgba(5, 150, 105, 0.3);
    }

    /* Status Badge */
    .status-badge {
      padding: 0.5rem 1rem;
      border-radius: 15px;
      font-size: 0.75rem;
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

    /* Modal Styles */
    .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.6);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 1000;
      opacity: 0;
      visibility: hidden;
      transition: var(--transition);
      backdrop-filter: blur(4px);
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
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.75rem;
    }

    .modal-body {
      text-align: center;
      margin-bottom: 2rem;
      color: var(--secondary-color);
      line-height: 1.6;
    }

    .modal-body strong {
      color: #1e293b;
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
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      min-width: 120px;
      justify-content: center;
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
      gap: 0.75rem;
      transition: var(--transition);
      margin-top: 2rem;
      font-size: 1rem;
    }

    .back-button:hover {
      background: #475569;
      color: white;
      text-decoration: none;
      transform: translateY(-2px);
      box-shadow: var(--card-shadow);
    }

    /* Responsive */
    @media (max-width: 768px) {
      .header-text h1 {
        font-size: 2rem;
      }

      .header-stats {
        width: 100%;
        justify-content: center;
      }

      .scanner-section {
        padding: 1.5rem;
      }

      .product-header {
        flex-direction: column;
        text-align: center;
      }

      .product-details {
        grid-template-columns: 1fr;
      }

      .action-buttons-row {
        flex-direction: column;
        align-items: center;
      }

      .action-btn {
        width: 100%;
        max-width: 300px;
      }

      .places-grid {
        gap: 6px;
        padding: 1rem;
      }

      .place-box {
        width: 40px;
        height: 40px;
        font-size: 0.6rem;
      }

      .storage-table {
        font-size: 0.875rem;
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
      <div class="header-left">
        <div class="header-icon">
          <i class="fas fa-barcode"></i>
        </div>
        <div class="header-text">
          <h1>Scanner WMS</h1>
          <p>Scannez et gérez vos produits en temps réel</p>
        </div>
      </div>

      <div class="header-stats">
        <div class="stat-badge">
          <i class="fas fa-check-circle"></i>
          Système Actif
        </div>
        <div class="stat-badge">
          <i class="fas fa-wifi"></i>
          Connecté
        </div>
      </div>
    </div>
  </div>
</header>

<!-- Main Content -->
<div class="main-container">
  <!-- Scanner Section -->
  <div class="scanner-section">
    <div class="scanner-header">
      <h2>
        <i class="fas fa-qrcode"></i>
        Scanner un Code-Barres
      </h2>
      <p>Entrez ou scannez le code-barres du produit pour afficher ses informations</p>
    </div>

    <form action="scan" method="POST" class="scanner-form" id="scannerForm">
      <div class="scanner-input-group">
        <input type="text" name="barcode" class="scanner-input"
               placeholder="Code-barres du produit..." required autocomplete="off" autofocus>
      </div>
      <button type="submit" class="scan-button" id="scanButton">
        <i class="fas fa-search"></i>
        Scanner le Produit
      </button>
    </form>

    <!-- Alert Messages -->
    <% String errorMessage = (String) request.getAttribute("error"); %>
    <% String errorParam = request.getParameter("error"); %>
    <% if (errorMessage != null || errorParam != null) { %>
    <div class="alert-custom alert-danger">
      <i class="fas fa-exclamation-triangle"></i>
      <%= (errorMessage != null) ? errorMessage : errorParam %>
    </div>
    <% } %>

    <% String successMessage = (String) request.getAttribute("success"); %>
    <% String successParam = request.getParameter("success"); %>
    <% if (successMessage != null || successParam != null) { %>
    <div class="alert-custom alert-success">
      <i class="fas fa-check-circle"></i>
      <%= (successMessage != null) ? successMessage : successParam %>
    </div>
    <% } %>
  </div>

  <!-- Product Display -->
  <% Product product = (Product) request.getAttribute("product"); %>
  <% if (product != null) { %>
  <div class="product-section">
    <div class="product-header">
      <div class="product-icon">
        <i class="fas fa-box"></i>
      </div>
      <div class="product-info">
        <h3><%= product.getName() %></h3>
        <p>Produit scanné avec succès - Code: <%= product.getBarcode() %></p>
      </div>
    </div>

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
        <div class="detail-icon" style="background: var(--warning-color);">
          <i class="fas fa-layer-group"></i>
        </div>
        <div class="detail-value">
          <%
            String categoryName = "";
            String categoryClass = "";
            switch(product.getCategory()) {
              case 1:
                categoryName = "Réseau";
                categoryClass = "category-1";
                break;
              case 2:
                categoryName = "Serveurs";
                categoryClass = "category-2";
                break;
              case 3:
                categoryName = "Sécurité";
                categoryClass = "category-3";
                break;
              case 4:
                categoryName = "Monitoring";
                categoryClass = "category-4";
                break;
              default:
                categoryName = "Cat. " + product.getCategory();
                categoryClass = "category-1";
            }
          %>
          <span class="category-badge <%= categoryClass %>">
              <i class="fas fa-tag"></i>
              <%= categoryName %>
            </span>
        </div>
        <div class="detail-label">Catégorie</div>
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
    </div>

    <!-- Action Buttons -->
    <div class="action-section">
      <div class="action-header">
        <h4>Actions Disponibles</h4>
        <p>Choisissez une action à effectuer sur ce produit</p>
      </div>

      <div class="action-buttons-row">
        <form action="scan" method="POST" style="display: inline;">
          <input type="hidden" name="barcode" value="<%= product.getBarcode() %>">
          <input type="hidden" name="action" value="autoStock">
          <button type="submit" class="action-btn auto-stock-btn">
            <i class="fas fa-robot"></i>
            Stockage Automatique
          </button>
        </form>

        <button type="button" class="action-btn delete-product-btn" onclick="confirmDeleteProduct('<%= product.getBarcode() %>', '<%= product.getName() %>')">
          <i class="fas fa-trash-alt"></i>
          Supprimer Produit
        </button>
      </div>
    </div>
  </div>

  <!-- Storage Locations -->
  <% List<Place> places = (List<Place>) request.getAttribute("places"); %>
  <% if (places != null && !places.isEmpty()) { %>
  <div class="storage-section">
    <div class="storage-header">
      <h3>
        <i class="fas fa-map-marker-alt"></i>
        Emplacements de Stockage
      </h3>
      <p>Emplacements disponibles pour ce produit</p>
    </div>

    <!-- Visual Grid -->
    <div class="places-grid">
      <% for (Place place : places) { %>
      <div class="place-box <%= place.isOccupied() ? "occupied" : "free" %>"
           title="Section <%= place.getSectionId() %> | Rangée <%= place.getRowIndex() %> | Colonne <%= place.getColIndex() %> | <%= place.isOccupied() ? "Occupé" : "Libre" %>">
        <%= place.getRowIndex() %>-<%= place.getColIndex() %>
      </div>
      <% } %>
    </div>

    <!-- Manual Storage Table -->
    <div class="storage-header" style="margin-top: 2rem;">
      <h4 style="font-size: 1.25rem; margin-bottom: 1rem;">
        <i class="fas fa-hand-pointer"></i>
        Stockage Manuel
      </h4>
      <p style="margin-bottom: 1.5rem;">Sélectionnez un emplacement libre pour stocker le produit</p>
    </div>

    <div class="storage-table">
      <table class="table">
        <thead>
        <tr>
          <th>N°</th>
          <th>Emplacement</th>
          <th>Position</th>
          <th>Section</th>
          <th>Statut</th>
          <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <% int counter = 1; %>
        <% for (Place place : places) { %>
        <% if (!place.isOccupied()) { %>
        <tr>
          <td><%= counter++ %></td>
          <td><%= place.getName() %></td>
          <td>R<%= place.getRowIndex() %> - C<%= place.getColIndex() %></td>
          <td>Section <%= place.getSectionId() %></td>
          <td>
                  <span class="status-badge status-free">
                    <i class="fas fa-check-circle"></i> Libre
                  </span>
          </td>
          <td>
            <form action="storeProduct" method="POST" style="display: inline;">
              <input type="hidden" name="barcode" value="<%= product.getBarcode() %>">
              <input type="hidden" name="placeId" value="<%= place.getId() %>">
              <input type="hidden" name="sectionId" value="<%= place.getSectionId() %>">
              <button type="submit" class="store-btn">
                <i class="fas fa-box"></i>
                Stocker Ici
              </button>
            </form>
          </td>
        </tr>
        <% } %>
        <% } %>
        </tbody>
      </table>
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

<!-- Delete Confirmation Modal -->
<div class="modal-overlay" id="deleteModal">
  <div class="modal-content">
    <div class="modal-header">
      <h3><i class="fas fa-exclamation-triangle"></i> Confirmer la Suppression</h3>
    </div>
    <div class="modal-body">
      <p>Êtes-vous sûr de vouloir supprimer le produit <strong id="productToDelete"></strong> ?</p>
      <p style="color: var(--danger-color); font-weight: 600; margin-top: 1rem;">
        <i class="fas fa-warning"></i> Cette action supprimera définitivement le produit de l'inventaire !
      </p>
    </div>
    <div class="modal-actions">
      <button type="button" class="modal-btn modal-btn-cancel" onclick="closeDeleteModal()">
        <i class="fas fa-times"></i> Annuler
      </button>
      <button type="button" class="modal-btn modal-btn-confirm" onclick="executeDeleteProduct()">
        <i class="fas fa-trash-alt"></i> Supprimer
      </button>
    </div>
  </div>
</div>

<!-- Hidden Form for Deletion -->
<form id="deleteProductForm" action="deleteProduct" method="POST" style="display: none;">
  <input type="hidden" name="barcode" id="deleteProductBarcode">
  <input type="hidden" name="confirmDelete" value="true">
  <input type="hidden" name="redirectPage" value="scan">
</form>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  let currentDeleteBarcode = '';

  // Auto-focus on barcode input
  document.addEventListener('DOMContentLoaded', function() {
    const barcodeInput = document.querySelector('.scanner-input');
    if (barcodeInput) {
      barcodeInput.focus();
    }

    // Add visual feedback on successful scan
    const productSection = document.querySelector('.product-section');
    if (productSection) {
      productSection.style.opacity = '0';
      productSection.style.transform = 'translateY(20px)';

      setTimeout(() => {
        productSection.style.transition = 'all 0.6s ease';
        productSection.style.opacity = '1';
        productSection.style.transform = 'translateY(0)';
      }, 200);
    }
  });

  // Form submission handling
  document.getElementById('scannerForm').addEventListener('submit', function(e) {
    const button = document.getElementById('scanButton');
    const input = document.querySelector('.scanner-input');

    if (!input.value.trim()) {
      e.preventDefault();
      input.focus();
      input.style.borderColor = 'var(--danger-color)';
      setTimeout(() => {
        input.style.borderColor = '#e2e8f0';
      }, 2000);
      return;
    }

    // Show loading state
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Recherche...';
    button.disabled = true;

    // Reset after timeout (fallback)
    setTimeout(() => {
      button.innerHTML = '<i class="fas fa-search"></i> Scanner le Produit';
      button.disabled = false;
    }, 5000);
  });

  // Input enhancement
  document.querySelector('.scanner-input').addEventListener('input', function() {
    const value = this.value.trim();

    if (value.length > 0) {
      this.style.borderColor = 'var(--success-color)';
      this.style.backgroundColor = '#f0fdf4';
    } else {
      this.style.borderColor = '#e2e8f0';
      this.style.backgroundColor = 'white';
    }
  });

  // Confirm delete product function
  function confirmDeleteProduct(barcode, productName) {
    currentDeleteBarcode = barcode;
    document.getElementById('productToDelete').textContent = productName;
    document.getElementById('deleteModal').classList.add('active');
  }

  // Close delete modal
  function closeDeleteModal() {
    document.getElementById('deleteModal').classList.remove('active');
    currentDeleteBarcode = '';
  }

  // Execute product deletion
  function executeDeleteProduct() {
    if (currentDeleteBarcode) {
      document.getElementById('deleteProductBarcode').value = currentDeleteBarcode;
      document.getElementById('deleteProductForm').submit();
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

    // Quick focus on scanner input with F2
    if (e.key === 'F2') {
      e.preventDefault();
      document.querySelector('.scanner-input').focus();
    }
  });

  // Place box click effects
  document.querySelectorAll('.place-box').forEach(box => {
    box.addEventListener('click', function() {
      // Add ripple effect
      this.style.transform = 'scale(1.3)';
      setTimeout(() => {
        this.style.transform = 'scale(1)';
      }, 200);
    });
  });

  // Auto stock button effect
  document.querySelector('.auto-stock-btn')?.addEventListener('click', function() {
    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Stockage...';
    this.disabled = true;
  });

  // Store buttons effect
  document.querySelectorAll('.store-btn').forEach(btn => {
    btn.addEventListener('click', function() {
      this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Stockage...';
      this.disabled = true;
    });
  });

  // Detail cards animation
  document.querySelectorAll('.detail-card').forEach((card, index) => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(20px)';

    setTimeout(() => {
      card.style.transition = 'all 0.5s ease';
      card.style.opacity = '1';
      card.style.transform = 'translateY(0)';
    }, 300 + (index * 100));
  });

  // Success/Error message auto-hide
  setTimeout(() => {
    const alerts = document.querySelectorAll('.alert-custom');
    alerts.forEach(alert => {
      alert.style.opacity = '0';
      alert.style.transform = 'translateY(-20px)';
      setTimeout(() => {
        alert.style.display = 'none';
      }, 300);
    });
  }, 5000);

  // Enhanced visual feedback for scanner input
  const scannerInput = document.querySelector('.scanner-input');
  scannerInput.addEventListener('focus', function() {
    this.parentElement.style.transform = 'scale(1.02)';
  });

  scannerInput.addEventListener('blur', function() {
    this.parentElement.style.transform = 'scale(1)';
  });

  // Barcode validation (basic)
  scannerInput.addEventListener('input', function() {
    const value = this.value;
    const cleanValue = value.replace(/[^a-zA-Z0-9]/g, '');
    if (value !== cleanValue) {
      this.value = cleanValue;
    }
  });
</script>
</body>
</html>