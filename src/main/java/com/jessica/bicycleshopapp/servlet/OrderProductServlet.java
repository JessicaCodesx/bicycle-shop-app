package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.dao.InventoryDAO;
import com.jessica.bicycleshopapp.model.Order;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/order-product")
public class OrderProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            LocalDate orderDate = LocalDate.parse(request.getParameter("orderDate"));
            LocalDate deliveryDate = LocalDate.parse(request.getParameter("deliveryDate"));

            Order order = new Order(productId, supplierId, quantity, orderDate, deliveryDate);
            new InventoryDAO().placeOrder(order);

            response.sendRedirect("dashboard.jsp?success=order");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("order-product.jsp?error=true");
        }
    }
}
