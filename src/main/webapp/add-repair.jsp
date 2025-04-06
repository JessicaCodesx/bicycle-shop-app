<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.CustomerDAO, com.jessica.bicycleshopapp.dao.ProductDAO, com.jessica.bicycleshopapp.model.Customer, com.jessica.bicycleshopapp.model.Product" %>
<%
    List<Customer> customers = new CustomerDAO().getAllCustomers();
    List<Product> products = new ProductDAO().getAllProducts();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log Repair - Bike Shop System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-wrench"></i> Log New Repair</h1>
            <a href="repairs.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Repairs
            </a>
        </div>

        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> Error logging repair. Please check your inputs and try again.
        </div>
        <% } %>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-tools"></i> Repair Information</h3>
            </div>
            <div class="card-body">
                <form method="post" action="addRepair" id="repairForm">
                    <div class="d-flex gap-3 flex-wrap">
                        <div class="form-group" style="flex: 1; min-width: 250px;">
                            <label for="customerId">Customer <span class="text-danger">*</span></label>
                            <select id="customerId" name="customerId" required>
                                <option value="">-- Select Customer --</option>
                                <% for (Customer c : customers) { %>
                                <option value="<%= c.getCustomerId() %>"><%= c.getFirstName() %> <%= c.getLastName() %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="form-group" style="flex: 1; min-width: 250px;">
                            <label for="productId">Product <span class="text-danger">*</span></label>
                            <select id="productId" name="productId" required>
                                <option value="">-- Select Product --</option>
                                <% for (Product p : products) { %>
                                <option value="<%= p.getProductId() %>"><%= p.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="cost">Repair Cost ($) <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-dollar-sign text-muted mr-2"></i>
                            <input type="number" id="cost" name="cost" step="0.01" min="0" required placeholder="0.00">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description">Repair Description</label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-clipboard-list text-muted mr-2" style="align-self: flex-start; margin-top: 12px;"></i>
                            <textarea id="description" name="description" rows="4" placeholder="Enter repair details, issues, and notes"></textarea>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Log Repair
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    document.getElementById('repairForm').addEventListener('submit', function(e) {
        const customerId = document.getElementById('customerId').value.trim();
        const productId = document.getElementById('productId').value.trim();
        const cost = document.getElementById('cost').value.trim();

        if (!customerId) {
            e.preventDefault();
            alert('Please select a customer!');
            return false;
        }

        if (!productId) {
            e.preventDefault();
            alert('Please select a product!');
            return false;
        }

        if (!cost || isNaN(parseFloat(cost)) || parseFloat(cost) < 0) {
            e.preventDefault();
            alert('Please enter a valid repair cost!');
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

    document.querySelectorAll('.mr-2').forEach(el => {
        el.style.marginRight = '10px';
    });
</script>
</body>
</html>