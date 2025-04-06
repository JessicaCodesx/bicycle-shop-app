<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%
  List<Map<String, Object>> returns = new ArrayList<>();

  try (Connection conn = DBUtil.getConnection();
       PreparedStatement ps = conn.prepareStatement(
               "SELECT r.ReturnID, r.ReturnDate, r.Quantity, r.Reason, p.Name " +
                       "FROM RETURNS r JOIN PRODUCT p ON r.ProductID = p.ProductID " +
                       "ORDER BY r.ReturnDate DESC"
       );
       ResultSet rs = ps.executeQuery()) {

    while (rs.next()) {
      Map<String, Object> row = new HashMap<>();
      row.put("id", rs.getInt("ReturnID"));
      row.put("date", rs.getDate("ReturnDate"));
      row.put("product", rs.getString("Name"));
      row.put("qty", rs.getInt("Quantity"));
      row.put("reason", rs.getString("Reason"));
      returns.add(row);
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<html>
<%@ include file="navbar.jsp" %>
<head><title>Returns</title></head>
<body>
<div class="wrapper">
  <h2>Returns</h2>
  <a href="add-return.jsp">+ Record Return</a>
  <table border="1">
    <tr>
      <th>ID</th><th>Date</th><th>Product</th><th>Qty</th><th>Reason</th>
    </tr>
    <% for (Map<String, Object> r : returns) { %>
    <tr>
      <td><%= r.get("id") %></td>
      <td><%= r.get("date") %></td>
      <td><%= r.get("product") %></td>
      <td><%= r.get("qty") %></td>
      <td><%= r.get("reason") %></td>
    </tr>
    <% } %>
  </table>
</div>
</body>
</html>
