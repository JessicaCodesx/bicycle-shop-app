<%@ include file="navbar.jsp" %>
<h2>Order New Inventory</h2>
<form method="post" action="order-product">
    <label>Product ID:</label>
    <input type="number" name="productId" required><br>
    <label>Supplier ID:</label>
    <input type="number" name="supplierId" required><br>
    <label>Quantity:</label>
    <input type="number" name="quantity" required><br>
    <label>Order Date:</label>
    <input type="date" name="orderDate" required><br>
    <label>Delivery Date:</label>
    <input type="date" name="deliveryDate" required><br>
    <button type="submit">Submit Order</button>
</form>
