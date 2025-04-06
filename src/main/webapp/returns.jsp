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

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Returns - Bike Shop System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
  <div class="wrapper">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h1><i class="fas fa-undo"></i> Product Returns</h1>
      <a href="add-return.jsp" class="btn">
        <i class="fas fa-plus-circle"></i> Record Return
      </a>
    </div>

    <div class="card">
      <div class="card-header">
        <h3><i class="fas fa-list"></i> Return History</h3>
      </div>
      <div class="card-body">
        <% if (returns.isEmpty()) { %>
        <p class="text-muted">No returns recorded.</p>
        <% } else { %>
        <div class="table-responsive">
          <table class="table">
            <thead>
            <tr>
              <th>ID</th>
              <th>Date</th>
              <th>Product</th>
              <th>Quantity</th>
              <th>Reason</th>
            </tr>
            </thead>
            <tbody>
            <% for (Map<String, Object> r : returns) { %>
            <tr>
              <td><%= r.get("id") %></td>
              <td><%= r.get("date") %></td>
              <td><%= r.get("product") %></td>
              <td><%= r.get("qty") %></td>
              <td><%= r.get("reason") %></td>
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
