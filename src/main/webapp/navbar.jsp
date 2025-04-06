<%@ page import="com.jessica.bicycleshopapp.model.User" %>
<%
  // get user and role from session
  String navbarRole = "";
  String username = "";
  if (session.getAttribute("user") instanceof User) {
    User currentUser = (User) session.getAttribute("user");
    navbarRole = currentUser.getRole();
    username = currentUser.getUsername();
  }
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<div class="navbar">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center w-100">
      <a href="dashboard.jsp" class="navbar-brand">
        <i class="fas fa-bicycle mr-2"></i> Bike Shop System
      </a>

      <div class="user-info d-flex align-items-center">
        <i class="fas fa-user-circle mr-2"></i>
        <span><strong><%= username %></strong> (<%= navbarRole %>)</span>
      </div>
    </div>

    <div class="navbar-menu">
      <div class="navbar-section">
        <a href="dashboard.jsp"><i class="fas fa-tachometer-alt mr-1"></i> Dashboard</a>
        <a href="customers.jsp"><i class="fas fa-users mr-1"></i> Customers</a>
        <a href="products.jsp"><i class="fas fa-bicycle mr-1"></i> Products</a>
        <a href="inventory.jsp"><i class="fas fa-boxes mr-1"></i> Inventory</a>
      </div>

      <div class="navbar-section">
        <a href="sales.jsp"><i class="fas fa-shopping-cart mr-1"></i> Sales</a>
        <a href="returns.jsp"><i class="fas fa-undo mr-1"></i> Returns</a>
        <a href="repairs.jsp"><i class="fas fa-tools mr-1"></i> Repairs</a>
        <a href="suppliers.jsp"><i class="fas fa-truck mr-1"></i> Suppliers</a>
      </div>

      <div class="navbar-section">
        <a href="sales-report.jsp"><i class="fas fa-chart-line mr-1"></i> Sales Report</a>
        <a href="inventory-report.jsp"><i class="fas fa-clipboard-list mr-1"></i> Inventory Report</a>
        <a href="repair-report.jsp"><i class="fas fa-wrench mr-1"></i> Repair Report</a>
      </div>

      <% if ("admin".equalsIgnoreCase(navbarRole) || "owner".equalsIgnoreCase(navbarRole)) { %>
      <div class="navbar-section">
        <a href="order-product.jsp"><i class="fas fa-truck-loading mr-1"></i> Order Inventory</a>
        <a href="receive-orders.jsp"><i class="fas fa-clipboard-check mr-1"></i> Receive Orders</a>
      </div>
      <% } %>

      <% if ("admin".equalsIgnoreCase(navbarRole)) { %>
      <div class="navbar-section">
        <a href="user-report.jsp"><i class="fas fa-user-cog mr-1"></i> User Report</a>
        <a href="add-user.jsp"><i class="fas fa-user-plus mr-1"></i> Add User</a>
      </div>
      <% } %>

      <div class="navbar-section">
        <a href="logout.jsp"><i class="fas fa-sign-out-alt mr-1"></i> Logout</a>
      </div>
    </div>
  </div>
</div>
<div class="nav-divider"></div>

<style>
  .mr-1 { margin-right: 5px; }
  .mr-2 { margin-right: 10px; }
</style>