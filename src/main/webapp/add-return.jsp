<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Record Return - Bike Shop System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-undo-alt"></i> Record Product Return</h1>
            <a href="returns.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Returns
            </a>
        </div>

        <% if ("1".equals(request.getParameter("error"))) { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> Error processing return. Please check the inputs.
        </div>
        <% } %>

        <%
            List<Map<String, Object>> saleItems = new ArrayList<>();
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement ps = conn.prepareStatement(
                         "SELECT sd.SaleID, sd.ProductID, p.Name, sd.Quantity " +
                                 "FROM SALEDETAILS sd " +
                                 "JOIN PRODUCT p ON sd.ProductID = p.ProductID " +
                                 "ORDER BY sd.SaleID DESC");
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("saleId", rs.getInt("SaleID"));
                    row.put("productId", rs.getInt("ProductID"));
                    row.put("name", rs.getString("Name"));
                    row.put("quantity", rs.getInt("Quantity"));
                    saleItems.add(row);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-box-open"></i> Return Information</h3>
            </div>
            <div class="card-body">
                <form id="returnForm" method="post" action="addReturn">
                    <div class="form-group">
                        <label for="saleProduct">Sale + Product <span class="text-danger">*</span></label>
                        <select name="saleProduct" id="saleProduct" required>
                            <option value="">-- Select Sale and Product --</option>
                            <% for (Map<String, Object> item : saleItems) { %>
                            <option value="<%= item.get("saleId") %>_<%= item.get("productId") %>">
                                Sale #<%= item.get("saleId") %> - <%= item.get("name") %> (Qty: <%= item.get("quantity") %>)
                            </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="quantity">Quantity to Return <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-sort-numeric-up-alt text-muted mr-2"></i>
                            <input type="number" name="quantity" id="quantity" min="1" required placeholder="Enter quantity">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="reason">Reason for Return</label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-comment-alt text-muted mr-2" style="align-self: flex-start; margin-top: 12px;"></i>
                            <textarea name="reason" id="reason" rows="3" placeholder="Enter reason for return"></textarea>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Submit Return
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    document.getElementById("returnForm").addEventListener("submit", function (e) {
        const select = document.getElementById("saleProduct");
        if (!select.value) {
            e.preventDefault();
            alert("Please select a sale and product.");
            return;
        }

        const quantity = document.getElementById("quantity").value;
        if (!quantity || isNaN(quantity) || parseInt(quantity) < 1) {
            e.preventDefault();
            alert("Please enter a valid quantity.");
            return;
        }

        const [saleId, productId] = select.value.split("_");
        const saleInput = document.createElement("input");
        saleInput.type = "hidden";
        saleInput.name = "saleId";
        saleInput.value = saleId;

        const productInput = document.createElement("input");
        productInput.type = "hidden";
        productInput.name = "productId";
        productInput.value = productId;

        this.appendChild(saleInput);
        this.appendChild(productInput);
    });

    document.addEventListener('DOMContentLoaded', function () {
        const selects = document.querySelectorAll('select');
        for (const select of selects) {
            select.addEventListener('change', function () {
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
