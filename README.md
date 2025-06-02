# Documentation Technique - MyWMS
## Système de Gestion d'Entrepôt (Warehouse Management System)

---

## Table des Matières

1. [Vue d'ensemble du Projet](#vue-densemble-du-projet)
2. [Architecture du Système](#architecture-du-système)
3. [Technologies Utilisées](#technologies-utilisées)
4. [Structure du Projet](#structure-du-projet)
5. [Modèle de Données](#modèle-de-données)
6. [API et Contrôleurs](#api-et-contrôleurs)
7. [Interfaces Utilisateur](#interfaces-utilisateur)
8. [Configuration et Déploiement](#configuration-et-déploiement)
9. [Fonctionnalités Principales](#fonctionnalités-principales)
10. [Guide d'Installation](#guide-dinstallation)
11. [Tests et Validation](#tests-et-validation)
12. [Maintenance et Evolution](#maintenance-et-evolution)

---

## 1. Vue d'ensemble du Projet

### 1.1 Description Générale

MyWMS est un système de gestion d'entrepôt moderne développé en Java avec une architecture MVC (Model-View-Controller). Le système permet de gérer efficacement l'inventaire, le stockage et la localisation des produits dans un environnement d'entrepôt structuré.

### 1.2 Objectifs Principaux

- **Gestion d'inventaire** : Suivi en temps réel des produits et des stocks
- **Optimisation du stockage** : Allocation intelligente des emplacements
- **Traçabilité** : Suivi complet des mouvements de produits
- **Interface intuitive** : Interfaces web modernes et responsives
- **Scalabilité** : Architecture modulaire pour une croissance future

### 1.3 Domaine d'Application

Le système est spécialement conçu pour la gestion d'équipements informatiques et de sécurité, organisés en quatre catégories principales :

1. **Équipements Réseau** (Catégorie 1)
2. **Serveurs & Infrastructure** (Catégorie 2)
3. **Chiffrement & Authentification** (Catégorie 3)
4. **Monitoring & Analyse** (Catégorie 4)

---

## 2. Architecture du Système

### 2.1 Architecture Générale

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Presentation  │    │    Business     │    │   Data Access   │
│     Layer       │◄──►│     Layer       │◄──►│     Layer       │
│                 │    │                 │    │                 │
│ • JSP Pages     │    │ • Services      │    │ • DAO Classes   │
│ • Servlets      │    │ • Business      │    │ • Database      │
│ • CSS/JS        │    │   Logic         │    │   Connection    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### 2.2 Patterns Architecturaux

- **MVC (Model-View-Controller)** : Séparation claire des responsabilités
- **DAO (Data Access Object)** : Abstraction de l'accès aux données
- **Service Layer** : Logique métier centralisée
- **Factory Pattern** : Gestion des connexions de base de données

### 2.3 Structure en Couches

#### Couche Présentation
- **JSP (JavaServer Pages)** : Interfaces utilisateur dynamiques
- **Servlets** : Contrôleurs de requêtes HTTP
- **CSS/JavaScript** : Styles et interactions client

#### Couche Business
- **Services** : Logique métier et règles de gestion
- **Models** : Entités et objets métier
- **Utilitaires** : Classes d'aide et de support

#### Couche Données
- **DAO** : Accès et manipulation des données
- **Base de données MySQL** : Stockage persistant
- **Configuration** : Gestion des connexions

---

## 3. Technologies Utilisées

### 3.1 Backend

| Technologie | Version | Utilisation |
|-------------|---------|-------------|
| **Java** | 17+ | Langage principal |
| **Jakarta EE** | 10.0 | Framework web |
| **MySQL** | 8.0+ | Base de données |
| **Maven** | 3.8+ | Gestion des dépendances |
| **Apache Tomcat** | 10.1+ | Serveur d'application |

### 3.2 Frontend

| Technologie | Version | Utilisation |
|-------------|---------|-------------|
| **HTML5** | - | Structure des pages |
| **CSS3** | - | Styles et animations |
| **JavaScript** | ES6+ | Interactions dynamiques |
| **Bootstrap** | 5.3.0 | Framework CSS responsive |
| **Font Awesome** | 6.4.2 | Icônes |

### 3.3 Outils de Développement

- **IDE** : IntelliJ IDEA / Eclipse
- **Contrôle de version** : Git
- **Déploiement** : Render.com
- **Base de données cloud** : Aiven MySQL

---

## 4. Structure du Projet

### 4.1 Organisation des Packages

```
src/main/java/org/example/mywmsapp/
├── controller/          # Servlets et contrôleurs
├── dao/                # Data Access Objects
├── model/              # Modèles de données
├── service/            # Services métier
└── util/               # Classes utilitaires

src/main/webapp/
├── WEB-INF/            # Configuration web
├── static/             # Ressources statiques
└── *.jsp               # Pages JSP
```

### 4.2 Détail des Packages

#### Package Controller
- `AddProductServlet.java` : Ajout de nouveaux produits
- `BarcodeServlet.java` : Gestion du scan de codes-barres
- `DeleteProductServlet.java` : Suppression de produits
- `ProductServlet.java` : Recherche et affichage de produits
- `WarehouseServlet.java` : Gestion de l'entrepôt
- `StoreProductServlet.java` : Stockage de produits
- `FreePlaceServlet.java` : Libération d'emplacements

#### Package DAO
- `ProductDAO.java` : Accès aux données des produits
- `WarehouseDAO.java` : Accès aux données d'entrepôt
- `SectionDAO.java` : Accès aux données des sections
- `BarcodeDAO.java` : Historique des scans
- `DatabaseConnection.java` : Gestion des connexions

#### Package Model
- `Product.java` : Modèle de produit
- `Place.java` : Modèle d'emplacement
- `Section.java` : Modèle de section
- `Warehouse.java` : Modèle d'entrepôt
- `BarcodeScan.java` : Modèle de scan

#### Package Service
- `ProductService.java` : Services produits
- `WarehouseService.java` : Services entrepôt
- `BarcodeService.java` : Services de scan
- `SectionService.java` : Services sections

---

## 5. Modèle de Données

### 5.1 Diagramme Entité-Relation

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Product   │     │   Section   │     │    Place    │
├─────────────┤     ├─────────────┤     ├─────────────┤
│ id (PK)     │     │ id (PK)     │     │ id (PK)     │
│ name        │     │ name        │     │ category_id │
│ barcode     │────►│ category    │◄────│ row_index   │
│ width       │     │             │     │ col_index   │
│ height      │     └─────────────┘     │ is_occupied │
│ depth       │                         └─────────────┘
│ quantity    │
│ category    │     ┌─────────────┐
│ minThreshold│     │BarcodeScan  │
└─────────────┘     ├─────────────┤
                    │ id (PK)     │
                    │ barcode     │
                    │ scan_date   │
                    │ warehouse_id│
                    │ category_id │
                    │ place_id    │
                    └─────────────┘
```

### 5.2 Tables de Base de Données

#### Table `products`
```sql
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    barcode VARCHAR(100) UNIQUE NOT NULL,
    width DECIMAL(10,2) DEFAULT 0.0,
    height DECIMAL(10,2) DEFAULT 0.0,
    depth DECIMAL(10,2) DEFAULT 0.0,
    quantity DECIMAL(10,2) NOT NULL DEFAULT 0.0,
    category INT NOT NULL,
    min_threshold INT DEFAULT 5,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

#### Table `sections`
```sql
CREATE TABLE sections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category INT NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Table `warehouse_places`
```sql
CREATE TABLE warehouse_places (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    row_index INT NOT NULL,
    col_index INT NOT NULL,
    is_occupied BOOLEAN DEFAULT FALSE,
    max_width DECIMAL(10,2) DEFAULT 100.0,
    max_height DECIMAL(10,2) DEFAULT 100.0,
    max_depth DECIMAL(10,2) DEFAULT 100.0,
    stored_product_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES sections(category),
    UNIQUE KEY unique_position (category_id, row_index, col_index)
);
```

#### Table `barcode_scans`
```sql
CREATE TABLE barcode_scans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    barcode VARCHAR(100) NOT NULL,
    scan_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    warehouse_id INT DEFAULT 1,
    category_id INT NOT NULL,
    place_id INT NULL,
    action_type ENUM('SCAN', 'STORE', 'RETRIEVE') DEFAULT 'SCAN',
    FOREIGN KEY (place_id) REFERENCES warehouse_places(id)
);
```

### 5.3 Données de Référence

#### Catégories de Produits
```sql
INSERT INTO sections (name, category, description) VALUES
('Équipements Réseau', 1, 'Firewalls, routeurs, switches et équipements de communication'),
('Serveurs & Infrastructure', 2, 'Serveurs, stockage, UPS et équipements de centre de données'),
('Chiffrement & Authentification', 3, 'HSM, tokens, certificats et solutions de sécurité'),
('Monitoring & Analyse', 4, 'SIEM, scanners, outils de surveillance et d\'analyse');
```

---

## 6. API et Contrôleurs

### 6.1 Endpoints Principaux

#### Gestion des Produits

| Endpoint | Méthode | Description | Paramètres |
|----------|---------|-------------|------------|
| `/addProduct` | GET | Affiche le formulaire d'ajout | - |
| `/addProduct` | POST | Ajoute un nouveau produit | name, barcode, quantity, category, dimensions |
| `/product` | GET | Recherche un produit | barcode |
| `/deleteProduct` | POST | Supprime un produit | barcode, confirmDelete |

#### Gestion de l'Entrepôt

| Endpoint | Méthode | Description | Paramètres |
|----------|---------|-------------|------------|
| `/warehouse` | GET | Affiche la vue d'entrepôt | - |
| `/scan` | POST | Scanne un code-barres | barcode, action |
| `/storeProduct` | POST | Stocke un produit | barcode, placeId, sectionId |
| `/freePlace` | POST | Libère un emplacement | placeId |

### 6.2 Flux de Données Typiques

#### Ajout d'un Produit
```
1. GET /addProduct → Affichage du formulaire
2. POST /addProduct → Validation et sauvegarde
3. Redirection → Confirmation ou erreur
```

#### Scan et Stockage
```
1. POST /scan → Recherche du produit
2. Affichage des emplacements disponibles
3. POST /storeProduct → Stockage effectif
4. Mise à jour de l'occupation
```

### 6.3 Gestion des Erreurs

#### Codes de Retour
- **200** : Succès
- **400** : Erreur de validation
- **404** : Ressource non trouvée
- **500** : Erreur serveur

#### Messages d'Erreur
- Validation des champs obligatoires
- Vérification de l'unicité des codes-barres
- Contrôle de la disponibilité des emplacements
- Gestion des erreurs de base de données

---

## 7. Interfaces Utilisateur

### 7.1 Pages Principales

#### Dashboard (index.jsp)
- **Fonction** : Page d'accueil avec navigation principale
- **Éléments** : Statistiques, liens rapides, aperçu système
- **Responsive** : Optimisé mobile et desktop

#### Scanner (scan.jsp)
- **Fonction** : Interface de scan de codes-barres
- **Fonctionnalités** :
  - Scan manuel ou par caméra
  - Affichage des informations produit
  - Stockage automatique ou manuel
  - Gestion des emplacements

#### Gestion Produits (product.jsp)
- **Fonction** : Recherche et gestion des produits
- **Fonctionnalités** :
  - Recherche par code-barres
  - Affichage détaillé des informations
  - Actions de modification/suppression

#### Ajout Produit (add-product.jsp)
- **Fonction** : Formulaire d'ajout de nouveaux produits
- **Fonctionnalités** :
  - Validation en temps réel
  - Sélection de catégorie
  - Gestion des dimensions
  - Aperçu avant validation

#### Entrepôt (warehouse.jsp)
- **Fonction** : Vue d'ensemble de l'entrepôt
- **Fonctionnalités** :
  - Grille visuelle des emplacements
  - Statistiques par section
  - Gestion des places libres/occupées
  - Actions de libération

### 7.2 Design System

#### Couleurs Principales
```css
--primary-color: #2563eb    /* Bleu principal */
--success-color: #059669    /* Vert succès */
--warning-color: #d97706    /* Orange avertissement */
--danger-color: #dc2626     /* Rouge erreur */
--info-color: #0891b2       /* Bleu information */
```

#### Typographie
- **Police principale** : Inter (Google Fonts)
- **Tailles** : 12px à 48px avec échelle modulaire
- **Poids** : 300, 400, 500, 600, 700

#### Composants Réutilisables
- **Cards** : Conteneurs avec ombres et bordures arrondies
- **Boutons** : Styles gradients avec états hover/active
- **Formulaires** : Validation visuelle et feedback
- **Modales** : Confirmations et détails
- **Grilles** : Layouts responsives

---

## 8. Configuration et Déploiement

### 8.1 Configuration de Base de Données

#### Variables d'Environnement
```properties
# Production (Render/Aiven)
DB_HOST=mysql-xxxx.aivencloud.com
DB_PORT=12345
DB_NAME=defaultdb
DB_USER=avnadmin
DB_PASSWORD=xxxxx

# Développement Local
DB_HOST=localhost
DB_PORT=3306
DB_NAME=mywmsdb
DB_USER=root
DB_PASSWORD=
```

#### Configuration SSL
```java
// Production avec SSL
url = "jdbc:mysql://host:port/db?useSSL=true&requireSSL=true&sslMode=REQUIRED"

// Développement local
url = "jdbc:mysql://host:port/db?useSSL=false"
```

### 8.2 Déploiement sur Render

#### Structure des Fichiers
```
├── Dockerfile
├── render.yaml
├── target/
│   └── mywmsapp.war
└── pom.xml
```

#### Configuration Render
```yaml
services:
  - type: web
    name: mywms-app
    env: java
    buildCommand: mvn clean package
    startCommand: java -jar target/mywmsapp.war
    envVars:
      - key: DB_HOST
        value: mysql-xxxx.aivencloud.com
      - key: DB_USER
        value: avnadmin
```

### 8.3 Scripts de Déploiement

#### Build Maven
```bash
mvn clean compile package
```

#### Déploiement Local
```bash
cp target/mywmsapp.war $TOMCAT_HOME/webapps/
$TOMCAT_HOME/bin/catalina.sh run
```

---

## 9. Fonctionnalités Principales

### 9.1 Gestion d'Inventaire

#### Ajout de Produits
- **Formulaire intuitif** avec validation en temps réel
- **Catégorisation automatique** selon le type d'équipement
- **Gestion des dimensions** pour optimisation de stockage
- **Codes-barres uniques** avec vérification de doublon

#### Recherche et Consultation
- **Recherche par code-barres** instantanée
- **Affichage détaillé** des informations produit
- **Historique des mouvements** et traçabilité
- **Alertes de stock faible** configurables

### 9.2 Stockage Intelligent

#### Allocation Automatique
- **Algorithme génétique** pour optimisation des emplacements
- **Critères multiples** : proximité, disponibilité, historique
- **Respect des catégories** et contraintes de stockage

#### Gestion Manuelle
- **Sélection visuelle** des emplacements
- **Interface graphique** de la grille d'entrepôt
- **Validation des contraintes** avant stockage

### 9.3 Interface de Scan

#### Scan de Codes-Barres
- **Interface mobile-first** optimisée pour terminaux
- **Scan en temps réel** avec validation instantanée
- **Actions rapides** : stockage, recherche, suppression
- **Feedback visuel** et sonore

#### Gestion des Emplacements
- **Vue d'ensemble** de l'entrepôt par sections
- **Statistiques en temps réel** d'occupation
- **Actions de maintenance** : libération, nettoyage

### 9.4 Reporting et Analytics

#### Tableaux de Bord
- **Métriques clés** : occupation, rotation, alertes
- **Graphiques interactifs** d'évolution des stocks
- **Alertes automatiques** pour actions requises

#### Historique et Traçabilité
- **Journal complet** des mouvements
- **Rapports de performance** par catégorie
- **Export de données** pour analyse externe

---

## 10. Guide d'Installation

### 10.1 Prérequis Système

#### Environnement de Développement
- **Java JDK** 17 ou supérieur
- **Apache Maven** 3.8+
- **Apache Tomcat** 10.1+
- **MySQL Server** 8.0+
- **IDE** : IntelliJ IDEA ou Eclipse

#### Environnement de Production
- **Serveur Java** compatible Jakarta EE 10
- **Base de données MySQL** avec SSL
- **Certificats SSL** pour connexions sécurisées

### 10.2 Installation Locale

#### Étape 1 : Clone du Projet
```bash
git clone https://github.com/username/mywmsapp.git
cd mywmsapp
```

#### Étape 2 : Configuration Base de Données
```sql
-- Création de la base
CREATE DATABASE mywmsdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Création des tables
SOURCE scripts/database_schema.sql;

-- Insertion des données de test
SOURCE scripts/sample_data.sql;
```

#### Étape 3 : Configuration Application
```properties
# src/main/resources/application.properties
db.host=localhost
db.port=3306
db.name=mywmsdb
db.user=root
db.password=your_password
```

#### Étape 4 : Build et Déploiement
```bash
mvn clean package
cp target/mywmsapp.war $TOMCAT_HOME/webapps/
$TOMCAT_HOME/bin/startup.sh
```

#### Étape 5 : Vérification
- Accéder à `http://localhost:8080/mywmsapp`
- Tester les fonctionnalités principales
- Vérifier la connexion base de données

### 10.3 Déploiement Production

#### Configuration Render
1. **Fork du repository** sur GitHub
2. **Connexion Render** au repository
3. **Configuration variables** d'environnement
4. **Déploiement automatique** via Git push

#### Configuration Aiven MySQL
1. **Création instance** MySQL sur Aiven
2. **Configuration SSL** et utilisateurs
3. **Import du schéma** de base de données
4. **Test de connectivité** depuis Render

---

## 11. Tests et Validation

### 11.1 Tests Unitaires

#### Couche DAO
```java
@Test
public void testProductDAO_insertAndRetrieve() {
    ProductDAO dao = new ProductDAO();
    Product product = new Product("Test Product", "TEST001", 1);
    
    boolean inserted = dao.insertProduct(product);
    assertTrue(inserted);
    
    Product retrieved = dao.getProductByBarcode("TEST001");
    assertNotNull(retrieved);
    assertEquals("Test Product", retrieved.getName());
}
```

#### Couche Service
```java
@Test
public void testProductService_validateBarcode() {
    ProductService service = new ProductService();
    
    // Test avec code-barres valide
    Product product = service.getProductByBarcode("VALID001");
    assertNotNull(product);
    
    // Test avec code-barres invalide
    Product invalid = service.getProductByBarcode("INVALID");
    assertNull(invalid);
}
```

### 11.2 Tests d'Intégration

#### Test Workflow Complet
```java
@Test
public void testCompleteWorkflow() {
    // 1. Ajout d'un produit
    ProductService productService = new ProductService();
    Product newProduct = new Product("Router Cisco", "RTR001", 1);
    boolean added = productService.saveProduct(newProduct);
    assertTrue(added);
    
    // 2. Scan du produit
    BarcodeService barcodeService = new BarcodeService();
    Product scanned = barcodeService.scanProduct("RTR001");
    assertNotNull(scanned);
    
    // 3. Stockage
    WarehouseService warehouseService = new WarehouseService();
    boolean stored = warehouseService.storeProduct("RTR001", 1);
    assertTrue(stored);
    
    // 4. Vérification occupation
    Place place = warehouseService.getPlaceById(1);
    assertTrue(place.isOccupied());
}
```

### 11.3 Tests Fonctionnels

#### Scénarios de Test
1. **Ajout de produit complet**
   - Validation formulaire
   - Sauvegarde base de données
   - Vérification unicité code-barres

2. **Workflow de stockage**
   - Scan code-barres
   - Sélection emplacement
   - Confirmation stockage
   - Mise à jour occupation

3. **Gestion des erreurs**
   - Produit inexistant
   - Emplacement occupé
   - Erreurs de base de données

### 11.4 Tests de Performance

#### Métriques Clés
- **Temps de réponse** : < 2 secondes
- **Concurrence** : 50 utilisateurs simultanés
- **Débit** : 100 requêtes/seconde
- **Disponibilité** : 99.9% uptime

#### Outils de Test
- **JMeter** : Tests de charge
- **Selenium** : Tests d'interface
- **Postman** : Tests d'API

---

## 12. Maintenance et Evolution

### 12.1 Monitoring et Alertes

#### Métriques à Surveiller
- **Performance base de données** : temps de requête, connexions
- **Utilisation mémoire** : heap, garbage collection
- **Erreurs applicatives** : exceptions, timeouts
- **Utilisation disque** : logs, données temporaires

#### Alertes Automatiques
- **Stock critique** : produits sous seuil minimum
- **Erreurs système** : échecs de connexion, exceptions
- **Performance dégradée** : temps de réponse élevés

### 12.2 Sauvegardes et Récupération

#### Stratégie de Sauvegarde
- **Sauvegarde quotidienne** complète de la base
- **Sauvegarde incrémentale** toutes les 6 heures
- **Rétention** : 30 jours en ligne, 1 an archivé
- **Test de restauration** mensuel

#### Plan de Continuité
1. **Détection de problème** : monitoring automatique
2. **Évaluation impact** : criticité et utilisateurs affectés
3. **Activation plan B** : serveur de secours si nécessaire
4. **Restauration service** : procédures documentées
5. **Post-mortem** : analyse et amélioration

### 12.3 Évolutions Futures

#### Fonctionnalités Prévues

##### Phase 2 - Q3 2025
- **API REST complète** pour intégrations tierces
- **Application mobile native** Android/iOS
- **Scan par caméra** en temps réel
- **Rapports avancés** avec export Excel/PDF

##### Phase 3 - Q4 2025
- **Intelligence artificielle** pour prédiction de stock
- **Optimisation 3D** de l'espace d'entrepôt
- **Intégration ERP** (SAP, Oracle)
- **Module de facturation** automatisée

##### Phase 4 - Q1 2026
- **Multi-entrepôts** avec synchronisation
- **Gestion des fournisseurs** et commandes
- **Workflow d'approbation** pour mouvements critiques
- **Dashboard analytique** temps réel

#### Architecture Future
- **Microservices** : découpage modulaire
- **Container Docker** : déploiement standardisé
- **Load balancing** : haute disponibilité
- **Cache Redis** : optimisation performance

### 12.4 Documentation Technique

#### Standards de Code
- **Conventions Java** : style Google/Oracle
- **Commentaires** : JavaDoc pour APIs publiques
- **Tests** : couverture minimum 80%
- **Logging** : niveaux appropriés (DEBUG, INFO, WARN, ERROR)

#### Procédures de Déploiement
1. **Développement** : tests locaux complets
2. **Staging** : validation en environnement similaire
3. **Production** : déploiement planifié avec rollback
4. **Validation** : tests de smoke et monitoring

---

## Conclusion

MyWMS représente une solution complète et évolutive pour la gestion d'entrepôt, combinant une architecture robuste, des interfaces modernes et des fonctionnalités avancées. Le système est conçu pour grandir avec les besoins de l'organisation tout en maintenant des performances optimales et une expérience utilisateur exceptionnelle.

### Points Clés

- **Architecture MVC solide** avec séparation claire des responsabilités
- **Interface utilisateur moderne** responsive et intuitive
- **Gestion intelligente du stockage** avec algorithmes d'optimisation
- **Traçabilité complète** des mouvements et opérations
- **Déploiement cloud** scalable et sécurisé

### Recommandations

1. **Formation utilisateurs** : session d'onboarding complète
2. **Monitoring continu** : surveillance proactive des performances
3. **Évolution incrémentale** : développement agile par phases
4. **Feedback utilisateurs** : amélioration continue basée sur l'usage réel

---

**Réalisé par** : Anouar Boukabous , Youssef El Badouri , Saad Eddine Hachlaf , Zakaria Ouahi , Mohammed Amine Oubella. 
