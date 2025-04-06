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

<html>
<%@ include file="navbar.jsp" %>
<head><title>Inventory Report</title></head>
<body>
<div class="wrapper">
    <h2>Inventory Summary</h2>
    <table border="1">
        <tr><th>Product</th><th>Qty</th><th>Unit Price</th><th>Total Value</th></tr>
        <% for (Map<String, Object> row : inventory) { %>
        <tr>
            <td><%= row.get("name") %></td>
            <td><%= row.get("qty") %></td>
            <td>$<%= row.get("price") %></td>
            <td>$<%= row.get("value") %></td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
