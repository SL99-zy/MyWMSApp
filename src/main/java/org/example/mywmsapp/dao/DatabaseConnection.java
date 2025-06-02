package org.example.mywmsapp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Configuration via variables d'environnement (SÉCURISÉ pour Render)
    private static final String HOST = System.getenv("DB_HOST");
    private static final String PORT = System.getenv("DB_PORT");
    private static final String DATABASE = System.getenv("DB_NAME");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    // Configuration par défaut pour développement local uniquement
    private static final String DEFAULT_HOST = "localhost";
    private static final String DEFAULT_PORT = "3306";
    private static final String DEFAULT_DATABASE = "mywmsdb";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "";

    public static Connection getConnection() throws SQLException {
        // Utiliser les variables d'environnement si disponibles, sinon utiliser les valeurs par défaut
        String host = (HOST != null && !HOST.isEmpty()) ? HOST : DEFAULT_HOST;
        String port = (PORT != null && !PORT.isEmpty()) ? PORT : DEFAULT_PORT;
        String database = (DATABASE != null && !DATABASE.isEmpty()) ? DATABASE : DEFAULT_DATABASE;
        String user = (USER != null && !USER.isEmpty()) ? USER : DEFAULT_USER;
        String password = (PASSWORD != null && !PASSWORD.isEmpty()) ? PASSWORD : DEFAULT_PASSWORD;

        // Construction de l'URL selon l'environnement
        String url;
        if (HOST != null && HOST.contains("aivencloud.com")) {
            // Configuration Aiven avec SSL (Production)
            url = String.format(
                    "jdbc:mysql://%s:%s/%s?useSSL=true&requireSSL=true&sslMode=REQUIRED&useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC&allowPublicKeyRetrieval=true",
                    host, port, database
            );
            System.out.println("🌐 Connexion à Aiven (Production)");
        } else {
            // Configuration locale (Développement)
            url = String.format("jdbc:mysql://%s:%s/%s?useSSL=false", host, port, database);
            System.out.println("🏠 Connexion locale (Développement)");
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Connexion à la base de données établie avec succès !");
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("❌ MySQL Driver not found: " + e.getMessage());
            throw new SQLException("MySQL Driver not found", e);
        } catch (SQLException e) {
            System.err.println("❌ Erreur de connexion à la base de données: " + e.getMessage());
            System.err.println("🔍 URL tentée: " + url.replaceAll("password=[^&]*", "password=***"));
            throw e;
        }
    }

    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("🔗 Test de connexion réussi !");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("❌ Test de connexion échoué: " + e.getMessage());
        }
        return false;
    }
}