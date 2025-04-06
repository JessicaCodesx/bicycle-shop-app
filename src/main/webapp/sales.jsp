<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%
    List<Map<String, Object>> sales = new ArrayList<>();
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(
                 "SELECT s.SaleID, s.SaleDate, c.FirstName, c.LastName, s.Cost " +
                         "FROM SALES s JOIN CUSTOMER c ON s.CustomerID = c.CustomerID " +
                         "ORDER BY s.SaleDate DESC"
         );
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("saleId", rs.getInt("SaleID"));
            row.put("date", rs.getDate("SaleDate"));
            row.put("customer", rs.getString("FirstName") + " " + rs.getString("LastName"));
            row.put("cost", rs.getDouble("Cost"));
            sales.add(row);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sales History - Bike Shop System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-shopping-cart"></i> Sales History</h1>
            <a href="add-sale.jsp" class="btn">
                <i class="fas fa-plus-circle"></i> Record New Sale
            </a>
        </div>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-list"></i> Recent Sales</h3>
            </div>
            <div class="card-body">
                <% if (sales.isEmpty()) { %>
                <p class="text-muted">No sales recorded yet.</p>
                <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Sale ID</th>
                            <th>Date</th>
                            <th>Customer</th>
                            <th>Total ($)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Map<String, Object> s : sales) { %>
                        <tr>
                            <td><%= s.get("saleId") %></td>
                            <td><%= s.get("date") %></td>
                            <td><%= s.get("customer") %></td>
                            <td>$<%= String.format("%.2f", s.get("cost")) %></td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
