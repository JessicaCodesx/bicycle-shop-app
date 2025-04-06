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

<html>
<%@ include file="navbar.jsp" %>
<head><title>Sales History</title></head>
<body>
<h2>Sales History</h2>
<a href="add-sale.jsp">+ Record New Sale</a>
<table border="1">
    <tr>
        <th>Sale ID</th><th>Date</th><th>Customer</th><th>Total ($)</th>
    </tr>
    <% for (Map<String, Object> s : sales) { %>
    <tr>
        <td><%= s.get("saleId") %></td>
        <td><%= s.get("date") %></td>
        <td><%= s.get("customer") %></td>
        <td><%= s.get("cost") %></td>
    </tr>
    <% } %>
</table>
</body>
</html>
