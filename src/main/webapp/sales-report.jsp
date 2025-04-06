<%@ page import="java.sql.*, java.util.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ page import="java.sql.Date" %>
<%
    String start = request.getParameter("start");
    String end = request.getParameter("end");

    List<Map<String, Object>> sales = new ArrayList<>();

    if (start != null && end != null) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT SaleDate, SUM(Cost) AS TotalSales " +
                             "FROM SALES " +
                             "WHERE SaleDate BETWEEN ? AND ? " +
                             "GROUP BY SaleDate " +
                             "ORDER BY SaleDate"
             )) {

            ps.setDate(1, Date.valueOf(start));
            ps.setDate(2, Date.valueOf(end));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("date", rs.getDate("SaleDate"));
                row.put("total", rs.getDouble("TotalSales"));
                sales.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<html>
<%@ include file="navbar.jsp" %>
<head><title>Sales Report</title></head>
<body>
<div class="wrapper">
    <h2>Sales Report</h2>
    <form method="get">
        From: <input type="date" name="start" value="<%= start != null ? start : "" %>">
        To: <input type="date" name="end" value="<%= end != null ? end : "" %>">
        <input type="submit" value="Run Report">
    </form>

    <% if (sales.size() > 0) { %>
    <table border="1">
        <tr><th>Date</th><th>Total Sales ($)</th></tr>
        <% for (Map<String, Object> row : sales) { %>
        <tr>
            <td><%= row.get("date") %></td>
            <td>$<%= row.get("total") %></td>
        </tr>
        <% } %>
    </table>
    <% } else if (start != null && end != null) { %>
    <p>No sales found in this range.</p>
    <% } %>
</div>
</body>
</html>
