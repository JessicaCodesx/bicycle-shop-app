package com.jessica.bicycleshopapp.servlet;
import com.jessica.bicycleshopapp.dao.SupplierDAO;
import com.jessica.bicycleshopapp.model.Supplier;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AddSupplierServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Supplier s = new Supplier();
        s.setSupplierName(req.getParameter("supplierName"));
        s.setSupplierEmail(req.getParameter("supplierEmail"));
        s.setSupplierPhone(req.getParameter("supplierPhone"));

        try {
            new SupplierDAO().addSupplier(s);
            resp.sendRedirect("suppliers.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("add-supplier.jsp?error=1");
        }
    }
}