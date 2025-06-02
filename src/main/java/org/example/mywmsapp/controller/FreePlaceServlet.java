package org.example.mywmsapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.mywmsapp.service.WarehouseService;

import java.io.IOException;

@WebServlet("/freePlace")
public class FreePlaceServlet extends HttpServlet {
    private final WarehouseService warehouseService = new WarehouseService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String placeIdStr = request.getParameter("placeId");

        System.out.println("🔎 Received placeId: " + placeIdStr);  // Debugging

        try {
            if (placeIdStr == null || placeIdStr.trim().isEmpty()) {
                System.out.println("❌ Erreur: placeId est vide.");
                response.sendRedirect("warehouse.jsp?error=placeIdVide");
                return;
            }

            int placeId = Integer.parseInt(placeIdStr);
            boolean success = warehouseService.freePlace(placeId);

            if (success) {
                System.out.println("✅ Emplacement libéré avec succès: " + placeId);
                response.sendRedirect("warehouse");  // ✅ Redirection immédiate vers warehouse.jsp
            } else {
                System.out.println("❌ Erreur: Échec de la libération de l'emplacement.");
                response.sendRedirect("warehouse.jsp?error=echecLiberation");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("warehouse.jsp?error=exception&message=" + e.getMessage());
        }
    }
}
