<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add Supplier - Bike Shop System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="container">
  <div class="wrapper">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h1><i class="fas fa-truck"></i> Add New Supplier</h1>
      <a href="suppliers.jsp" class="btn">
        <i class="fas fa-arrow-left"></i> Back to Suppliers
      </a>
    </div>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger">
      <i class="fas fa-exclamation-circle"></i> Error adding supplier. Please try again.
    </div>
    <% } %>

    <div class="card">
      <div class="card-header">
        <h3><i class="fas fa-industry"></i> Supplier Information</h3>
      </div>
      <div class="card-body">
        <form method="post" action="addSupplier" id="supplierForm">
          <div class="form-group">
            <label for="supplierName">Name <span class="text-danger">*</span></label>
            <div class="d-flex align-items-center">
              <i class="fas fa-user text-muted mr-2"></i>
              <input type="text" id="supplierName" name="supplierName" required placeholder="Supplier Name">
            </div>
          </div>

          <div class="form-group">
            <label for="supplierEmail">Email</label>
            <div class="d-flex align-items-center">
              <i class="fas fa-envelope text-muted mr-2"></i>
              <input type="email" id="supplierEmail" name="supplierEmail" placeholder="supplier@example.com">
            </div>
          </div>

          <div class="form-group">
            <label for="supplierPhone">Phone</label>
            <div class="d-flex align-items-center">
              <i class="fas fa-phone text-muted mr-2"></i>
              <input type="text" id="supplierPhone" name="supplierPhone" placeholder="1234567890">
            </div>
          </div>

          <div class="d-flex justify-content-end gap-2 mt-4">
            <button type="reset" class="btn btn-warning">
              <i class="fas fa-undo"></i> Reset
            </button>
            <button type="submit" class="btn btn-success">
              <i class="fas fa-save"></i> Add Supplier
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.mr-2').forEach(el => {
      el.style.marginRight = '10px';
    });
  });
</script>

</body>
</html>
