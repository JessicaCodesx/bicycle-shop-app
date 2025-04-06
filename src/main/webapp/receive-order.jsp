<%@ page import="java.sql.*, java.util.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ include file="navbar.jsp" %>
<html>
<head><title>Receive Orders</title></head>
<body>
<div class="wrapper">
    <h2>Pending Orders</h2>

    <%
        List<Map<String, Object>> orders = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT o.OrderID, p.Name AS ProductName, o.Quantity, o.OrderDate, o.DeliveryDate " +
                             "FROM ORDERS o " +
                             "JOIN PRODUCT p ON o.ProductID = p.ProductID " +
                             "WHERE o.DeliveryDate IS NOT NULL " +
                             "AND o.OrderID NOT IN (SELECT DISTINCT OrderID FROM InventoryReceived)"
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

    <% if (orders.isEmpty()) { %>
    <p>No orders pending receipt.</p>
    <% } else { %>
    <table border="1">
        <tr><th>Order ID</th><th>Product</th><th>Quantity</th><th>Order Date</th><th>Delivery Date</th><th>Action</th></tr>
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
                    <input type="submit" value="Receive">
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>
</body>
</html>
