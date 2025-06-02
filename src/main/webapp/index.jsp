<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MyWMS - Système de Gestion d'Entrepôt</title>

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

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      background-color: var(--light-bg);
      color: #1e293b;
      line-height: 1.6;
    }

    /* Header */
    .main-header {
      background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
      color: white;
      padding: 2rem 0;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .header-content {
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
      gap: 1rem;
    }

    .logo-section {
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .logo-icon {
      background: rgba(255, 255, 255, 0.2);
      padding: 1rem;
      border-radius: var(--border-radius);
      font-size: 2rem;
    }

    .logo-text h1 {
      font-size: 2.5rem;
      font-weight: 700;
      margin: 0;
    }

    .logo-text p {
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

    /* Navigation Cards */
    .dashboard-container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 3rem 1rem;
    }

    .section-title {
      font-size: 2rem;
      font-weight: 600;
      color: #1e293b;
      margin-bottom: 0.5rem;
      text-align: center;
    }

    .section-subtitle {
      color: var(--secondary-color);
      text-align: center;
      margin-bottom: 3rem;
      font-size: 1.125rem;
    }

    .cards-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 2rem;
      margin-bottom: 3rem;
    }

    .nav-card {
      background: white;
      border-radius: var(--border-radius);
      padding: 2rem;
      box-shadow: var(--card-shadow);
      transition: var(--transition);
      cursor: pointer;
      border: 1px solid #e2e8f0;
      text-decoration: none;
      color: inherit;
    }

    .nav-card:hover {
      transform: translateY(-4px);
      box-shadow: var(--card-shadow-hover);
      text-decoration: none;
      color: inherit;
    }

    .card-icon {
      width: 60px;
      height: 60px;
      border-radius: var(--border-radius);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      margin-bottom: 1.5rem;
      color: white;
    }

    .card-warehouse { background: linear-gradient(135deg, var(--primary-color), #1d4ed8); }
    .card-scan { background: linear-gradient(135deg, var(--success-color), #047857); }
    .card-search { background: linear-gradient(135deg, var(--warning-color), #b45309); }
    .card-add { background: linear-gradient(135deg, var(--danger-color), #b91c1c); }

    .card-title {
      font-size: 1.25rem;
      font-weight: 600;
      margin-bottom: 1rem;
      color: #1e293b;
    }

    .card-description {
      color: var(--secondary-color);
      margin-bottom: 1.5rem;
      line-height: 1.6;
    }

    .card-button {
      background: var(--primary-color);
      color: white;
      border: none;
      padding: 0.75rem 1.5rem;
      border-radius: 8px;
      font-weight: 500;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      transition: var(--transition);
    }

    .card-button:hover {
      background: #1d4ed8;
      color: white;
      text-decoration: none;
    }

    .btn-success {
      background: var(--success-color);
    }

    .btn-success:hover {
      background: #047857;
    }

    .btn-warning {
      background: var(--warning-color);
    }

    .btn-warning:hover {
      background: #b45309;
    }

    .btn-danger {
      background: var(--danger-color);
    }

    .btn-danger:hover {
      background: #b91c1c;
    }

    /* Quick Stats Section */
    .quick-stats {
      background: white;
      border-radius: var(--border-radius);
      padding: 2rem;
      box-shadow: var(--card-shadow);
      margin-bottom: 3rem;
    }

    .stats-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .stats-header h3 {
      font-size: 1.5rem;
      font-weight: 600;
      color: #1e293b;
      margin-bottom: 0.5rem;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 2rem;
    }

    .stat-card {
      text-align: center;
      padding: 1.5rem;
      background: var(--light-bg);
      border-radius: var(--border-radius);
      border: 1px solid #e2e8f0;
    }

    .stat-icon {
      width: 48px;
      height: 48px;
      margin: 0 auto 1rem;
      background: var(--primary-color);
      color: white;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.25rem;
    }

    .stat-value {
      font-size: 2rem;
      font-weight: 700;
      color: var(--primary-color);
      margin-bottom: 0.5rem;
    }

    .stat-name {
      color: var(--secondary-color);
      font-weight: 500;
    }

    /* Footer */
    .main-footer {
      background: #1e293b;
      color: white;
      text-align: center;
      padding: 2rem 0;
      margin-top: 4rem;
    }

    .footer-content {
      opacity: 0.8;
    }

    /* Loading State */
    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.9);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 9999;
      opacity: 0;
      visibility: hidden;
      transition: all 0.3s ease;
    }

    .loading-overlay.active {
      opacity: 1;
      visibility: visible;
    }

    .loading-spinner {
      width: 40px;
      height: 40px;
      border: 3px solid #e2e8f0;
      border-top: 3px solid var(--primary-color);
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    /* Responsive */
    @media (max-width: 768px) {
      .logo-text h1 {
        font-size: 2rem;
      }

      .header-stats {
        justify-content: center;
        width: 100%;
      }

      .cards-grid {
        grid-template-columns: 1fr;
        gap: 1.5rem;
      }

      .stats-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
      }
    }

    @media (max-width: 480px) {
      .stats-grid {
        grid-template-columns: 1fr;
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
<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
  <div class="loading-spinner"></div>
</div>

<!-- Header -->
<header class="main-header">
  <div class="container">
    <div class="header-content">
      <div class="logo-section">
        <div class="logo-icon">
          <i class="fas fa-warehouse"></i>
        </div>
        <div class="logo-text">
          <h1>MyWMS</h1>
          <p>Système de Gestion d'Entrepôt</p>
        </div>
      </div>

      <div class="header-stats">
        <div class="stat-item">
          <span class="stat-number" id="totalProducts">152</span>
          <span class="stat-label">Produits</span>
        </div>
        <div class="stat-item">
          <span class="stat-number" id="availableSlots">324</span>
          <span class="stat-label">Places Libres</span>
        </div>
        <div class="stat-item">
          <span class="stat-number" id="occupancyRate">68%</span>
          <span class="stat-label">Occupation</span>
        </div>
      </div>
    </div>
  </div>
</header>

<!-- Main Content -->
<div class="dashboard-container">
  <!-- Section Title -->
  <h2 class="section-title fade-in">Tableau de Bord</h2>
  <p class="section-subtitle fade-in">Gérez efficacement votre entrepôt avec nos outils intégrés</p>

  <!-- Navigation Cards -->
  <div class="cards-grid">
    <a href="warehouse" class="nav-card fade-in" onclick="showLoading()" style="animation-delay: 0.1s">
      <div class="card-icon card-warehouse">
        <i class="fas fa-cubes"></i>
      </div>
      <h3 class="card-title">Gestion d'Entrepôt</h3>
      <p class="card-description">
        Visualisez et gérez l'ensemble de vos emplacements de stockage.
        Surveillez la capacité et l'occupation en temps réel.
      </p>
      <div class="card-button">
        <i class="fas fa-eye"></i>
        Consulter l'Entrepôt
      </div>
    </a>

    <a href="scan.jsp" class="nav-card fade-in" onclick="showLoading()" style="animation-delay: 0.2s">
      <div class="card-icon card-scan">
        <i class="fas fa-barcode"></i>
      </div>
      <h3 class="card-title">Scanner de Produits</h3>
      <p class="card-description">
        Scannez rapidement les codes-barres pour localiser ou stocker vos produits.
        Interface optimisée pour une utilisation mobile.
      </p>
      <div class="card-button btn-success">
        <i class="fas fa-qrcode"></i>
        Lancer le Scanner
      </div>
    </a>

    <a href="product.jsp" class="nav-card fade-in" onclick="showLoading()" style="animation-delay: 0.3s">
      <div class="card-icon card-search">
        <i class="fas fa-search"></i>
      </div>
      <h3 class="card-title">Recherche de Produits</h3>
      <p class="card-description">
        Recherchez et consultez les détails de vos produits par code-barres.
        Accès complet aux informations de stock et localisation.
      </p>
      <div class="card-button btn-warning">
        <i class="fas fa-search-plus"></i>
        Rechercher
      </div>
    </a>

    <a href="addProduct" class="nav-card fade-in" onclick="showLoading()" style="animation-delay: 0.4s">
      <div class="card-icon card-add">
        <i class="fas fa-plus-circle"></i>
      </div>
      <h3 class="card-title">Ajouter un Produit</h3>
      <p class="card-description">
        Ajoutez de nouveaux produits à votre inventaire avec toutes leurs caractéristiques.
        Gestion complète des catégories et dimensions.
      </p>
      <div class="card-button btn-danger">
        <i class="fas fa-plus"></i>
        Nouveau Produit
      </div>
    </a>
  </div>

  <!-- Quick Stats -->
  <div class="quick-stats fade-in" style="animation-delay: 0.5s">
    <div class="stats-header">
      <h3>Aperçu Rapide</h3>
      <p class="text-muted">Statistiques en temps réel de votre entrepôt</p>
    </div>

    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-icon">
          <i class="fas fa-boxes"></i>
        </div>
        <div class="stat-value" id="categoryCount">4</div>
        <div class="stat-name">Catégories</div>
      </div>

      <div class="stat-card">
        <div class="stat-icon" style="background: var(--success-color);">
          <i class="fas fa-check-circle"></i>
        </div>
        <div class="stat-value" id="freeSpaces">324</div>
        <div class="stat-name">Places Libres</div>
      </div>

      <div class="stat-card">
        <div class="stat-icon" style="background: var(--warning-color);">
          <i class="fas fa-exclamation-triangle"></i>
        </div>
        <div class="stat-value" id="lowStock">8</div>
        <div class="stat-name">Stock Faible</div>
      </div>

      <div class="stat-card">
        <div class="stat-icon" style="background: var(--info-color);">
          <i class="fas fa-chart-line"></i>
        </div>
        <div class="stat-value" id="efficiency">92%</div>
        <div class="stat-name">Efficacité</div>
      </div>
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="main-footer">
  <div class="container">
    <div class="footer-content">
      <p>&copy; 2025 MyWMS - Système de Gestion d'Entrepôt | Tous droits réservés</p>
    </div>
  </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Show loading overlay
  function showLoading() {
    const overlay = document.getElementById('loadingOverlay');
    overlay.classList.add('active');
  }

  // Update statistics with animation
  function animateValue(element, start, end, duration) {
    let startTimestamp = null;
    const step = (timestamp) => {
      if (!startTimestamp) startTimestamp = timestamp;
      const progress = Math.min((timestamp - startTimestamp) / duration, 1);
      const current = Math.floor(progress * (end - start) + start);

      if (element.id === 'occupancyRate' || element.id === 'efficiency') {
        element.textContent = current + '%';
      } else {
        element.textContent = current;
      }

      if (progress < 1) {
        window.requestAnimationFrame(step);
      }
    };
    window.requestAnimationFrame(step);
  }

  // Initialize statistics animation
  function initializeStats() {
    const stats = [
      { id: 'totalProducts', start: 100, end: 152 },
      { id: 'availableSlots', start: 250, end: 324 },
      { id: 'occupancyRate', start: 50, end: 68 },
      { id: 'categoryCount', start: 1, end: 4 },
      { id: 'freeSpaces', start: 250, end: 324 },
      { id: 'lowStock', start: 1, end: 8 },
      { id: 'efficiency', start: 80, end: 92 }
    ];

    stats.forEach((stat, index) => {
      setTimeout(() => {
        const element = document.getElementById(stat.id);
        if (element) {
          animateValue(element, stat.start, stat.end, 1500);
        }
      }, index * 200);
    });
  }

  // Card hover effects
  function initializeCardEffects() {
    const cards = document.querySelectorAll('.nav-card');

    cards.forEach(card => {
      card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-8px) scale(1.02)';
      });

      card.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0) scale(1)';
      });
    });
  }

  // Initialize page
  document.addEventListener('DOMContentLoaded', function() {
    // Remove loading overlay
    setTimeout(() => {
      document.getElementById('loadingOverlay').classList.remove('active');
    }, 300);

    // Initialize animations
    setTimeout(initializeStats, 500);
    initializeCardEffects();

    // Add fade-in animation to elements
    const elements = document.querySelectorAll('.fade-in');
    elements.forEach((element, index) => {
      setTimeout(() => {
        element.style.animationDelay = (index * 0.1) + 's';
        element.style.opacity = '1';
      }, 100);
    });
  });

  // Update stats periodically (simulation)
  setInterval(() => {
    const totalProducts = document.getElementById('totalProducts');
    const availableSlots = document.getElementById('availableSlots');

    if (totalProducts && availableSlots) {
      const currentProducts = parseInt(totalProducts.textContent);
      const currentSlots = parseInt(availableSlots.textContent);

      // Small random variations
      const newProducts = currentProducts + Math.floor(Math.random() * 3) - 1;
      const newSlots = currentSlots + Math.floor(Math.random() * 5) - 2;

      if (newProducts > 0) totalProducts.textContent = newProducts;
      if (newSlots > 0) availableSlots.textContent = newSlots;
    }
  }, 30000); // Update every 30 seconds
</script>
</body>
</html>