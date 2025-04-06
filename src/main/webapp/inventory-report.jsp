<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%
    List<Map<String, Object>> inventory = new ArrayList<>();

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(
                 "SELECT p.Name, i.Quantity, p.Price, (p.Price * i.Quantity) AS TotalValue " +
                         "FROM INVENTORY i " +
                         "JOIN PRODUCT p ON i.ProductID = p.ProductID"
         );
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("name", rs.getString("Name"));
            row.put("qty", rs.getInt("Quantity"));
            row.put("price", rs.getDouble("Price"));
            row.put("value", rs.getDouble("TotalValue"));
            inventory.add(row);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inventory Report - Bike Shop System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-warehouse"></i> Inventory Report</h1>
            <a href="dashboard.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <!-- Filter -->
        <form method="get" class="mb-4 d-flex align-items-end gap-3">
            <div class="form-group">
                <label for="search">Filter by Product Name:</label>
                <input type="text" id="search" name="search" class="form-control"
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
                       placeholder="e.g., Helmet, Bike">
            </div>
            <button type="submit" class="btn">
                <i class="fas fa-search"></i> Filter
            </button>
        </form>

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3><i class="fas fa-list-alt"></i> Inventory Summary</h3>
                <span class="text-muted"><%= inventory.size() %> items listed</span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Total Value</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            String filter = request.getParameter("search");
                            double grandTotal = 0.0;
                            int visibleCount = 0;

                            for (Map<String, Object> row : inventory) {
                                String name = (String) row.get("name");
                                if (filter == null || name.toLowerCase().contains(filter.toLowerCase())) {
                                    visibleCount++;
                                    grandTotal += (double) row.get("value");
                        %>
                        <tr>
                            <td><%= name %></td>
                            <td><%= row.get("qty") %></td>
                            <td>$<%= String.format("%.2f", row.get("price")) %></td>
                            <td>$<%= String.format("%.2f", row.get("value")) %></td>
                        </tr>
                        <%      }
                        }
                        %>
                        <tr class="text-primary font-weight-bold">
                            <td colspan="3" style="text-align: right;">Total Inventory Value:</td>
                            <td><strong>$<%= String.format("%.2f", grandTotal) %></strong></td>
                        </tr>
                        </tbody>
                    </table>
                    <p class="text-muted mt-2"><%= visibleCount %> result<%= visibleCount == 1 ? "" : "s" %> shown.</p>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>

</html>
