<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.ProductDAO, com.jessica.bicycleshopapp.model.Product" %>
<%
    List<Product> products = new ProductDAO().getAllProducts();
%>
<html>
<%@ include file="navbar.jsp" %>
<head><title>Products</title></head>
<body>
<div class="wrapper">
    <h2>Product List</h2>
    <a href="add-product.jsp">+ Add Product</a>
    <table border="1">
        <tr>
            <th>ID</th><th>Name</th><th>Price</th><th>Category</th><th>Supplier ID</th><th>Discontinued</th><th>Action</th>
        </tr>
        <%
            for (Product p : products) {
        %>
        <tr>
            <td><%= p.getProductId() %></td>
            <td><%= p.getName() %></td>
            <td>$<%= p.getPrice() %></td>
            <td><%= p.getCategory() %></td>
            <td><%= p.getSupplierId() %></td>
            <td><%= p.isDiscontinued() ? "Yes" : "No" %></td>
            <td>
                <% if (!p.isDiscontinued()) { %>
                <form method="post" action="discontinueProduct" style="display:inline;">
                    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                    <input type="submit" value="Discontinue">
                </form>
                <% } else { %>
                <em>Discontinued</em>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
