<%@ page import="com.jessica.bicycleshopapp.model.User" %>
<%@ page import="com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect("login.jsp");
    return;
  }
  String role = user.getRole();

  int totalCustomers = 0;
  int totalProducts = 0;
  int totalSales = 0;
  double totalRevenue = 0.0;
  int pendingRepairs = 0;
  int lowStockItems = 0;

  try (Connection conn = DBUtil.getConnection()) {
    PreparedStatement psCustomers = conn.prepareStatement("SELECT COUNT(*) FROM CUSTOMER");
    ResultSet rsCustomers = psCustomers.executeQuery();
    if (rsCustomers.next()) {
      totalCustomers = rsCustomers.getInt(1);
    }

    PreparedStatement psProducts = conn.prepareStatement("SELECT COUNT(*) FROM PRODUCT WHERE Discontinued = FALSE");
    ResultSet rsProducts = psProducts.executeQuery();
    if (rsProducts.next()) {
      totalProducts = rsProducts.getInt(1);
    }

    PreparedStatement psSales = conn.prepareStatement("SELECT COUNT(*), SUM(Cost) FROM SALES");
    ResultSet rsSales = psSales.executeQuery();
    if (rsSales.next()) {
      totalSales = rsSales.getInt(1);
      totalRevenue = rsSales.getDouble(2);
    }

    PreparedStatement psRepairs = conn.prepareStatement("SELECT COUNT(*) FROM REPAIRS WHERE CompletedDate IS NULL");
    ResultSet rsRepairs = psRepairs.executeQuery();
    if (rsRepairs.next()) {
      pendingRepairs = rsRepairs.getInt(1);
    }

    // Count low stock items (less than 5 in inventory)
    PreparedStatement psLowStock = conn.prepareStatement(
            "SELECT COUNT(*) FROM INVENTORY i JOIN PRODUCT p ON i.ProductID = p.ProductID " +
                    "WHERE i.Quantity < 5 AND p.Discontinued = FALSE"
    );
    ResultSet rsLowStock = psLowStock.executeQuery();
    if (rsLowStock.next()) {
      lowStockItems = rsLowStock.getInt(1);
    }
  } catch (Exception e) {
    e.printStackTrace();
  }

  SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, MMMM d, yyyy");
  String currentDate = dateFormat.format(new java.util.Date());
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard - Bike Shop System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
  <div class="wrapper">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h1><i class="fas fa-tachometer-alt"></i> Dashboard</h1>
      <div class="text-right">
        <h4>Welcome, <span class="text-primary"><%= user.getUsername() %></span>!</h4>
        <p class="text-muted"><i class="far fa-calendar-alt"></i> <%= currentDate %></p>
      </div>
    </div>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
      <% if ("order".equals(request.getParameter("success"))) { %>
      Order placed successfully!
      <% } else if ("receive".equals(request.getParameter("success"))) { %>
      Shipment received and inventory updated successfully!
      <% } %>
    </div>
    <% } %>

    <div class="stats-container">
      <div class="stat-card">
        <i class="fas fa-users fa-2x mb-3 text-primary"></i>
        <div class="stat-value"><%= totalCustomers %></div>
        <div class="stat-label">Customers</div>
      </div>

      <div class="stat-card">
        <i class="fas fa-bicycle fa-2x mb-3 text-primary"></i>
        <div class="stat-value"><%= totalProducts %></div>
        <div class="stat-label">Active Products</div>
      </div>

      <div class="stat-card">
        <i class="fas fa-shopping-cart fa-2x mb-3 text-primary"></i>
        <div class="stat-value"><%= totalSales %></div>
        <div class="stat-label">Total Sales</div>
      </div>

      <div class="stat-card">
        <i class="fas fa-dollar-sign fa-2x mb-3 text-primary"></i>
        <div class="stat-value">$<%= String.format("%.2f", totalRevenue) %></div>
        <div class="stat-label">Total Revenue</div>
      </div>

      <div class="stat-card">
        <i class="fas fa-tools fa-2x mb-3 text-primary"></i>
        <div class="stat-value"><%= pendingRepairs %></div>
        <div class="stat-label">Pending Repairs</div>
      </div>

      <div class="stat-card">
        <i class="fas fa-exclamation-triangle fa-2x mb-3 <%= lowStockItems > 0 ? "text-warning" : "text-primary" %>"></i>
        <div class="stat-value"><%= lowStockItems %></div>
        <div class="stat-label">Low Stock Items</div>
      </div>
    </div>

    <div class="card mb-4">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h3><i class="fas fa-bolt"></i> Quick Actions</h3>
        <span class="text-muted">Common tasks</span>
      </div>
      <div class="card-body">
        <div class="quick-actions">
          <a href="add-sale.jsp" class="btn"><i class="fas fa-cart-plus"></i> Record Sale</a>
          <a href="add-return.jsp" class="btn"><i class="fas fa-undo"></i> Record Return</a>
          <a href="add-repair.jsp" class="btn"><i class="fas fa-wrench"></i> Log Repair</a>
          <a href="add-customer.jsp" class="btn"><i class="fas fa-user-plus"></i> Add Customer</a>
          <a href="add-product.jsp" class="btn"><i class="fas fa-plus-circle"></i> Add Product</a>
          <a href="inventory-report.jsp" class="btn"><i class="fas fa-clipboard-list"></i> Inventory Report</a>
          <a href="sales-report.jsp" class="btn"><i class="fas fa-chart-line"></i> Sales Report</a>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h3><i class="fas fa-history"></i> Recent Sales</h3>
          <a href="sales.jsp" class="btn btn-sm">View All</a>
        </div>
        <div class="card-body">
          <table>
            <thead>
            <tr>
              <th>Sale ID</th>
              <th>Date</th>
              <th>Customer</th>
              <th>Amount</th>
            </tr>
            </thead>
            <tbody>
            <%
              try (Connection conn = DBUtil.getConnection();
                   PreparedStatement ps = conn.prepareStatement(
                           "SELECT s.SaleID, s.SaleDate, CONCAT(c.FirstName, ' ', c.LastName) as CustomerName, s.Cost " +
                                   "FROM SALES s JOIN CUSTOMER c ON s.CustomerID = c.CustomerID " +
                                   "ORDER BY s.SaleDate DESC LIMIT 5"
                   );
                   ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
            %>
            <tr>
              <td><%= rs.getInt("SaleID") %></td>
              <td><%= rs.getDate("SaleDate") %></td>
              <td><%= rs.getString("CustomerName") %></td>
              <td>$<%= String.format("%.2f", rs.getDouble("Cost")) %></td>
            </tr>
            <%
                }
              } catch (Exception e) {
                e.printStackTrace();
              }
            %>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <% if ("admin".equalsIgnoreCase(role) || "owner".equalsIgnoreCase(role)) { %>
    <div class="row">
      <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h3><i class="fas fa-exclamation-triangle"></i> Low Stock Alerts</h3>
          <a href="inventory.jsp" class="btn btn-sm">View Inventory</a>
        </div>
        <div class="card-body">
          <table>
            <thead>
            <tr>
              <th>Product</th>
              <th>Current Stock</th>
              <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
              try (Connection conn = DBUtil.getConnection();
                   PreparedStatement ps = conn.prepareStatement(
                           "SELECT p.ProductID, p.Name, i.Quantity FROM INVENTORY i " +
                                   "JOIN PRODUCT p ON i.ProductID = p.ProductID " +
                                   "WHERE i.Quantity < 5 AND p.Discontinued = FALSE " +
                                   "ORDER BY i.Quantity ASC LIMIT 5"
                   );
                   ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
            %>
            <tr>
              <td><%= rs.getString("Name") %></td>
              <td><span class="text-<%= rs.getInt("Quantity") <= 0 ? "danger" : "warning" %>">
                  <%= rs.getInt("Quantity") %>
                </span></td>
              <td>
                <form method="get" action="order-product.jsp">
                  <input type="hidden" name="productId" value="<%= rs.getInt("ProductID") %>">
                  <button type="submit" class="btn btn-sm">Order More</button>
                </form>
              </td>
            </tr>
            <%
              }
              if (!rs.next() && lowStockItems == 0) {
            %>
            <tr>
              <td colspan="3" class="text-center">All products are well-stocked!</td>
            </tr>
            <%
                }
              } catch (Exception e) {
                e.printStackTrace();
              }
            %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <% } %>
  </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>