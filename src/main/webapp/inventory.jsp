<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.InventoryDAO, com.jessica.bicycleshopapp.model.Inventory" %>
<%
  List<Inventory> inventoryList = new InventoryDAO().getAllInventory();
  String role = ((com.jessica.bicycleshopapp.model.User) session.getAttribute("user")).getRole().toLowerCase();

  // inventory stats
  int totalItems = 0;
  int lowStockItems = 0;
  int outOfStockItems = 0;

  for (Inventory item : inventoryList) {
    totalItems += item.getQuantity();
    if (item.getQuantity() <= 0) {
      outOfStockItems++;
    } else if (item.getQuantity() < 5) {
      lowStockItems++;
    }
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Inventory - Bike Shop System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
  <div class="wrapper">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h1><i class="fas fa-boxes"></i> Inventory Management</h1>
      <div>
        <% if ("admin".equals(role) || "owner".equals(role)) { %>
        <a href="order-product.jsp" class="btn">
          <i class="fas fa-truck-loading"></i> Order Products
        </a>
        <% } %>
      </div>
    </div>

    <div class="stats-container mb-4">
      <div class="stat-card">
        <i class="fas fa-cubes fa-2x mb-3 text-primary"></i>
        <div class="stat-value"><%= inventoryList.size() %></div>
        <div class="stat-label">Product Types</div>
      </div>

      <div class="stat-card">
        <i class="fas fa-warehouse fa-2x mb-3 text-primary"></i>
        <div class="stat-value"><%= totalItems %></div>
        <div class="stat-label">Total Items</div>
      </div>

      <div class="stat-card">
        <i class="fas fa-exclamation-triangle fa-2x mb-3 <%= lowStockItems > 0 ? "text-warning" : "text-primary" %>"></i>
        <div class="stat-value"><%= lowStockItems %></div>
        <div class="stat-label">Low Stock</div>
      </div>

      <div class="stat-card">
        <i class="fas fa-times-circle fa-2x mb-3 <%= outOfStockItems > 0 ? "text-danger" : "text-primary" %>"></i>
        <div class="stat-value"><%= outOfStockItems %></div>
        <div class="stat-label">Out of Stock</div>
      </div>
    </div>

    <div class="card mb-4">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h3><i class="fas fa-filter"></i> Filter Inventory</h3>
        <span class="text-muted" id="inventoryCount"><%= inventoryList.size() %> products</span>
      </div>
      <div class="card-body">
        <div class="d-flex flex-wrap gap-3">
          <div class="form-group" style="flex: 2; min-width: 200px;">
            <input type="text" id="inventorySearch" onkeyup="filterInventory()"
                   placeholder="Search products..." class="form-control">
          </div>
          <div class="form-group" style="flex: 1; min-width: 150px;">
            <select id="stockFilter" onchange="filterInventory()" class="form-control">
              <option value="all">All Items</option>
              <option value="inStock">In Stock</option>
              <option value="lowStock">Low Stock (&lt; 5)</option>
              <option value="outOfStock">Out of Stock</option>
            </select>
          </div>
          <div class="form-group" style="flex: 1; min-width: 150px;">
            <select id="sortBy" onchange="sortInventory()" class="form-control">
              <option value="name">Sort by Name</option>
              <option value="id">Sort by ID</option>
              <option value="quantityAsc">Quantity (Low to High)</option>
              <option value="quantityDesc">Quantity (High to Low)</option>
            </select>
          </div>
        </div>
      </div>
    </div>

    <div class="card">
      <div class="card-header">
        <h3><i class="fas fa-list"></i> Inventory List</h3>
      </div>
      <div class="card-body">
        <div class="table-responsive">
          <table id="inventoryTable">
            <thead>
            <tr>
              <th>ID</th>
              <th>Product Name</th>
              <th>Product ID</th>
              <th>Quantity</th>
              <th>Status</th>
              <% if ("admin".equals(role) || "owner".equals(role)) { %>
              <th>Actions</th>
              <% } %>
            </tr>
            </thead>
            <tbody>
            <% for (Inventory inv : inventoryList) { %>
            <tr data-quantity="<%= inv.getQuantity() %>" data-name="<%= inv.getProductName().toLowerCase() %>">
              <td><%= inv.getInventoryId() %></td>
              <td><%= inv.getProductName() %></td>
              <td><%= inv.getProductId() %></td>
              <td><%= inv.getQuantity() %></td>
              <td>
                <% if (inv.getQuantity() <= 0) { %>
                <span class="badge" style="background-color: var(--danger-color); color: white;">
                  <i class="fas fa-times-circle"></i> Out of Stock
                </span>
                <% } else if (inv.getQuantity() < 5) { %>
                <span class="badge" style="background-color: var(--warning-color); color: white;">
                  <i class="fas fa-exclamation-triangle"></i> Low Stock
                </span>
                <% } else { %>
                <span class="badge" style="background-color: var(--success-color); color: white;">
                  <i class="fas fa-check-circle"></i> In Stock
                </span>
                <% } %>
              </td>
              <% if ("admin".equals(role) || "owner".equals(role)) { %>
              <td>
                <div class="table-actions">
                  <a href="product-details.jsp?id=<%= inv.getProductId() %>" class="action-btn view">
                    <i class="fas fa-eye"></i> View
                  </a>
                  <a href="order-product.jsp?productId=<%= inv.getProductId() %>" class="action-btn">
                    <i class="fas fa-shopping-cart"></i> Order
                  </a>
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
  function filterInventory() {
    const searchInput = document.getElementById("inventorySearch").value.toLowerCase();
    const stockFilter = document.getElementById("stockFilter").value;
    const table = document.getElementById("inventoryTable");
    const rows = table.getElementsByTagName("tr");
    let visibleCount = 0;

    for (let i = 1; i < rows.length; i++) {
      const row = rows[i];
      let showRow = true;

      const name = row.getAttribute("data-name");
      const quantity = parseInt(row.getAttribute("data-quantity"));

      if (searchInput && (!name || !name.includes(searchInput))) showRow = false;
      if (showRow && stockFilter !== "all") {
        if (stockFilter === "inStock" && quantity <= 0) showRow = false;
        else if (stockFilter === "lowStock" && (quantity >= 5 || quantity <= 0)) showRow = false;
        else if (stockFilter === "outOfStock" && quantity > 0) showRow = false;
      }

      row.style.display = showRow ? "" : "none";
      if (showRow) visibleCount++;
    }

    document.getElementById("inventoryCount").innerText = visibleCount + " products";
  }

  function sortInventory() {
    const table = document.getElementById("inventoryTable");
    const rows = Array.from(table.rows).slice(1);
    const sortBy = document.getElementById("sortBy").value;

    rows.sort((a, b) => {
      switch (sortBy) {
        case "name":
          return a.getAttribute("data-name").localeCompare(b.getAttribute("data-name"));
        case "id":
          return parseInt(a.cells[0].innerText) - parseInt(b.cells[0].innerText);
        case "quantityAsc":
          return parseInt(a.getAttribute("data-quantity")) - parseInt(b.getAttribute("data-quantity"));
        case "quantityDesc":
          return parseInt(b.getAttribute("data-quantity")) - parseInt(a.getAttribute("data-quantity"));
        default:
          return 0;
      }
    });

    for (const row of rows) table.tBodies[0].appendChild(row);
    filterInventory();
  }
</script>
</body>
</html>
