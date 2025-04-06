<%@ page import="java.util.*, java.sql.*, java.text.SimpleDateFormat, com.jessica.bicycleshopapp.util.DBUtil" %>
<%
    String start = request.getParameter("start");
    String end = request.getParameter("end");

    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DATE, -7);
    java.sql.Date lastWeek = new java.sql.Date(cal.getTimeInMillis());

    String formattedStart = (start != null) ? start : df.format(lastWeek);
    String formattedEnd = (end != null) ? end : df.format(today);

    List<Map<String, Object>> repairs = new ArrayList<>();
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(
                 "SELECT r.RepairDate, c.FirstName, c.LastName, p.Name, r.Cost, r.Description " +
                         "FROM REPAIRS r " +
                         "JOIN CUSTOMER c ON r.CustomerID = c.CustomerID " +
                         "JOIN PRODUCT p ON r.ProductID = p.ProductID " +
                         "WHERE r.RepairDate BETWEEN ? AND ? " +
                         "ORDER BY r.RepairDate DESC"
         )) {
        ps.setDate(1, java.sql.Date.valueOf(formattedStart));
        ps.setDate(2, java.sql.Date.valueOf(formattedEnd));
        ResultSet rs = ps.executeQuery();

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

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Repair Report - Bike Shop System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="wrapper">
        <h1><i class="fas fa-tools"></i> Repair Report</h1>

        <form method="get" class="d-flex gap-3 align-items-end mb-4">
            <div class="form-group">
                <label>Start Date:</label>
                <input type="date" name="start" value="<%= formattedStart %>">
            </div>
            <div class="form-group">
                <label>End Date:</label>
                <input type="date" name="end" value="<%= formattedEnd %>">
            </div>
            <button type="submit" class="btn">
                <i class="fas fa-search"></i> Filter
            </button>
        </form>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-wrench"></i> Repairs from <%= formattedStart %> to <%= formattedEnd %></h3>
            </div>
            <div class="card-body">
                <% if (repairs.isEmpty()) { %>
                <p class="text-muted">No repairs found in this range.</p>
                <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr><th>Date</th><th>Customer</th><th>Product</th><th>Cost</th><th>Description</th></tr>
                        </thead>
                        <tbody>
                        <% for (Map<String, Object> r : repairs) { %>
                        <tr>
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

