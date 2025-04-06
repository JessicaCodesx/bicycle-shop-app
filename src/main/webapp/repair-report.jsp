<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%
    List<Map<String, Object>> repairs = new ArrayList<>();

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(
                 "SELECT r.RepairDate, c.FirstName, c.LastName, p.Name, r.Cost, r.Description " +
                         "FROM REPAIRS r " +
                         "JOIN CUSTOMER c ON r.CustomerID = c.CustomerID " +
                         "JOIN PRODUCT p ON r.ProductID = p.ProductID " +
                         "ORDER BY r.RepairDate DESC"
         );
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("date", rs.getDate("RepairDate"));
            row.put("customer", rs.getString("FirstName") + " " + rs.getString("LastName"));
            row.put("product", rs.getString("Name"));
            row.put("cost", rs.getDouble("Cost"));
            row.put("desc", rs.getString("Description"));
            repairs.add(row);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<html>
<%@ include file="navbar.jsp" %>
<head><title>Repair Report</title></head>
<body>
<div class="wrapper">
    <h2>Repair Report</h2>
    <table border="1">
        <tr><th>Date</th><th>Customer</th><th>Product</th><th>Cost</th><th>Description</th></tr>
        <% for (Map<String, Object> r : repairs) { %>
        <tr>
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
