<%@ include file="navbar.jsp" %>
<h2>Receive Shipment</h2>
<form method="post" action="receive-shipment">
  <label>Product ID:</label>
  <input type="number" name="productId" required><br>
  <label>Quantity Received:</label>
  <input type="number" name="quantity" required><br>
  <button type="submit">Update Inventory</button>
</form>
