<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%
    List<Map<String, Object>> repairs = new ArrayList<>();

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(
                 "SELECT r.RepairID, r.RepairDate, r.Cost, r.Description, c.FirstName, c.LastName, p.Name AS ProductName " +
                         "FROM REPAIRS r " +
                         "JOIN CUSTOMER c ON r.CustomerID = c.CustomerID " +
                         "JOIN PRODUCT p ON r.ProductID = p.ProductID " +
                         "ORDER BY r.RepairDate DESC"
         );
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("id", rs.getInt("RepairID"));
            row.put("date", rs.getDate("RepairDate"));
            row.put("cost", rs.getDouble("Cost"));
            row.put("desc", rs.getString("Description"));
            row.put("product", rs.getString("ProductName"));
            row.put("customer", rs.getString("FirstName") + " " + rs.getString("LastName"));
            repairs.add(row);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Repairs - Bike Shop System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-tools"></i> Repair History</h1>
            <a href="add-repair.jsp" class="btn">
                <i class="fas fa-plus-circle"></i> Log New Repair
            </a>
        </div>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-list"></i> Repair Records</h3>
            </div>
            <div class="card-body">
                <% if (repairs.isEmpty()) { %>
                <p class="text-muted">No repairs have been logged yet.</p>
                <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Date</th>
                            <th>Customer</th>
                            <th>Product</th>
                            <th>Cost</th>
                            <th>Description</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Map<String, Object> r : repairs) { %>
                        <tr>
                            <td><%= r.get("id") %></td>
                            <td><%= r.get("date") %></td>
                            <td><%= r.get("customer") %></td>
                            <td><%= r.get("product") %></td>
                            <td>$<%= String.format("%.2f", r.get("cost")) %></td>
                            <td><%= r.get("desc") %></td>
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
