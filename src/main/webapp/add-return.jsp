<%@ page import="java.util.*, java.sql.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ include file="navbar.jsp" %>
<html>
<head>
    <title>Record Return</title>
</head>
<body>
<div class="wrapper">
    <h2>Record Product Return</h2>

    <%
        List<Map<String, Object>> saleItems = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT sd.SaleID, sd.ProductID, p.Name, sd.Quantity " +
                             "FROM SALEDETAILS sd " +
                             "JOIN PRODUCT p ON sd.ProductID = p.ProductID " +
                             "ORDER BY sd.SaleID DESC"
             );
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("saleId", rs.getInt("SaleID"));
                row.put("productId", rs.getInt("ProductID"));
                row.put("name", rs.getString("Name"));
                row.put("quantity", rs.getInt("Quantity"));
                saleItems.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <% if ("1".equals(request.getParameter("error"))) { %>
    <p style="color:red";>Error processing return. Please check the inputs.</p>
    <% } %>

    <form id="returnForm" method="post" action="addReturn">
        Sale + Product:
        <select name="saleProduct" required>
            <% for (Map<String, Object> item : saleItems) { %>
            <option value="<%= item.get("saleId") %>_<%= item.get("productId") %>">
                Sale #<%= item.get("saleId") %> - <%= item.get("name") %> (Qty: <%= item.get("quantity") %>)
            </option>
            <% } %>
        </select><br/>

        Quantity to Return: <input type="number" name="quantity" min="1" required><br/>
        Reason: <input type="text" name="reason"><br/>

        <input type="submit" value="Submit Return">
    </form>

    <script>
        document.getElementById("returnForm").addEventListener("submit", function (e) {
            const select = document.querySelector("[name=saleProduct]");
            const [saleId, productId] = select.value.split("_");

            const saleInput = document.createElement("input");
            saleInput.type = "hidden";
            saleInput.name = "saleId";
            saleInput.value = saleId;

            const productInput = document.createElement("input");
            productInput.type = "hidden";
            productInput.name = "productId";
            productInput.value = productId;

            this.appendChild(saleInput);
            this.appendChild(productInput);
        });
    </script>
</div>
</body>
</html>
