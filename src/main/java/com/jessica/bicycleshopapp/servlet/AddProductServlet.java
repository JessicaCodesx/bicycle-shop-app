package com.jessica.bicycleshopapp.servlet;

import com.jessica.bicycleshopapp.dao.ProductDAO;
import com.jessica.bicycleshopapp.model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Product p = new Product();
            p.setName(req.getParameter("name"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setCategory(req.getParameter("category"));
            p.setSupplierId(Integer.parseInt(req.getParameter("supplierId")));
            p.setDiscontinued(false);

            int quantity = Integer.parseInt(req.getParameter("quantity"));

            new ProductDAO().addProduct(p, quantity);
            resp.sendRedirect("products.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("add-product.jsp?error=1");
        }
    }
}
