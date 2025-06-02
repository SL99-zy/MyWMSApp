<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyWMS - Ajouter un Produit</title>

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
            background: linear-gradient(135deg, var(--danger-color) 0%, #b91c1c 100%);
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
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        /* Form Section */
        .form-section {
            background: white;
            border-radius: var(--border-radius);
            padding: 2.5rem;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
            border: 1px solid #e2e8f0;
        }

        .form-header {
            text-align: center;
            margin-bottom: 2.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .form-header h2 {
            font-size: 1.75rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }

        .form-header p {
            color: var(--secondary-color);
            margin: 0;
            font-size: 1.1rem;
        }

        /* Alert Messages */
        .alert-custom {
            padding: 1rem 1.5rem;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            border: 1px solid;
            display: flex;
            align-items: center;
            gap: 0.75rem;
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

        /* Form Styling */
        .form-grid {
            display: grid;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
        }

        .form-label i {
            color: var(--primary-color);
            width: 16px;
        }

        .form-label .required {
            color: var(--danger-color);
        }

        .form-input {
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background: white;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .form-input.error {
            border-color: var(--danger-color);
            box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
        }

        .form-select {
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background: white;
            cursor: pointer;
        }

        .form-select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        /* Grid Layout */
        .grid-2 {
            grid-template-columns: 1fr 1fr;
        }

        .grid-3 {
            grid-template-columns: 1fr 1fr 1fr;
        }

        .grid-full {
            grid-template-columns: 1fr;
        }

        /* Category Section */
        .category-section {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            border: 1px solid #e2e8f0;
            margin: 1.5rem 0;
        }

        .category-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1rem;
        }

        .category-option {
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            padding: 1rem;
            cursor: pointer;
            transition: var(--transition);
            text-align: center;
        }

        .category-option:hover {
            border-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: var(--card-shadow);
        }

        .category-option.selected {
            border-color: var(--primary-color);
            background: rgba(37, 99, 235, 0.05);
        }

        .category-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 0.75rem;
            font-size: 1.25rem;
            color: white;
        }

        .category-1 { background: linear-gradient(135deg, var(--primary-color), #1d4ed8); }
        .category-2 { background: linear-gradient(135deg, var(--success-color), #047857); }
        .category-3 { background: linear-gradient(135deg, var(--warning-color), #b45309); }
        .category-4 { background: linear-gradient(135deg, var(--danger-color), #b91c1c); }

        .category-name {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.25rem;
        }

        .category-description {
            font-size: 0.875rem;
            color: var(--secondary-color);
        }

        /* Dimensions Section */
        .dimensions-section {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            border: 1px solid #e2e8f0;
            margin: 1.5rem 0;
        }

        .dimensions-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .dimensions-help {
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .dimensions-help-text {
            color: #1e40af;
            font-size: 0.875rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Submit Section */
        .submit-section {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 2rem;
            border: 1px solid #e2e8f0;
            text-align: center;
        }

        .submit-button {
            background: linear-gradient(135deg, var(--danger-color), #b91c1c);
            color: white;
            border: none;
            padding: 1rem 2.5rem;
            border-radius: var(--border-radius);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            min-width: 200px;
            justify-content: center;
        }

        .submit-button:hover {
            transform: translateY(-2px);
            box-shadow: var(--card-shadow-hover);
        }

        .submit-button:active {
            transform: translateY(0);
        }

        .submit-button:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
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

        /* Helper Text */
        .helper-text {
            font-size: 0.875rem;
            color: var(--secondary-color);
            margin-top: 0.5rem;
        }

        .helper-text.error {
            color: var(--danger-color);
        }

        /* Progress Indicator */
        .progress-steps {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .progress-step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e2e8f0;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            transition: var(--transition);
        }

        .progress-step.active {
            background: var(--primary-color);
            color: white;
        }

        .progress-step.completed {
            background: var(--success-color);
            color: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header-text h1 {
                font-size: 2rem;
            }

            .form-section {
                padding: 1.5rem;
            }

            .grid-2,
            .grid-3 {
                grid-template-columns: 1fr;
            }

            .category-grid {
                grid-template-columns: 1fr;
            }

            .submit-button {
                width: 100%;
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
            <div class="header-icon">
                <i class="fas fa-plus-circle"></i>
            </div>
            <div class="header-text">
                <h1>Ajouter un Produit</h1>
                <p>Enrichissez votre inventaire avec un nouveau produit</p>
            </div>
        </div>
    </div>
</header>

<!-- Main Content -->
<div class="main-container">
    <!-- Form Section -->
    <div class="form-section fade-in">
        <div class="form-header">
            <h2>Informations du Produit</h2>
            <p>Remplissez tous les champs requis pour ajouter le produit à votre inventaire</p>
        </div>

        <!-- Progress Steps -->
        <div class="progress-steps">
            <div class="progress-step active">1</div>
            <div class="progress-step">2</div>
            <div class="progress-step">3</div>
        </div>

        <!-- Alert Messages -->
        <% String successMessage = (String) request.getAttribute("success"); %>
        <% if (successMessage != null) { %>
        <div class="alert-custom alert-success">
            <i class="fas fa-check-circle"></i>
            <%= successMessage %>
        </div>
        <% } %>

        <% String errorMessage = (String) request.getAttribute("error"); %>
        <% if (errorMessage != null) { %>
        <div class="alert-custom alert-danger">
            <i class="fas fa-exclamation-triangle"></i>
            <%= errorMessage %>
        </div>
        <% } %>

        <!-- Product Form -->
        <form action="addProduct" method="POST" id="productForm">
            <!-- Step 1: Basic Information -->
            <div class="form-step" id="step1">
                <h3 style="color: var(--primary-color); margin-bottom: 1.5rem;">
                    <i class="fas fa-info-circle"></i> Informations Générales
                </h3>

                <div class="form-grid grid-2">
                    <div class="form-group">
                        <label for="name" class="form-label">
                            <i class="fas fa-tag"></i>
                            Nom du Produit <span class="required">*</span>
                        </label>
                        <input type="text" id="name" name="name" class="form-input"
                               placeholder="Ex: Firewall Cisco ASA 5525-X" required>
                        <div class="helper-text">Nom descriptif et précis du produit</div>
                    </div>

                    <div class="form-group">
                        <label for="barcode" class="form-label">
                            <i class="fas fa-barcode"></i>
                            Code-Barres <span class="required">*</span>
                        </label>
                        <input type="text" id="barcode" name="barcode" class="form-input"
                               placeholder="Ex: FW001" required>
                        <div class="helper-text">Code unique d'identification</div>
                    </div>
                </div>

                <div class="form-grid grid-2" style="margin-top: 1.5rem;">
                    <div class="form-group">
                        <label for="quantity" class="form-label">
                            <i class="fas fa-boxes"></i>
                            Quantité Initiale <span class="required">*</span>
                        </label>
                        <input type="number" id="quantity" name="quantity" class="form-input"
                               placeholder="Ex: 10" min="0" required>
                        <div class="helper-text">Nombre d'unités à ajouter en stock</div>
                    </div>

                    <div class="form-group">
                        <label for="minThreshold" class="form-label">
                            <i class="fas fa-exclamation-triangle"></i>
                            Seuil d'Alerte
                        </label>
                        <input type="number" id="minThreshold" name="minThreshold" class="form-input"
                               placeholder="Ex: 5" min="0" value="5">
                        <div class="helper-text">Quantité minimale avant alerte</div>
                    </div>
                </div>
            </div>

            <!-- Step 2: Category Selection -->
            <div class="category-section" style="margin-top: 2rem;">
                <h3 class="category-title">
                    <i class="fas fa-layer-group"></i>
                    Catégorie du Produit <span class="required">*</span>
                </h3>

                <div class="category-grid">
                    <div class="category-option" data-category="1">
                        <div class="category-icon category-1">
                            <i class="fas fa-network-wired"></i>
                        </div>
                        <div class="category-name">Équipements Réseau</div>
                        <div class="category-description">Firewalls, routeurs, switches</div>
                    </div>

                    <div class="category-option" data-category="2">
                        <div class="category-icon category-2">
                            <i class="fas fa-server"></i>
                        </div>
                        <div class="category-name">Serveurs & Infrastructure</div>
                        <div class="category-description">Serveurs, NAS, UPS</div>
                    </div>

                    <div class="category-option" data-category="3">
                        <div class="category-icon category-3">
                            <i class="fas fa-shield-halved"></i>
                        </div>
                        <div class="category-name">Chiffrement & Auth</div>
                        <div class="category-description">HSM, tokens, certificats</div>
                    </div>

                    <div class="category-option" data-category="4">
                        <div class="category-icon category-4">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="category-name">Monitoring & Analyse</div>
                        <div class="category-description">SIEM, scanners, outils</div>
                    </div>
                </div>

                <input type="hidden" id="category" name="category" required>
                <div class="helper-text error" id="categoryError" style="display: none;">
                    Veuillez sélectionner une catégorie
                </div>
            </div>

            <!-- Step 3: Dimensions -->
            <div class="dimensions-section">
                <h3 class="dimensions-title">
                    <i class="fas fa-ruler-combined"></i>
                    Dimensions (Optionnel)
                </h3>

                <div class="dimensions-help">
                    <p class="dimensions-help-text">
                        <i class="fas fa-info-circle"></i>
                        Les dimensions permettent une meilleure gestion de l'espace de stockage
                    </p>
                </div>

                <div class="form-grid grid-3">
                    <div class="form-group">
                        <label for="width" class="form-label">
                            <i class="fas fa-arrows-alt-h"></i>
                            Largeur (cm)
                        </label>
                        <input type="number" id="width" name="width" class="form-input"
                               placeholder="Ex: 48.3" step="0.1" min="0" value="0">
                    </div>

                    <div class="form-group">
                        <label for="height" class="form-label">
                            <i class="fas fa-arrows-alt-v"></i>
                            Hauteur (cm)
                        </label>
                        <input type="number" id="height" name="height" class="form-input"
                               placeholder="Ex: 8.8" step="0.1" min="0" value="0">
                    </div>

                    <div class="form-group">
                        <label for="depth" class="form-label">
                            <i class="fas fa-arrows-alt"></i>
                            Profondeur (cm)
                        </label>
                        <input type="number" id="depth" name="depth" class="form-input"
                               placeholder="Ex: 55.9" step="0.1" min="0" value="0">
                    </div>
                </div>
            </div>

            <!-- Submit Section -->
            <div class="submit-section">
                <button type="submit" class="submit-button" id="submitButton">
                    <i class="fas fa-plus"></i>
                    Ajouter le Produit
                </button>
                <div class="helper-text" style="margin-top: 1rem;">
                    Vérifiez toutes les informations avant de soumettre
                </div>
            </div>
        </form>
    </div>

    <!-- Back Button -->
    <div class="text-center">
        <a href="index.jsp" class="back-button">
            <i class="fas fa-arrow-left"></i>
            Retour au Dashboard
        </a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Category selection handling
    document.querySelectorAll('.category-option').forEach(option => {
        option.addEventListener('click', function() {
            // Remove previous selection
            document.querySelectorAll('.category-option').forEach(opt =>
                opt.classList.remove('selected'));

            // Add selection to clicked option
            this.classList.add('selected');

            // Set hidden input value
            const categoryValue = this.getAttribute('data-category');
            document.getElementById('category').value = categoryValue;

            // Hide error message
            document.getElementById('categoryError').style.display = 'none';

            // Update progress
            updateProgressStep(2);
        });
    });

    // Form validation
    document.getElementById('productForm').addEventListener('submit', function(e) {
        let isValid = true;

        // Check required fields
        const requiredFields = ['name', 'barcode', 'quantity'];
        requiredFields.forEach(fieldId => {
            const field = document.getElementById(fieldId);
            if (!field.value.trim()) {
                field.classList.add('error');
                isValid = false;
            } else {
                field.classList.remove('error');
            }
        });

        // Check category selection
        const category = document.getElementById('category').value;
        if (!category) {
            document.getElementById('categoryError').style.display = 'block';
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault();
            return;
        }

        // Show loading state
        const submitButton = document.getElementById('submitButton');
        submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Ajout en cours...';
        submitButton.disabled = true;
    });

    // Input validation feedback
    document.querySelectorAll('.form-input').forEach(input => {
        input.addEventListener('input', function() {
            if (this.value.trim()) {
                this.classList.remove('error');
                this.style.borderColor = 'var(--success-color)';

                // Update progress based on filled fields
                updateProgress();
            } else {
                this.style.borderColor = '#e2e8f0';
            }
        });

        input.addEventListener('blur', function() {
            this.style.borderColor = '#e2e8f0';
        });
    });

    // Progress tracking
    function updateProgress() {
        const name = document.getElementById('name').value.trim();
        const barcode = document.getElementById('barcode').value.trim();
        const quantity = document.getElementById('quantity').value.trim();
        const category = document.getElementById('category').value;

        if (name && barcode) {
            updateProgressStep(1);
        }

        if (quantity && category) {
            updateProgressStep(2);
        }

        if (name && barcode && quantity && category) {
            updateProgressStep(3);
        }
    }

    function updateProgressStep(step) {
        const steps = document.querySelectorAll('.progress-step');

        for (let i = 0; i < step; i++) {
            steps[i].classList.add('completed');
            steps[i].classList.remove('active');
        }

        if (steps[step - 1]) {
            steps[step - 1].classList.add('active');
        }
    }

    // Auto-focus first input
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('name').focus();

        // Add fade-in animation
        setTimeout(() => {
            document.querySelector('.form-section').style.opacity = '1';
            document.querySelector('.form-section').style.transform = 'translateY(0)';
        }, 100);
    });

    // Barcode validation
    document.getElementById('barcode').addEventListener('input', function() {
        const value = this.value.replace(/[^a-zA-Z0-9]/g, '');
        this.value = value;
    });

    // Generate barcode suggestion
    document.getElementById('name').addEventListener('blur', function() {
        const barcodeField = document.getElementById('barcode');
        if (!barcodeField.value && this.value) {
            // Simple barcode generation based on name
            const suggestion = this.value.replace(/[^a-zA-Z0-9]/g, '').substring(0, 8).toUpperCase();
            if (suggestion.length >= 3) {
                barcodeField.placeholder = `Suggestion: ${suggestion}`;
            }
        }
    });

    // Dimensions helper
    document.querySelectorAll('#width, #height, #depth').forEach(input => {
        input.addEventListener('input', function() {
            updateVolumeDisplay();
        });
    });

    function updateVolumeDisplay() {
        const width = parseFloat(document.getElementById('width').value) || 0;
        const height = parseFloat(document.getElementById('height').value) || 0;
        const depth = parseFloat(document.getElementById('depth').value) || 0;

        if (width > 0 && height > 0 && depth > 0) {
            const volume = (width * height * depth).toFixed(2);
            const helpText = document.querySelector('.dimensions-help-text');
            helpText.innerHTML = `<i class="fas fa-cube"></i> Volume calculé: ${volume} cm³`;
        }
    }
</script>
</body>
</html>