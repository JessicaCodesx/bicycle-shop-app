<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ include file="navbar.jsp" %>
<html>
<head>
    <title>Record Sale</title>
</head>
<body>
<div class="wrapper">
    <h2>Record New Sale</h2>

    <% if ("insufficient".equals(request.getParameter("error"))) { %>
    <p style="color: red; font-weight: bold;"> Not enough inventory to complete the sale.</p>
    <% } %>

    <%
        List<Map<String, Object>> products = new ArrayList<>();
        List<Map<String, Object>> customers = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            // Products
            PreparedStatement psProd = conn.prepareStatement(
                    "SELECT p.ProductID, p.Name, i.Quantity FROM PRODUCT p " +
                            "JOIN INVENTORY i ON p.ProductID = i.ProductID " +
                            "WHERE p.Discontinued = FALSE"
            );
            ResultSet rsProd = psProd.executeQuery();
            while (rsProd.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rsProd.getInt("ProductID"));
                row.put("name", rsProd.getString("Name"));
                row.put("qty", rsProd.getInt("Quantity"));
                products.add(row);
            }

            // Customers
            PreparedStatement psCust = conn.prepareStatement(
                    "SELECT CustomerID, FirstName, LastName FROM CUSTOMER"
            );
            ResultSet rsCust = psCust.executeQuery();
            while (rsCust.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rsCust.getInt("CustomerID"));
                row.put("name", rsCust.getString("FirstName") + " " + rsCust.getString("LastName"));
                customers.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <form method="post" action="addSale">
        <label>Customer:</label>
        <select name="customerId" required>
            <% for (Map<String, Object> c : customers) { %>
            <option value="<%= c.get("id") %>"><%= c.get("name") %></option>
            <% } %>
        </select><br/>

        <label>Product:</label>
        <select name="productId" required>
            <% for (Map<String, Object> p : products) { %>
            <option value="<%= p.get("id") %>">
                <%= p.get("name") %> (In Stock: <%= p.get("qty") %>)
            </option>
            <% } %>
        </select><br/>

        <label>Quantity:</label>
        <input type="number" name="quantity" min="1" required><br/>

        <input type="submit" value="Submit Sale">
    </form>
</div>
</body>
</html>
