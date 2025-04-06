<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ include file="navbar.jsp" %>
<html>
<head><title>Place Product Order</title></head>
<body>
<div class="wrapper">
    <h2>Place Product Order</h2>

    <%
        List<Map<String, Object>> products = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT p.ProductID, p.Name, s.SupplierName FROM PRODUCT p " +
                             "JOIN SUPPLIER s ON p.SupplierID = s.SupplierID"
             );
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getInt("ProductID"));
                row.put("name", rs.getString("Name"));
                row.put("supplier", rs.getString("SupplierName"));
                products.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <form method="post" action="addOrder">
        Product:
        <select name="productId">
            <% for (Map<String, Object> p : products) { %>
            <option value="<%= p.get("id") %>">
                <%= p.get("name") %> (Supplier: <%= p.get("supplier") %>)
            </option>
            <% } %>
        </select><br/>

        Quantity: <input type="number" name="quantity" min="1" required><br/>
        Delivery Date: <input type="date" name="delivery"><br/>
        <input type="submit" value="Place Order">
    </form>

    <% if ("1".equals(request.getParameter("success"))) { %>
    <p style="color:green;">Order placed successfully!</p>
    <% } %>
</div>
</body>
</html>
