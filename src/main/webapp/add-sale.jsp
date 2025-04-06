<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Record New Sale - Bike Shop System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-cash-register"></i> Record New Sale</h1>
            <a href="sales.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Sales
            </a>
        </div>

        <% if ("insufficient".equals(request.getParameter("error"))) { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> Not enough inventory to complete the sale.
        </div>
        <% } %>

        <%
            List<Map<String, Object>> products = new ArrayList<>();
            List<Map<String, Object>> customers = new ArrayList<>();

            try (Connection conn = DBUtil.getConnection()) {
                PreparedStatement psProd = conn.prepareStatement(
                        "SELECT p.ProductID, p.Name, i.Quantity FROM PRODUCT p " +
                                "JOIN INVENTORY i ON p.ProductID = i.ProductID " +
                                "WHERE p.Discontinued = FALSE"
                );
                ResultSet rsProd = psProd.executeQuery();
                while (rsProd.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("id", rsProd.getInt("ProductID"));
                    row.put("name", rsProd.getString("Name"));
                    row.put("qty", rsProd.getInt("Quantity"));
                    products.add(row);
                }

                PreparedStatement psCust = conn.prepareStatement(
                        "SELECT CustomerID, FirstName, LastName FROM CUSTOMER"
                );
                ResultSet rsCust = psCust.executeQuery();
                while (rsCust.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("id", rsCust.getInt("CustomerID"));
                    row.put("name", rsCust.getString("FirstName") + " " + rsCust.getString("LastName"));
                    customers.add(row);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-cart-plus"></i> Sale Details</h3>
            </div>
            <div class="card-body">
                <form id="saleForm" method="post" action="addSale">
                    <div class="d-flex gap-3 flex-wrap">
                        <div class="form-group" style="flex: 1; min-width: 250px;">
                            <label for="customerId">Customer <span class="text-danger">*</span></label>
                            <select name="customerId" id="customerId" required>
                                <option value="">-- Select Customer --</option>
                                <% for (Map<String, Object> c : customers) { %>
                                <option value="<%= c.get("id") %>"><%= c.get("name") %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="form-group" style="flex: 1; min-width: 250px;">
                            <label for="productId">Product <span class="text-danger">*</span></label>
                            <select name="productId" id="productId" required>
                                <option value="">-- Select Product --</option>
                                <% for (Map<String, Object> p : products) { %>
                                <option value="<%= p.get("id") %>">
                                    <%= p.get("name") %> (In Stock: <%= p.get("qty") %>)
                                </option>
                                <% } %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="quantity">Quantity <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-sort-numeric-up text-muted mr-2"></i>
                            <input type="number" name="quantity" id="quantity" min="1" required placeholder="Enter quantity">
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-check"></i> Submit Sale
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
        const selects = document.querySelectorAll('select');
        selects.forEach(select => {
            select.addEventListener('change', function () {
                this.style.color = this.value ? 'var(--text-color)' : 'var(--light-text)';
            });

            select.style.color = select.value ? 'var(--text-color)' : 'var(--light-text)';
        });

        document.querySelectorAll('.mr-2').forEach(el => {
            el.style.marginRight = '10px';
        });
    });
</script>
</body>
</html>
