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

<html>
<%@ include file="navbar.jsp" %>
<head><title>Repairs</title></head>
<body>
<div class="wrapper">
    <h2>Repair History</h2>
    <a href="add-repair.jsp">+ Log New Repair</a>
    <table border="1">
        <tr>
            <th>ID</th><th>Date</th><th>Customer</th><th>Product</th><th>Cost</th><th>Description</th>
        </tr>
        <% for (Map<String, Object> r : repairs) { %>
        <tr>
            <td><%= r.get("id") %></td>
            <td><%= r.get("date") %></td>
            <td><%= r.get("customer") %></td>
            <td><%= r.get("product") %></td>
            <td>$<%= r.get("cost") %></td>
            <td><%= r.get("desc") %></td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
