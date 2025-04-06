package com.jessica.bicycleshopapp.servlet;
import com.jessica.bicycleshopapp.dao.CustomerDAO;
import com.jessica.bicycleshopapp.model.Customer;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AddCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Customer customer = new Customer();
        customer.setFirstName(req.getParameter("firstName"));
        customer.setLastName(req.getParameter("lastName"));
        customer.setPhoneNumber(req.getParameter("phoneNumber"));
        customer.setEmail(req.getParameter("email"));
        customer.setAddress(req.getParameter("address"));

        try {
            new CustomerDAO().addCustomer(customer);
            resp.sendRedirect("customers.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("add-customer.jsp?error=1");
        }
    }
}