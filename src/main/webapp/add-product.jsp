<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.SupplierDAO, com.jessica.bicycleshopapp.model.Supplier" %>
<%
  List<Supplier> suppliers = new SupplierDAO().getAllSuppliers();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Product - Bike Shop System</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
  <div class="wrapper">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h1><i class="fas fa-plus-circle"></i> Add New Product</h1>
      <a href="products.jsp" class="btn">
        <i class="fas fa-arrow-left"></i> Back to Products
      </a>
    </div>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger">
      <i class="fas fa-exclamation-circle"></i> Error adding product. Please check your inputs and try again.
    </div>
    <% } %>

    <div class="card">
      <div class="card-header">
        <h3><i class="fas fa-bicycle"></i> Product Information</h3>
      </div>
      <div class="card-body">
        <form method="post" action="addProduct" id="productForm">
          <div class="d-flex gap-3 flex-wrap">
            <div class="form-group" style="flex: 2; min-width: 300px;">
              <label for="name">Product Name <span class="text-danger">*</span></label>
              <input type="text" id="name" name="name" required placeholder="Enter product name">
            </div>

            <div class="form-group" style="flex: 1; min-width: 150px;">
              <label for="price">Price ($) <span class="text-danger">*</span></label>
              <input type="number" id="price" name="price" step="0.01" min="0" required placeholder="0.00">
            </div>
          </div>

          <div class="d-flex gap-3 flex-wrap">
            <div class="form-group" style="flex: 1; min-width: 200px;">
              <label for="category">Category</label>
              <select id="category" name="category">
                <option value="">-- Select Category --</option>
                <option value="Bicycle">Bicycle</option>
                <option value="Accessories">Accessories</option>
                <option value="Parts">Parts</option>
                <option value="Clothing">Clothing</option>
                <option value="Tools">Tools</option>
                <option value="Other">Other</option>
              </select>
            </div>

            <div class="form-group" style="flex: 1; min-width: 200px;">
              <label for="supplierId">Supplier <span class="text-danger">*</span></label>
              <select id="supplierId" name="supplierId" required>
                <option value="">-- Select Supplier --</option>
                <% for (Supplier s : suppliers) { %>
                <option value="<%= s.getSupplierId() %>"><%= s.getSupplierName() %></option>
                <% } %>
              </select>
            </div>

            <div class="form-group" style="flex: 1; min-width: 150px;">
              <label for="quantity">Initial Stock</label>
              <input type="number" id="quantity" name="quantity" value="0" min="0" placeholder="0">
            </div>
          </div>

          <div class="form-group">
            <label for="description">Product Description</label>
            <textarea id="description" name="description" rows="4" placeholder="Enter product description"></textarea>
          </div>

          <div class="d-flex justify-content-end gap-2 mt-4">
            <button type="reset" class="btn btn-warning">
              <i class="fas fa-undo"></i> Reset
            </button>
            <button type="submit" class="btn btn-success">
              <i class="fas fa-save"></i> Add Product
            </button>
          </div>
        </form>
      </div>
    </div>

    <% if (suppliers.isEmpty()) { %>
    <div class="alert alert-warning mt-3">
      <i class="fas fa-exclamation-triangle"></i>
      No suppliers found. <a href="add-supplier.jsp">Add a supplier</a> before adding products.
    </div>
    <% } %>
  </div>
</div>

<%@ include file="footer.jsp" %>

<script>
  document.getElementById('productForm').addEventListener('submit', function(e) {
    const name = document.getElementById('name').value.trim();
    const price = document.getElementById('price').value.trim();
    const supplierId = document.getElementById('supplierId').value;

    if (!name) {
      e.preventDefault();
      alert('Product name is required!');
      return false;
    }

    if (!price || isNaN(parseFloat(price)) || parseFloat(price) < 0) {
      e.preventDefault();
      alert('Please enter a valid price!');
      return false;
    }

    if (!supplierId) {
      e.preventDefault();
      alert('Please select a supplier!');
      return false;
    }

    return true;
  });

  document.addEventListener('DOMContentLoaded', function() {
    const selects = document.querySelectorAll('select');
    for (const select of selects) {
      select.addEventListener('change', function() {
        if (this.value) {
          this.style.color = 'var(--text-color)';
        } else {
          this.style.color = 'var(--light-text)';
        }
      });

      if (select.value) {
        select.style.color = 'var(--text-color)';
      } else {
        select.style.color = 'var(--light-text)';
      }
    }
  });
</script>
</body>
</html>