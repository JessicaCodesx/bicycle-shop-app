<%@ page import="java.sql.*, java.util.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Receive Orders</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="wrapper">
        <h1><i class="fas fa-truck-loading"></i> Receive Orders</h1>

        <%
            List<Map<String, Object>> orders = new ArrayList<>();
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement ps = conn.prepareStatement(
                         "SELECT o.OrderID, p.Name AS ProductName, o.Quantity, o.OrderDate, o.DeliveryDate " +
                                 "FROM ORDERS o JOIN PRODUCT p ON o.ProductID = p.ProductID " +
                                 "WHERE o.DeliveryDate IS NOT NULL AND o.Received = FALSE"
                 );
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("orderId", rs.getInt("OrderID"));
                    row.put("product", rs.getString("ProductName"));
                    row.put("qty", rs.getInt("Quantity"));
                    row.put("orderDate", rs.getDate("OrderDate"));
                    row.put("deliveryDate", rs.getDate("DeliveryDate"));
                    orders.add(row);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-boxes"></i> Pending Orders</h3>
            </div>
            <div class="card-body">
                <% if (orders.isEmpty()) { %>
                <p class="text-muted">No orders pending receipt.</p>
                <% } else { %>
                <table class="table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Order Date</th>
                        <th>Delivery Date</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Map<String, Object> o : orders) { %>
                    <tr>
                        <td><%= o.get("orderId") %></td>
                        <td><%= o.get("product") %></td>
                        <td><%= o.get("qty") %></td>
                        <td><%= o.get("orderDate") %></td>
                        <td><%= o.get("deliveryDate") %></td>
                        <td>
                            <form method="post" action="receiveOrder">
                                <input type="hidden" name="orderId" value="<%= o.get("orderId") %>">
                                <button type="submit" class="btn btn-sm btn-success">
                                    <i class="fas fa-check-circle"></i> Receive
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <% } %>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>

