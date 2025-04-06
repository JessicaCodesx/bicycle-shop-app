<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jessica.bicycleshopapp.dao.SupplierDAO, com.jessica.bicycleshopapp.model.Supplier" %>
<%
  int id = Integer.parseInt(request.getParameter("id"));
  Supplier s = new SupplierDAO().getSupplierById(id);
%>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Supplier - Bike Shop System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="container">
  <div class="wrapper">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h1><i class="fas fa-edit"></i> Edit Supplier</h1>
      <a href="suppliers.jsp" class="btn">
        <i class="fas fa-arrow-left"></i> Back to Suppliers
      </a>
    </div>

    <div class="card">
      <div class="card-header">
        <h3><i class="fas fa-industry"></i> Supplier Details</h3>
      </div>
      <div class="card-body">
        <form method="post" action="editSupplier" id="editSupplierForm">
          <input type="hidden" name="id" value="<%= s.getSupplierId() %>">

          <div class="form-group">
            <label for="name">Name <span class="text-danger">*</span></label>
            <div class="d-flex align-items-center">
              <i class="fas fa-user text-muted mr-2"></i>
              <input type="text" name="name" id="name" value="<%= s.getSupplierName() %>" required placeholder="Supplier Name">
            </div>
          </div>

          <div class="form-group">
            <label for="email">Email</label>
            <div class="d-flex align-items-center">
              <i class="fas fa-envelope text-muted mr-2"></i>
              <input type="email" name="email" id="email" value="<%= s.getSupplierEmail() %>" placeholder="supplier@example.com">
            </div>
          </div>

          <div class="form-group">
            <label for="phone">Phone</label>
            <div class="d-flex align-items-center">
              <i class="fas fa-phone text-muted mr-2"></i>
              <input type="text" name="phone" id="phone" value="<%= s.getSupplierPhone() %>" placeholder="1234567890">
            </div>
          </div>

          <div class="d-flex justify-content-end gap-2 mt-4">
            <button type="reset" class="btn btn-warning">
              <i class="fas fa-undo"></i> Reset
            </button>
            <button type="submit" class="btn btn-success">
              <i class="fas fa-save"></i> Update Supplier
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
