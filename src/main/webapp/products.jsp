<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.ProductDAO, com.jessica.bicycleshopapp.model.Product" %>
<%
    List<Product> products = new ProductDAO().getAllProducts();
    String role = ((com.jessica.bicycleshopapp.model.User) session.getAttribute("user")).getRole().toLowerCase();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - Bike Shop System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-bicycle"></i> Product Management</h1>
            <% if ("admin".equals(role) || "owner".equals(role)) { %>
            <a href="add-product.jsp" class="btn">
                <i class="fas fa-plus-circle"></i> Add New Product
            </a>
            <% } %>
        </div>

        <% if ("success".equals(request.getParameter("status"))) { %>
        <div class="alert alert-success">
            Product added successfully!
        </div>
        <% } else if ("discontinued".equals(request.getParameter("status"))) { %>
        <div class="alert alert-warning">
            Product has been discontinued.
        </div>
        <% } %>

        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3><i class="fas fa-filter"></i> Filter Products</h3>
                <span class="text-muted" id="productCount"><%= products.size() %> products</span>
            </div>
            <div class="card-body">
                <div class="d-flex flex-wrap gap-3">
                    <div class="form-group" style="flex: 2; min-width: 200px;">
                        <input type="text" id="productSearch" onkeyup="filterProducts()"
                               placeholder="Search products..." class="form-control">
                    </div>
                    <div class="form-group" style="flex: 1; min-width: 150px;">
                        <select id="categoryFilter" onchange="filterProducts()" class="form-control">
                            <option value="">All Categories</option>
                            <%
                                Set<String> categories = new HashSet<>();
                                for (Product p : products) {
                                    if (p.getCategory() != null && !p.getCategory().isEmpty()) {
                                        categories.add(p.getCategory());
                                    }
                                }
                                for (String category : categories) {
                            %>
                            <option value="<%= category %>"><%= category %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group" style="flex: 1; min-width: 150px;">
                        <select id="statusFilter" onchange="filterProducts()" class="form-control">
                            <option value="">All Statuses</option>
                            <option value="active">Active Only</option>
                            <option value="discontinued">Discontinued Only</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-list"></i> Product List</h3>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="productsTable">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Category</th>
                            <th>Supplier ID</th>
                            <th>Status</th>
                            <% if ("admin".equals(role) || "owner".equals(role)) { %>
                            <th>Actions</th>
                            <% } %>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Product p : products) { %>
                        <tr data-category="<%= p.getCategory() %>" data-status="<%= p.isDiscontinued() ? "discontinued" : "active" %>">
                            <td><%= p.getProductId() %></td>
                            <td><%= p.getName() %></td>
                            <td><span class="text-primary">$<%= String.format("%.2f", p.getPrice()) %></span></td>
                            <td><span class="badge" style="background-color: var(--primary-color); color: white; padding: 5px 8px; border-radius: 4px;"><%= p.getCategory() %></span></td>
                            <td><%= p.getSupplierId() %></td>
                            <td>
                                <% if (p.isDiscontinued()) { %>
                                <span class="badge" style="background-color: var(--danger-color); color: white; padding: 5px 8px; border-radius: 4px;">Discontinued</span>
                                <% } else { %>
                                <span class="badge" style="background-color: var(--success-color); color: white; padding: 5px 8px; border-radius: 4px;">Active</span>
                                <% } %>
                            </td>
                            <% if ("admin".equals(role) || "owner".equals(role)) { %>
                            <td>
                                <div class="table-actions">
                                    <a href="product-details.jsp?id=<%= p.getProductId() %>" class="action-btn view">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <% if (!p.isDiscontinued()) { %>
                                    <form method="post" action="discontinueProduct" style="display:inline;" onsubmit="return confirm('Are you sure you want to discontinue this product?');">
                                        <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                        <button type="submit" class="action-btn delete">
                                            <i class="fas fa-ban"></i> Discontinue
                                        </button>
                                    </form>
                                    <% } %>
                                </div>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    function filterProducts() {
        var searchInput = document.getElementById("productSearch").value.toLowerCase();
        var categoryFilter = document.getElementById("categoryFilter").value;
        var statusFilter = document.getElementById("statusFilter").value;

        var table = document.getElementById("productsTable");
        var rows = table.getElementsByTagName("tr");

        var visibleCount = 0;

        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var showRow = true;

            var cells = row.getElementsByTagName("td");
            var found = false;

            for (var j = 0; j < cells.length; j++) {
                var cell = cells[j];
                if (cell) {
                    var text = cell.textContent || cell.innerText;
                    if (text.toLowerCase().indexOf(searchInput) > -1) {
                        found = true;
                        break;
                    }
                }
            }

            if (!found) {
                showRow = false;
            }

            if (showRow && categoryFilter !== "") {
                if (row.getAttribute("data-category") !== categoryFilter) {
                    showRow = false;
                }
            }
            if (showRow && statusFilter !== "") {
                if (row.getAttribute("data-status") !== statusFilter) {
                    showRow = false;
                }
            }
            row.style.display = showRow ? "" : "none";

            if (showRow) visibleCount++;
        }
        document.getElementById("productCount").innerText = visibleCount + " products";
    }
</script>
</body>
</html>