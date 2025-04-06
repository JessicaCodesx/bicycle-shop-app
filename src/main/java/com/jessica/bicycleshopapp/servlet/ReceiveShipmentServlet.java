package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.dao.InventoryDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/receive-shipment")
public class ReceiveShipmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            new InventoryDAO().receiveShipment(productId, quantity);
            response.sendRedirect("dashboard.jsp?success=receive");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("receive-shipment.jsp?error=true");
        }
    }
}
