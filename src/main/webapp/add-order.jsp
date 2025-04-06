<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Product Order - Bike Shop System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-shopping-cart"></i> Place Product Order</h1>
            <a href="inventory.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Inventory
            </a>
        </div>

        <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> Order placed successfully!
        </div>
        <% } else if ("1".equals(request.getParameter("error"))) { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> Error placing order. Please try again.
        </div>
        <% } %>

        <%
            List<Map<String, Object>> products = new ArrayList<>();
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement ps = conn.prepareStatement(
                         "SELECT p.ProductID, p.Name, s.SupplierName, p.Price FROM PRODUCT p " +
                                 "JOIN SUPPLIER s ON p.SupplierID = s.SupplierID " +
                                 "WHERE p.Discontinued = FALSE"
                 );
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("id", rs.getInt("ProductID"));
                    row.put("name", rs.getString("Name"));
                    row.put("supplier", rs.getString("SupplierName"));
                    row.put("price", rs.getDouble("Price"));
                    products.add(row);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-clipboard-list"></i> Order Details</h3>
            </div>
            <div class="card-body">
                <form method="post" action="addOrder" id="orderForm">
                    <div class="form-group">
                        <label for="productId"><i class="fas fa-bicycle"></i> Product:</label>
                        <select id="productId" name="productId" class="form-control" required>
                            <option value="">-- Select Product --</option>
                            <% for (Map<String, Object> p : products) { %>
                            <option value="<%= p.get("id") %>" data-price="<%= p.get("price") %>">
                                <%= p.get("name") %> (Supplier: <%= p.get("supplier") %>) - $<%= String.format("%.2f", p.get("price")) %>
                            </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="d-flex gap-3 flex-wrap">
                        <div class="form-group" style="flex: 1; min-width: 200px;">
                            <label for="quantity"><i class="fas fa-hashtag"></i> Quantity:</label>
                            <input type="number" id="quantity" name="quantity" min="1" value="1" class="form-control" required>
                        </div>

                        <div class="form-group" style="flex: 1; min-width: 200px;">
                            <label><i class="fas fa-dollar-sign"></i> Estimated Cost:</label>
                            <div class="form-control" id="estimatedCost" style="background-color: #f8f9fa;">$0.00</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="delivery"><i class="fas fa-calendar-alt"></i> Expected Delivery Date:</label>
                        <input type="date" id="delivery" name="delivery" class="form-control" required>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-check"></i> Place Order
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date();
        const deliveryDate = new Date(today);
        deliveryDate.setDate(today.getDate() + 7);

        const deliveryInput = document.getElementById('delivery');
        deliveryInput.min = today.toISOString().split('T')[0];
        deliveryInput.value = deliveryDate.toISOString().split('T')[0];

        const productSelect = document.getElementById('productId');
        const quantityInput = document.getElementById('quantity');
        const estimatedCost = document.getElementById('estimatedCost');

        function updateCost() {
            const selectedOption = productSelect.options[productSelect.selectedIndex];
            if (selectedOption && selectedOption.value) {
                const price = parseFloat(selectedOption.getAttribute('data-price'));
                const quantity = parseInt(quantityInput.value);
                const cost = price * quantity;
                estimatedCost.textContent = '$' + cost.toFixed(2);
            } else {
                estimatedCost.textContent = '$0.00';
            }
        }

        productSelect.addEventListener('change', updateCost);
        quantityInput.addEventListener('input', updateCost);
    });
</script>
</body>
</html>