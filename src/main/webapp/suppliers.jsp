<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.SupplierDAO, com.jessica.bicycleshopapp.model.Supplier" %>
<%
    List<Supplier> suppliers = new SupplierDAO().getAllSuppliers();
    String role = ((com.jessica.bicycleshopapp.model.User) session.getAttribute("user")).getRole().toLowerCase();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Suppliers - Bike Shop System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-truck"></i> Supplier Management</h1>
            <% if ("admin".equals(role) || "owner".equals(role)) { %>
            <a href="add-supplier.jsp" class="btn">
                <i class="fas fa-plus-circle"></i> Add Supplier
            </a>
            <% } %>
        </div>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-list"></i> Supplier List</h3>
            </div>
            <div class="card-body">
                <% if (suppliers.isEmpty()) { %>
                <p class="text-muted">No suppliers found.</p>
                <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <% if ("admin".equals(role) || "owner".equals(role)) { %>
                            <th>Actions</th>
                            <% } %>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Supplier s : suppliers) { %>
                        <tr>
                            <td><%= s.getSupplierId() %></td>
                            <td><%= s.getSupplierName() %></td>
                            <td><%= s.getSupplierEmail() %></td>
                            <td><%= s.getSupplierPhone() %></td>
                            <% if ("admin".equals(role) || "owner".equals(role)) { %>
                            <td>
                                <div class="table-actions">
                                    <form action="edit-supplier.jsp" method="get" style="display:inline;">
                                        <input type="hidden" name="id" value="<%= s.getSupplierId() %>">
                                        <button class="action-btn view" type="submit">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                    </form>
                                    <form action="deleteSupplier" method="post" style="display:inline;"
                                          onsubmit="return confirm('Are you sure you want to delete this supplier?');">
                                        <input type="hidden" name="id" value="<%= s.getSupplierId() %>">
                                        <button class="action-btn delete" type="submit">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </button>
                                    </form>
                                </div>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
